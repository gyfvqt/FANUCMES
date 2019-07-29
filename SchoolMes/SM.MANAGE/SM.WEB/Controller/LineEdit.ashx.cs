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
    /// LineEdit 的摘要说明
    /// </summary>
    public class LineEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string LineId = HttpContext.Current.Request.Params["lineid"];
                string LineName = HttpContext.Current.Request.Params["lineName"];
                string LineType = HttpContext.Current.Request.Params["lineType"];
                string DesignCycle = HttpContext.Current.Request.Params["designCycle"];
                string PlanCycle = HttpContext.Current.Request.Params["planCycle"];
                string IsEnable = HttpContext.Current.Request.Params["isEnable"];
                string PLCDB = HttpContext.Current.Request.Params["plcdb"];
                //string UserImagic = HttpContext.Current.Request.Params["userImagic"];

                if (ID.Trim() == "")
                {                    
                    var code = "";
                    var CallId = ID;
                    string sqlrole = string.Format("insert into LineInfo(LineName,LineType,DesignCycle,PlanCycle,IsEnable,PLCDB) values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}') ;select SCOPE_IDENTITY();",
                         LineName, LineType, DesignCycle, PlanCycle, IsEnable, PLCDB);
                    object o = SQLHelper.GetObject(sqlrole);

                    if (o != null)
                    {
                        code =  o.ToString().PadLeft(2, '0');
                        string sqlx = @"update LineInfo set LineId='" + code + "' where ID=" + o.ToString();
                        SQLHelper.ExcuteSQL(sqlx);
                        CallId = o.ToString();
                    }
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增线体成功:" + LineId + "/" + LineName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update LineInfo set LineName=N'{0}',LineType=N'{1}',DesignCycle=N'{2}',PlanCycle=N'{3}',IsEnable=N'{4}',PLCDB=N'{6}' where ID={5};",
                         LineName, LineType, DesignCycle, PlanCycle, IsEnable, ID, PLCDB);


                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑线体成功:" + LineId + "/" + LineName );
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