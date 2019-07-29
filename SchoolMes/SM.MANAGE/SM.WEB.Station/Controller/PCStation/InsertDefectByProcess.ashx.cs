using Helper;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Station.Controller.PCStation
{
    /// <summary>
    /// InsertDefectByProcess 的摘要说明
    /// </summary>
    public class InsertDefectByProcess : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string StationId = HttpContext.Current.Request.Params["stationid"];
                string ProductionID = HttpContext.Current.Request.Params["productionid"];
                string Qid = HttpContext.Current.Request.Params["qid"];
                string info = string.Format(@"select * from StationInfo(nolock) where ID=N'{0}';
                                select *  from PCStationProcessSheet(nolock) where ProcessId=N'{2}';
                                select a.*,b.ID as ProductionId,b.ProductionSheet,c.ID as endid  from ERPOrderDetails(nolock) a 
                                    join ProductionInfo(nolock) b on a.ProductionCode=b.ProductionId 
									join EndProduct(nolock) c on b.ID=c.ProductionId and a.ProductionCode=c.ProductionCode and a.ERPDetailCode=c.ERPDetailCode
                                    where c.EndProductSN=N'{1}' AND a.Status IN(3,4);",
                                StationId, ProductionID, Qid);
                DataSet dsinfo = Helper.SQLHelper.GetDataSet(info);
                string sqldefect = string.Format(@"select * from ProductDefectInfo(nolock) where ProcessId=N'{0}' AND StationId=N'{1}'", Qid, StationId);
                DataSet dsDefect = SQLHelper.GetDataSet(sqldefect);
                if (dsDefect != null && dsDefect.Tables[0].Rows.Count > 0)
                {
                    string updatedefect=string.Format(@"update ProductDefectInfo set LastStatus='NOK' where ProcessId=N'{0}' AND StationId=N'{1}'", Qid, StationId);
                    SQLHelper.ExcuteSQL(updatedefect);
                }
                else
                {
                    string sqlap = string.Format(@"insert into ProductDefectInfo(ProductId,ProductCode,DefectCode,DefectDesc,ProcessId,StationId,StationName,LastStatus,UpdateTime)
                                        values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',GETDATE());",
                                            dsinfo.Tables[2].Rows[0]["endid"].ToString(), ProductionID,
                                            "", dsinfo.Tables[1].Rows[0]["ProcessName"].ToString(), dsinfo.Tables[1].Rows[0]["ProcessId"].ToString(),
                                                  dsinfo.Tables[0].Rows[0]["ID"].ToString(), dsinfo.Tables[0].Rows[0]["StationName"].ToString(), "NOK");

                    SQLHelper.ExcuteSQL(sqlap);
                }
                string sqlcount = string.Format(@"select count(1) from ProductDefectInfo(nolock) where StationId=N'{0}' and ProductId=N'{1}' and LastStatus='NOK'", dsinfo.Tables[0].Rows[0]["ID"].ToString(), dsinfo.Tables[2].Rows[0]["endid"].ToString());
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