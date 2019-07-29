using DAL;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// WorkShiftEdit 的摘要说明
    /// </summary>
    public class WorkShiftEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";                
                string YM = HttpContext.Current.Request.Params["ymdList"];
                string sql = "delete from WorkShift;";
                if (YM.Trim() != "")
                {
                    YM = YM.TrimStart('|');
                    string[] ymdList = YM.Split('|');
                    if (ymdList.Length > 0)
                    {
                        for (int i = 0; i < ymdList.Length; i++)
                        {
                            string[] shif = ymdList[i].Split('_');
                            if(shif.Length==3)
                            {
                                sql += string.Format(@"insert WorkShift(ID,BeginTime,EndTime) values(N'{0}',N'{1}',N'{2}');", shif[0], shif[1],shif[2]);
                            }
                            
                        }
                        if(sql!="") SQLHelper.ExcuteSQL(sql);
                    }
                }


                DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                    dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                    dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                    "设置班次成功!");

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