using Helper;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Station.Controller.PCStation
{
    /// <summary>
    /// IsExitPCStation 的摘要说明
    /// </summary>
    public class IsExitPCStation : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string StationId = HttpContext.Current.Request.Params["stationid"];
                string ProductionID = HttpContext.Current.Request.Params["productionid"];

                string info = string.Format(@"select * from StationInfo(nolock) where ID=N'{0}';                               
                                select a.*,b.ID as ProductionId,b.ProductionSheet,c.ID as endid  from ERPOrderDetails(nolock) a 
                                    join ProductionInfo(nolock) b on a.ProductionCode=b.ProductionId 
									join EndProduct(nolock) c on b.ID=c.ProductionId and a.ProductionCode=c.ProductionCode and a.ERPDetailCode=c.ERPDetailCode
                                    where c.EndProductSN=N'{1}' AND a.Status IN(3,4);",
                                StationId, ProductionID);
                DataSet dsinfo = Helper.SQLHelper.GetDataSet(info);

                string sqlt = string.Format(@"select count(1) from ProductTransitInfo(nolock) where ProductId=N'{0}' and StationId=N'{1}'", dsinfo.Tables[1].Rows[0]["endid"].ToString(), StationId);
                var c = SQLHelper.GetObject(sqlt).ToString();
                if (c == "0")
                {
                    HttpContext.Current.Response.Write("0");
                }
                else
                {
                    HttpContext.Current.Response.Write("1");
                }


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