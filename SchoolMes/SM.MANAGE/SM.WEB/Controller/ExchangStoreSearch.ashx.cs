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
    /// ExchangStoreSearch 的摘要说明
    /// </summary>
    public class ExchangStoreSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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

                string MaterialDataNo = HttpContext.Current.Request.Params["materialDataNo"];
                string MaterialDataName = HttpContext.Current.Request.Params["materialDataName"];
                string StoreName = HttpContext.Current.Request.Params["storeName"];
                string TicketNumber = HttpContext.Current.Request.Params["ticketNumber"];
                string ExchangeType = HttpContext.Current.Request.Params["exchangeType"];
                string InStoreName = HttpContext.Current.Request.Params["inStoreName"];
                string CuserId = HttpContext.Current.Request.Params["cuserId"];
                string UuserId = HttpContext.Current.Request.Params["uuserId"];
                string CreateTimeB = HttpContext.Current.Request.Params["createTimeB"];
                string CreateTimeE = HttpContext.Current.Request.Params["createTimeE"];
                string UpdateTimeB = HttpContext.Current.Request.Params["updateTimeB"];
                string UpdateTimeE = HttpContext.Current.Request.Params["updateTimeE"];
                string ExStatus = HttpContext.Current.Request.Params["status"];
                string sqlwhere = "";

                if (MaterialDataNo.Trim() != "")
                {
                    sqlwhere += " AND a.MaterialDataNo like N'%" + MaterialDataNo.Trim() + "%'";
                }
                if (StoreName.Trim() != "")
                {
                    sqlwhere += " AND a.MaterialDataName like N'%" + MaterialDataName.Trim() + "%'";
                }
                if (StoreName.Trim() != "")
                {
                    sqlwhere += " AND b.StoreName like N'%" + StoreName.Trim() + "%'";
                }
                if (TicketNumber.Trim() != "")
                {
                    sqlwhere += " AND a.TicketNumber like N'%" + TicketNumber.Trim() + "%'";
                }
                if (ExchangeType.Trim() != "")
                {
                    sqlwhere += " AND a.ExchangeType like N'%" + ExchangeType.Trim() + "%'";
                }
                if (ExStatus.Trim() != "")
                {
                    sqlwhere += " AND a.ExStatus like N'%" + ExStatus.Trim() + "%'";
                }
                if (InStoreName.Trim() != "")
                {
                    sqlwhere += " AND c.StoreName like N'%" + InStoreName.Trim() + "%'";
                }
                if (CuserId.Trim() != "")
                {
                    sqlwhere += " AND a.CuserId like N'%" + CuserId.Trim() + "%'";
                }
                if (UuserId.Trim() != "")
                {
                    sqlwhere += " AND a.UuserId like N'%" + UuserId.Trim() + "%'";
                }
                if (CreateTimeB.Trim() != "")
                {
                    sqlwhere += " AND a.CreateTime>= N'" + CreateTimeB.Trim() + "'";
                }
                if (CreateTimeE.Trim() != "")
                {
                    sqlwhere += " AND a.CreateTime<= N'" + CreateTimeE.Trim() + "'";
                }
                if (UpdateTimeB.Trim() != "")
                {
                    sqlwhere += " AND a.UpdateTime>= N'" + UpdateTimeB.Trim() + "'";
                }
                if (UpdateTimeE.Trim() != "")
                {
                    sqlwhere += " AND a.UpdateTime<= N'" + UpdateTimeE.Trim() + "'";
                }

                string sqlCount = string.Format(@"select count(1) from ExchangStore(nolock) a  left join Store(nolock) b on a.StoreId=b.ID left join Store(nolock) c on a.InStoreId=c.ID 
                        where 1=1  {0}", sqlwhere);
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
FROM    ( SELECT TOP ( {0} * {1} )
                    ROW_NUMBER() OVER ( ORDER BY a.[ID] DESC ) AS rownum ,
                    a.*,b.StoreName,c.StoreName as InStoreName
            from ExchangStore(nolock) a  left join Store(nolock) b on a.StoreId=b.ID left join Store(nolock) c on a.InStoreId=c.ID 
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