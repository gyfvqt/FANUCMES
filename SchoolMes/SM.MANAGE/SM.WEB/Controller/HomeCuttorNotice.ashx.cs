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
    /// HomeCuttorNotice 的摘要说明
    /// </summary>
    public class HomeCuttorNotice : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["userId"];
                
                string sqlSearch = string.Format(@"select top 6 a.Message,CONVERT(varchar(100), a.UpdateTime, 23) UpdateTime,a.StationId,a.status,c.UserId as UserId  from Notices(nolock) a 
  join CuttorAlarmConfigurationStation(nolock) b on a.StationId=b.StationId
  join CuttorAlarmConfigurationUser(nolock) c on b.TipId=c.TipId  
  where 1=1 and c.UserId=N'{0}'  order by a.ID desc", ID);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);

                string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());
                HttpContext.Current.Response.Write(result);

                HttpContext.Current.Response.End();

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