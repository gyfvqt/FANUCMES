using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// FaultUserInfoEdit 的摘要说明
    /// </summary>
    public class FaultUserInfoEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                //string ID = HttpContext.Current.Request.Params["id"];
                string EquipmentId = HttpContext.Current.Request.Params["equipmentId"];
                string EquipmentName = HttpContext.Current.Request.Params["equipmentName"];
                string User = HttpContext.Current.Request.Params["UserId"];
                string sql = string.Format(@"delete from FaultUserInfo where EquipmentId=N'{0}';", EquipmentId);
                if (User != "")
                {
                    string[] arruser = User.Split('|');
                    if (arruser.Length > 0)
                    {
                        for (int i = 0; i < arruser.Length; i++)
                        {
                            if (arruser[i] != "")
                            {
                                string[] arrUser = arruser[i].Split('_');
                                if (arruser.Length > 1)
                                {
                                    sql += string.Format(@"insert into FaultUserInfo(EquipmentId,EquipmentName,UserId,UserName) values(N'{0}',N'{1}',N'{2}',N'{3}');", EquipmentId, EquipmentName, arrUser[0], arrUser[1]);
                                }
                            }
                        }
                    }
                }
                SQLHelper.ExcuteSQL(sql);
                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "设置设备提醒成功:" + EquipmentId + "/" + EquipmentName);
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