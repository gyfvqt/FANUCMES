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
    /// StationProcessEdit 的摘要说明
    /// </summary>
    public class StationProcessEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string PCStationId = HttpContext.Current.Request.Params["pcStationId"];
                string ProcessName = HttpContext.Current.Request.Params["processName"];
                string ProcessDesc = HttpContext.Current.Request.Params["processDesc"];
                string ProcessType = HttpContext.Current.Request.Params["processType"];
                

                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into PCStationProcessSheet(PCStationId,ProcessName,ProcessDesc,ProcessType) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}') ;select SCOPE_IDENTITY();",
                        PCStationId, ProcessName, ProcessDesc, ProcessType);
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
                            "新增站点工艺成功:" + ProcessName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update PCStationProcessSheet set PCStationId=N'{0}',ProcessName=N'{1}',ProcessDesc=N'{2}',ProcessType=N'{3}'where ProcessId={4};",
                         PCStationId, ProcessName, ProcessDesc, ProcessType, ID);

                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑站点工艺成功:" + ProcessName);
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