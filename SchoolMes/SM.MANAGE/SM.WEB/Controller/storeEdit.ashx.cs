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
    /// storeEdit 的摘要说明
    /// </summary>
    public class storeEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string StoreNo = HttpContext.Current.Request.Params["storeNo"];
                string KG = HttpContext.Current.Request.Params["kg"];
                string MaxNo = HttpContext.Current.Request.Params["maxNo"];
                string StoreName = HttpContext.Current.Request.Params["storeName"];
                string PickArea = HttpContext.Current.Request.Params["pickArea"];
                string IsEnable = HttpContext.Current.Request.Params["isEnable"];
                string WarehouseId = HttpContext.Current.Request.Params["warehouseId"];
                //string UserImagic = HttpContext.Current.Request.Params["userImagic"];

                if (ID.Trim() == "")
                {
                    string sqlmaxid = "Select max(ID) from Store";
                    string maxid = SQLHelper.GetObject(sqlmaxid).ToString();
                    if (maxid == "" || maxid == "NULL")
                    {
                        maxid = "1";
                    }
                    else
                    {
                        maxid = (Convert.ToInt32(maxid) + 1).ToString();
                    }
                    maxid = maxid.PadLeft(5, '0');
                    string sqlrole = string.Format("insert into Store(StoreNo,StoreName,PickArea,KG,MaxNo,IsEnable,WarehouseId) values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}') ;",
                        "FANUC_S" + maxid, StoreName, PickArea, KG, MaxNo, IsEnable, WarehouseId);
                    SQLHelper.ExcuteSQL(sqlrole);
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增仓位成功:" + "FANUC_W" + maxid + "/" + StoreName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update Store set StoreName=N'{0}',PickArea=N'{1}',KG=N'{2}',MaxNo=N'{3}',IsEnable=N'{4}',WarehouseId=N'{5}' where ID={6};",
                         StoreName, PickArea, KG, MaxNo, IsEnable, WarehouseId, ID);


                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑仓位成功:" + StoreNo + "/" + StoreName);
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