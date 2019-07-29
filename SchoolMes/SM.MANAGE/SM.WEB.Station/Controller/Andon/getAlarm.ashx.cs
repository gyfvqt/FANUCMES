using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Station.Controller.Andon
{
    /// <summary>
    /// getAlarm 的摘要说明
    /// </summary>
    public class getAlarm : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string Team = HttpContext.Current.Request.Params["team"];
                string sqlSearch =string.Format( @"select top 2 a.*,b.ParentId,b.EquipmentCode,b.EquipmentName,b.Team 
                                from EquipmentFault(nolock) a 
                                join EquipmentData(nolock) b on a.EquipmentId=b.ID
                                where b.Team=N'{0}' and FaultEndTime is null
                                order by a.ID desc",Team);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);

                string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());

                HttpContext.Current.Response.Write(result);

            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("0");
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