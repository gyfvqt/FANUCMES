using DAL;
using GF2.MES.Report.Helper;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// ProceessInfo 的摘要说明
    /// </summary>
    public class ProceessdefectInfo : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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

                //string ERPDetailCode = HttpContext.Current.Request.Params["erpDetailCode"];
                string ProductionCode = HttpContext.Current.Request.Params["productionCode"];
                string ProductionName = HttpContext.Current.Request.Params["productionName"];
                string EndProductSN = HttpContext.Current.Request.Params["endProductSN"];
                string PLCDataDesc = HttpContext.Current.Request.Params["pLCDataDesc"];
                string BeginTime = HttpContext.Current.Request.Params["bgintime"];
                string EndTime = HttpContext.Current.Request.Params["endtime"];
                string StationName = HttpContext.Current.Request.Params["stationName"];

                string sqlwhere = "";

                //if (ERPDetailCode.Trim() != "")
                //{
                //    sqlwhere += " AND a.ERPDetailCode like N'%" + ERPDetailCode.Trim() + "%'";
                //}
                if (ProductionName.Trim() != "")
                {
                    sqlwhere += " AND b.ProductionName like N'%" + ProductionName.Trim() + "%'";
                }

                if (ProductionCode.Trim() != "")
                {
                    sqlwhere += " AND b.ProductionCode like N'%" + ProductionCode.Trim() + "%'";
                }
                if (EndProductSN.Trim() != "")
                {
                    sqlwhere += " AND b.EndProductSN like N'%" + EndProductSN.Trim() + "%'";
                }
                if (PLCDataDesc.Trim() != "")
                {
                    sqlwhere += " AND a.PLCDataDesc like N'%" + PLCDataDesc.Trim() + "%'";
                }


                if (BeginTime.Trim() != "")
                {
                    sqlwhere += " AND b.EndTime >= N'" + BeginTime.Trim() + "'";
                }
                if (EndTime.Trim() != "")
                {
                    sqlwhere += " AND b.EndTime <= N'" + EndTime.Trim() + "'";
                }


                string sqlCount = string.Format(@"select count(1) from  ProductPLCTraceabilityInfo(nolock) a left join EndProduct(nolock) b on a.ProductId=b.ID 
                        where 1=1  {0}", sqlwhere);
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
FROM    ( SELECT TOP ( {0} * {1} )
                    ROW_NUMBER() OVER ( ORDER BY a.[ID]  ) AS rownum ,
                    a.StationName,a.PLCDataDesc,a.UpdateTime as UpdateTimeA,a.PLCDataResult,a.LastStatus,a.Updator,b.*
              FROM ProductPLCTraceabilityInfo(nolock) a left join EndProduct(nolock) b on a.ProductId=b.ID 
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