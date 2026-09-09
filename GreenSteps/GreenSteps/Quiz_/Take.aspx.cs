using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Quiz_Take : Page
    {
        private int QuizId
        {
            get
            {
                int id;
                return int.TryParse(Request.QueryString["id"], out id) ? id : 0;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Require login
            if (Session["UserId"] == null)
            {
                Session["FlashMessage"] = "🔒 Please login to take a quiz!";
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            // Admin can't take quizzes
            if ((Session["UserRole"] as string) == "Admin")
            {
                Session["FlashMessage"] = "🛑 Admins cannot take quizzes.";
                Response.Redirect("~/Quiz.aspx");
                return;
            }

            if (QuizId == 0)
            {
                Response.Redirect("~/Quiz.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadQuiz();
            }

            lnkTryAgain.NavigateUrl = "Take.aspx?id=" + QuizId;
        }

        private void LoadQuiz()
        {
            // Load quiz info
            DataTable quizDt = DataAccess.ExecuteQuery(
                "SELECT * FROM Quizzes WHERE QuizId = @Id",
                new SqlParameter("@Id", QuizId));

            if (quizDt.Rows.Count == 0)
            {
                Response.Redirect("~/Quiz.aspx");
                return;
            }

            litQuizTitle.Text = Server.HtmlEncode(quizDt.Rows[0]["Title"].ToString());
            litQuizDescription.Text = Server.HtmlEncode(quizDt.Rows[0]["Description"].ToString());

            // Load questions
            DataTable questionsDt = DataAccess.ExecuteQuery(
                "SELECT * FROM Questions WHERE QuizId = @Id ORDER BY QuestionId",
                new SqlParameter("@Id", QuizId));

            rptQuestions.DataSource = questionsDt;
            rptQuestions.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Load questions again to check answers
            DataTable questionsDt = DataAccess.ExecuteQuery(
                "SELECT * FROM Questions WHERE QuizId = @Id ORDER BY QuestionId",
                new SqlParameter("@Id", QuizId));

            int correct = 0;
            int total = questionsDt.Rows.Count;

            foreach (DataRow r in questionsDt.Rows)
            {
                string qId = r["QuestionId"].ToString();
                string userAnswer = Request.Form["answer_" + qId];
                string correctAnswer = r["CorrectAnswer"].ToString();

                if (userAnswer == correctAnswer)
                {
                    correct++;
                }
            }

            // 💾 SAVE THIS ATTEMPT TO THE DATABASE
            int userId = Convert.ToInt32(Session["UserId"]);
            DataAccess.ExecuteNonQuery(
                "INSERT INTO QuizAttempts (UserId, QuizId, QuizTitle, Score, TotalQuestions, AttemptedAt) " +
                "VALUES (@UserId, @QuizId, @QuizTitle, @Score, @Total, GETDATE())",
                new SqlParameter("@UserId", userId),
                new SqlParameter("@QuizId", QuizId),
                new SqlParameter("@QuizTitle", litQuizTitle.Text),
                new SqlParameter("@Score", correct),
                new SqlParameter("@Total", total));

            // Show results
            phQuizForm.Visible = false;
            phResult.Visible = true;

            int percent = total > 0 ? (int)Math.Round(100.0 * correct / total) : 0;
            litPercent.Text = percent.ToString();
            litScore.Text = correct + " out of " + total;

            if (percent >= 80)
            {
                scoreCircle.Attributes["class"] = "score-circle";
                litMessage.Text = "🌟 Excellent!";
            }
            else if (percent >= 50)
            {
                scoreCircle.Attributes["class"] = "score-circle fail";
                litMessage.Text = "👍 Good try!";
            }
            else
            {
                scoreCircle.Attributes["class"] = "score-circle bad";
                litMessage.Text = "💪 Keep learning!";
            }
        }
    }
}
