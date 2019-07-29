using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Station.Controller
{
    /// <summary>
    /// GetJPHActure 的摘要说明
    /// </summary>
    public class GetJPHActure : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ActureReturn = HttpContext.Current.Request.Params["actureReturn"];
                Double totalSpandTime = 0;
                Double totalshifttime = 0;

                string sqlSearch = @"select * from WorkShift(nolock)";
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);
                DateTime dt = DateTime.Now;
                DateTime dtbegin, dtend;
                dtbegin = dtend = dt;
                DateTime dtbeginx, dtendx;
                dtbeginx = dtendx = dt;
                string result = "0";
                if (dsSearch != null && dsSearch.Tables[0].Rows.Count > 0)
                {

                    //获取当前班次的开始时间和结束时间
                    for (int i = 0; i < dsSearch.Tables[0].Rows.Count; i++)
                    {
                        dtbegin = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["BeginTime"].ToString().Trim());
                        dtend = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["EndTime"].ToString().Trim());
                        if (dtbegin <= dt && dt >= dtend)
                        {
                            dtbeginx = dtbegin;
                            dtendx = dtend;
                        }
                    }
                    totalSpandTime = (dt - dtbeginx).TotalMinutes;
                    totalshifttime = (dtendx - dtbeginx).TotalMinutes;
                    //获取班次小休
                    DataSet dsrest = SQLHelper.GetDataSet("select * from Rest(nolock)");
                    Double spandrest = 0;
                    if (dsrest != null && dsrest.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < dsrest.Tables[0].Rows.Count; i++)
                        {
                            dtbegin = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["BeginTime"].ToString().Trim());
                            dtend = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["EndTime"].ToString().Trim());
                            if (dt >= dtend)
                            {
                                spandrest = (dtend - dtbegin).TotalMinutes;
                            }
                            else if (dt > dtbegin && dt <= dtend)
                            {
                                spandrest = (dt - dtbegin).TotalMinutes;
                            }
                            totalSpandTime -= spandrest;
                            totalshifttime -= spandrest;
                        }
                    }

                    var a = int.Parse(ActureReturn) / totalshifttime;
                    result = int.Parse(a.ToString()).ToString();
                }

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