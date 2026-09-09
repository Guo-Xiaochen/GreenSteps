using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Progress_Index : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["UserRole"] as string) != "Admin")
            {
                Session["FlashMessage"] = "🔒 Admin access required.";
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOverallStats();
                LoadTopPerformers();
                LoadUserSummary();
            }
        }

        private void LoadOverallStats()
        {
            litTotalAttempts.Text = DataAccess.ExecuteScalar(
                "SELECT COUNT(*) FROM QuizAttempts").ToString();

            litActiveLearners.Text = DataAccess.ExecuteScalar(
                "SELECT COUNT(DISTINCT UserId) FROM QuizAttempts").ToString();

            var avg = DataAccess.ExecuteScalar(
                "SELECT AVG(CAST(Score AS FLOAT) * 100.0 / NULLIF(TotalQuestions, 0)) FROM QuizAttempts");
            litAvgPlatform.Text = avg == null || avg == DBNull.Value
                ? "0"
                : Math.Round(Convert.ToDouble(avg)).ToString();

            litPerfect.Text = DataAccess.ExecuteScalar(
                "SELECT COUNT(*) FROM QuizAttempts WHERE Score = TotalQuestions AND TotalQuestions > 0").ToString();
        }

        private void LoadTopPerformers()
        {
            DataTable dt = DataAccess.ExecuteQuery(
                @"SELECT TOP 5 u.FullName,
                    COUNT(*) AS AttemptCount,
                    CAST(ROUND(AVG(CAST(qa.Score AS FLOAT) * 100.0 / NULLIF(qa.TotalQuestions, 0)), 0) AS INT) AS AverageScore,
                    CAST(ROUND(MAX(CAST(qa.Score AS FLOAT) * 100.0 / NULLIF(qa.TotalQuestions, 0)), 0) AS INT) AS BestScore
                FROM QuizAttempts qa
                JOIN Users u ON qa.UserId = u.UserId
                WHERE u.Role = 'User'
                GROUP BY qa.UserId, u.FullName
                ORDER BY AverageScore DESC, AttemptCount DESC");

            if (dt.Rows.Count == 0)
            {
                phEmptyLeaders.Visible = true;
            }
            else
            {
                rptLeaders.DataSource = dt;
                rptLeaders.DataBind();
            }
        }

        private void LoadUserSummary()
        {
            DataTable dt = DataAccess.ExecuteQuery(
                @"SELECT u.UserId, u.FullName, u.Email,
                    ISNULL(COUNT(qa.AttemptId), 0) AS AttemptCount,
                    ISNULL(CAST(ROUND(AVG(CAST(qa.Score AS FLOAT) * 100.0 / NULLIF(qa.TotalQuestions, 0)), 0) AS INT), 0) AS AverageScore,
                    ISNULL(CAST(ROUND(MAX(CAST(qa.Score AS FLOAT) * 100.0 / NULLIF(qa.TotalQuestions, 0)), 0) AS INT), 0) AS BestScore
                FROM Users u
                LEFT JOIN QuizAttempts qa ON u.UserId = qa.UserId
                WHERE u.Role = 'User'
                GROUP BY u.UserId, u.FullName, u.Email
                ORDER BY AttemptCount DESC, u.FullName");

            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        // Helpers
        protected string GetMedal(int rank)
        {
            switch (rank)
            {
                case 1: return "🥇";
                case 2: return "🥈";
                case 3: return "🥉";
                default: return "🏅";
            }
        }

        protected string ShowScore(object attemptCount, object score)
        {
            int count = Convert.ToInt32(attemptCount);
            if (count == 0)
                return "<span style='color:#999;'>—</span>";

            int pct = Convert.ToInt32(score);
            string color = pct >= 80 ? "#4caf50" : (pct >= 50 ? "#ff9800" : "#c62828");
            return "<span style='background:" + color + "; color:white; padding:0.25rem 0.7rem; border-radius:4px; font-weight:600;'>" + pct + "%</span>";
        }

        protected string ShowActionButton(object userId, object attemptCount)
        {
            int count = Convert.ToInt32(attemptCount);
            if (count == 0)
                return "<span style='color:#aaa; font-style:italic;'>No data</span>";

            return "<a href='Details.aspx?userId=" + userId + "' class='btn-view' style='background:#1976d2;'>👁️ View Details</a>";
        }
    }
}