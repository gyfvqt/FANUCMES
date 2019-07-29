using DAL;
using GF2.MES.Report.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// ERPOrderSeach 的摘要说明
    /// </summary>
    public class ERPOrderSeach : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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

                string ERPOrderId = HttpContext.Current.Request.Params["erpOrderId"];
                string ERPOrderName = HttpContext.Current.Request.Params["erpOrderName"];
                string ProductionId = HttpContext.Current.Request.Params["productionId"];
                string ProductionName = HttpContext.Current.Request.Params["productionName"];
                string BeginTime = HttpContext.Current.Request.Params["bgintime"];
                string EndTime = HttpContext.Current.Request.Params["endtime"];

                string sqlwhere = "";

                if (ERPOrderId.Trim() != "")
                {
                    sqlwhere += " AND a.ERPOrderId like N'%" + ERPOrderId.Trim() + "%'";
                }
                if (ProductionName.Trim() != "")
                {
                    sqlwhere += " AND b.ProductionName like N'%" + ProductionName.Trim() + "%'";
                }

                if (ERPOrderName.Trim() != "")
                {
                    sqlwhere += " AND a.ERPOrderName like N'%" + ERPOrderName.Trim() + "%'";
                }
                if (ProductionId.Trim() != "")
                {
                    sqlwhere += " AND a.ProductionId like N'%" + ProductionId.Trim() + "%'";
                }
                if (BeginTime.Trim() != "")
                {
                    sqlwhere += " AND a.EndDate >= N'" + BeginTime.Trim() + "'";
                }
                if (EndTime.Trim() != "")
                {
                    sqlwhere += " AND a.EndDate <= N'" + EndTime.Trim() + "'";
                }

                string sqlCount = string.Format(@"select count(1) from  ERPOrder(nolock) a join ProductionInfo(nolock) b on a.ProductionId = b.ProductionId
                        where 1=1  {0}", sqlwhere);
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
FROM    ( SELECT TOP ( {0} * {1} )
                    ROW_NUMBER() OVER ( ORDER BY a.[ID] DESC ) AS rownum ,
                    a.[ID]
                  ,a.[ERPOrderId]
                  ,a.[ProductionId]      
                  ,a.[EndDate]
                  ,a.[ERPOrderName]
                  ,b.ProductionSheet as ProductionImg
                  ,a.[PlanCount]
                  ,a.[ERPStatus]
	              ,b.ProductionName
                  ,a.Createdate
              FROM ERPOrder(nolock) a join ProductionInfo(nolock) b on a.ProductionId = b.ProductionId
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