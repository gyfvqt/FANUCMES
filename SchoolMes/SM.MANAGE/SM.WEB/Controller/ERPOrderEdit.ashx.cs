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
    /// ERPOrderEdit 的摘要说明
    /// </summary>
    public class ERPOrderEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string ERPOrderId = HttpContext.Current.Request.Params["erpOrderId"];
                string ProductionId = HttpContext.Current.Request.Params["productionId"];
                string ERPOrderName = HttpContext.Current.Request.Params["erpOrderName"];
                string ProductionImg = HttpContext.Current.Request.Params["productionImg"];
                string PlanCount = HttpContext.Current.Request.Params["planCount"];
                string EndDate = HttpContext.Current.Request.Params["endDate"];
                //string PhoneNumber = HttpContext.Current.Request.Params["phoneNumber"];
                //string UserImagic = HttpContext.Current.Request.Params["userImagic"];

                if (ID.Trim() == "")
                {
                    string sqlmaxid = "Select max(ID) from Warehouse";
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
                    string sqlrole = string.Format("insert into ERPOrder(ERPOrderId,ProductionId,ERPOrderName,ProductionImg,PlanCount,EndDate,ERPStatus) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',1) ;",
                        ERPOrderId, ProductionId, ERPOrderName, ProductionImg, PlanCount, EndDate);
                    SQLHelper.ExcuteSQL(sqlrole);
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增ERP订单成功:" + ERPOrderId + "/" + ERPOrderName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update ERPOrder set ERPOrderId=N'{0}',ProductionId=N'{1}',ERPOrderName=N'{2}',ProductionImg=N'{3}',PlanCount=N'{4}',EndDate=N'{5}' where ID={6};",
                         ERPOrderId, ProductionId, ERPOrderName, ProductionImg, PlanCount, EndDate, ID);
                    SQLHelper.ExcuteSQL(sqlrole);
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑ERP订单成功:" + ERPOrderId + "/" + ERPOrderName);
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