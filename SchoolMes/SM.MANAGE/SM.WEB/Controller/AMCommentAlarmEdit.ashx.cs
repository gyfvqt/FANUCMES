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
    /// AMCommentAlarmEdit 的摘要说明
    /// </summary>
    public class AMCommentAlarmEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string TicketId = HttpContext.Current.Request.Params["ticketId"];
                string AlarmContent = HttpContext.Current.Request.Params["alarmContent"];
                string Xdate = HttpContext.Current.Request.Params["xdate"];
                string AlarmTime = HttpContext.Current.Request.Params["alarmTime"];

                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into AMCommentAlarm(TicketId,AlarmContent,Xdate,AlarmTime) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}') ;select SCOPE_IDENTITY();",
                        TicketId, AlarmContent, Xdate, AlarmTime);
                    object o = SQLHelper.GetObject(sqlrole);
                    //if (o != null)
                    //{
                    //    string sqlx = @"update StationInfo set StationCode='FANUC-S-C-" + o.ToString().PadLeft(5, '0') + "' where ID=" + o.ToString();
                    //    SQLHelper.ExcuteSQL(sqlx);
                    //    ID = o.ToString();
                    //}
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增维护任务提醒内容信息成功:" + AlarmContent);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update AMCommentAlarm set TicketId=N'{0}',AlarmContent=N'{1}',Xdate=N'{2}',AlarmTime=N'{3}' where ID=N'{4}';",
                         TicketId, AlarmContent, Xdate, AlarmTime, ID);

                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑维护任务提醒内容信息成功:" + AlarmContent);
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