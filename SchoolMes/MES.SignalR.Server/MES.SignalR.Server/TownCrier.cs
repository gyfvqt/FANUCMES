using Microsoft.Owin.Hosting;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using Microsoft.Owin.Host.HttpListener;

namespace MES.SignalR.Server
{
    public class TownCrier
    {
        readonly Timer _timer;
        public TownCrier()
        {
            _timer = new Timer(1000) { AutoReset = true };
            _timer.Elapsed += (sender, eventArgs) => Console.WriteLine("It is {0} and all is well", DateTime.Now);
        }
        public void Start() {
            _timer.Start();
            //string url = ConfigurationManager.AppSettings["URL"];
            //try
            //{
            //    //string url = "http://localhost:10086";//设定 SignalR Hub Server 对外的接口

            //    using (WebApp.Start(url))//启动 SignalR Hub Server
            //    {
            //        Console.WriteLine("Server running on {0}", url);
            //        Console.ReadLine();
            //    }
            //}
            //catch (Exception ex)
            //{
            //    Console.WriteLine("Server is started on {0},don't start repeatedly", url);
            //    Console.WriteLine("Error {0}", ex.Message);
            //    Console.ReadLine();
            //}
            Startup.StartServer();

        }
        public void Stop() { _timer.Stop(); Startup.StopServer(); }

    }
}
