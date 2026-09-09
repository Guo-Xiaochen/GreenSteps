using System;
using System.Web.UI;

namespace GreenSteps
{
    public partial class SiteMaster : MasterPage
    {
        public bool IsLoggedIn { get { return Session["UserId"] != null; } }
        public bool IsAdmin { get { return (Session["UserRole"] as string) == "Admin"; } }
        public string UserName { get { return Session["UserName"] as string ?? ""; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Show welcome banner if TempMessage is set (session-based flash message)
            if (Session["FlashMessage"] != null)
            {
                litWelcomeBanner.Text = "<div class='welcome-banner'>" +
                    Server.HtmlEncode(Session["FlashMessage"].ToString()) + "</div>";
                Session.Remove("FlashMessage");
            }
        }
    }
}
