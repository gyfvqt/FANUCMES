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
    /// FaultUserInfoSearch 的摘要说明
    /// </summary>
    public class FaultUserInfoSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
                

                string sqlCount = @"SELECT count(DISTINCT EquipmentId) FROM [dbo].[FaultUserInfo]";
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
FROM    ( SELECT  TOP ( {0} * {1} ) ROW_NUMBER() OVER ( ORDER BY [EquipmentId] ) AS rownum ,
                     EquipmentId,EquipmentName,UserList
                    from (
                   select  distinct EquipmentId,EquipmentName,
STUFF((SELECT ';'+UserName FROM [dbo].[FaultUserInfo] WHERE EquipmentId = A.EquipmentId  FOR XML PATH('')),1,1,'')AS UserList  
FROM [dbo].[FaultUserInfo] AS A
) q
        ) AS temp
WHERE   temp.rownum > (  {0} * ( {1} - 1 ))      
ORDER BY temp.[EquipmentId]  ", pagesize, pageindex);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);

                string jsonText = "";
                JsonHelper jsonHelper = new JsonHelper();
                if (dsSearch != null && dsSearch.Tables[0].Rows.Count > 0)
                {
                    jsonText = jsonHelper.DataTableToJson(dsSearch.Tables[0], int.Parse(dscount.Tables[0].Rows[0][0].ToString()));
                }
                else
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("tips");
                    dt.AcceptChanges();
                    DataRow dr = dt.NewRow();
                    dr["tips"] = "没有数据";
                    dt.Rows.Add(dr);
                    dt.AcceptChanges();
                    jsonText = jsonHelper.DataTableToJson(dt, 0);
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