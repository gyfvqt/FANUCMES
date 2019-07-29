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
    /// PCStationTransit 的摘要说明
    /// </summary>
    public class PCStationTransit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
                string sqlcount = string.Format(@"select count(1) from ProductDefectInfo(nolock) where StationId=N'{0}' and ProductId=N'{1}' and LastStatus='NOK'", dsinfo.Tables[0].Rows[0]["ID"].ToString(), dsinfo.Tables[1].Rows[0]["endid"].ToString());
                var o = SQLHelper.GetObject(sqlcount).ToString();
                var OKNG = int.Parse(o) == 0 ? "OK" : "NOK";
                string sqlt = string.Format(@"select count(1) from ProductTransitInfo(nolock) where ProductId=N'{0}' and StationId=N'{1}'", dsinfo.Tables[1].Rows[0]["endid"].ToString(), StationId);
                var c= SQLHelper.GetObject(sqlt).ToString();
                if (c == "0")
                {
                    string sqlTransit = string.Format(@"insert into ProductTransitInfo(ProductId,ProductCode,StationName,StationDesc,StationType,TransitTime,StationId,StationCode,QualityStatus) 
                                                                        values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',GETDATE(),N'{5}',N'{6}',N'{7}');select SCOPE_IDENTITY();",
                                                                            dsinfo.Tables[1].Rows[0]["endid"].ToString(), dsinfo.Tables[1].Rows[0]["ProductCode"].ToString(), dsinfo.Tables[0].Rows[0]["StationName"].ToString(),
                                                                            dsinfo.Tables[0].Rows[0]["StationDesc"].ToString(),
                                                                            dsinfo.Tables[0].Rows[0]["StationType"].ToString(),
                                                                            dsinfo.Tables[0].Rows[0]["ID"].ToString(),
                                                                            dsinfo.Tables[0].Rows[0]["StationCode"].ToString(), OKNG);
                    SQLHelper.GetObject(sqlTransit).ToString();
                }
                else
                {
                    string updatesql = string.Format(@"update ProductDefectInfo set TransitTime=getdate() where StationId=N'{0}' and ProductId=N'{1}' and LastStatus='NOK'", dsinfo.Tables[0].Rows[0]["ID"].ToString(), dsinfo.Tables[1].Rows[0]["endid"].ToString());
                    SQLHelper.ExcuteSQL(updatesql);
                    
                }
                HttpContext.Current.Response.Write("1");

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