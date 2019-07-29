using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNet.SignalR.Client;
using System.Configuration;

namespace MES.SignalRConsoleClient
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.Write("请输入用户名: ");
            string clientName = Console.ReadLine();


            var url = ConfigurationManager.AppSettings["URL"].ToString(); //"http://10.27.163.14:10086";
            var connection = new HubConnection(url);
            var chatHub = connection.CreateHubProxy("IMHub");

            connection.Start().ContinueWith(t =>
            {
                if (!t.IsFaulted)
                {
                    //连接成功，调用Register方法
                    chatHub.Invoke("Register", clientName);
                }
            });

            //客户端接收实现，可以用js，也可以用后端接收
            var broadcastHandler = chatHub.On<string, string>("receivePrivateMessage", (name, message) =>
            {
                Console.WriteLine("[{0}]{1}: {2}", DateTime.Now.ToString("HH:mm:ss"), name, message);
            });

            Console.WriteLine("请输入接收者名:");
            var _name = Console.ReadLine();
            Console.WriteLine("请输入发送信息!");
            while (true)
            {
                var _message = Console.ReadLine();
                chatHub.Invoke("SendPrivateMessage", _name, _message).ContinueWith(t =>
                {
                    if (t.IsFaulted)
                    {
                        Console.WriteLine("连接失败!");
                    }
                });
                Console.WriteLine("请输入接收者名:");
                _name = Console.ReadLine();
                Console.WriteLine("请输入发送信息!");
            }

        }
    }
}
