using DAL;
using System;
using System.Data;
using System.Web;


namespace SM.WEB.Controller
{
    /// <summary>
    /// StationTraceabilityDeleteByid 的摘要说明
    /// </summary>
    public class StationTraceabilityDeleteByid : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string TraceabilityDesc = HttpContext.Current.Request.Params["traceabilityDesc"];
                string sql = "";

                if (ID.Trim() != "")
                {
                    sql += string.Format(@"delete from PCTraceability  where TraceabilityId =N'{0}';", ID);
                    SQLHelper.ExcuteSQL(sql);
                }

                SQLHelper.ExcuteSQL(sql);
                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "删除站点零件追溯信息:" + ID + "/" + TraceabilityDesc);
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