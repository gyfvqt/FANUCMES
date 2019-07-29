using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// PLCTemplateInfoDetailEdit 的摘要说明
    /// </summary>
    public class PLCTemplateInfoDetailEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string PLCTemplateID = HttpContext.Current.Request.Params["plcTemplateID"];
                string PLCUPDBAddress = HttpContext.Current.Request.Params["plcUPDBAddress"];
                //string UPDataLength = HttpContext.Current.Request.Params["upDataLength"];
                string UPDataDesc = HttpContext.Current.Request.Params["upDataDesc"];

                DataSet dsuserinfo = new DataSet();
                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                }
                if (ID.Trim() == "")
                {
                    string sqlrole = string.Format("insert into PLCTemplateInfoDetail(PLCTemplateID,PLCUPDBAddress,UPDataLength,UPDataDesc) " +
                        "values(N'{0}',N'{1}',N'{2}',N'{3}') ;select SCOPE_IDENTITY();",
                        PLCTemplateID, PLCUPDBAddress, 1, UPDataDesc);
                    object o = SQLHelper.GetObject(sqlrole);
                    //if (o != null)
                    //{
                    //    //string sqlx = @"update StationInfo set StationCode='FANUC-S-C-" + o.ToString().PadLeft(5, '0') + "' where ID=" + o.ToString();
                    //    //SQLHelper.ExcuteSQL(sqlx);
                    //    ID = o.ToString();
                    //}
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增PLC模板明细成功:" + UPDataDesc);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update PLCTemplateInfoDetail set PLCTemplateID=N'{0}',PLCUPDBAddress=N'{1}',UPDataLength=N'{2}',UPDataDesc=N'{3}' where ID={4};",
                         PLCTemplateID, PLCUPDBAddress, 1, UPDataDesc, ID);

                    SQLHelper.ExcuteSQL(sqlrole);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑PLC模板明细成功:" + UPDataDesc);
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