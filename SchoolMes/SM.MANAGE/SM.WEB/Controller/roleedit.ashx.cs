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
    /// roleedit 的摘要说明
    /// </summary>
    public class roleedit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string RoleName = HttpContext.Current.Request.Params["rolename"];
                string RoleDesc = HttpContext.Current.Request.Params["roledesc"];
                string Perminssions = HttpContext.Current.Request.Params["permissions"];

                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into UserRole(RoleName,RoleDesc) values(N'{0}',N'{1}') ;", RoleName, RoleDesc);
                    SQLHelper.ExcuteSQL(sqlrole);
                    string getrole = @"select max(ID)  from UserRole";
                    string roleid = SQLHelper.GetObject(getrole).ToString();
                    string permissions = "";
                    if (Perminssions.Trim() != "")
                    {
                        string[] list = Perminssions.Split('|');
                        if (list.Length > 0)
                        {
                            for (int i = 0; i < list.Length; i++)
                            {
                                if (list[i].Trim() != "")
                                {
                                    permissions += string.Format(@"insert into Permissions(RoleId,MenuId) values(N'{0}',N'{1}') ;", roleid, list[i]);
                                }
                            }
                            SQLHelper.ExcuteSQL(permissions);
                        }
                    }
                    
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增角色成功:"+RoleName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update UserRole set RoleName=N'{0}',RoleDesc=N'{1}' where ID={2};", RoleName, RoleDesc, ID);
                    string deletepermissio = string.Format(@"delete from Permissions where RoleId={0};", ID);
                    string permissions = "";
                    if (Perminssions.Trim() != "")
                    {
                        string[] list = Perminssions.Split('|');
                        if (list.Length > 0)
                        {
                            for (int i = 0; i < list.Length; i++)
                            {
                                if (list[i].Trim() != "")
                                {
                                    permissions += string.Format(@"insert into Permissions(RoleId,MenuId) values(N'{0}',N'{1}') ;", ID, list[i]);
                                }
                            }

                        }
                    }
                    SQLHelper.ExcuteSQL(sqlrole + deletepermissio + permissions);
                    //SQLHelper.ExcuteSQL(permissions);

                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑角色成功:" + RoleName);
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