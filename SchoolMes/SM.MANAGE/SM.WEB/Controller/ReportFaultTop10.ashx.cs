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
    /// ReportFaultTop10 的摘要说明
    /// </summary>
    public class ReportFaultTop10 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            
            string EId = HttpContext.Current.Request.Params["eid"];

            string DTSTART = HttpContext.Current.Request.Params["dtstart"];

            string DTEND = HttpContext.Current.Request.Params["dtend"];

            string sqlwhere = "";
            if (EId.Trim() != "")
            {
                sqlwhere += " AND EquipmentId=N'" + EId.Trim() + "'";
            }
            if (DTSTART.Trim() != "")
            {
                sqlwhere += " AND FaultBeginTime>=N'" + DTSTART.Trim() + "'";
            }
            if (DTEND.Trim() != "")
            {
                sqlwhere += " AND FaultBeginTime<=N'" + DTEND.Trim() + "'";
            }
            string sql = string.Format(@" select top 10 equipmentid,faultid,faultdesc, count(1) as xcount from EquipmentFault(nolock) where 1=1 {0}
                            group by equipmentid,faultid,faultdesc 
                            order by xcount desc", sqlwhere);
            DataSet dsSearch = SQLHelper.GetDataSet(sql);
            
            string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());
            HttpContext.Current.Response.Write(result);

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