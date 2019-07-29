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
    /// StationTraceabilityEdit 的摘要说明
    /// </summary>
    public class StationTraceabilityEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string PCStationId = HttpContext.Current.Request.Params["pcStationId"];
                string TraceabilityDesc = HttpContext.Current.Request.Params["traceabilityDesc"];
                //string ProcessDesc = HttpContext.Current.Request.Params["processDesc"];
                //string ProcessType = HttpContext.Current.Request.Params["processType"];


                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into PCTraceability(PCStationId,TraceabilityDesc) " +
                        "values(N'{0}',N'{1}') ;select SCOPE_IDENTITY();",
                        PCStationId, TraceabilityDesc);
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
                            "新增站点零件追溯信息成功:" + TraceabilityDesc);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update PCTraceability set PCStationId=N'{0}',TraceabilityDesc=N'{1}' where ProcessId={2};",
                         PCStationId, TraceabilityDesc,  ID);

                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑站点零件追溯信息成功:" + TraceabilityDesc);
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