using Microsoft.AspNet.SignalR;
using Microsoft.Owin;
using Microsoft.Owin.Cors;
using Microsoft.Owin.Hosting;
using Owin;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

[assembly: OwinStartup(typeof(SM.MES.SignalR.Server.Startup))]
namespace SM.MES.SignalR.Server
{
    public class Startup
    {
        static CancellationTokenSource _cancellationTokenSource = new CancellationTokenSource();
        private static IDisposable _runningInstance;
        // Your startup logic
        public static void StartServer()
        {
            var cancellationTokenSource = new CancellationTokenSource();
            Task.Factory.StartNew(RunSignalRServer, TaskCreationOptions.LongRunning
                                  , cancellationTokenSource.Token);
        }

        private static void RunSignalRServer(object task)
        {
            try
            {
                string url = ConfigurationManager.AppSettings["URL"];
                IOHelper.WriteLog(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + string.Format("Server running on {0}", url));
                _runningInstance = WebApp.Start(url);                
            }
            catch (Exception ex)
            {
                string url = ConfigurationManager.AppSettings["URL"];

                IOHelper.WriteLog(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + string.Format("Server running on {0} error!" + ex.Message, url));
            }
            

        }

        public static void StopServer()
        {
            _cancellationTokenSource.Cancel();
            _runningInstance.Dispose();
        }
        public void Configuration(IAppBuilder app)
        {
            //允许CORS跨域
            //app.UseCors(CorsOptions.AllowAll);
            //app.MapSignalR();

            app.Map("/signalr", map =>
            {
                // Setup the CORS middleware to run before SignalR.
                // By default this will allow all origins. You can 
                // configure the set of origins and/or http verbs by
                // providing a cors options with a different policy.
                map.UseCors(CorsOptions.AllowAll);
                var hubConfiguration = new HubConfiguration
                {
                    // You can enable JSONP by uncommenting line below.
                    // JSONP requests are insecure but some older browsers (and some
                    // versions of IE) require JSONP to work cross domain
                    EnableJSONP = true,
                    EnableDetailedErrors = true
                };
                // Run the SignalR pipeline. We're not using MapSignalR
                // since this branch already runs under the "/signalr"
                // path.
                map.RunSignalR(hubConfiguration);
            });

        }

    }
}
