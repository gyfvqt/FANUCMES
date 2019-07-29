using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GF2.MES.Report.Helper;
using DAL;
using System.Data;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Controller
{
    /// <summary>
    /// HomeFaultNotice 的摘要说明
    /// </summary>
    public class HomeFaultNotice : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["userId"];

                string sqlSearch = string.Format(@"select  a.TicketNo,a.FaultName,a.FaultDesc,CONVERT(varchar(100), a.CreateTime, 23) CreateTime from FaultNotice(nolock) a join FaultUserInfo(nolock) b on a.EquipmentId=b.EquipmentId where b.UserId=N'{0}' order by a.ID desc", ID);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);

                string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());
                HttpContext.Current.Response.Write(result);

                //HttpContext.Current.Response.End();

            }
            catch (Exception ex)
            {
                //HttpContext.Current.Response.End();
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