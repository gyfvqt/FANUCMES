using DAL;
using GF2.MES.Report.Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;


namespace SM.WEB.Controller
{
    /// <summary>
    /// PLCTemplateOperationInfoEdit 的摘要说明
    /// </summary>
    public class PLCTemplateOperationInfoEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string PLCStationId = HttpContext.Current.Request.Params["plcStationId"];
                string PLCTrigger = HttpContext.Current.Request.Params["plcTrigger"];
                string CommunicateType = HttpContext.Current.Request.Params["communicateType"];
                string CheckAddress = HttpContext.Current.Request.Params["checkAddress"];
                string PLCDB = HttpContext.Current.Request.Params["plcDB"];
                string ActionCode = HttpContext.Current.Request.Params["actionCode"];
                string CommunicateName = HttpContext.Current.Request.Params["communicateName"];
                string ReturnLength = HttpContext.Current.Request.Params["returnLength"];
                string PLCTemplateId = HttpContext.Current.Request.Params["plcTemplateId"];
                //string IsEnable = HttpContext.Current.Request.Params["isEnable"];

                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into PLCTemplateOperationInfo(PLCStationId,PLCTemplateId,PLCTrigger,CommunicateType,CheckAddress,PLCDB,ActionCode,CommunicateName,ReturnLength) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}') ;select SCOPE_IDENTITY();",
                        PLCStationId, PLCTemplateId, PLCTrigger, CommunicateType, CheckAddress, PLCDB, ActionCode, CommunicateName, ReturnLength);
                    object o = SQLHelper.GetObject(sqlrole);
                    if (o != null)
                    {                        
                        ID = o.ToString();
                    }
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增PLC模板信息成功:" + PLCTemplateId );
                    }
                }
                else
                {
                    string sqlrole = string.Format("update PLCTemplateOperationInfo set PLCStationId=N'{0}',PLCTemplateId=N'{1}',PLCTrigger=N'{2}',CommunicateType=N'{3}',CheckAddress=N'{4}',PLCDB=N'{5}',ActionCode=N'{6}',CommunicateName=N'{7}',ReturnLength=N'{8}' where ID={9};",
                         PLCStationId, PLCTemplateId, PLCTrigger, CommunicateType, CheckAddress, PLCDB, ActionCode, CommunicateName, ReturnLength, ID);


                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑PLC模板信息成功:" + PLCTemplateId);
                    }
                }
                HttpContext.Current.Response.Write(ID);
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