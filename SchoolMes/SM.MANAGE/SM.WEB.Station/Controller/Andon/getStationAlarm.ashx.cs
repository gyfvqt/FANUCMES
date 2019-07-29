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
    /// getStationAlarm 的摘要说明
    /// </summary>
    public class getStationAlarm : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string Team = HttpContext.Current.Request.Params["team"];
                string sqlSearch = string.Format(@" select top 4 a.ID
                                                  ,a.StationId
	                                              ,CONVERT(varchar(100), a.StartTime, 20) StartTime
                                                  ,CONVERT(varchar(100), a.EndTime, 20) EndTime
                                                  ,a.FaultType
                                                  ,a.LineOrSatation,b.EquipmentCode  AS StationCode,b.EquipmentName StationName,b.Team,b.ParentId LineId
                                                  from FaultInfo(nolock) a join EquipmentData(nolock) b on a.parentid=b.ID
                                                  where a.EndTime is null and Team=N'T01' and a.LineOrSatation=3 and FaultType<>5
                                                  order by FaultType", Team);
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