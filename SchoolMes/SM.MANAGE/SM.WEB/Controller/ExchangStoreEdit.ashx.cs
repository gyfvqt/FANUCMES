using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// ExchangStoreEdit 的摘要说明
    /// </summary>
    public class ExchangStoreEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string MaterialId = HttpContext.Current.Request.Params["materialId"];
                string MaterialDataNo = HttpContext.Current.Request.Params["materialDataNo"];
                string ExchangeType = HttpContext.Current.Request.Params["exchangeType"];
                string TicketNumber = HttpContext.Current.Request.Params["ticketNumber"];
                string WarehouseId = HttpContext.Current.Request.Params["warehouseId"];
                string StoreId = HttpContext.Current.Request.Params["storeId"];
                string InWarehouseId = HttpContext.Current.Request.Params["inWarehouseId"];
                string InStoreId = HttpContext.Current.Request.Params["inStoreId"]; 
                string MaterialDataName = HttpContext.Current.Request.Params["materialDataName"];
                DataSet dsuserinfo = new DataSet();
                string _TicketNumber="0";
                string _TicketNumberIn="0";
                switch (ExchangeType) {
                    case "库存出库":
                        _TicketNumber = "-" + TicketNumber;
                        break;
                    case "库存入库":
                        _TicketNumber = "-" + TicketNumber;
                        break;
                    case "库存转储":
                        _TicketNumber = "-" + TicketNumber;
                        _TicketNumberIn = TicketNumber;
                        break;
                }                

                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                }
                if (ID.Trim() == "")
                {
                    if (ExchangeType != "库存转储")
                    {
                        string sqlrole = string.Format("insert into ExchangStore(MaterialId,MaterialDataNo,ExchangeType,TicketNumber,WarehouseId,StoreId,ExStatus,CuserId,Creator,CreateTime,MaterialDataName) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}',N'{10}') ;",
                        MaterialId, MaterialDataNo, ExchangeType, TicketNumber, WarehouseId, StoreId,"发起", dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                                    dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), MaterialDataName);
                        //sqlrole += string.Format(@"update Material_W_S set exchangecount=N'{0}' where MaterialId=N'{1}' and WarehouseId=N'{2}' and StoreId=N'{3}';", _TicketNumber, MaterialId, WarehouseId, StoreId);
                        SQLHelper.ExcuteSQL(sqlrole);
                    }
                    else
                    {
                        string sqlrole = string.Format("insert into ExchangStore(MaterialId,MaterialDataNo,ExchangeType,TicketNumber,WarehouseId,StoreId,InWarehouseId,InStoreId,ExStatus,CuserId,Creator,CreateTime,MaterialDataName) " +
                            "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}',N'{10}',N'{11}',N'{12}') ;",
                            MaterialId, MaterialDataNo, ExchangeType, TicketNumber, WarehouseId, StoreId, InWarehouseId, InStoreId, "发起", dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                                        DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), MaterialDataName);
                        //sqlrole += string.Format(@"update Material_W_S set exchangecount=N'{0}' where MaterialId=N'{1}' and WarehouseId=N'{2}' and StoreId=N'{3}';", _TicketNumber, MaterialId, WarehouseId, StoreId);
                        //sqlrole += string.Format(@"update Material_W_S set exchangecount=N'{0}' where MaterialId=N'{1}' and WarehouseId=N'{2}' and StoreId=N'{3}';", _TicketNumberIn, MaterialId, InWarehouseId, InStoreId);
                        SQLHelper.ExcuteSQL(sqlrole);
                    }
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增转储单成功:" + MaterialDataNo);
                    }
                }
                else
                {
                    if (ExchangeType != "库存转储")
                    {
                        string sqlrole = string.Format("update ExchangStore set MaterialId=N'{0}',MaterialDataNo=N'{1}',ExchangeType=N'{2}',TicketNumber=N'{3}',WarehouseId=N'{4}',StoreId=N'{5}',UuserId=N'{6}',Updator=N'{7}',UpdateTime=N'{8}',MaterialDataName=N'{10}' where ID={9};",
                         MaterialId, MaterialDataNo, ExchangeType, TicketNumber, WarehouseId, StoreId, dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                                    dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), ID, MaterialDataName);
                        //sqlrole += string.Format(@"update Material_W_S set exchangecount=N'{0}' where MaterialId=N'{1}' and WarehouseId=N'{2}' and StoreId=N'{3}';", _TicketNumber, MaterialId, WarehouseId, StoreId);
                        SQLHelper.ExcuteSQL(sqlrole);
                    }
                    else
                    {
                        string sqlrole = string.Format("update ExchangStore set MaterialId=N'{0}',MaterialDataNo=N'{1}',ExchangeType=N'{2}',TicketNumber=N'{3}',WarehouseId=N'{4}',StoreId=N'{5}',InWarehouseId=N'{6}',InStoreId=N'{7}',UuserId=N'{8}',Updator=N'{9}',UpdateTime=N'{10}',MaterialDataName=N'{12}' where ID={11};",
                         MaterialId, MaterialDataNo, ExchangeType, TicketNumber, WarehouseId, StoreId, InWarehouseId, InStoreId, dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                                    dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), ID, MaterialDataName);
                        //sqlrole += string.Format(@"update Material_W_S set exchangecount=N'{0}' where MaterialId=N'{1}' and WarehouseId=N'{2}' and StoreId=N'{3}';", _TicketNumber, MaterialId, WarehouseId, StoreId);
                        //sqlrole += string.Format(@"update Material_W_S set exchangecount=N'{0}' where MaterialId=N'{1}' and WarehouseId=N'{2}' and StoreId=N'{3}';", _TicketNumberIn, MaterialId, InWarehouseId, InStoreId);
                        SQLHelper.ExcuteSQL(sqlrole);
                    }

                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑转储单成功:" + MaterialDataNo);
                    }
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