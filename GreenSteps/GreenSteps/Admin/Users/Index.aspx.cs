using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Admin_Users_Index : Page
    {
        private int CurrentAdminId
        {
            get { return Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0; }
        }

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
                LoadUsers();
                ShowFlashMessage();
            }
        }

        private void ShowFlashMessage()
        {
            if (Session["UserMessage"] != null)
            {
                litMessage.Text = "<div class='alert alert-success'>" +
                    Server.HtmlEncode(Session["UserMessage"].ToString()) + "</div>";
                Session.Remove("UserMessage");
            }
            if (Session["UserError"] != null)
            {
                litMessage.Text += "<div class='alert alert-error'>" +
                    Server.HtmlEncode(Session["UserError"].ToString()) + "</div>";
                Session.Remove("UserError");
            }
        }

        private void LoadUsers()
        {
            DataTable dt = DataAccess.ExecuteQuery(
                "SELECT UserId, FullName, Email, Role, CreatedAt FROM Users ORDER BY CreatedAt DESC");
            gvUsers.DataSource = dt;
            gvUsers.DataBind();

            // Stats
            litTotal.Text = dt.Rows.Count.ToString();
            int adminCount = 0, userCount = 0;
            foreach (DataRow r in dt.Rows)
            {
                if (r["Role"].ToString() == "Admin") adminCount++;
                else userCount++;
            }
            litAdmins.Text = adminCount.ToString();
            litUsers.Text = userCount.ToString();
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int userId = Convert.ToInt32(e.CommandArgument);

            // Self-protection: can't do actions on yourself
            if (userId == CurrentAdminId && e.CommandName != "None")
            {
                Session["UserError"] = "🛡️ You cannot perform this action on your own account!";
                Response.Redirect(Request.RawUrl);
                return;
            }

            if (e.CommandName == "PromoteUser")
            {
                DataAccess.ExecuteNonQuery(
                    "UPDATE Users SET Role = 'Admin' WHERE UserId = @Id",
                    new SqlParameter("@Id", userId));
                Session["UserMessage"] = "👑 User promoted to Admin successfully!";
            }
            else if (e.CommandName == "DemoteUser")
            {
                DataAccess.ExecuteNonQuery(
                    "UPDATE Users SET Role = 'User' WHERE UserId = @Id",
                    new SqlParameter("@Id", userId));
                Session["UserMessage"] = "📉 Admin demoted to regular User.";
            }
            else if (e.CommandName == "DeleteUser")
            {
                // Get name first for the message
                var name = DataAccess.ExecuteScalar(
                    "SELECT FullName FROM Users WHERE UserId = @Id",
                    new SqlParameter("@Id", userId));

                DataAccess.ExecuteNonQuery(
                    "DELETE FROM Users WHERE UserId = @Id",
                    new SqlParameter("@Id", userId));

                Session["UserMessage"] = "🗑️ User '" + (name != null ? name.ToString() : "") + "' has been deleted.";
            }

            Response.Redirect(Request.RawUrl);
        }

        // Helpers
        protected string ShowYouBadge(object userId)
        {
            if (Convert.ToInt32(userId) == CurrentAdminId)
                return "<span style='background:#fff59d; color:#5d4037; padding:0.2rem 0.5rem; border-radius:4px; font-size:0.75rem; font-weight:600; margin-left:0.5rem;'>YOU</span>";
            return "";
        }

        protected string ShowRolePill(object role)
        {
            string r = role.ToString();
            if (r == "Admin")
                return "<span style='background:#ffebee; color:#c62828; padding:0.25rem 0.7rem; border-radius:4px; font-size:0.85rem; font-weight:500;'>👑 Admin</span>";
            else
                return "<span style='background:#e3f2fd; color:#1565c0; padding:0.25rem 0.7rem; border-radius:4px; font-size:0.85rem; font-weight:500;'>🌱 User</span>";
        }

        protected string ShowActionButtons(object userId, object role)
        {
            int uid = Convert.ToInt32(userId);
            string r = role.ToString();

            // If viewing self, show protected badge
            if (uid == CurrentAdminId)
                return "<span style='background:#ccc; color:white; padding:0.4rem 0.9rem; border-radius:5px; font-size:0.85rem;'>🛡️ Protected (You)</span>";

            string buttons = "";

            if (r == "User")
            {
                // Regular User: show Promote + Delete
                buttons += "<a href='javascript:void(0);' onclick=\"if(confirm('Promote this user to Admin?')) __doPostBack('gvUsers','PromoteUser$" + uid + "');\" style='background:#6a1b9a; color:white; padding:0.4rem 0.9rem; border-radius:5px; font-size:0.85rem; font-weight:500; text-decoration:none; display:inline-block; margin-right:0.3rem;'>👑 Promote</a>";
                buttons += "<a href='javascript:void(0);' onclick=\"if(confirm('Delete this user permanently? This cannot be undone!')) __doPostBack('gvUsers','DeleteUser$" + uid + "');\" style='background:#c62828; color:white; padding:0.4rem 0.9rem; border-radius:5px; font-size:0.85rem; font-weight:500; text-decoration:none; display:inline-block;'>🗑️ Delete</a>";
            }
            else
            {
                // Admin: show Demote + Delete
                buttons += "<a href='javascript:void(0);' onclick=\"if(confirm('Demote this admin to regular User?')) __doPostBack('gvUsers','DemoteUser$" + uid + "');\" style='background:#f57c00; color:white; padding:0.4rem 0.9rem; border-radius:5px; font-size:0.85rem; font-weight:500; text-decoration:none; display:inline-block; margin-right:0.3rem;'>📉 Demote</a>";
                buttons += "<a href='javascript:void(0);' onclick=\"if(confirm('Delete this admin permanently? This cannot be undone!')) __doPostBack('gvUsers','DeleteUser$" + uid + "');\" style='background:#c62828; color:white; padding:0.4rem 0.9rem; border-radius:5px; font-size:0.85rem; font-weight:500; text-decoration:none; display:inline-block;'>🗑️ Delete</a>";
            }

            return buttons;
        }
    }
}