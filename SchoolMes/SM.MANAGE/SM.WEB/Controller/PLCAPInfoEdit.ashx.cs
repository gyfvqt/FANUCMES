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
    /// PLCAPInfoEdit 的摘要说明
    /// </summary>
    public class PLCAPInfoEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string PLCStationId = HttpContext.Current.Request.Params["plcStationId"];
                string PLCAPDBAddress = HttpContext.Current.Request.Params["plcAPDBAddress"];
                string APDataLength = HttpContext.Current.Request.Params["apDataLength"];
                string APDataDesc = HttpContext.Current.Request.Params["apDataDesc"];


                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into PLCAPInfo(PLCStationId,PLCAPDBAddress,APDataLength,APDataDesc) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}') ;select SCOPE_IDENTITY();",
                        PLCStationId, PLCAPDBAddress, 1, APDataDesc);
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
                            "新增站点PLCAP信息成功:" + APDataDesc);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update PLCAPInfo set PLCStationId=N'{0}',PLCAPDBAddress=N'{1}',APDataLength=N'{2}',APDataDesc=N'{3}' where PLCAPId=N'{4}';",
                         PLCStationId, PLCAPDBAddress, 1, APDataDesc, ID);

                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑站点PLCAP信息成功:" + APDataDesc);
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