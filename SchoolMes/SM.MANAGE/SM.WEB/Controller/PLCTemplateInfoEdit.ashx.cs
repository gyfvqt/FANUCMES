using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// PLCTemplateInfoEdit 的摘要说明
    /// </summary>
    public class PLCTemplateInfoEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string PLCTemplateName = HttpContext.Current.Request.Params["plcTemplateName"];
                //string ProcessName = HttpContext.Current.Request.Params["processName"];
                //string ProcessDesc = HttpContext.Current.Request.Params["processDesc"];
                //string ProcessType = HttpContext.Current.Request.Params["processType"];

                DataSet dsuserinfo = new DataSet();
                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                }
                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into PLCTemplateInfo(PLCTemplateName,UpdateTime,Updator) " +
                        "values(N'{0}',N'{1}',N'{2}') ;select SCOPE_IDENTITY();",
                        PLCTemplateName, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString());
                    object o = SQLHelper.GetObject(sqlrole);
                    if (o != null)
                    {
                        //string sqlx = @"update StationInfo set StationCode='FANUC-S-C-" + o.ToString().PadLeft(5, '0') + "' where ID=" + o.ToString();
                        //SQLHelper.ExcuteSQL(sqlx);
                        ID = o.ToString();
                    }
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增PLC模板成功:" + PLCTemplateName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update PLCTemplateInfo set PLCTemplateName=N'{0}',UpdateTime=N'{1}',Updator=N'{2}' where ID={3};",
                         PLCTemplateName, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), 
                         dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(), ID);

                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑PLC模板成功:" + PLCTemplateName);
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