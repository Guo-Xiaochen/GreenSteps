using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Quizzes_Questions : Page
    {
        private int QuizId
        {
            get
            {
                int id;
                return int.TryParse(Request.QueryString["quizId"], out id) ? id : 0;
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

            if (QuizId == 0) { Response.Redirect("~/Admin/Quizzes/Index.aspx"); return; }

            if (!IsPostBack)
            {
                LoadQuizAndQuestions();
                if (Session["QuestionMessage"] != null)
                {
                    litMessage.Text = "<div class='alert alert-success'>" +
                        Server.HtmlEncode(Session["QuestionMessage"].ToString()) + "</div>";
                    Session.Remove("QuestionMessage");
                }
            }
        }

        private void LoadQuizAndQuestions()
        {
            // Load quiz title
            DataTable quiz = DataAccess.ExecuteQuery(
                "SELECT * FROM Quizzes WHERE QuizId = @Id",
                new SqlParameter("@Id", QuizId));

            if (quiz.Rows.Count == 0)
            {
                Response.Redirect("~/Admin/Quizzes/Index.aspx");
                return;
            }

            litQuizTitle.Text = Server.HtmlEncode(quiz.Rows[0]["Title"].ToString());

            // Load questions
            DataTable qs = DataAccess.ExecuteQuery(
                "SELECT * FROM Questions WHERE QuizId = @Id ORDER BY QuestionId",
                new SqlParameter("@Id", QuizId));

            litCount.Text = qs.Rows.Count.ToString();
            rptQuestions.DataSource = qs;
            rptQuestions.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            DataAccess.ExecuteNonQuery(
                "INSERT INTO Questions (QuizId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) " +
                "VALUES (@QuizId, @Q, @A, @B, @C, @D, @Correct)",
                new SqlParameter("@QuizId", QuizId),
                new SqlParameter("@Q", txtQuestion.Text.Trim()),
                new SqlParameter("@A", txtA.Text.Trim()),
                new SqlParameter("@B", txtB.Text.Trim()),
                new SqlParameter("@C", txtC.Text.Trim()),
                new SqlParameter("@D", txtD.Text.Trim()),
                new SqlParameter("@Correct", ddlCorrect.SelectedValue));

            Session["QuestionMessage"] = "✅ Question added successfully!";
            Response.Redirect(Request.RawUrl);
        }

        protected void rptQuestions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteQuestion")
            {
                int qId = Convert.ToInt32(e.CommandArgument);
                DataAccess.ExecuteNonQuery(
                    "DELETE FROM Questions WHERE QuestionId = @Id",
                    new SqlParameter("@Id", qId));
                Session["QuestionMessage"] = "🗑️ Question deleted!";
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}
