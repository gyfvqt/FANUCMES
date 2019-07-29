using Helper;
using Microsoft.Owin.Hosting;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace SM.MES.SignalR.Server
{
    static class Program
    {
        /// <summary>
        /// 应用程序的主入口点。
        /// </summary>
        static void Main()
        {
            //string url = ConfigurationManager.AppSettings["URL"];  //"http://10.27.163.14:10086";//设定 SignalR Hub Server 对外的接口
            //using (WebApp.Start(url))//启动 SignalR Hub Server
            //{
            //    SystemLogs.InsertErrLog(string.Format("Server running on {0}", url));
            //}
            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[]
            {
                new MesAlertServer()
            };
            ServiceBase.Run(ServicesToRun);
        }
    }
}
