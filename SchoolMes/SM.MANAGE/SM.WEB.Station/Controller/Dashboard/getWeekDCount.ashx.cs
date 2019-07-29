using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Station.Controller.Dashboard
{
    /// <summary>
    /// getWeekJPH 的摘要说明
    /// </summary>
    public class getWeekDCount : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string LineId = HttpContext.Current.Request.Params["lineId"];
                var now = DateTime.Now;
                var weekbegindate = TimeHelper.GetTimeStartByType("Week", now);
                string STime = TimeHelper.GetTimeStartByType("Week", now).ToString("yyyy-MM-dd HH:mm:ss");
                string ETime = TimeHelper.GetTimeEndByType("Week", now).ToString("yyyy-MM-dd HH:mm:ss");

                string sql = string.Format(@"  select TTime,sum(case QualityStatus when 'NOK' THEN 1 ELSE 0 END )AS DCount from(
                          select CONVERT(varchar(10),a.TransitTime,112) as TTime,isnull(c.QualityStatus,'OK') QualityStatus from ProductTransitInfo(nolock) a
                          join StationInfo(nolock) b on a.StationId=b.ID and b.IsFirstStation=3 
                          join EndProduct(nolock) c on a.ProductId=c.ID
                          where a.TransitTime>=N'{1}' and a.TransitTime<=N'{2}' and b.LineId=N'{0}'  
                          )f
                          group by TTime", LineId, STime, ETime);
                DataSet ds = SQLHelper.GetDataSet(sql);

                for (int i = 0; i < 7; i++)
                {
                    var date = weekbegindate.AddDays(i).ToString("yyyyMMdd");
                    DataRow[] dr = ds.Tables[0].Select("TTime='" + date + "'");
                    if (dr.Length == 0)
                    {
                        DataRow d = ds.Tables[0].NewRow();
                        d["TTime"] = date;
                        d["DCount"] = 0;
                        ds.Tables[0].Rows.Add(d);
                        ds.AcceptChanges();
                    }
                }
                ds.Tables[0].DefaultView.Sort = "TTime ASC";
                ds.Tables[0].DefaultView.ToTable();
                string result = JsonConvert.SerializeObject(ds.Tables[0].DefaultView.ToTable(), new DataTableConverter());
                HttpContext.Current.Response.Write(result);
            }
            catch (Exception ex)
            {
                //HttpContext.Current.Response.Write("-1");
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