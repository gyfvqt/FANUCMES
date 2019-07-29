using DAL;
using GF2.MES.Report.Helper;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// ERPInterfaceEdit 的摘要说明
    /// </summary>
    public class ERPInterfaceEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string FTPIP = HttpContext.Current.Request.Params["ftpip"];
                string FileName = HttpContext.Current.Request.Params["fileName"];
                string Path = HttpContext.Current.Request.Params["path"];
                string GetRate = HttpContext.Current.Request.Params["getRate"];
                string IsEnable = HttpContext.Current.Request.Params["isEnable"];
                //string IsEnable = HttpContext.Current.Request.Params["isEnable"];
                //string PhoneNumber = HttpContext.Current.Request.Params["phoneNumber"];
                //string UserImagic = HttpContext.Current.Request.Params["userImagic"];

                if (ID.Trim() == "")
                {
                    
                    string sqlrole = string.Format("insert into ERPInterface(FTPIP,FileName,Path,GetRate,IsEnable) values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}') ;",
                        FTPIP, FileName, Path, GetRate, IsEnable);
                    SQLHelper.ExcuteSQL(sqlrole);
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增ERP接口基本信息成功；" );
                    }
                }
                else
                {
                    string sqlrole = string.Format("update ERPInterface set FTPIP=N'{0}',FileName=N'{1}',Path=N'{2}',GetRate=N'{3}',IsEnable=N'{4}' where ID={5};",
                         FTPIP, FileName, Path, GetRate, IsEnable, ID);


                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑ERP接口基本信息成功；");
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