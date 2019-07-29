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
    /// EquipmentDataEdit 的摘要说明
    /// </summary>
    public class EquipmentDataEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string ParentId = HttpContext.Current.Request.Params["parentId"];
                string EquipmentCode = HttpContext.Current.Request.Params["equipmentCode"];
                string EquipmentName = HttpContext.Current.Request.Params["equipmentName"];
                string EquipmentDesc = HttpContext.Current.Request.Params["equipmentDesc"];
                string Team = HttpContext.Current.Request.Params["team"];
                string EquipmentImg = HttpContext.Current.Request.Params["equipmentImg"];
                string PLCIP = HttpContext.Current.Request.Params["plcIP"];
                string EType = HttpContext.Current.Request.Params["etype"];
                string PLCDB = HttpContext.Current.Request.Params["plcDB"];
                string IsPayPoint = HttpContext.Current.Request.Params["isPayPoint"];
                string DesignCycletime = HttpContext.Current.Request.Params["designCycletime"];
                string DesignJPH = HttpContext.Current.Request.Params["designJPH"];
                string EquipmentSupplier = HttpContext.Current.Request.Params["equipmentSupplier"];
                string Counter = HttpContext.Current.Request.Params["counter"];

                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into EquipmentData(ParentId,EquipmentCode,EquipmentName,EquipmentDesc,Team,PLCIP,PLCDB,IsPayPoint,DesignCycletime,DesignJPH,EquipmentSupplier,Counter,EquipmentImg,EType) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}',N'{10}',N'{11}',N'{12}',N'{13}') ;select SCOPE_IDENTITY();",
                        ParentId, EquipmentCode, EquipmentName, EquipmentDesc, Team, PLCIP, PLCDB, IsPayPoint, DesignCycletime, DesignJPH, EquipmentSupplier, Counter, EquipmentImg, EType);
                    object o = SQLHelper.GetObject(sqlrole);
                    if (o != null)
                    {
                        ID = o.ToString();
                        string sqlx = @"update EquipmentData set EquipmentId='" + o.ToString().PadLeft(3, '0') + "' where ID=" + o.ToString();
                        SQLHelper.ExcuteSQL(sqlx);
                    }
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增设备成功:" + EquipmentName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update EquipmentData set ParentId=N'{0}',EquipmentCode=N'{1}',EquipmentName=N'{2}',EquipmentDesc=N'{3}',Team=N'{4}',PLCIP=N'{5}',PLCDB=N'{6}',IsPayPoint=N'{7}',DesignCycletime=N'{8}',DesignJPH=N'{9}',EquipmentSupplier=N'{10}',Counter=N'{11}',EquipmentImg=N'{13}',EType=N'{14}' where ID={12};",
                         ParentId, EquipmentCode, EquipmentName, EquipmentDesc, Team, PLCIP, PLCDB, IsPayPoint, DesignCycletime, DesignJPH, EquipmentSupplier, Counter, ID, EquipmentImg, EType);                    
                    SQLHelper.ExcuteSQL(sqlrole);
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑设备成功:" + EquipmentName);
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