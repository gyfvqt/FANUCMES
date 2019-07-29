using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Sockets;
using System.Data;
using Helper;
using System.Configuration;
using System.Management;

namespace SM.WEB.Station
{
    public partial class Station : System.Web.UI.Page
    {
        public DataSet ds = new DataSet();
        public string stationCode = "";
        public string stationId = "";
        public string linename = "";
        public string HUPIP = "127.0.0.1";
        public string PlanCycle = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var cpusn = GetCPUSerialNumber();
                HUPIP = ConfigurationManager.AppSettings["SignalRServer"].ToString();
                var IP = GetLocalIp();
                ds = BaseHelper.GetStationBase(IP);
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    stationCode = ds.Tables[0].Rows[0]["StationCode"].ToString();
                    stationId = ds.Tables[0].Rows[0]["ID"].ToString();
                    linename = ds.Tables[0].Rows[0]["LineName"].ToString();
                    PlanCycle = ds.Tables[0].Rows[0]["PlanCycle"].ToString();
                    if (ds.Tables[0].Rows[0]["StationType"].ToString() == "PC")
                    {
                        var url = "PCStationView.aspx?stationid=" + ds.Tables[0].Rows[0]["ID"].ToString() + "&stationcode=" + ds.Tables[0].Rows[0]["StationCode"].ToString()+"&timespan="+DateTime.Now.Ticks;
                        Response.Redirect(url);
                    }
                    else if (ds.Tables[0].Rows[0]["StationType"].ToString() == "PLC")
                    {
                        var url = "PLCStationView.aspx?stationid=" + ds.Tables[0].Rows[0]["ID"].ToString() + "&stationcode=" + ds.Tables[0].Rows[0]["StationCode"].ToString() + "&timespan=" + DateTime.Now.Ticks;
                        Response.Redirect(url);
                    }
                }
                
            }
            catch (Exception ex)
            { }
        }

        public static string GetLocalIp()
        {
            IPAddress localIp = null;

            try
            {
                IPAddress[] ipArray;
                ipArray = Dns.GetHostAddresses(Dns.GetHostName());
                localIp = ipArray.First(ip => ip.AddressFamily == AddressFamily.InterNetwork);

            }
            catch (Exception ex)
            {
            }
            if (localIp == null)
            {
                localIp = IPAddress.Parse("127.0.0.1");
            }
            return localIp.ToString();
        }

        public static string GetCPUSerialNumber()
        {
            string cpuSerialNumber = string.Empty;
            ManagementClass mc = new ManagementClass("Win32_Processor");
            ManagementObjectCollection moc = mc.GetInstances();
            foreach (ManagementObject mo in moc)
            {
                cpuSerialNumber = mo["ProcessorId"].ToString();
                break;
            }
            mc.Dispose();
            moc.Dispose();
            return cpuSerialNumber;
        }
    }
}