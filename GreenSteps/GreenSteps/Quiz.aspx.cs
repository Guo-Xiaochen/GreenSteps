using System;
using System.Data;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Quiz : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 🎯 Admins go to manage quizzes instead
            if ((Session["UserRole"] as string) == "Admin")
            {
                Response.Redirect("~/Admin/Quizzes/Index.aspx");
                return;
            }

            if (!IsPostBack)
            {
                DataTable dt = DataAccess.ExecuteQuery(
                    @"SELECT q.QuizId, q.Title, q.Description, q.Category, q.CreatedAt,
            (SELECT COUNT(*) FROM Questions WHERE QuizId = q.QuizId) AS QuestionCount
            FROM Quizzes q
            ORDER BY q.CreatedAt DESC");
                rptQuizzes.DataSource = dt;
                rptQuizzes.DataBind();
            }
        }
    }
}
