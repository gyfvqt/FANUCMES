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
    /// getWMSByMid 的摘要说明
    /// </summary>
    public class getWMSByMid : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                

                string Mid = HttpContext.Current.Request.Params["mid"];
                
                string sqlwhere = " AND a.MaterialId = N'" + Mid.Trim() + "'";               
                string sqlCount = string.Format(@"select distinct b.ID,b.WarehouseName from  Material_W_S(nolock) a
                        join Warehouse(nolock) b on a.WarehouseId =b.ID      
                        
                        where 1=1  {0}", sqlwhere);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlCount);
                

                string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());
                HttpContext.Current.Response.Write(result);
                

            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("[]");
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