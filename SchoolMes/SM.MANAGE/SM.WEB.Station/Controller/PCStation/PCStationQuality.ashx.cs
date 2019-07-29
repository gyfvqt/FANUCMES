using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Station.Controller.PCStation
{
    /// <summary>
    /// PCStationQuality 的摘要说明
    /// </summary>
    public class PCStationQuality : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                string StationId = HttpContext.Current.Request.Params["stationid"];
                string ProductionID = HttpContext.Current.Request.Params["productionid"];

                string sqlSearch = string.Format(@"  select a.*,b.ID,b.ProductId,b.ProductCode,b.DefectCode,b.DefectDesc,b.StationName,b.LastStatus from PCStationQuality(nolock) a
  left join ProductDefectInfo(nolock) b on a.PCStationId=b.StationId and a.QualityId=b.QualityId  and b.ProductCode=N'{0}'
  where a.PCStationId=N'{1}'  ", ProductionID, StationId);
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