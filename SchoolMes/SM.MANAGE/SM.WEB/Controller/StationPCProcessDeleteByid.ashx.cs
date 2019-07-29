﻿using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// StationPCProcessDeleteByid 的摘要说明
    /// </summary>
    public class StationPCProcessDeleteByid : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string QualityDesc = HttpContext.Current.Request.Params["qualityDesc"];
                string sql = "";

                if (ID.Trim() != "")
                {
                    sql += string.Format(@"delete from PCStationQuality  where QualityId =N'{0}';", ID);
                    SQLHelper.ExcuteSQL(sql);
                }

                SQLHelper.ExcuteSQL(sql);
                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "删除站点过程质量信息:" + ID + "/" + QualityDesc);
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