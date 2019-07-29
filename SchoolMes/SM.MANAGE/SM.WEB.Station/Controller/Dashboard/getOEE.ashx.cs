using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SM.WEB.Station.Controller.Dashboard
{
    /// <summary>
    /// getOEE 的摘要说明
    /// </summary>
    public class getOEE : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string LineId = HttpContext.Current.Request.Params["eid"];
                DataSet dsline = SQLHelper.GetDataSet(string.Format(@"select * from EquipmentData(nolock) where ID=N'{0}'", LineId));
                var DJPH = dsline.Tables[0].Rows[0]["DesignJPH"].ToString();

                double totalSpandTime = 0;
                double totalshifttime = 0;

                string sqlSearch = @"select * from WorkShift(nolock)";
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);
                DateTime dt = DateTime.Now;
                DateTime dtbegin, dtend;
                dtbegin = dtend = dt;
                DateTime dtbeginx, dtendx;
                dtbeginx = dtendx = dt;

                if (dsSearch != null && dsSearch.Tables[0].Rows.Count > 0)
                {

                    //获取当前班次的开始时间和结束时间
                    for (int i = 0; i < dsSearch.Tables[0].Rows.Count; i++)
                    {
                        dtbegin = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["BeginTime"].ToString().Trim());
                        dtend = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["EndTime"].ToString().Trim());
                        if (dtbegin >= dtend) dtend = dtend.AddDays(1);//跨天结束时间加1天
                        if (dtbegin <= dt && dt <= dtend)
                        {
                            dtbeginx = dtbegin;
                            dtendx = dtend;
                        }
                    }
                    totalSpandTime = (dt - dtbeginx).TotalMinutes;
                    totalshifttime = (dtendx - dtbeginx).TotalMinutes;
                    //获取班次小休
                    DataSet dsrest = SQLHelper.GetDataSet("select * from Rest(nolock)");
                    double spandrest = 0;
                    if (dsrest != null && dsrest.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < dsrest.Tables[0].Rows.Count; i++)
                        {
                            dtbegin = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["BeginTime"].ToString().Trim());
                            dtend = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["EndTime"].ToString().Trim());
                            if (dtbegin >= dtend) dtend = dtend.AddDays(1);//跨天结束时间加1天
                            if (dt >= dtend)
                            {
                                spandrest = (dtend - dtbegin).TotalMinutes;
                            }
                            else if (dt > dtbegin && dt <= dtend)
                            {
                                spandrest = (dt - dtbegin).TotalMinutes;
                            }
                            totalSpandTime -= spandrest;
                            totalshifttime -= spandrest;
                        }
                    }
                }
                //运行时间总长
                double runtime = totalSpandTime;
                //累计故障时长
                string sql = string.Format(@"select 
                                 sum(DATEDIFF(minute,starttime,isnull(endtime,getdate()))) faultminute from FaultInfo(nolock) a
                                JOIN EquipmentData(nolock) b on a.parentid=b.ID and a.FaultType<>5
                                where StartTime>=N'{0}' AND StartTime<=N'{1}' 
                                 ", dtbeginx.ToString("yyyy-MM-dd HH:mm:ss"), dtendx.ToString("yyyy-MM-dd HH:mm:ss"));
                var faultlong = SQLHelper.GetObject(sql).ToString();
                faultlong = faultlong == "" ? "0" : faultlong;

                //累计JPH
                string sqlJPH = string.Format(@"select count(1) as acturecount from CycleTimeInfo(nolock)
  where EId in (select a.ID from EquipmentData(nolock) a
join EquipmentData(nolock) b on a.ParentId=b.ID and a.EType=3 and b.EType=2 and b.ParentId=N'{2}'
union
select a.ID from EquipmentData(nolock) a
join EquipmentData(nolock) b on a.ParentId=b.ID and a.EType=2 and b.EType=1 and b.ID=N'{2}') 
                                and StartTime>=N'{0}' AND StartTime<=N'{1}' 
                                 ", dtbeginx.ToString("yyyy-MM-dd HH:mm:ss"), dtendx.ToString("yyyy-MM-dd HH:mm:ss"), LineId);
                var acount = SQLHelper.GetObject(sqlJPH).ToString();
                var JPH = (int.Parse(acount) / (totalSpandTime / 60)).ToString("f1");

                //设备使用效率=OEE ？
                var OEE = runtime == 0 ? "100" : ((runtime - double.Parse(faultlong)) * 100 / runtime).ToString("f1") ;


                string result = runtime.ToString("f0") + "|" + faultlong + "|" + DJPH + "|" + JPH + "|" + OEE;
                HttpContext.Current.Response.Write(result);
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("");
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}