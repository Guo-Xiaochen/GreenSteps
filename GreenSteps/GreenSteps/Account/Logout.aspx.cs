using System;
using System.Web.UI;

namespace GreenSteps.Account
{
    public partial class Logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session["FlashMessage"] = "👋 You have been logged out successfully.";
            Response.Redirect("~/Default.aspx");
        }
    }
}
