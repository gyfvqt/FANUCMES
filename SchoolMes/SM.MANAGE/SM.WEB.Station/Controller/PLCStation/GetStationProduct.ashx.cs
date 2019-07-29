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
    /// GetStationProduct 的摘要说明
    /// </summary>
    public class GetStationProduct : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                //string StationId = HttpContext.Current.Request.Params["stationid"];
                string ProductionSN = HttpContext.Current.Request.Params["productionsn"];

                string sqlSearch = string.Format(@"select a.*,isnull(b.ProductionImg,'') ProductionImg from EndProduct(nolock) a 
  left join ProductionInfo(nolock) b on a.ProductionId=b.ID 
  where EndProductSN=N'{0}' ", ProductionSN);
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