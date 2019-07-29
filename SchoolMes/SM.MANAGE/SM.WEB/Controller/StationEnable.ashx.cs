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
    /// StationEnable 的摘要说明
    /// </summary>
    public class StationEnable : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                //string DEPT = HttpContext.Current.Request.Params["dept"];
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
                                sql += string.Format(@"update StationInfo set IsEnable=(case IsEnable when 1 then 0 else 1 end) where ID =N'{0}';", list[i]);
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
                        "设置站点状态成功:" + ID);
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