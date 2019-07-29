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
    /// ERPOrderDetailList 的摘要说明
    /// </summary>
    public class ERPOrderDetailList : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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

                string ERPDetailCode = HttpContext.Current.Request.Params["erpDetailCode"];
                string ProductionCode = HttpContext.Current.Request.Params["productionCode"];                
                string ProductionName = HttpContext.Current.Request.Params["productionName"];
                string Status = HttpContext.Current.Request.Params["status"];
                string BeginTime = HttpContext.Current.Request.Params["bgintime"];
                string EndTime = HttpContext.Current.Request.Params["endtime"];
                string CreateTime = HttpContext.Current.Request.Params["createTime"];

                string sqlwhere = "";

                if (ERPDetailCode.Trim() != "")
                {
                    sqlwhere += " AND a.ERPDetailCode like N'%" + ERPDetailCode.Trim() + "%'";
                }
                if (ProductionName.Trim() != "")
                {
                    sqlwhere += " AND a.ProductionName like N'%" + ProductionName.Trim() + "%'";
                }

                if (ProductionCode.Trim() != "")
                {
                    sqlwhere += " AND a.ProductionCode like N'%" + ProductionCode.Trim() + "%'";
                }
                if (Status.Trim() != "")
                {
                    sqlwhere += " AND a.Status like N'%" + Status.Trim() + "%'";
                }
                if (BeginTime.Trim() != "")
                {
                    sqlwhere += " AND a.EndDate >= N'" + BeginTime.Trim() + "'";
                }
                if (EndTime.Trim() != "")
                {
                    sqlwhere += " AND a.EndDate <= N'" + EndTime.Trim() + "'";
                }

                if (CreateTime.Trim() != "")
                {
                    sqlwhere += " AND CONVERT(varchar(100), a.CreateTime, 23) = N'" + CreateTime.Trim() + "'";
                }

                string sqlCount = string.Format(@"select count(1) from  ERPOrderDetails(nolock) a join LineInfo b on a.LineId=b.ID
                        where 1=1  {0}", sqlwhere);
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
FROM    ( SELECT TOP ( {0} * {1} )
                    ROW_NUMBER() OVER ( ORDER BY a.[ID]  ) AS rownum ,
                    a.*,b.LineName
              FROM ERPOrderDetails(nolock) a   join LineInfo b on a.LineId=b.ID
where 1=1  {2}  
        ) AS temp
WHERE   temp.rownum > (  {0} * ( {1} - 1 ))     
ORDER BY temp.[ID] ", pagesize, pageindex, sqlwhere);
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