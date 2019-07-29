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
    /// FaultCodeInfoEdit 的摘要说明
    /// </summary>
    public class FaultCodeInfoEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string EquipmentId = HttpContext.Current.Request.Params["equipmentId"];
                string FaultCode = HttpContext.Current.Request.Params["faultCode"];
                string FaultType = HttpContext.Current.Request.Params["faultType"];
                string FaultDesc = HttpContext.Current.Request.Params["faultDesc"];
                string PLCDB = HttpContext.Current.Request.Params["plcDB"];
                
                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into FaultCodeInfo(EquipmentId,FaultCode,FaultType,FaultDesc,PLCDB) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}') ;select SCOPE_IDENTITY();",
                        EquipmentId, FaultCode, FaultType, FaultDesc, PLCDB);
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
                            "新增故障代码信息成功:" + FaultCode);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update FaultCodeInfo set EquipmentId=N'{0}',FaultCode=N'{1}',FaultType=N'{2}',FaultDesc=N'{3}',PLCDB=N'{4}' where ID={5};",
                         EquipmentId, FaultCode, FaultType, FaultDesc, PLCDB, ID);


                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑故障代码信息成功:" + FaultCode);
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