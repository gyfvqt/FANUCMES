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
    /// InsertTraceability 的摘要说明
    /// </summary>
    public class InsertTraceability : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
                string TSn = HttpContext.Current.Request.Params["tsn"];
                string Tid = HttpContext.Current.Request.Params["tid"];
                string info = string.Format(@"select * from StationInfo(nolock) where StationCode=N'{0}';                                
                                select a.*,b.ID as ProductionId,b.ProductionSheet,c.ID as endid  from ERPOrderDetails(nolock) a 
                                    join ProductionInfo(nolock) b on a.ProductionCode=b.ProductionId 
									join EndProduct(nolock) c on b.ID=c.ProductionId and a.ProductionCode=c.ProductionCode and a.ERPDetailCode=c.ERPDetailCode
                                    where c.EndProductSN=N'{1}' AND a.Status IN(3,4);",
                                StationCode, ProductionID);
                DataSet dsinfo = Helper.SQLHelper.GetDataSet(info);
                string sqlap = string.Format(@"insert into ProductTraceabilityInfo(ProductId,ProductCode,StationName,ItemID,ParkSn,TransitTime,StationId)
                                        values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',GETDATE(),N'{5}');", dsinfo.Tables[1].Rows[0]["endid"].ToString(), ProductionID,
                                               dsinfo.Tables[0].Rows[0]["StationName"].ToString(), Tid, TSn, dsinfo.Tables[0].Rows[0]["ID"].ToString());

                SQLHelper.ExcuteSQL(sqlap);

                //string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());
                HttpContext.Current.Response.Write("1");

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