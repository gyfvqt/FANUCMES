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
    /// AndonEdit 的摘要说明
    /// </summary>
    public class AndonEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string AndonNo = HttpContext.Current.Request.Params["andonNo"];
                string AndonName = HttpContext.Current.Request.Params["andonName"];
                string LineId = HttpContext.Current.Request.Params["lineId"];
                string LineName = HttpContext.Current.Request.Params["lineName"];
                string AndonIP = HttpContext.Current.Request.Params["andonIP"];
                string Team = HttpContext.Current.Request.Params["team"];
                //string PhoneNumber = HttpContext.Current.Request.Params["phoneNumber"];
                //string UserImagic = HttpContext.Current.Request.Params["userImagic"];

                if (ID.Trim() == "")
                {                   
                    
                    string sqlrole = string.Format("insert into AndonConfiguration(AndonName,LineId,LineName,AndonIP,Team) values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}') ;select SCOPE_IDENTITY();",
                         AndonName, LineId, LineName, AndonIP,Team);
                    object o = SQLHelper.GetObject(sqlrole);

                    if (o != null)
                    {
                        o.ToString().PadLeft(4, '0');
                        string sqlx = @"update AndonConfiguration set AndonNo='Andon" + o.ToString().PadLeft(4, '0') + "' where ID=" + o.ToString();
                        SQLHelper.ExcuteSQL(sqlx);                        
                    }
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增Andon成功:" + "FANUC_Andon" + o + "/" + AndonName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update AndonConfiguration set AndonName=N'{0}',LineId=N'{1}',LineName=N'{2}',AndonIP=N'{3}',Team=N'{5}' where ID={4};",
                         AndonName, LineId, LineName, AndonIP, ID,Team);


                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑Andon成功:" + AndonNo + "/" + AndonName);
                    }
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