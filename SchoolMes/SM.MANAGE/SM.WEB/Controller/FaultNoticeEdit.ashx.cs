using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// FaultNoticeEdit 的摘要说明
    /// </summary>
    public class FaultNoticeEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string FaultName = HttpContext.Current.Request.Params["faultName"];
                string FaultDesc = HttpContext.Current.Request.Params["faultDesc"];
                string EquipmentId = HttpContext.Current.Request.Params["equipmentId"];                
                string UserId = HttpContext.Current.Request.Params["userId"];
                string FaultReturn = HttpContext.Current.Request.Params["faultReturn"];               

                DataSet dsuserinfo = new DataSet();

                dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                if (ID.Trim() == "")
                {

                    string sql = string.Format("insert into FaultNotice(FaultName,FaultDesc,EquipmentId,Creator,UserId,ExecuteStatus,CreateTime,FaultReturn) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'新建',getdate(),N'{5}') ;select SCOPE_IDENTITY();",
                        FaultName, FaultDesc, EquipmentId, dsuserinfo.Tables[0].Rows[0]["ID"].ToString(), UserId, FaultReturn);
                    object o = SQLHelper.GetObject(sql);
                    var code = "";
                    var CallId = "";
                    if (o != null)
                    {
                        code = "FN-"+DateTime.Now.ToString("yyyyMMdd") + o.ToString().PadLeft(6, '0');
                        string sqlx = @"update FaultNotice set TicketNo='"+ code + "' where ID=" + o.ToString();
                        SQLHelper.ExcuteSQL(sqlx);
                        CallId = o.ToString();
                    }

                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增故障通知单成功:" + FaultName);
                    }
                }
                else
                {

                    string sqlrole = string.Format("update FaultNotice set FaultName=N'{0}',FaultDesc=N'{1}',EquipmentId=N'{2}',UserId=N'{3}',FaultReturn=N'{5}' ,ExecuteStatus=N'{6}'  where ID={4};",
                     FaultName, FaultDesc, EquipmentId,  UserId, ID,FaultReturn, FaultReturn==""?"新建":"执行");
                    SQLHelper.ExcuteSQL(sqlrole);

                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑故障通知单成功:" + FaultName);
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