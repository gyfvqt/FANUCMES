using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace SM.WEB.Station
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // 在应用程序启动时运行的代码
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
        protected void Application_End(object sender, EventArgs e)
        {
            //在应用程序关闭时运行的代码 
            //解决应用池回收问题 
            System.Threading.Thread.Sleep(2000);
            //HitPage();
        }
    }
}