using System;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Quizzes_Create : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["UserRole"] as string) != "Admin")
            {
                Session["FlashMessage"] = "🔒 Admin access required.";
                Response.Redirect("~/Account/Login.aspx");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            DataAccess.ExecuteNonQuery(
                "INSERT INTO Quizzes (Title, Description, Category, CreatedAt) " +
                "VALUES (@Title, @Description, @Category, GETDATE())",
                new SqlParameter("@Title", txtTitle.Text.Trim()),
                new SqlParameter("@Description", txtDescription.Text.Trim()),
                new SqlParameter("@Category", ddlCategory.SelectedValue));

            // Get new quiz ID and redirect to Questions manager
            var newId = DataAccess.ExecuteScalar(
                "SELECT TOP 1 QuizId FROM Quizzes ORDER BY QuizId DESC");

            Session["QuizMessage"] = "✅ Quiz created! Now add some questions.";
            Response.Redirect("~/Admin/Quizzes/Questions.aspx?quizId=" + newId);
        }
    }
}
