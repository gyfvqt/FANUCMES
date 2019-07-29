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
    /// RestEdit 的摘要说明
    /// </summary>
    public class RestEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string ShiftCode = HttpContext.Current.Request.Params["shiftCode"];
                string ShiftName = HttpContext.Current.Request.Params["shiftName"];
                string BeginTime = HttpContext.Current.Request.Params["beginTime"];
                string EndTime = HttpContext.Current.Request.Params["endTime"];
                

                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into Rest(ShiftCode,ShiftName,BeginTime,EndTime) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}') ;select SCOPE_IDENTITY();",
                        ShiftCode, ShiftName, BeginTime, EndTime);
                    object o = SQLHelper.GetObject(sqlrole);
                    //if (o != null)
                    //{
                    //    string sqlx = @"update StationInfo set StationCode='FANUC-S-C-" + o.ToString().PadLeft(5, '0') + "' where ID=" + o.ToString();
                    //    SQLHelper.ExcuteSQL(sqlx);
                    //    ID = o.ToString();
                    //}
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增小休成功:" + ShiftName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update Rest set ShiftCode=N'{0}',ShiftName=N'{1}',BeginTime=N'{2}',EndTime=N'{3}' where ID={4};",
                         ShiftCode, ShiftName, BeginTime, EndTime, ID);


                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑小休成功:" + ShiftName);
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