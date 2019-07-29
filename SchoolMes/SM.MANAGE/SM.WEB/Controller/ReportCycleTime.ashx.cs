using DAL;
using GF2.MES.Report.Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// ReportCycleTime 的摘要说明
    /// </summary>
    public class ReportCycleTime : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";                
                string EId = HttpContext.Current.Request.Params["eid"];
                string DTSTART = HttpContext.Current.Request.Params["dtstart"];
                string DTEND = HttpContext.Current.Request.Params["dtend"];
                string EType = HttpContext.Current.Request.Params["etype"];
                string sqlSearch = "";
                if (EType == "1")//线体
                {
                    sqlSearch = string.Format(@"SELECT a.EId,a.StartTime,a.EndTime,b.ID,b.ParentId,b.EquipmentName,DATEDIFF(minute,starttime,isnull(endtime,getdate())) as cycletime FROM CycleTimeInfo(NOLOCK) a 
                                  join EquipmentData(nolock) b on a.ParentId=b.ID and b.ParentId=N'{2}'
                                  where a.EndTime>=N'{0}' and a.EndTime<N'{1}' order by a.EId,b.EquipmentName  ", DTSTART.Trim(), DTEND.Trim(), EId);
                }
                else if (EType == "2")//站点
                {
                    sqlSearch = string.Format(@"SELECT a.EId,a.StartTime,a.EndTime,b.ID,b.ParentId,b.EquipmentName,DATEDIFF(minute,starttime,isnull(endtime,getdate())) as cycletime FROM CycleTimeInfo(NOLOCK) a 
                                  join EquipmentData(nolock) b on a.ParentId=b.ID and b.ID=N'{2}'
                                  where a.EndTime>=N'{0}' and a.EndTime<N'{1}' order by a.EId,b.EquipmentName  ", DTSTART.Trim(), DTEND.Trim(), EId);
                }
                else if (EType == "3")//设备
                {
                    sqlSearch = string.Format(@"SELECT a.EId,a.StartTime,a.EndTime,b.ID,b.ParentId,b.EquipmentName,DATEDIFF(minute,starttime,isnull(endtime,getdate())) as cycletime FROM CycleTimeInfo(NOLOCK) a 
                                  join EquipmentData(nolock) b on a.EId=b.ID  and b.ID=N'{2}'
                                  where a.EndTime>=N'{0}' and a.EndTime<N'{1}' order by a.EId,b.EquipmentName  ", DTSTART.Trim(), DTEND.Trim(), EId);
                }
                if (sqlSearch != "")
                {
                    DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);
                    string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());
                    HttpContext.Current.Response.Write(result);
                }
            }
            catch (Exception ex)
            {
               
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