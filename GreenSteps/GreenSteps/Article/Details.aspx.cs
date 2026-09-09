using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Articles_Details : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Require login
            if (Session["UserId"] == null)
            {
                Session["FlashMessage"] = "🔒 Please login to read the full article!";
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                int id;
                if (!int.TryParse(Request.QueryString["id"], out id))
                {
                    Response.Redirect("~/Articles.aspx");
                    return;
                }

                DataTable dt = DataAccess.ExecuteQuery(
                    "SELECT * FROM Articles WHERE ArticleId = @Id",
                    new SqlParameter("@Id", id));

                if (dt.Rows.Count == 0)
                {
                    phArticle.Visible = false;
                    phNotFound.Visible = true;
                }
                else
                {
                    DataRow r = dt.Rows[0];
                    litTitle.Text = Server.HtmlEncode(r["Title"].ToString());
                    litCategory.Text = Server.HtmlEncode(r["Category"].ToString());
                    litAuthor.Text = Server.HtmlEncode(r["Author"] != DBNull.Value ? r["Author"].ToString() : "Anonymous");
                    litDate.Text = ((DateTime)r["PublishedDate"]).ToString("dd MMMM yyyy");
                    litContent.Text = Server.HtmlEncode(r["Content"].ToString());
                }
            }
        }
    }
}
