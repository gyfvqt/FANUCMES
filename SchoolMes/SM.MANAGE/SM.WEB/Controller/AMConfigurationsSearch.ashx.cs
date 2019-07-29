using DAL;
using GF2.MES.Report.Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
namespace SM.WEB.Controller
{
    /// <summary>
    /// AMConfigurationsSearch 的摘要说明
    /// </summary>
    public class AMConfigurationsSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                string ID = HttpContext.Current.Request.Params["Id"];
                
                string sqlwhere = " AND TicketId = N'" + ID.Trim() + "'";
                
                string sqlSearch = string.Format(@"select [ID]
                                      ,[TicketId]
                                      ,[PeriodType]
                                      ,[Xweek]
                                      ,[WeekDate]
                                      ,[Month]
                                      ,[Day]
                                      ,CONVERT(varchar(10), BeginDate) as BeginDate
                                      ,CONVERT(varchar(10), EndDate) as EndDate from AMConfiguration(nolock) where 1=1 {0}", sqlwhere);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);

                //string jsonText = "";
                //JsonHelper jsonHelper = new JsonHelper();

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