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
    /// GetProcessSheet 的摘要说明
    /// </summary>
    public class GetProcessSheet : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                string StationId = HttpContext.Current.Request.Params["stationid"];
                //string ProductionID = HttpContext.Current.Request.Params["productionid"];

                string sqlSearch = string.Format(@"select * from PCStationProcessSheet(nolock) where PCStationId=N'{0}' ", StationId);
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