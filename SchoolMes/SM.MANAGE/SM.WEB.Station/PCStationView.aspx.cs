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

namespace SM.WEB.Station
{
    public partial class PCStationView : System.Web.UI.Page
    {
        public DataSet ds = new DataSet();
        public string stationCode = "";
        public string stationId = "";
        public string linename = "";
        public string HUPIP = "127.0.0.1";
        public string PlanCycle = "0";
        public string ProcessSheet = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var IP = GetLocalIp();
                ds = BaseHelper.GetStationBase(IP);
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    stationCode = ds.Tables[0].Rows[0]["StationCode"].ToString();
                    stationId = ds.Tables[0].Rows[0]["ID"].ToString();
                    linename = ds.Tables[0].Rows[0]["LineName"].ToString();
                    PlanCycle = ds.Tables[0].Rows[0]["PlanCycle"].ToString();
                    ProcessSheet = ds.Tables[0].Rows[0]["ProcessSheet"].ToString() == "" ? "#" : ds.Tables[0].Rows[0]["ProcessSheet"].ToString();
                }
                else
                {
                    stationId = Request.QueryString["stationid"] != null ? Request.QueryString["stationid"].ToString() : "";
                    if (stationId != "")
                    {
                        ds = BaseHelper.GetStationBaseById(stationId);
                        if (ds != null && ds.Tables[0].Rows.Count > 0)
                        {
                            stationCode = ds.Tables[0].Rows[0]["StationCode"].ToString();
                            stationId = ds.Tables[0].Rows[0]["ID"].ToString();
                            linename = ds.Tables[0].Rows[0]["LineName"].ToString();
                            PlanCycle = ds.Tables[0].Rows[0]["PlanCycle"].ToString();
                            ProcessSheet = ds.Tables[0].Rows[0]["ProcessSheet"].ToString() == "" ? "#" : ds.Tables[0].Rows[0]["ProcessSheet"].ToString();
                        }
                    }

                }
                HUPIP = ConfigurationManager.AppSettings["SignalRServer"].ToString();
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
    }
}