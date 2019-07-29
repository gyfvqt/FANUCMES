using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// AMTicketExcute 的摘要说明
    /// </summary>
    public class AMTicketExcute : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string TicketReturn = HttpContext.Current.Request.Params["ticketReturn"];
                string ExecuteStatus = HttpContext.Current.Request.Params["executeStatus"];
                
                string sqlrole = string.Format("update AMTicketSplit set SplitReturn=N'{0}',Stratus=N'{1}' where ID=N'{2}';",
                     TicketReturn, ExecuteStatus, ID);

                SQLHelper.ExcuteSQL(sqlrole);


                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "编辑维护任务内容信息成功:" + TicketReturn);
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