using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps.Account
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            // Check if email already exists
            var check = DataAccess.ExecuteScalar(
                "SELECT COUNT(*) FROM Users WHERE Email = @Email",
                new SqlParameter("@Email", email));

            if (Convert.ToInt32(check) > 0)
            {
                litMessage.Text = "<div class='alert alert-error'>❌ This email is already registered.</div>";
                return;
            }

            // Insert new user
            DataAccess.ExecuteNonQuery(
     "INSERT INTO Users (FullName, Email, Password, Role, CreatedAt) VALUES (@FullName, @Email, @Password, 'User', GETDATE())",
     new SqlParameter("@FullName", fullName),
     new SqlParameter("@Email", email),
     new SqlParameter("@Password", password));

            // Get the new user's ID
            var newUserId = DataAccess.ExecuteScalar(
                "SELECT UserId FROM Users WHERE Email = @Email",
                new SqlParameter("@Email", email));

            // Auto-login
            Session["UserId"] = Convert.ToInt32(newUserId);
            Session["UserName"] = fullName;
            Session["UserEmail"] = email;
            Session["UserRole"] = "User";
            Session["FlashMessage"] = "🎉 Welcome to GreenSteps, " + fullName + "!";

            Response.Redirect("~/Default.aspx");
        }
    }
}
