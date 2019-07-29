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
    /// AMTicketEdit 的摘要说明
    /// </summary>
    public class AMTicketEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string FaultName = HttpContext.Current.Request.Params["faultName"];
                string FaultDesc = HttpContext.Current.Request.Params["faultDesc"];
                string EquipmentId = HttpContext.Current.Request.Params["equipmentId"];
                string UserId = HttpContext.Current.Request.Params["userId"];
                string FaultReturn = HttpContext.Current.Request.Params["faultReturn"];

                DataSet dsuserinfo = new DataSet();
                var code = "";
                var CallId = ID;
                dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                if (ID.Trim() == "")
                {

                    string sql = string.Format("insert into AMTicket(TicketName,TicketDesc,Creator,UserId,ExecuteStatus,CreateTime,TicketReturn) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}',N'新建',getdate(),N'{4}') ;select SCOPE_IDENTITY();",
                        FaultName, FaultDesc,  dsuserinfo.Tables[0].Rows[0]["ID"].ToString(), UserId, FaultReturn);
                    object o = SQLHelper.GetObject(sql);
                    
                    if (o != null)
                    {
                        code = "FN-" + DateTime.Now.ToString("yyyyMMdd") + o.ToString().PadLeft(6, '0');
                        string sqlx = @"update AMTicket set TicketNo='" + code + "' where ID=" + o.ToString();
                        SQLHelper.ExcuteSQL(sqlx);
                        CallId = o.ToString();
                    }

                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增日常维护任务成功:" + FaultName);
                    }
                }
                else
                {

                    string sqlrole = string.Format("update AMTicket set TicketName=N'{0}',TicketDesc=N'{1}',UserId=N'{2}',TicketReturn=N'{4}' ,ExecuteStatus=N'{5}'  where ID={3};",
                     FaultName, FaultDesc,  UserId, ID, FaultReturn, FaultReturn == "" ? "新建" : "执行");
                    SQLHelper.ExcuteSQL(sqlrole);

                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑日常维护任务成功:" + FaultName);
                    }
                }
                HttpContext.Current.Response.Write(CallId);
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