﻿using DAL;
using GF2.MES.Report.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
namespace SM.WEB.Controller
{
    /// <summary>
    /// StationSearch 的摘要说明
    /// </summary>
    public class StationSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string pageindex = HttpContext.Current.Request.Params["pageindex"];
                if (string.IsNullOrEmpty(pageindex))
                {
                    HttpContext.Current.Response.Write("pageindex error");
                    return;
                }
                string pagesize = HttpContext.Current.Request.Params["pagesize"];
                if (string.IsNullOrEmpty(pagesize))
                {
                    HttpContext.Current.Response.Write("pagesize error");
                    return;
                }

                string StationCode = HttpContext.Current.Request.Params["stationCode"];
                string StationName = HttpContext.Current.Request.Params["stationName"];
                string StationDesc = HttpContext.Current.Request.Params["stationDesc"];
                string StationType = HttpContext.Current.Request.Params["stationType"];
                string sqlwhere = "";

                if (StationCode.Trim() != "")
                {
                    sqlwhere += " AND a.StationCode like N'%" + StationCode.Trim() + "%'";
                }
                if (StationName.Trim() != "")
                {
                    sqlwhere += " AND a.StationName like N'%" + StationName.Trim() + "%'";
                }

                if (StationDesc.Trim() != "")
                {
                    sqlwhere += " AND b.StationDesc like N'%" + StationDesc.Trim() + "%'";
                }
                if (StationType.Trim() != "")
                {
                    sqlwhere += " AND b.StationType like N'%" + StationType.Trim() + "%'";
                }

                string sqlCount = string.Format(@"select count(1) from  [StationInfo](nolock)  a  
                        where 1=1  {0}", sqlwhere);
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
FROM    ( SELECT TOP ( {0} * {1} )
                    ROW_NUMBER() OVER ( ORDER BY a.[ID] DESC ) AS rownum ,
                    a.*
            FROM  StationInfo(nolock)  a  
where 1=1  {2}  
        ) AS temp
WHERE   temp.rownum > (  {0} * ( {1} - 1 ))     
ORDER BY temp.[ID] DESC", pagesize, pageindex, sqlwhere);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);

                string jsonText = "";
                JsonHelper jsonHelper = new JsonHelper();
                if (dsSearch != null && dsSearch.Tables[0].Rows.Count > 0)
                {
                    jsonText = jsonHelper.DataTableToJson(dsSearch.Tables[0], int.Parse(dscount.Tables[0].Rows[0][0].ToString()));
                }
                else
                {
                    
                    jsonText = "[]";
                }
                HttpContext.Current.Response.Write(jsonText);

            }
            catch (Exception ex)
            {
                JsonHelper jsonHelper = new JsonHelper();
                DataTable dt = new DataTable();
                dt.Columns.Add("tips");
                dt.AcceptChanges();
                DataRow dr = dt.NewRow();
                dr["tips"] = "没有数据";
                dt.Rows.Add(dr);
                dt.AcceptChanges();
                string jsonText = jsonHelper.DataTableToJson(dt, 0);
                HttpContext.Current.Response.Write(jsonText);

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