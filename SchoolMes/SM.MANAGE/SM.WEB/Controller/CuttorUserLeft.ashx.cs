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
    /// CuttorUserLeft 的摘要说明
    /// </summary>
    public class CuttorUserLeft : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string EquipmentId = HttpContext.Current.Request.Params["eid"];
                string sqlSearch = string.Format(@"select ID AS UserId,[LastName]+[FirstName] AS UserName from UserInfo where ID not in(select UserId from CuttorAlarmConfigurationUser(nolock) where TipId=N'{0}' )", EquipmentId);
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