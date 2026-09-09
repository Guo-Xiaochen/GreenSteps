using System;
using System.Web.UI;

namespace GreenSteps
{
    public partial class _Default : Page
    {
        public bool IsAdminUser
        {
            get { return (Session["UserRole"] as string) == "Admin"; }
        }

        protected void Page_Load(object sender, EventArgs e) { }
    }
}
