using DAL;
using System;
using System.Data;
using System.Web;


namespace SM.WEB.Controller
{
    /// <summary>
    /// FaultNoticeExec 的摘要说明
    /// </summary>
    public class FaultNoticeExec : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string FaultReturn = HttpContext.Current.Request.Params["faultReturn"];
                
                DataSet dsuserinfo = new DataSet();
                string sqlrole = string.Format("update FaultNotice set FaultReturn=N'{0}'  where ID={1};", FaultReturn, ID);
                SQLHelper.ExcuteSQL(sqlrole);

                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "执行故障通知单成功:" + FaultReturn);
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