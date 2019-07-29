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
    /// GetDefectCount 的摘要说明
    /// </summary>
    public class GetDefectCount : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                string StationId = HttpContext.Current.Request.Params["stationid"];
                string ProductionSN = HttpContext.Current.Request.Params["productionSN"];

                string sqlSearch = string.Format(@"select count(1) AS DCount from ProductPLCTraceabilityInfo(nolock) 
  where ProductCode=N'{0}' and Stationid=N'{1}' and (PLCDataResult='NOK' OR PLCDataResult='KO' ) ", ProductionSN, StationId);
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