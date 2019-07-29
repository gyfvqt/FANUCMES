using DAL;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// WorkCalendarSet 的摘要说明
    /// </summary>
    public class WorkCalendarSet : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";

                string Ym = HttpContext.Current.Request.Params["ym"];
                string YM = HttpContext.Current.Request.Params["ymdList"];
                string sql =string.Format( "delete from WorkCalendar where WorkDate like N'%{0}%';",Ym);
                if (YM.Trim() != "")
                {
                    YM = YM.TrimStart('|');
                    string[] ymdList = YM.Split('|');
                    if (ymdList.Length > 0)
                    {
                        for (int i = 0; i < ymdList.Length; i++)
                        {
                            sql += string.Format(@"insert into WorkCalendar(WorkDate) values(N'{0}');", ymdList[i]);
                        }
                        SQLHelper.ExcuteSQL(sql);
                    }
                }


                DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                    dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                    dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                    "设置工作日成功!" );

                HttpContext.Current.Response.Write("1");

                //HttpContext.Current.Response.End();

            }
            catch (Exception ex)
            {
                //HttpContext.Current.Response.End();
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