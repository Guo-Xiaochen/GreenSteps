using System;
using System.Web.Optimization;
using System.Web.Routing;

namespace GreenSteps
{
    public class Global : System.Web.HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // 注册 FriendlyUrls（自动处理 Web Forms 友好 URL）
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            // 注册捆绑（CSS/JS 压缩）
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}