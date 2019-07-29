using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GF2.MES.Report.Helper;
using DAL;
using System.Data;
using SM.WEB;

namespace SM.WEB.Controller
{
    /// <summary>
    /// ERPOrderSplit 的摘要说明
    /// </summary>
    public class ERPOrderSplit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                //string DEPT = HttpContext.Current.Request.Params["dept"];

                DataSet dsuserinfo = new DataSet();
                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                }
                    if (ID.Trim() != "")
                {
                    string sql = string.Format(@"select a.*,b.Batch,b.ProductionName as ProductionNameA from ERPOrder(nolock) a 
                    join ProductionInfo b on a.ProductionId=b.ProductionId  
                    where a.ID in ({0})", ID.TrimStart('|').Replace("|", ","));
                    DataSet dsorder= SQLHelper.GetDataSet(sql);
                    sql = "";
                    if (dsorder != null && dsorder.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < dsorder.Tables[0].Rows.Count; i++)
                        {
                            int time = Convert.ToInt32(dsorder.Tables[0].Rows[i]["PlanCount"].ToString()) / Convert.ToInt32(dsorder.Tables[0].Rows[i]["Batch"].ToString());
                            int remainder= Convert.ToInt32(dsorder.Tables[0].Rows[i]["PlanCount"].ToString()) % Convert.ToInt32(dsorder.Tables[0].Rows[i]["Batch"].ToString());
                            if (time > 0)
                            {
                                for (int j = 0; j < time; j++) {
                                    sql += string.Format(@"insert into ERPOrderDetails(ERPID,ERPDetailCode,ProductionCode,SN,ProductionName,DetailCount,Status,EndDate,CreateTime,Creator) 
                                                        values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}');",
                                                        dsorder.Tables[0].Rows[i]["ID"].ToString(),
                                                        dsorder.Tables[0].Rows[i]["ERPOrderId"].ToString()+"-"+(j+1).ToString().PadLeft(4,'0'),
                                                        dsorder.Tables[0].Rows[i]["ProductionId"].ToString(),
                                                        j.ToString().PadLeft(2, '0'),
                                                        dsorder.Tables[0].Rows[i]["ProductionNameA"].ToString(),
                                                        dsorder.Tables[0].Rows[i]["Batch"].ToString(),
                                                        "2",
                                                        dsorder.Tables[0].Rows[i]["EndDate"].ToString(),
                                                        DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                                                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString());
                                }
                            }
                            if (remainder > 0)
                            {
                                sql += string.Format(@"insert into ERPOrderDetails(ERPID,ERPDetailCode,ProductionCode,SN,ProductionName,DetailCount,Status,EndDate,CreateTime,Creator) 
                                                        values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}');",
                                                        dsorder.Tables[0].Rows[i]["ID"].ToString(),
                                                        dsorder.Tables[0].Rows[i]["ERPOrderId"].ToString() + "-" + (time+1).ToString().PadLeft(4, '0'),
                                                        dsorder.Tables[0].Rows[i]["ProductionId"].ToString(),
                                                        time>0?time.ToString().PadLeft(2, '0'):"01",
                                                        dsorder.Tables[0].Rows[i]["ProductionNameA"].ToString(),
                                                        remainder,
                                                        "2",
                                                        dsorder.Tables[0].Rows[i]["EndDate"].ToString(),
                                                        DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                                                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString());
                            }

                            sql += string.Format(@"update ERPOrder set ERPStatus=1 where ID =N'{0}';", dsorder.Tables[0].Rows[i]["ID"].ToString());
                        }
                        SQLHelper.ExcuteSQL(sql);
                    }
                    
                }
                
                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "分解ERP订单成功:" + ID);
                }
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