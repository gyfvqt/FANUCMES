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
    /// PLCAPResult 的摘要说明
    /// </summary>
    public class PLCUPResult : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        /// <summary>
        /// PLC 站点制造过程项目实绩获取
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                string StationCode = HttpContext.Current.Request.Params["stationcode"];
                string ProductionID = HttpContext.Current.Request.Params["productionid"];
                
                string sqlSearch = string.Format(@"  select a.*,b.PLCDataDesc,isnull(b.PLCDataResult,'') as PLCDataResult,c.StationCode from PLCUPInfo(nolock) a 
  join StationInfo(nolock) c on a.PLCStationId=c.ID
  left join ProductPLCTraceabilityInfo(nolock) b on c.ID=b.StationId and b.ProductCode=N'{1}' and a.PLCUPId=b.ItemId
  where c.StationCode=N'{0}' ", StationCode, ProductionID);
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