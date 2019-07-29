using DAL;
using GF2.MES.Report.Helper;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// ERPInterfaceRuleEdit 的摘要说明
    /// </summary>
    public class ERPInterfaceRuleEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string erprule = HttpContext.Current.Request.Params["erprule"];
                //string WarehouseNo = HttpContext.Current.Request.Params["warehouseNo"];
                //string WarehouseType = HttpContext.Current.Request.Params["warehouseType"];
                //string WarehouseName = HttpContext.Current.Request.Params["warehouseName"];
                //string DesignCycle = HttpContext.Current.Request.Params["designCycle"];
                //string PlanCycle = HttpContext.Current.Request.Params["planCycle"];
                //string IsEnable = HttpContext.Current.Request.Params["isEnable"];
                //string PhoneNumber = HttpContext.Current.Request.Params["phoneNumber"];
                //string UserImagic = HttpContext.Current.Request.Params["userImagic"];


                string sqlwms = "";
                if (erprule.Trim() != "")
                {
                    string[] list = erprule.Split('|');
                    if (list.Length > 0)
                    {
                        for (int i = 0; i < list.Length; i++)
                        {
                            if (list[i].Trim() != "")
                            {
                                string[] list2 = list[i].Split('_');
                                sqlwms += string.Format(@"update ERPInterfaceRule set BeginChar=N'{0}',DataLength=N'{1}' where ID=N'{2}' ;", list2[1], list2[2], list2[0]);
                            }
                        }

                    }
                }

                if (sqlwms != "") SQLHelper.ExcuteSQL(sqlwms);



                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "更新ERP接口字段配置成功:" + erprule);
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