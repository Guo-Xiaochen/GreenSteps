using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Videos_Edit : Page
    {
        private int VideoId
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

            if (VideoId == 0) { Response.Redirect("~/Admin/Videos/Index.aspx"); return; }

            if (!IsPostBack)
            {
                DataTable dt = DataAccess.ExecuteQuery(
                    "SELECT * FROM Videos WHERE VideoId = @Id",
                    new SqlParameter("@Id", VideoId));

                if (dt.Rows.Count == 0) { Response.Redirect("~/Admin/Videos/Index.aspx"); return; }

                DataRow r = dt.Rows[0];
                txtTitle.Text = r["Title"].ToString();
                txtYouTubeId.Text = r["YouTubeId"].ToString();
                ddlCategory.SelectedValue = r["Category"].ToString();
                txtDuration.Text = r["DurationMinutes"].ToString();
                txtDescription.Text = r["Description"].ToString();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int duration;
            if (!int.TryParse(txtDuration.Text, out duration)) duration = 5;

            DataAccess.ExecuteNonQuery(
                "UPDATE Videos SET Title=@Title, Description=@Description, YouTubeId=@YouTubeId, " +
                "Category=@Category, DurationMinutes=@Duration WHERE VideoId=@Id",
                new SqlParameter("@Title", txtTitle.Text.Trim()),
                new SqlParameter("@Description", txtDescription.Text.Trim()),
                new SqlParameter("@YouTubeId", txtYouTubeId.Text.Trim()),
                new SqlParameter("@Category", ddlCategory.SelectedValue),
                new SqlParameter("@Duration", duration),
                new SqlParameter("@Id", VideoId));

            Session["VideoMessage"] = "✅ Video updated successfully!";
            Response.Redirect("~/Admin/Videos/Index.aspx");
        }
    }
}
