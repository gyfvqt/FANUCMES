using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Station.Controller
{
    /// <summary>
    /// TraceabilityResult 的摘要说明
    /// </summary>
    public class TraceabilityResult : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        /// <summary>
        /// PLC UP 实际
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                string StationCode = HttpContext.Current.Request.Params["stationcode"];
                string ProductionID = HttpContext.Current.Request.Params["productionid"];

                string sqlSearch = string.Format(@"select a.*,isnull(b.ParkSn,'') as ParkSn ,c.StationCode from PLCAPInfo(nolock) a 
  join StationInfo(nolock) c on a.PLCStationId=c.ID
  left join ProductTraceabilityInfo(nolock) b on c.ID=b.StationId and a.PLCAPId=b.ItemId and b.ProductCode=N'{1}'
  where c.StationCode=N'{0}'   ", StationCode, ProductionID);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);

                string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());
                HttpContext.Current.Response.Write(result);

            }
            catch (Exception ex)
            {
                //HttpContext.Current.Response.End();
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