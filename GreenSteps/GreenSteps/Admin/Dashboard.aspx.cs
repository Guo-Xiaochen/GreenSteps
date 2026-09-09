using System;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Admin only
            if ((Session["UserRole"] as string) != "Admin")
            {
                Session["FlashMessage"] = "🔒 Admin access required.";
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                litName.Text = Server.HtmlEncode(Session["UserName"] as string ?? "Admin");
                litArticles.Text = DataAccess.ExecuteScalar("SELECT COUNT(*) FROM Articles").ToString();
                litVideos.Text = DataAccess.ExecuteScalar("SELECT COUNT(*) FROM Videos").ToString();
                litQuizzes.Text = DataAccess.ExecuteScalar("SELECT COUNT(*) FROM Quizzes").ToString();
                litQuestions.Text = DataAccess.ExecuteScalar("SELECT COUNT(*) FROM Questions").ToString();
                litUsers.Text = DataAccess.ExecuteScalar("SELECT COUNT(*) FROM Users").ToString();
            }
        }
    }
}
