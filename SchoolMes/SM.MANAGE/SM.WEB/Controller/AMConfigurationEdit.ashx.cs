using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// AMConfigurationEdit 的摘要说明
    /// </summary>
    public class AMConfigurationEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string TicketId = HttpContext.Current.Request.Params["ticketId"];
                string PeriodType = HttpContext.Current.Request.Params["periodType"];
                string Xweek = HttpContext.Current.Request.Params["xweek"];
                string WeekDate = HttpContext.Current.Request.Params["weekDate"];
                string Month = HttpContext.Current.Request.Params["month"];
                string Day = HttpContext.Current.Request.Params["day"];
                string BeginDate = HttpContext.Current.Request.Params["beginDate"];
                string EndDate = HttpContext.Current.Request.Params["endDate"];
                string sqlrole = string.Format( "delete from AMConfiguration where TicketId=N'{0}';", TicketId);
                switch (PeriodType)
                {
                    case "每天":
                        sqlrole += string.Format("insert into AMConfiguration(TicketId,PeriodType,BeginDate,EndDate) " +
                                    "values(N'{0}',N'{1}',N'{2}',N'{3}') ;select SCOPE_IDENTITY();",
                                    TicketId, PeriodType, BeginDate, EndDate);
                        break;
                    case "每周":
                        sqlrole += string.Format("insert into AMConfiguration(TicketId,PeriodType,Xweek,WeekDate,BeginDate,EndDate) " +
                                    "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}') ;select SCOPE_IDENTITY();",
                                    TicketId, PeriodType, Xweek, WeekDate, BeginDate, EndDate);
                        break;
                    case "每月":
                        sqlrole += string.Format("insert into AMConfiguration(TicketId,PeriodType,Day,BeginDate,EndDate) " +
                                    "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}') ;select SCOPE_IDENTITY();",
                                    TicketId, PeriodType, Day, BeginDate, EndDate);
                        break;
                    case "每年":
                        sqlrole += string.Format("insert into AMConfiguration(TicketId,PeriodType,Month,Day,BeginDate,EndDate) " +
                                    "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}') ;select SCOPE_IDENTITY();",
                                    TicketId, PeriodType, Month, Day, BeginDate, EndDate);
                        break;
                }


                //string sqlrole = string.Format("insert into AMConfiguration(TicketId,PeriodType,Xweek,WeekDate,Month,Day,BeginDate,EndDate) " +
                //    "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}') ;select SCOPE_IDENTITY();",
                //    TicketId, PeriodType, Xweek, WeekDate, Month, Day, BeginDate, EndDate);
                object o = SQLHelper.GetObject(sqlrole);

                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "编辑任务维护单执行频率成功:" + TicketId);
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