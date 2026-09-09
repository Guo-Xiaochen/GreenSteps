using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Quizzes_Edit : Page
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
            if ((Session["UserRole"] as string) != "Admin")
            {
                Session["FlashMessage"] = "🔒 Admin access required.";
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            if (QuizId == 0) { Response.Redirect("~/Admin/Quizzes/Index.aspx"); return; }

            if (!IsPostBack)
            {
                DataTable dt = DataAccess.ExecuteQuery(
                    "SELECT * FROM Quizzes WHERE QuizId = @Id",
                    new SqlParameter("@Id", QuizId));

                if (dt.Rows.Count == 0) { Response.Redirect("~/Admin/Quizzes/Index.aspx"); return; }

                DataRow r = dt.Rows[0];
                txtTitle.Text = r["Title"].ToString();
                txtDescription.Text = r["Description"].ToString();
                ddlCategory.SelectedValue = r["Category"].ToString();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            DataAccess.ExecuteNonQuery(
                "UPDATE Quizzes SET Title=@Title, Description=@Description, Category=@Category WHERE QuizId=@Id",
                new SqlParameter("@Title", txtTitle.Text.Trim()),
                new SqlParameter("@Description", txtDescription.Text.Trim()),
                new SqlParameter("@Category", ddlCategory.SelectedValue),
                new SqlParameter("@Id", QuizId));

            Session["QuizMessage"] = "✅ Quiz updated successfully!";
            Response.Redirect("~/Admin/Quizzes/Index.aspx");
        }
    }
}
