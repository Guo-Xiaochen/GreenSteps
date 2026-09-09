using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Videos_Details : Page
    {
        public string YouTubeId { get; set; } = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Require login to watch full video
            if (Session["UserId"] == null)
            {
                Session["FlashMessage"] = "🔒 Please login to watch this video!";
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                int id;
                if (!int.TryParse(Request.QueryString["id"], out id))
                {
                    Response.Redirect("~/Videos.aspx");
                    return;
                }

                DataTable dt = DataAccess.ExecuteQuery(
                    "SELECT * FROM Videos WHERE VideoId = @Id",
                    new SqlParameter("@Id", id));

                if (dt.Rows.Count == 0)
                {
                    phVideo.Visible = false;
                    phNotFound.Visible = true;
                }
                else
                {
                    DataRow r = dt.Rows[0];
                    YouTubeId = r["YouTubeId"].ToString();
                    litTitle.Text = Server.HtmlEncode(r["Title"].ToString());
                    litCategory.Text = Server.HtmlEncode(r["Category"].ToString());
                    litDescription.Text = Server.HtmlEncode(r["Description"].ToString());
                    litDuration.Text = r["DurationMinutes"].ToString();
                    litDate.Text = ((DateTime)r["UploadedDate"]).ToString("dd MMMM yyyy");
                    litId.Text = r["VideoId"].ToString();
                }
            }
        }
    }
}