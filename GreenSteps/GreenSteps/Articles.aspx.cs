using System;
using System.Data;
using System.Web.UI;
using GreenSteps.Models;

namespace GreenSteps
{
    public partial class Articles : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadArticles();
            }
        }

        private void LoadArticles()
        {
            DataTable dt = DataAccess.ExecuteQuery(
                "SELECT * FROM Articles ORDER BY PublishedDate DESC");
            rptArticles.DataSource = dt;
            rptArticles.DataBind();
        }

        protected string TrimContent(string content)
        {
            if (string.IsNullOrEmpty(content)) return "";
            return content.Length > 200 ? content.Substring(0, 200) + "..." : content;
        }
    }
}
