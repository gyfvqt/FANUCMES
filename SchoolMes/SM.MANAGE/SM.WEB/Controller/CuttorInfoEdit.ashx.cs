using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// CuttorInfoEdit 的摘要说明
    /// </summary>
    public class CuttorInfoEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string CutterCode = HttpContext.Current.Request.Params["cutterCode"];
                string CutterName = HttpContext.Current.Request.Params["cutterName"];
                string CutterSupplier = HttpContext.Current.Request.Params["cutterSupplier"];
                string CutterDesc = HttpContext.Current.Request.Params["cutterDesc"];
                string CutterImg = HttpContext.Current.Request.Params["cutterImg"];
                string StoreId = HttpContext.Current.Request.Params["storeId"];
                string Speed = HttpContext.Current.Request.Params["speed"];
                string LimitTime = HttpContext.Current.Request.Params["limitTime"];
                string AlarmTime = HttpContext.Current.Request.Params["alarmTime"];
                string StationId = HttpContext.Current.Request.Params["stationId"];
                string SingleTime = HttpContext.Current.Request.Params["singleTime"];
                string UsedTime = HttpContext.Current.Request.Params["usedTime"];
                string Status = HttpContext.Current.Request.Params["status"];
                DataSet dsuserinfo = new DataSet();
                
                
                if (ID.Trim() == "")
                {
                    
                        string sqlrole = string.Format("insert into CuttorInfo(CutterCode,CutterName,CutterSupplier,CutterDesc,CutterImg,StoreId,Speed,LimitTime,AlarmTime,StationId,SingleTime,UsedTime,Status) " +
                            "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}',N'{10}',N'{11}',N'{12}') ;",
                            CutterCode, CutterName, CutterSupplier, CutterDesc, CutterImg, StoreId, Speed, LimitTime, AlarmTime, StationId, SingleTime, UsedTime, Status);
                        SQLHelper.ExcuteSQL(sqlrole);
                    
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增刀具成功:" + CutterName);
                    }
                }
                else
                {
                    
                        string sqlrole = string.Format("update CuttorInfo set CutterCode=N'{0}',CutterName=N'{1}',CutterSupplier=N'{2}',CutterDesc=N'{3}',CutterImg=N'{4}',StoreId=N'{5}',Speed=N'{6}',LimitTime=N'{7}',AlarmTime=N'{8}',StationId=N'{9}',SingleTime=N'{10}',UsedTime=N'{11}',Status=N'{12}' where ID={13};",
                         CutterCode, CutterName, CutterSupplier, CutterDesc, CutterImg, StoreId, Speed, LimitTime, AlarmTime, StationId, SingleTime, UsedTime, Status, ID);
                        SQLHelper.ExcuteSQL(sqlrole);
                    
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑刀具成功:" + CutterName);
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