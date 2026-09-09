using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Quizzes_Index : Page
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
                LoadQuizzes();
                if (Session["QuizMessage"] != null)
                {
                    litMessage.Text = "<div class='alert alert-success'>" +
                        Server.HtmlEncode(Session["QuizMessage"].ToString()) + "</div>";
                    Session.Remove("QuizMessage");
                }
            }
        }

        private void LoadQuizzes()
        {
            DataTable dt = DataAccess.ExecuteQuery(
                @"SELECT q.*, (SELECT COUNT(*) FROM Questions WHERE QuizId = q.QuizId) AS QuestionCount
                FROM Quizzes q ORDER BY q.CreatedAt DESC");
            gvQuizzes.DataSource = dt;
            gvQuizzes.DataBind();
        }

        protected void gvQuizzes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteQuiz")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                DataAccess.ExecuteNonQuery(
                    "DELETE FROM Quizzes WHERE QuizId = @Id",
                    new SqlParameter("@Id", id));
                Session["QuizMessage"] = "🗑️ Quiz deleted successfully!";
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}
