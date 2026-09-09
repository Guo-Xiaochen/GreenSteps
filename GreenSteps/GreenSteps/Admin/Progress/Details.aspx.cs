using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Progress_Details : Page
    {
        private int UserId
        {
            get
            {
                int id;
                return int.TryParse(Request.QueryString["userId"], out id) ? id : 0;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["UserRole"] as string) != "Admin")
            {
                Session["FlashMessage"] = "🔒 Admin access required.";
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            if (UserId == 0)
            {
                Response.Redirect("~/Admin/Progress/Index.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadPage();
                ShowFlashMessage();
            }
        }

        private void ShowFlashMessage()
        {
            if (Session["ProgressMessage"] != null)
            {
                litMessage.Text = "<div class='alert alert-success'>" +
                    Server.HtmlEncode(Session["ProgressMessage"].ToString()) + "</div>";
                Session.Remove("ProgressMessage");
            }
        }

        private void LoadPage()
        {
            // Load user info
            DataTable userDt = DataAccess.ExecuteQuery(
                "SELECT * FROM Users WHERE UserId = @Id",
                new SqlParameter("@Id", UserId));

            if (userDt.Rows.Count == 0)
            {
                Session["ProgressMessage"] = "❌ User not found.";
                Response.Redirect("~/Admin/Progress/Index.aspx");
                return;
            }

            litName.Text = Server.HtmlEncode(userDt.Rows[0]["FullName"].ToString());
            litEmail.Text = Server.HtmlEncode(userDt.Rows[0]["Email"].ToString());

            // Load attempts
            DataTable attempts = DataAccess.ExecuteQuery(
                "SELECT * FROM QuizAttempts WHERE UserId = @Id ORDER BY AttemptedAt DESC",
                new SqlParameter("@Id", UserId));

            litTotal.Text = attempts.Rows.Count.ToString();

            if (attempts.Rows.Count == 0)
            {
                phEmpty.Visible = true;
                litAvg.Text = "0";
                litBest.Text = "0";
                litLastActive.Text = "—";
                return;
            }

            // Stats
            double totalPct = 0, bestPct = 0;
            DateTime lastActive = DateTime.MinValue;
            foreach (DataRow r in attempts.Rows)
            {
                int score = Convert.ToInt32(r["Score"]);
                int total = Convert.ToInt32(r["TotalQuestions"]);
                double pct = total > 0 ? (100.0 * score / total) : 0;
                totalPct += pct;
                if (pct > bestPct) bestPct = pct;
                DateTime at = Convert.ToDateTime(r["AttemptedAt"]);
                if (at > lastActive) lastActive = at;
            }

            litAvg.Text = Math.Round(totalPct / attempts.Rows.Count).ToString();
            litBest.Text = Math.Round(bestPct).ToString();
            litLastActive.Text = lastActive.ToString("dd MMM");

            rptAttempts.DataSource = attempts;
            rptAttempts.DataBind();
        }

        protected void rptAttempts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int attemptId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "SaveFeedback")
            {
                // Find the textbox in this specific item
                TextBox txt = (TextBox)e.Item.FindControl("txtFeedback");
                string feedback = txt.Text.Trim();

                if (string.IsNullOrEmpty(feedback))
                {
                    // Clear feedback if empty
                    DataAccess.ExecuteNonQuery(
                        "UPDATE QuizAttempts SET AdminFeedback = NULL, FeedbackDate = NULL WHERE AttemptId = @Id",
                        new SqlParameter("@Id", attemptId));
                    Session["ProgressMessage"] = "🗑️ Feedback cleared.";
                }
                else
                {
                    DataAccess.ExecuteNonQuery(
                        "UPDATE QuizAttempts SET AdminFeedback = @Feedback, FeedbackDate = GETDATE() WHERE AttemptId = @Id",
                        new SqlParameter("@Feedback", feedback),
                        new SqlParameter("@Id", attemptId));
                    Session["ProgressMessage"] = "✅ Feedback saved successfully!";
                }
            }
            else if (e.CommandName == "DeleteAttempt")
            {
                DataAccess.ExecuteNonQuery(
                    "DELETE FROM QuizAttempts WHERE AttemptId = @Id",
                    new SqlParameter("@Id", attemptId));
                Session["ProgressMessage"] = "🗑️ Attempt deleted successfully!";
            }

            Response.Redirect(Request.RawUrl);
        }

        // Helpers
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

        protected string ShowLastEdited(object feedbackDate)
        {
            if (feedbackDate == null || feedbackDate == DBNull.Value)
                return "";
            return "<small style='color:#777; margin-left:0.5rem;'>Last edited: " +
                ((DateTime)feedbackDate).ToString("dd MMM yyyy, HH:mm") + "</small>";
        }
    }
}