using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Articles_Index : Page
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
                LoadArticles();
                ShowFlashMessage();
            }
        }

        private void ShowFlashMessage()
        {
            if (Session["ArticleMessage"] != null)
            {
                litMessage.Text = "<div class='alert alert-success'>" +
                    Server.HtmlEncode(Session["ArticleMessage"].ToString()) + "</div>";
                Session.Remove("ArticleMessage");
            }
        }

        private void LoadArticles()
        {
            DataTable dt = DataAccess.ExecuteQuery(
                "SELECT * FROM Articles ORDER BY PublishedDate DESC");
            gvArticles.DataSource = dt;
            gvArticles.DataBind();
        }

        protected void gvArticles_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteArticle")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                DataAccess.ExecuteNonQuery(
                    "DELETE FROM Articles WHERE ArticleId = @Id",
                    new SqlParameter("@Id", id));
                Session["ArticleMessage"] = "🗑️ Article deleted successfully!";
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}
