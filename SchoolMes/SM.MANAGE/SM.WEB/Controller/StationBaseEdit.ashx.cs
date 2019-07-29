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
    /// StationBaseEdit 的摘要说明
    /// </summary>
    public class StationBaseEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string StationCode = HttpContext.Current.Request.Params["stationCode"];
                string StationName = HttpContext.Current.Request.Params["stationName"];
                string StationType = HttpContext.Current.Request.Params["stationType"];
                string StationDesc = HttpContext.Current.Request.Params["stationDesc"];
                string LineId = HttpContext.Current.Request.Params["lineId"];
                string StationPosition = HttpContext.Current.Request.Params["stationPosition"];
                string Team = HttpContext.Current.Request.Params["team"];
                string IP = HttpContext.Current.Request.Params["ip"];
                string IsFirst = HttpContext.Current.Request.Params["isfirst"];
                string StationAsset = HttpContext.Current.Request.Params["stationAsset"]; 
                //string IsEnable = HttpContext.Current.Request.Params["isEnable"];
                var xcode = "00";
                if (StationPosition == "标准站点")
                {
                    xcode = LineId.PadLeft(2, '0');
                }
                if (IsFirst == "1")
                {
                    string sqlf = @"select * from StationInfo where LineId=N'"+LineId+ "' AND IsFirstStation='1' AND ID<>N'"+ID+"' ";
                    DataSet ds = SQLHelper.GetDataSet(sqlf);
                    if (ds != null && ds.Tables[0].Rows.Count > 0)
                    {
                        HttpContext.Current.Response.Write("-1");
                        return;
                    }
                }
                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into StationInfo(LineId,StationName,StationDesc,StationType,StationPosition,Team,IP,IsEnable,IsFirstStation,StationAsset) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',N'{9}') ;select SCOPE_IDENTITY();",
                        LineId, StationName, StationDesc, StationType, StationPosition, Team, IP, 1,IsFirst, StationAsset);
                    object o= SQLHelper.GetObject(sqlrole);
                    if (o != null)
                    {
                        string sqlx = @"update StationInfo set StationCode='"+ xcode + o.ToString().PadLeft(3,'0') + "' where ID=" + o.ToString();
                        SQLHelper.ExcuteSQL(sqlx);
                        ID = o.ToString();
                    }
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增站点基本信息成功:" + StationName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update StationInfo set LineId=N'{0}',StationName=N'{1}',StationDesc=N'{2}',StationType=N'{3}',StationPosition=N'{4}',Team=N'{5}',IP=N'{6}',IsFirstStation=N'{8}',StationAsset=N'{9}' where ID={7};",
                         LineId, StationName, StationDesc, StationType, StationPosition, Team, IP, ID,IsFirst, StationAsset);


                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑站点基本信息成功:" + StationName);
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