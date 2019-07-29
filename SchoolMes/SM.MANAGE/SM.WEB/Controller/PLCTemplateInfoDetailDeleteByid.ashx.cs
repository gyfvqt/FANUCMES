using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// PLCTemplateInfoDetailDeleteByid 的摘要说明
    /// </summary>
    public class PLCTemplateInfoDetailDeleteByid : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string UPDataDesc = HttpContext.Current.Request.Params["upDataDesc"];
                string sql = "";

                if (ID.Trim() != "")
                {
                    sql += string.Format(@"delete from PLCTemplateInfoDetail  where ID =N'{0}';", ID);
                    SQLHelper.ExcuteSQL(sql);
                }

                SQLHelper.ExcuteSQL(sql);
                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "删除PLC模板明细信息:" + ID + "/" + UPDataDesc);
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