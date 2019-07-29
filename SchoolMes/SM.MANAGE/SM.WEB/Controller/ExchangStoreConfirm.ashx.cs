using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// ExchangStoreConfirm 的摘要说明
    /// </summary>
    public class ExchangStoreConfirm : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string sql = "";
                DataSet dsuserinfo = new DataSet();
                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                }
                if (ID.Trim() != "")
                {
                    ID = ID.TrimStart('|').Replace('|', ',');
                    sql = string.Format(@"select * from ExchangStore(nolock) where ID in ('{0}')", ID);
                    DataSet ds = SQLHelper.GetDataSet(sql);
                    sql = "";
                    if (ds != null && ds.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            if (ds.Tables[0].Rows[i]["ExchangeType"].ToString() == "库存出库")
                            {
                                //出库
                                sql += string.Format(@"update Material_W_S set MTotal=MTotal+{2},exchangecount='{2}' where StoreId=N'{0}' and MaterialId=N'{1}' ;", ds.Tables[0].Rows[i]["StoreId"].ToString(), ds.Tables[0].Rows[i]["MaterialId"].ToString(), "-"+ds.Tables[0].Rows[i]["TicketNumber"].ToString());
                                sql += string.Format(@"update ExchangStore set ExStatus=N'确认',UuserId=N'{1}',Updator=N'{2}',UpdateTime=N'{3}' where ID=N'{0}' ;",
                                    ds.Tables[0].Rows[i]["ID"].ToString(),
                                    dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                                    dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                            }
                            else if (ds.Tables[0].Rows[i]["ExchangeType"].ToString() == "库存入库")
                            {
                                //入库
                                sql += string.Format(@"update Material_W_S set MTotal=MTotal+{2},exchangecount='{2}' where StoreId=N'{0}' and MaterialId=N'{1}' ;", ds.Tables[0].Rows[i]["StoreId"].ToString(), ds.Tables[0].Rows[i]["MaterialId"].ToString(),ds.Tables[0].Rows[i]["TicketNumber"].ToString());
                                sql += string.Format(@"update ExchangStore set ExStatus=N'确认',UuserId=N'{1}',Updator=N'{2}',UpdateTime=N'{3}' where ID=N'{0}' ;",
                                    ds.Tables[0].Rows[i]["ID"].ToString(),
                                    dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                                    dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                            }
                            else if (ds.Tables[0].Rows[i]["ExchangeType"].ToString() == "库存转储")
                            {
                                //转储
                                sql += string.Format(@"update Material_W_S set MTotal=MTotal+{2},exchangecount='{2}' where StoreId=N'{0}' and MaterialId=N'{1}';", ds.Tables[0].Rows[i]["StoreId"].ToString(), ds.Tables[0].Rows[i]["MaterialId"].ToString(),"-"+ ds.Tables[0].Rows[i]["TicketNumber"].ToString());
                                sql += string.Format(@"update Material_W_S set MTotal=MTotal+{2},exchangecount='{2}' where StoreId=N'{0}' and MaterialId=N'{1}';", ds.Tables[0].Rows[i]["InStoreId"].ToString(), ds.Tables[0].Rows[i]["MaterialId"].ToString(), ds.Tables[0].Rows[i]["TicketNumber"].ToString());
                                sql += string.Format(@"update ExchangStore set ExStatus=N'确认',UuserId=N'{1}',Updator=N'{2}',UpdateTime=N'{3}' where ID=N'{0}' ;",
                                    ds.Tables[0].Rows[i]["ID"].ToString(),
                                    dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                                    dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                            }


                        }
                        if (sql != "") SQLHelper.ExcuteSQL(sql);
                    }

                }

                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "确认转储单成功:" + ID);
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