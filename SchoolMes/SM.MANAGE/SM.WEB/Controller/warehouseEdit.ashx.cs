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
    /// warehouseEdit 的摘要说明
    /// </summary>
    public class warehouseEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string WarehouseNo = HttpContext.Current.Request.Params["warehouseNo"];
                string WarehouseType = HttpContext.Current.Request.Params["warehouseType"];
                string WarehouseName = HttpContext.Current.Request.Params["warehouseName"];
                //string DesignCycle = HttpContext.Current.Request.Params["designCycle"];
                //string PlanCycle = HttpContext.Current.Request.Params["planCycle"];
                //string IsEnable = HttpContext.Current.Request.Params["isEnable"];
                //string PhoneNumber = HttpContext.Current.Request.Params["phoneNumber"];
                //string UserImagic = HttpContext.Current.Request.Params["userImagic"];

                if (ID.Trim() == "")
                {                    
                    string sqlrole = string.Format("insert into Warehouse(WarehouseType,WarehouseName) values(N'{0}',N'{1}');select SCOPE_IDENTITY();",
                         WarehouseType, WarehouseName);
                    object o = SQLHelper.GetObject(sqlrole);
                    if (o != null)
                    {
                        string sqlx = @"update Warehouse set WarehouseNo='" + o.ToString().PadLeft(3, '0') + "' where ID=" + o.ToString();
                        SQLHelper.ExcuteSQL(sqlx);
                        ID = o.ToString();
                    }
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增仓储区域成功:" + o.ToString().PadLeft(3, '0') + "/" + WarehouseName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update Warehouse set WarehouseType=N'{0}',WarehouseName=N'{1}' where ID={2};",
                         WarehouseType, WarehouseName, ID);


                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑仓储区域成功:" + WarehouseNo + "/" + WarehouseName);
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