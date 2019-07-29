using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// CuttorInfoUpdateUsedTime 的摘要说明
    /// </summary>
    public class CuttorInfoUpdateUsedTime : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string wmscount = HttpContext.Current.Request.Params["wmscount"];
                
                string sqlwms = "";
                if (wmscount.Trim() != "")
                {
                    string[] list = wmscount.Split('|');
                    if (list.Length > 0)
                    {
                        for (int i = 0; i < list.Length; i++)
                        {
                            if (list[i].Trim() != "")
                            {
                                string[] list2 = list[i].Split('_');
                                sqlwms += string.Format(@"update CuttorInfo set UsedTime=N'{0}' where ID=N'{1}' ;", list2[1], list2[0]);
                            }
                        }

                    }
                }

                if (sqlwms != "") SQLHelper.ExcuteSQL(sqlwms);



                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "更新当前加工次数成功:" + wmscount);
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