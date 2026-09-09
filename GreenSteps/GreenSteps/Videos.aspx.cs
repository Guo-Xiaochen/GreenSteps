using System;
using System.Data;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Videos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = DataAccess.ExecuteQuery(
                    "SELECT * FROM Videos ORDER BY UploadedDate DESC");
                rptVideos.DataSource = dt;
                rptVideos.DataBind();
            }
        }
    }
}
