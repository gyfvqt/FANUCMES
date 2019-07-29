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
    /// getDefectcount 的摘要说明
    /// </summary>
    public class getDefectcount : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string StationId = HttpContext.Current.Request.Params["stationid"];
                string ProductionID = HttpContext.Current.Request.Params["productionid"];
                
                string info = string.Format(@"select a.*,b.ID as ProductionId,b.ProductionSheet,c.ID as endid  from ERPOrderDetails(nolock) a 
                                    join ProductionInfo(nolock) b on a.ProductionCode=b.ProductionId 
									join EndProduct(nolock) c on b.ID=c.ProductionId and a.ProductionCode=c.ProductionCode and a.ERPDetailCode=c.ERPDetailCode
                                    where c.EndProductSN=N'{0}' AND a.Status IN(3,4);",
                                 ProductionID);
                DataSet dsinfo = Helper.SQLHelper.GetDataSet(info);                

                string sqlcount = string.Format(@"select count(1) from ProductDefectInfo(nolock) where StationId=N'{0}' and ProductId=N'{1}' and LastStatus='NOK'", StationId, dsinfo.Tables[0].Rows[0]["endid"].ToString());
                var o = SQLHelper.GetObject(sqlcount).ToString();
                HttpContext.Current.Response.Write(o);

            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("-1");
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