﻿using DAL;
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
    /// AMProcessSheetSearch 的摘要说明
    /// </summary>
    public class AMProcessSheetSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";


                string ID = HttpContext.Current.Request.Params["Id"];
                

                string sqlwhere = "";

                sqlwhere += " AND a.TicketId = N'" + ID.Trim() + "'";
                
                string sqlSearch = string.Format(@"select * from AMProcessSheet(nolock) a 
                where 1=1 {0}", sqlwhere);
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