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
    /// WorkCalendarSearch 的摘要说明
    /// </summary>
    public class WorkCalendarSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                string YM = HttpContext.Current.Request.Params["ym"];
                //string ERPOrderName = HttpContext.Current.Request.Params["erpOrderName"];
                //string ProductionId = HttpContext.Current.Request.Params["productionId"];
                //string ProductionName = HttpContext.Current.Request.Params["productionName"];
                //string BeginTime = HttpContext.Current.Request.Params["bgintime"];
                //string EndTime = HttpContext.Current.Request.Params["endtime"];

                string sqlwhere = "";

                
                sqlwhere += " AND WorkDate like N'%" + YM.Trim() + "%'";
                
                string sqlSearch = string.Format(@"select CONVERT(varchar(100), WorkDate, 23) as WorkDate from WorkCalendar(nolock) where 1=1 {0}", sqlwhere);
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