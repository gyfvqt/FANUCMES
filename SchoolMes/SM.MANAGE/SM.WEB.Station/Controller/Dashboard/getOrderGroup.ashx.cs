using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Station.Controller.Dashboard
{
    /// <summary>
    /// getOrderGroup 的摘要说明
    /// </summary>
    public class getOrderGroup : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string LineId = HttpContext.Current.Request.Params["lineId"];
                string sql = string.Format(@"select 
                              max(isnull(case when f.Status=1 then xcount end,0)) f1,
                              max(isnull(case when f.Status=2 then xcount end,0)) f2,
                              max(isnull(case when f.Status=3 then xcount end,0)) f3,
                              max(isnull(case when f.Status=4 then xcount end,0)) f4,
                              max(isnull(case when f.Status=5 then xcount end,0)) f5 
                              from 
                              (select Status,count(1) xcount from ERPOrderDetails(nolock) where LineId=N'{0}'
                              group by Status) f",LineId);
                DataSet ds = SQLHelper.GetDataSet(sql);               

                string result = JsonConvert.SerializeObject(ds.Tables[0], new DataTableConverter());
                HttpContext.Current.Response.Write(result);
            }
            catch (Exception ex)
            {
                //HttpContext.Current.Response.Write("-1");
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