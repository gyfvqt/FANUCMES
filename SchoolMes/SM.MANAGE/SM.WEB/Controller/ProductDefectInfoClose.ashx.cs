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
    /// ProductDefectInfoClose 的摘要说明
    /// </summary>
    public class ProductDefectInfoClose : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                //string DEPT = HttpContext.Current.Request.Params["dept"];

                DataSet dsuserinfo = new DataSet();
                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                }
                if (ID.Trim() != "")
                {
                    string sql = string.Format(@"update ProductDefectInfo set LastStatus=N'OK',LastUpdator=N'{1}'  where ID in ({0})",
                        ID.TrimStart('|').Replace("|", ","), dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString());
                    SQLHelper.ExcuteSQL(sql);
                }

                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "手工录入过程质量问题关闭成功:" + ID);
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