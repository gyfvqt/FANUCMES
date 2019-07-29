using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Data;
using DAL;
using SM.WEB;

namespace SM.WEB.Controller
{
    /// <summary>
    /// Login 的摘要说明
    /// </summary>
    public class Login : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string UserID = HttpContext.Current.Request.Params["userid"];
                string Password = HttpContext.Current.Request.Params["password"];
                if (UserID.Trim() != "" && Password.Trim() != "")
                {
                    DataSet dsuserinfo = new DataSet();
                    DataSet dsFpermission = new DataSet();
                    DataSet dsSpermission = new DataSet();
                    string sqluser = string.Format(@"select a.*,b.RoleName from UserInfo a join UserRole b on a.RoleId=b.ID where a.UserId=N'{0}' and Password=N'{1}'", UserID, Security.md5_Encode( Password.Trim()));
                    dsuserinfo = SQLHelper.GetDataSet(sqluser);
                    if (dsuserinfo != null && dsuserinfo.Tables[0].Rows.Count > 0)
                    {
                        context.Session["_dsuserinfo"] = dsuserinfo;
                        string sqlFpermission = @"select * from Menus where ParentId=0";
                        dsFpermission = SQLHelper.GetDataSet(sqlFpermission);
                        context.Session["_dsFpermission"] = dsFpermission;

                        string sqlSpermission = string.Format(@"select a.* from Menus a join Permissions b on a.ID=b.MenuId where b.RoleId=N'{0}' order by a.ParentId asc", dsuserinfo.Tables[0].Rows[0]["RoleId"].ToString());
                        dsSpermission = SQLHelper.GetDataSet(sqlSpermission);
                        context.Session["_dsSpermission"] = dsSpermission;
                        context.Response.Write("1");

                        SystemLogs.InsertSystemLog(UserID, dsuserinfo.Tables[0].Rows[0]["LastName"].ToString()+ dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(), dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(), "登录系统！");
                    }
                    else
                    {
                        context.Response.Write("0");
                    }

                    
                }
                else
                {
                    context.Response.Write("0");
                }
            }
            catch (Exception ex)
            {
                context.Response.Write("-1");
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