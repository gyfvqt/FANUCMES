using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// FaultUserInfoDeleteByEid 的摘要说明
    /// </summary>
    public class FaultUserInfoDeleteByEid : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string EquipmentId = HttpContext.Current.Request.Params["id"];
                string EquipmentName = HttpContext.Current.Request.Params["ename"];
                string sql = "";


                sql += string.Format(@"delete from FaultUserInfo  where EquipmentId =N'{0}';", EquipmentId);
                SQLHelper.ExcuteSQL(sql);



                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "删除设备故障提醒设置成功:" + EquipmentId + "/" + EquipmentName);
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