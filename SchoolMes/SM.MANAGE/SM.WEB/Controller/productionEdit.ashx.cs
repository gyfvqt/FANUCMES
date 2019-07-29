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
    /// productionEdit 的摘要说明
    /// </summary>
    public class productionEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string ProductionId = HttpContext.Current.Request.Params["productionId"];
                string ProductionName = HttpContext.Current.Request.Params["productionName"];
                string ProductionType = HttpContext.Current.Request.Params["productionType"];
                string ProductionSheet = HttpContext.Current.Request.Params["productionSheet"];
                string LineId = HttpContext.Current.Request.Params["lineId"];
                string Batch = HttpContext.Current.Request.Params["batch"];
                string StoreId = HttpContext.Current.Request.Params["storeId"];
                string ProductionImg = HttpContext.Current.Request.Params["productionImg"];
                string ProductionDesc = HttpContext.Current.Request.Params["productionDesc"];
                string IsEnable = HttpContext.Current.Request.Params["isEnable"];

                if (ID.Trim() == "")
                {                    
                    string sqlrole = string.Format("insert into ProductionInfo(ProductionId,ProductionName,ProductionType,ProductionSheet,LineId,Batch,StoreId,ProductionImg,ProductionDesc) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}') ;",
                        ProductionId, ProductionName, ProductionType, ProductionSheet, LineId, Batch, StoreId, ProductionImg, ProductionDesc);
                    SQLHelper.ExcuteSQL(sqlrole);
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增产品成功:"  + ProductionId + "/" + ProductionName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update ProductionInfo set ProductionId=N'{0}',ProductionName=N'{1}',ProductionType=N'{2}',ProductionSheet=N'{3}',LineId=N'{4}',Batch=N'{5}',StoreId=N'{6}',ProductionImg=N'{7}',ProductionDesc=N'{8}' where ID={9};",
                         ProductionId, ProductionName, ProductionType, ProductionSheet, LineId, Batch, StoreId, ProductionImg, ProductionDesc, ID);


                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑产品成功:" + ProductionId + "/" + ProductionName);
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