﻿using System;
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
    /// userEdit 的摘要说明
    /// </summary>
    public class userEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string UserID = HttpContext.Current.Request.Params["userid"];
                string LastName = HttpContext.Current.Request.Params["lastName"];
                string FirstName = HttpContext.Current.Request.Params["firstName"];
                string UserDesc = HttpContext.Current.Request.Params["userdesc"];
                string RoleId = HttpContext.Current.Request.Params["roleId"];
                string Email = HttpContext.Current.Request.Params["email"];
                string PhoneNumber = HttpContext.Current.Request.Params["phoneNumber"];
                //string UserImagic = HttpContext.Current.Request.Params["userImagic"];

                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into UserInfo(UserID,LastName,FirstName,UserDesc,RoleId,Email,PhoneNumber,Password) values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}') ;",
                        UserID, LastName, FirstName, UserDesc, RoleId, Email, PhoneNumber, Security.md5_Encode("123456"));
                    SQLHelper.ExcuteSQL(sqlrole);
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增用户成功:" + UserID+"/"+ LastName+ FirstName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update UserInfo set LastName=N'{0}',FirstName=N'{1}',UserDesc=N'{2}',RoleId=N'{3}',Email=N'{4}',PhoneNumber=N'{5}' where ID={6};", 
                        LastName, FirstName, UserDesc, RoleId, Email, PhoneNumber,  ID);
                   
                    
                    SQLHelper.ExcuteSQL(sqlrole);
                   

                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑用户成功:" + UserID + "/" + LastName + FirstName);
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