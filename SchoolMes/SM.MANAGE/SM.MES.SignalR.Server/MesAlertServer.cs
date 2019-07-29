using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Owin.Hosting;
using System.Configuration;
using Helper;
using Microsoft.Owin;
using System.Timers;

[assembly: OwinStartup(typeof(SM.MES.SignalR.Server.Startup))]
namespace SM.MES.SignalR.Server
{
    public partial class MesAlertServer : ServiceBase
    {
        readonly Timer _timer;
        public MesAlertServer()
        {
            _timer = new Timer(1000) { AutoReset = true };
            _timer.Elapsed += (sender, eventArgs) => Console.WriteLine("It is {0} and all is well", DateTime.Now);
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            _timer.Start();
            Startup.StartServer();
        }

        protected override void OnStop()
        {
            _timer.Stop();
            Startup.StopServer();
        }
    }
}
