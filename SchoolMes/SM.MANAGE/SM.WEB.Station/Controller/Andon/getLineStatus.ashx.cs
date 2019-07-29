using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Station.Controller.Andon
{
    /// <summary>
    /// getLineStatus 的摘要说明
    /// </summary>
    public class getLineStatus : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string LineId = HttpContext.Current.Request.Params["lineid"];
                string sqlSearch = string.Format(@"select top 1 a.* from FaultInfo(nolock) a
                      JOIN EquipmentData(nolock) b on a.parentid=b.ID
                      where EndTime is null  and LineOrSatation=3 and b.ParentId=N'{0}'
                      order by FaultType ", LineId);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);

                string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());

                HttpContext.Current.Response.Write(result);

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