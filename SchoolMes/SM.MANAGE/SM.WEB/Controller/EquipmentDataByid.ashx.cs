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
    /// EquipmentDataByid 的摘要说明
    /// </summary>
    public class EquipmentDataByid : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";

                string ID = HttpContext.Current.Request.Params["Id"];
                

                string sqlwhere = "";

                if (ID.Trim() != "")
                {
                    sqlwhere += " AND ID = N'" + ID.Trim() + "'";
                }
                string sqlSearch = string.Format(@"select * from EquipmentData(nolock) where 1=1 {0}", sqlwhere);
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