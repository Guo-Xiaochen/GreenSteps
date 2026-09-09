using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string input = txtEmailOrName.Text.Trim();
            string password = txtPassword.Text;

            // Look up user by email OR full name (case-insensitive)
            DataTable dt = DataAccess.ExecuteQuery(
                "SELECT UserId, FullName, Email, Role FROM Users " +
                "WHERE (LOWER(Email) = LOWER(@Input) OR LOWER(FullName) = LOWER(@Input)) " +
                "AND Password = @Password",
                new SqlParameter("@Input", input),
                new SqlParameter("@Password", password));

            if (dt.Rows.Count == 0)
            {
                litMessage.Text = "<div class='alert alert-error'>❌ Invalid credentials. Please check your email/name and password.</div>";
                return;
            }

            DataRow user = dt.Rows[0];
            Session["UserId"] = Convert.ToInt32(user["UserId"]);
            Session["UserName"] = user["FullName"].ToString();
            Session["UserEmail"] = user["Email"].ToString();
            Session["UserRole"] = user["Role"].ToString();
            Session["FlashMessage"] = "👋 Welcome back, " + user["FullName"].ToString() + "!";

            if (user["Role"].ToString() == "Admin")
                Response.Redirect("~/Admin/Dashboard.aspx");
            else
                Response.Redirect("~/Default.aspx");
        }
    }
}
