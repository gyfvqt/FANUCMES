using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Station.Controller.PLCStation
{
    /// <summary>
    /// Process 的摘要说明
    /// </summary>
    public class Process : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        /// <summary>
        /// 站点工艺获取
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string StationCode = HttpContext.Current.Request.Params["stationcode"];
                string ProductionID = HttpContext.Current.Request.Params["productionid"];

                string sqlSearch = string.Format(@"select a.* from PCStationProcessSheet(nolock) a
  join StationInfo(nolock) c on a.PCStationId=c.ID
  where c.StationCode=N'{0}'   ", StationCode);
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