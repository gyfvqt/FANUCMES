﻿using System;
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
    public partial class Andon : System.Web.UI.Page
    {
        public DataSet ds = new DataSet();
        public string stationCode = "";
        public string stationId = "";
        public string linename = "";
        public string AndonId = "";
        public string AndonNo = "";
        public string LineCode = "";
        public string LineId = "";
        public string HUPIP = "127.0.0.1";
        public string PlanCycle = "0";
        public string ProcessSheet = "";
        public string Team = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var IP = GetLocalIp();
                ds = BaseHelper.GetAndon(IP);
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    LineId= ds.Tables[0].Rows[0]["LineId"].ToString();
                    AndonNo = ds.Tables[0].Rows[0]["AndonNo"].ToString();
                    linename = ds.Tables[0].Rows[0]["LineName"].ToString();
                    PlanCycle = ds.Tables[0].Rows[0]["PlanCycle"].ToString();
                    Team= ds.Tables[0].Rows[0]["Team"].ToString();
                }
                else
                {
                    AndonId = Request.QueryString["Id"] != null ? Request.QueryString["Id"].ToString() : "";
                    if (AndonId != "")
                    {
                        ds = BaseHelper.GetAndonByid(AndonId);
                        if (ds != null && ds.Tables[0].Rows.Count > 0)
                        {
                            AndonNo = ds.Tables[0].Rows[0]["AndonNo"].ToString();
                            linename = ds.Tables[0].Rows[0]["LineName"].ToString();
                            PlanCycle = ds.Tables[0].Rows[0]["PlanCycle"].ToString();
                            LineId = ds.Tables[0].Rows[0]["LineId"].ToString();
                            Team = ds.Tables[0].Rows[0]["Team"].ToString();
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