using System;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Articles_Create : Page
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
                "INSERT INTO Articles (Title, Content, Category, Author, PublishedDate) " +
                "VALUES (@Title, @Content, @Category, @Author, GETDATE())",
                new SqlParameter("@Title", txtTitle.Text.Trim()),
                new SqlParameter("@Content", txtContent.Text.Trim()),
                new SqlParameter("@Category", ddlCategory.SelectedValue),
                new SqlParameter("@Author", (object)txtAuthor.Text.Trim() ?? DBNull.Value));

            Session["ArticleMessage"] = "✅ Article '" + txtTitle.Text.Trim() + "' was added successfully!";
            Response.Redirect("~/Admin/Articles/Index.aspx");
        }
    }
}
