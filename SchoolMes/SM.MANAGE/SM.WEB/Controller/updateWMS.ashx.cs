using DAL;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// updateWMS 的摘要说明
    /// </summary>
    public class updateWMS : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string wmscount = HttpContext.Current.Request.Params["wmscount"];
                //string WarehouseNo = HttpContext.Current.Request.Params["warehouseNo"];
                //string WarehouseType = HttpContext.Current.Request.Params["warehouseType"];
                //string WarehouseName = HttpContext.Current.Request.Params["warehouseName"];
                //string DesignCycle = HttpContext.Current.Request.Params["designCycle"];
                //string PlanCycle = HttpContext.Current.Request.Params["planCycle"];
                //string IsEnable = HttpContext.Current.Request.Params["isEnable"];
                //string PhoneNumber = HttpContext.Current.Request.Params["phoneNumber"];
                //string UserImagic = HttpContext.Current.Request.Params["userImagic"];


                string sqlwms = "";
                if (wmscount.Trim() != "")
                {
                    string[] list = wmscount.Split('|');
                    if (list.Length > 0)
                    {
                        for (int i = 0; i < list.Length; i++)
                        {
                            if (list[i].Trim() != "")
                            {
                                string[] list2 = list[i].Split('_');
                                sqlwms += string.Format(@"update Material_W_S set MTotal=N'{0}' where ID=N'{1}' ;", list2[1], list2[0]);
                            }
                        }
                        
                    }
                }

                if(sqlwms!="") SQLHelper.ExcuteSQL(sqlwms);



                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "更新库存成功:" + wmscount);
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