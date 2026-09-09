using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Articles_Edit : Page
    {
        private int ArticleId
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

            if (ArticleId == 0)
            {
                Response.Redirect("~/Admin/Articles/Index.aspx");
                return;
            }

            if (!IsPostBack)
            {
                DataTable dt = DataAccess.ExecuteQuery(
                    "SELECT * FROM Articles WHERE ArticleId = @Id",
                    new SqlParameter("@Id", ArticleId));

                if (dt.Rows.Count == 0)
                {
                    Response.Redirect("~/Admin/Articles/Index.aspx");
                    return;
                }

                DataRow r = dt.Rows[0];
                txtTitle.Text = r["Title"].ToString();
                ddlCategory.SelectedValue = r["Category"].ToString();
                txtAuthor.Text = r["Author"] != DBNull.Value ? r["Author"].ToString() : "";
                txtContent.Text = r["Content"].ToString();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            DataAccess.ExecuteNonQuery(
                "UPDATE Articles SET Title=@Title, Content=@Content, Category=@Category, Author=@Author WHERE ArticleId=@Id",
                new SqlParameter("@Title", txtTitle.Text.Trim()),
                new SqlParameter("@Content", txtContent.Text.Trim()),
                new SqlParameter("@Category", ddlCategory.SelectedValue),
                new SqlParameter("@Author", (object)txtAuthor.Text.Trim() ?? DBNull.Value),
                new SqlParameter("@Id", ArticleId));

            Session["ArticleMessage"] = "✅ Article updated successfully!";
            Response.Redirect("~/Admin/Articles/Index.aspx");
        }
    }
}
