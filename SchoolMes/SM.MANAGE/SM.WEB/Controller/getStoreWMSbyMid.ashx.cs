using DAL;
using GF2.MES.Report.Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// getStoreWMSbyMid 的摘要说明
    /// </summary>
    public class getStoreWMSbyMid : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                string Mid = HttpContext.Current.Request.Params["mid"];
                //string Wid = HttpContext.Current.Request.Params["wid"];

                string sqlwhere = " AND a.MaterialId = N'" + Mid.Trim() + "'";
                string sqlCount = string.Format(@"select distinct c.ID,c.StoreName from  Material_W_S(nolock) a                         
                        join Store(nolock) c on a.StoreId=c.ID
                        where 1=1  {0}", sqlwhere);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlCount);


                string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());
                HttpContext.Current.Response.Write(result);


            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("[]");
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