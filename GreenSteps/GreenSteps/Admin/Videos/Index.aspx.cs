using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Videos_Index : Page
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
                LoadVideos();
                if (Session["VideoMessage"] != null)
                {
                    litMessage.Text = "<div class='alert alert-success'>" +
                        Server.HtmlEncode(Session["VideoMessage"].ToString()) + "</div>";
                    Session.Remove("VideoMessage");
                }
            }
        }

        private void LoadVideos()
        {
            DataTable dt = DataAccess.ExecuteQuery(
                "SELECT * FROM Videos ORDER BY UploadedDate DESC");
            gvVideos.DataSource = dt;
            gvVideos.DataBind();
        }

        protected void gvVideos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteVideo")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                DataAccess.ExecuteNonQuery(
                    "DELETE FROM Videos WHERE VideoId = @Id",
                    new SqlParameter("@Id", id));
                Session["VideoMessage"] = "🗑️ Video deleted successfully!";
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}
