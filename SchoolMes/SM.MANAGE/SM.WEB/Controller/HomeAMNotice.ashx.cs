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
    /// HomeAMNotice 的摘要说明
    /// </summary>
    public class HomeAMNotice : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["userId"];

                var o = SQLHelper.GetObject("select top 1 Xdate from AMCommentAlarm(nolock)");
                int di = 5;
                if (o != null)
                {
                    di=  int.Parse(o.ToString());
                }
                
                var d = DateTime.Now;
                string begindate = d.ToString("yyyy-MM-dd");
                string enddate=d.AddDays(di).ToString("yyyy-MM-dd");

                string sqlSearch = string.Format(@"select distinct  top 6 a.*,CONVERT(varchar(100), b.ExecuteDate, 23) ExecuteDate from AMTicket(nolock) a join  AMTicketSplit(nolock) b on a.ID=b.TicketId
                                  where b.ExecuteDate between '{0}' and '{1}' 
                                  order by ID desc", begindate,enddate);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);

                string result = JsonConvert.SerializeObject(dsSearch.Tables[0], new DataTableConverter());
                HttpContext.Current.Response.Write(result);

                //HttpContext.Current.Response.End();

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