using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Configuration;
namespace Helper
{
    public class LogHelper
    {
        public static void WriteLog(string Log)
        {
            try
            {
                string path = ConfigurationManager.AppSettings["Logs"].ToString() + "\\" + DateTime.Now.ToString("yyyyMMdd");

                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

            }
            catch (Exception ex)
            {

            }
        }
    }
}
