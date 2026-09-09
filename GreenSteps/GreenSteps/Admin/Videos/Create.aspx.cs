using System;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Videos_Create : Page
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

            int duration;
            if (!int.TryParse(txtDuration.Text, out duration)) duration = 5;

            DataAccess.ExecuteNonQuery(
                "INSERT INTO Videos (Title, Description, YouTubeId, Category, DurationMinutes, UploadedDate) " +
                "VALUES (@Title, @Description, @YouTubeId, @Category, @Duration, GETDATE())",
                new SqlParameter("@Title", txtTitle.Text.Trim()),
                new SqlParameter("@Description", txtDescription.Text.Trim()),
                new SqlParameter("@YouTubeId", txtYouTubeId.Text.Trim()),
                new SqlParameter("@Category", ddlCategory.SelectedValue),
                new SqlParameter("@Duration", duration));

            Session["VideoMessage"] = "✅ Video '" + txtTitle.Text.Trim() + "' was added!";
            Response.Redirect("~/Admin/Videos/Index.aspx");
        }
    }
}
