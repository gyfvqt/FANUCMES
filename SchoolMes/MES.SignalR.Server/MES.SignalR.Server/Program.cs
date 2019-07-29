using Microsoft.Owin.Hosting;
using System;
using System.Configuration;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.InteropServices;
using Topshelf;

namespace MES.SignalR.Server
{
    class Program
    {
        [DllImport("user32.dll", EntryPoint = "ShowWindow", SetLastError = true)]
        static extern bool ShowWindow(IntPtr hWnd, uint nCmdShow);
        [DllImport("user32.dll", EntryPoint = "FindWindow", SetLastError = true)]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

        static void Main(string[] args)
        {
            //Console.Title = "WAHAHA";
            //IntPtr intptr = FindWindow("ConsoleWindowClass", "WAHAHA");
            //if (intptr != IntPtr.Zero)
            //{
            //    ShowWindow(intptr, 0);//隐藏这个窗口
            //}
            var rc = HostFactory.Run(x =>                                   //1
            {
                x.Service<TownCrier>(s =>                                   //2
                {
                    s.ConstructUsing(name => new TownCrier());                //3
                    s.WhenStarted(tc => tc.Start());                         //4
                    s.WhenStopped(tc => tc.Stop());                          //5
                });
                x.RunAsLocalSystem();                                       //6

                x.SetDescription("SignalR Server Host");                   //7
                x.SetDisplayName("SignalRServerHost");                                  //8
                x.SetServiceName("SignalRServerHost");                                  //9
            });                                                             //10

            var exitCode = (int)Convert.ChangeType(rc, rc.GetTypeCode());  //11
            Environment.ExitCode = exitCode;
            //if (RunningInstance() == null)
            //{
            //string url = ConfigurationManager.AppSettings["URL"];
            //    try
            //    {
            //        //string url = "http://localhost:10086";//设定 SignalR Hub Server 对外的接口
                    
            //        using (WebApp.Start(url))//启动 SignalR Hub Server
            //        {
            //            Console.WriteLine("Server running on {0}", url);
            //            Console.ReadLine();
            //        }
            //    }
            //    catch (Exception ex)
            //    {
            //        Console.WriteLine("Server is started on {0},don't start repeatedly", url);
            //        Console.WriteLine("Error {0}", ex.Message);
            //        Console.ReadLine();
            //    }

            //}
            



        }
        public static Process RunningInstance()

        {

            Process current = Process.GetCurrentProcess();

            Process[] processes = Process.GetProcessesByName(current.ProcessName);

            //Loop through the running processes in with the same name 

            foreach (Process process in processes)

            {

                //Ignore the current process 

                if (process.Id != current.Id)

                {

                    //Make sure that the process is running from the exe file. 

                    if (Assembly.GetExecutingAssembly().Location.Replace("/", "\\") == current.MainModule.FileName)

                    {

                        //Return the other process instance. 

                        return process;

                    }

                }

            }

            //No other instance was found, return null. 

            return null;

        }
    }
}
