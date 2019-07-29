using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// CuttorAlarmConfigurationEdit 的摘要说明
    /// </summary>
    public class CuttorAlarmConfigurationEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                //string SNO = HttpContext.Current.Request.Params["sno"];
                string Station = HttpContext.Current.Request.Params["station"];
                string User = HttpContext.Current.Request.Params["user"];
                string sql = string.Format(@"delete from CuttorAlarmConfigurationStation where TipId=N'{0}';
                                            delete from CuttorAlarmConfigurationUser where TipId=N'{0}';", ID);
                SQLHelper.ExcuteSQL(sql);
                string code = "";
                string CallId = "";
                if (ID.Trim() == "")
                {
                    sql = string.Format(@"insert into CuttorAlarmConfiguration(SNO) values(N'{0}');select SCOPE_IDENTITY();", "");
                    object o = SQLHelper.GetObject(sql);

                    if (o != null)
                    {
                        code = "SN_" + o.ToString().PadLeft(6, '0');
                        string sqlx = @"update CuttorAlarmConfiguration set SNO='" + code + "' where ID=" + o.ToString();
                        SQLHelper.ExcuteSQL(sqlx);
                        CallId = o.ToString();
                    }
                }
                else
                {
                    CallId = ID;
                }
                string sqluser = "";
                if (User != "")
                {
                    string user = User.TrimStart('|').Replace('|', ',');

                    sql = string.Format(@"Select ID,LastName+FirstName as UserName from UserInfo(nolock) where ID in({0})", user);
                    DataSet dsUser = SQLHelper.GetDataSet(sql);
                    //string sqluser = "";
                    if (dsUser != null && dsUser.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < dsUser.Tables[0].Rows.Count; i++)
                        {
                            sqluser += string.Format(@"insert into CuttorAlarmConfigurationUser(UserId,UserName,TipId) values(N'{0}',N'{1}',N'{2}');",
                                dsUser.Tables[0].Rows[i]["ID"].ToString(), dsUser.Tables[0].Rows[i]["UserName"].ToString(), CallId);
                        }
                        //if (sqluser != "") SQLHelper.ExcuteSQL(sqluser);
                    }
                }

                if (Station != "")
                {
                    string station = Station.TrimStart('|').Replace('|', ',');

                    sql = string.Format(@"Select ID,StationCode from StationInfo(nolock) where ID in({0})", station);
                    DataSet dsUser = SQLHelper.GetDataSet(sql);
                    //string sqluser = "";
                    if (dsUser != null && dsUser.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < dsUser.Tables[0].Rows.Count; i++)
                        {
                            sqluser += string.Format(@"insert into CuttorAlarmConfigurationStation(StationId,StationCode,TipId) values(N'{0}',N'{1}',N'{2}');",
                                dsUser.Tables[0].Rows[i]["ID"].ToString(), dsUser.Tables[0].Rows[i]["StationCode"].ToString(), CallId);
                        }
                        //if (sqluser != "") SQLHelper.ExcuteSQL(sqluser);
                    }
                }

                if (sqluser != "") SQLHelper.ExcuteSQL(sqluser);
                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "设置换刀提醒成功:" + Station + "/" + User);
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