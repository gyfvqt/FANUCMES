using DAL;
using GF2.MES.Report.Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// ERPOrderProduction 的摘要说明
    /// </summary>
    public class ERPOrderProduction : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
                    string sqlseq = @"select LineId,isnull(MAX(OrderSeq),'0000') as mxOrderSeq from ERPOrderDetails(nolock) where [Status]=3 group by LineId";
                    DataSet dsseq = SQLHelper.GetDataSet(sqlseq);
                    string sqldownorder = string.Format(@"select ID, LineId,SN from ERPOrderDetails(nolock) where ID in({0}) order by LineId,SN", ID.TrimStart('|').Replace("|", ","));
                    DataSet dsdownorder= SQLHelper.GetDataSet(sqldownorder);
                    var lineid = "";
                    var maxseq = "";
                    string sql = "";
                    for (int i = 0; i < dsdownorder.Tables[0].Rows.Count; i++)
                    {
                        if (lineid != dsdownorder.Tables[0].Rows[i]["LineId"].ToString())
                        {
                            lineid = dsdownorder.Tables[0].Rows[i]["LineId"].ToString();
                            if (dsseq != null && dsseq.Tables[0].Rows.Count > 0)
                            {
                                DataRow[] dr = dsseq.Tables[0].Select("LineId=" + dsdownorder.Tables[0].Rows[i]["LineId"].ToString());
                                if (dr.Length > 0)
                                {
                                    if (dr[0]["mxOrderSeq"].ToString() == "9999")
                                    {
                                        maxseq = "0001";
                                    }
                                    else
                                    {
                                        maxseq = (int.Parse(dr[0]["mxOrderSeq"].ToString()) + 1).ToString().PadLeft(4, '0');
                                    }
                                }
                                else
                                {
                                    maxseq = "0001";
                                }
                            }
                            else
                            {
                                maxseq = "0001";
                            }
                        }
                        else
                        {
                            if (maxseq == "9999")
                            {
                                maxseq = "0001";
                            }
                            else
                            {
                                maxseq = (int.Parse(maxseq) + 1).ToString().PadLeft(4, '0');
                            }
                        }

                        sql += string.Format(@"update ERPOrderDetails set OrderSeq=N'{1}'  where ID=N'{0}';", dsdownorder.Tables[0].Rows[i]["ID"].ToString(),maxseq);
                    }

                    sql += string.Format(@"update ERPOrderDetails set Status=3,UpdateTime=GETDATE()  where ID in ({0});", ID.TrimStart('|').Replace("|", ","));
                    SQLHelper.ExcuteSQL(sql);
                }

                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "订单下达成功:" + ID);
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