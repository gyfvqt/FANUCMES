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
    /// PLCAPInfoSearch 的摘要说明
    /// </summary>
    public class PLCAPInfoSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                string ID = HttpContext.Current.Request.Params["Id"];
                //string ERPOrderName = HttpContext.Current.Request.Params["erpOrderName"];
                //string ProductionId = HttpContext.Current.Request.Params["productionId"];
                //string ProductionName = HttpContext.Current.Request.Params["productionName"];
                //string BeginTime = HttpContext.Current.Request.Params["bgintime"];
                //string EndTime = HttpContext.Current.Request.Params["endtime"];

                string sqlwhere = "";

                if (ID.Trim() != "")
                {
                    sqlwhere += " AND PLCStationId = N'" + ID.Trim() + "'";
                }
                string sqlSearch = string.Format(@"select * from PLCAPInfo(nolock) where 1=1 {0}", sqlwhere);
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