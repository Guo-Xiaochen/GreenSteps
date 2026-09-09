using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Progress : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Require login
            if (Session["UserId"] == null)
            {
                Session["FlashMessage"] = "🔒 Please login to view your progress!";
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            // Redirect admins - they don't have personal progress
            if ((Session["UserRole"] as string) == "Admin")
            {
                Response.Redirect("~/Admin/Dashboard.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProgress();
            }
        }

        private void LoadProgress()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            litName.Text = Server.HtmlEncode(Session["UserName"] as string ?? "Learner");

            // Get this user's attempts
            DataTable attempts = DataAccess.ExecuteQuery(
                "SELECT * FROM QuizAttempts WHERE UserId = @UserId ORDER BY AttemptedAt DESC",
                new SqlParameter("@UserId", userId));

            litTotal.Text = attempts.Rows.Count.ToString();

            if (attempts.Rows.Count == 0)
            {
                phEmpty.Visible = true;
                litAvg.Text = "0";
                litBest.Text = "0";
                litBadges.Text = "0";
                MarkBadges(0, 0, false);
                return;
            }

            // Calculate stats
            double totalPct = 0;
            double bestPct = 0;
            bool hasPerfect = false;

            foreach (DataRow r in attempts.Rows)
            {
                int score = Convert.ToInt32(r["Score"]);
                int total = Convert.ToInt32(r["TotalQuestions"]);
                double pct = total > 0 ? (100.0 * score / total) : 0;
                totalPct += pct;
                if (pct > bestPct) bestPct = pct;
                if (score == total && total > 0) hasPerfect = true;
            }

            int avgPct = (int)Math.Round(totalPct / attempts.Rows.Count);
            int bestPercent = (int)Math.Round(bestPct);

            litAvg.Text = avgPct.ToString();
            litBest.Text = bestPercent.ToString();

            // Count badges
            int badges = 0;
            if (attempts.Rows.Count >= 1) badges++;
            if (attempts.Rows.Count >= 3) badges++;
            if (bestPercent >= 80) badges++;
            if (hasPerfect) badges++;
            litBadges.Text = badges.ToString();

            MarkBadges(attempts.Rows.Count, bestPercent, hasPerfect);

            // Bind the history
            rptAttempts.DataSource = attempts;
            rptAttempts.DataBind();
        }

        private void MarkBadges(int totalAttempts, int bestPercent, bool hasPerfect)
        {
            badge1.Attributes["class"] = "badge-card " + (totalAttempts >= 1 ? "earned" : "locked");
            badge2.Attributes["class"] = "badge-card " + (totalAttempts >= 3 ? "earned" : "locked");
            badge3.Attributes["class"] = "badge-card " + (bestPercent >= 80 ? "earned" : "locked");
            badge4.Attributes["class"] = "badge-card " + (hasPerfect ? "earned" : "locked");
        }

        // Helpers used by Repeater
        protected string GetPercent(object score, object total)
        {
            int s = Convert.ToInt32(score);
            int t = Convert.ToInt32(total);
            return t > 0 ? Math.Round(100.0 * s / t).ToString() : "0";
        }

        protected string GetColor(object score, object total)
        {
            int s = Convert.ToInt32(score);
            int t = Convert.ToInt32(total);
            int pct = t > 0 ? (int)Math.Round(100.0 * s / t) : 0;
            return pct >= 80 ? "#4caf50" : (pct >= 50 ? "#ff9800" : "#c62828");
        }

        protected string ShowFeedback(object feedback, object feedbackDate)
        {
            if (feedback == null || feedback == DBNull.Value || string.IsNullOrEmpty(feedback.ToString()))
                return "";

            string date = "";
            if (feedbackDate != null && feedbackDate != DBNull.Value)
                date = " <small style='color:#777;'>on " + ((DateTime)feedbackDate).ToString("dd MMM yyyy") + "</small>";

            return "<div style='background:#fff3e0; padding:1rem; border-radius:6px; margin-top:1rem; border-left:3px solid #ff9800;'>" +
                   "<strong style='color:#e65100;'>💬 Admin Feedback:</strong>" + date + "<br />" +
                   Server.HtmlEncode(feedback.ToString()) +
                   "</div>";
        }
    }
}