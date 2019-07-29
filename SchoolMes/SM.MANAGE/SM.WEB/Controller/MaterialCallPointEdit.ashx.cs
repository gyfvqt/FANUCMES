using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// MaterialCallPointEdit 的摘要说明
    /// </summary>
    public class MaterialCallPointEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string MaterialCallCode = HttpContext.Current.Request.Params["materialCallCode"];
                string MaterialId = HttpContext.Current.Request.Params["materialId"];
                string StoreId = HttpContext.Current.Request.Params["storeId"];
                string CallType = HttpContext.Current.Request.Params["callType"];
                string DeductionCountor = HttpContext.Current.Request.Params["deductionCountor"];
                string DeliverType = HttpContext.Current.Request.Params["deliverType"];
                string SaveNumber = HttpContext.Current.Request.Params["saveNumber"];
                string DelayTime = HttpContext.Current.Request.Params["delayTime"];
                string DeliverWay = HttpContext.Current.Request.Params["deliverWay"];
                string StationId = HttpContext.Current.Request.Params["stationId"];

                DataSet dsuserinfo = new DataSet();


                if (ID.Trim() == "")
                {

                    string sqlrole = string.Format("insert into MaterialCallPoint(MaterialCallCode,MaterialId,StoreId,CallType,DeductionCountor,DeliverType,SaveNumber,DelayTime,DeliverWay,StationId,WHCount) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}',0) ;",
                        MaterialCallCode, MaterialId, StoreId, CallType, DeductionCountor, DeliverType, SaveNumber, DelayTime, DeliverWay, StationId);
                    SQLHelper.ExcuteSQL(sqlrole);

                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增零件落点成功:" + MaterialCallCode);
                    }
                }
                else
                {

                    string sqlrole = string.Format("update MaterialCallPoint set MaterialCallCode=N'{0}',MaterialId=N'{1}',StoreId=N'{2}',CallType=N'{3}',DeductionCountor=N'{4}',DeliverType=N'{5}',SaveNumber=N'{6}',DelayTime=N'{7}',DeliverWay=N'{8}',StationId=N'{9}' where ID={10};",
                     MaterialCallCode, MaterialId, StoreId, CallType, DeductionCountor, DeliverType, SaveNumber, DelayTime, DeliverWay, StationId, ID);
                    SQLHelper.ExcuteSQL(sqlrole);

                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑零件落点成功:" + MaterialCallCode);
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