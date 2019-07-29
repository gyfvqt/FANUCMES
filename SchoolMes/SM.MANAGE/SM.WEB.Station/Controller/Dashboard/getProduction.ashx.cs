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
    /// getProduction 的摘要说明
    /// </summary>
    public class getProduction : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string LineId = HttpContext.Current.Request.Params["lineId"];
                
                var stime = DateTime.Now.ToString("yyyy-MM-dd ") + "00:00:00";
                var etime = DateTime.Now.ToString("yyyy-MM-dd ") + "23:59:59";
                DataSet ds = SQLHelper.GetDataSet(string.Format(@"select count(1) as count5 from ERPOrderDetails where Status=5 and UpdateTime5>=N'{0}' and UpdateTime5<=N'{1}' and LineId=N'{2}';
                select count(1) as count3 from ERPOrderDetails where Status=3 and UpdateTime>=N'{0}' and UpdateTime<=N'{1}' and LineId=N'{2}';",  stime,etime, LineId));
                //当天完成的订单
                var count5 = ds.Tables[0].Rows[0]["count5"].ToString();
                //当天下达的订单
                var count3 = ds.Tables[1].Rows[0]["count3"].ToString();

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
                DataSet dsline = SQLHelper.GetDataSet(string.Format(@"select * from LineInfo(nolock) where ID=N'{0}'", LineId));
                //计划产量
                double planCount = 0;  
                if (dsline != null && dsline.Tables[0].Rows.Count > 0)
                {                    
                    planCount= int.Parse(dsline.Tables[0].Rows[0]["PlanCycle"].ToString()) * totalSpandTime / 60;
                }
                //实绩产量
                var actureCount = SQLHelper.GetObject(string.Format(@"select count(1) from EndProduct(nolock) where Status in(2,3) and EndTime>=N'{0}' AND EndTime<=N'{1}'",
                    dtbeginx.ToString("yyyy-MM-dd HH:mm:ss"), dtendx.ToString("yyyy-MM-dd HH:mm:ss"))).ToString();
                
                //累计JPH                
                var JPH = (int.Parse(actureCount) / (totalSpandTime / 60)).ToString("f1");                

                string result = count3 + "|" + count5 + "|" + planCount.ToString("f0") + "|" + actureCount + "|" + JPH;
                if (totalSpandTime == 0) result = "0|0|0|0|0";
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