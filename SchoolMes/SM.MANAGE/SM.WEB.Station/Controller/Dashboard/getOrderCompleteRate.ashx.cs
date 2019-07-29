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
    /// getOrderCompleteRate 的摘要说明
    /// </summary>
    public class getOrderCompleteRate : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string LineId = HttpContext.Current.Request.Params["lineId"];
                string sql = string.Format(@"select count(case when Status=5 then 1 end) as ccount,count(case when Status<>5 then 1 end) as total from ERPOrderDetails(nolock) where LineId=N'{0}'",LineId);
                DataSet ds = SQLHelper.GetDataSet(sql);
                var rate = "0";
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    rate = (double.Parse(ds.Tables[0].Rows[0]["ccount"].ToString()) * 100 / double.Parse(ds.Tables[0].Rows[0]["total"].ToString())).ToString("f0");
                }

                string result = JsonConvert.SerializeObject(ds.Tables[0], new DataTableConverter());
                HttpContext.Current.Response.Write(rate);
            }
            catch (Exception es)
            {
                HttpContext.Current.Response.Write("-1");
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