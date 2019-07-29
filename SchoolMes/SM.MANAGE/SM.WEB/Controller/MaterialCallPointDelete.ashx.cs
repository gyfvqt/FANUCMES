using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using DAL;

namespace SM.WEB.Controller
{
    /// <summary>
    /// MaterialCallPointDelete 的摘要说明
    /// </summary>
    public class MaterialCallPointDelete : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string sql = "";

                if (ID.Trim() != "")
                {
                    string[] list = ID.Split('|');
                    if (list.Length > 0)
                    {
                        for (int i = 0; i < list.Length; i++)
                        {
                            if (list[i].Trim() != "")
                            {
                                sql += string.Format(@"delete from MaterialCallPoint  where ID =N'{0}';", list[i]);
                            }
                        }

                    }
                }

                SQLHelper.ExcuteSQL(sql);
                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "删除零件落点成功:" + ID);
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