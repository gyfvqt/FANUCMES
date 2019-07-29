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
    /// CallListSearch 的摘要说明
    /// </summary>
    public class CallListSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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

                string MaterialCallCode = HttpContext.Current.Request.Params["materialCallCode"];
                string MaterialDataNo = HttpContext.Current.Request.Params["materialDataNo"];
                string MaterialDataName = HttpContext.Current.Request.Params["materialDataName"];
                string DeliverWay = HttpContext.Current.Request.Params["deliverWay"];
                string StoreName = HttpContext.Current.Request.Params["storeName"];
                string CallTimeB = HttpContext.Current.Request.Params["btime"];
                string CallTimeE = HttpContext.Current.Request.Params["etime"];
                string sqlwhere = "";

                if (MaterialCallCode.Trim() != "")
                {
                    sqlwhere += " AND a.ID like N'%" + MaterialCallCode.Trim() + "%'";
                }
                if (MaterialDataNo.Trim() != "")
                {
                    sqlwhere += " AND b.MaterialDataNo like N'%" + MaterialDataNo.Trim() + "%'";
                }
                if (MaterialDataName.Trim() != "")
                {
                    sqlwhere += " AND b.MaterialDataName like N'%" + MaterialDataName.Trim() + "%'";
                }
                if (DeliverWay.Trim() != "")
                {
                    sqlwhere += " AND a.DeliverWay like N'%" + DeliverWay.Trim() + "%'";
                }
                if (StoreName.Trim() != "")
                {
                    sqlwhere += " AND c.StoreName like N'%" + StoreName.Trim() + "%'";
                }
                if (CallTimeB.Trim() != "")
                {
                    sqlwhere += " AND d.CallTime >= N'" + CallTimeB.Trim() + "'";
                }
                if (CallTimeE.Trim() != "")
                {
                    sqlwhere += " AND d.CallTime <= N'" + CallTimeE.Trim() + "'";
                }


                string sqlCount = string.Format(@"select count(1) from CallList(nolock) d join MaterialCallPoint(nolock) a  on d.MaterialCallPointId=a.ID
                        left join MaterialData(nolock) b on a.MaterialId=b.ID 
                        left join Store(nolock) c on a.StoreId=c.ID 
                        where 1=1  {0}", sqlwhere);
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
FROM    ( SELECT TOP ( {0} * {1} )
                    ROW_NUMBER() OVER ( ORDER BY d.[CallTime] DESC ) AS rownum ,
                    a.*,b.MaterialDataNo,b.MaterialDataName,b.BoxType,b.BoxTotalNo,b.Supplier,c.StoreName,d.CallCode,d.CallStatus,d.CallTime,d.CallCount,d.ID as CallId
            from CallList(nolock) d join MaterialCallPoint(nolock) a  on d.MaterialCallPointId=a.ID
            left join MaterialData(nolock) b on a.MaterialId=b.ID 
            left join Store(nolock) c on a.StoreId=c.ID
where 1=1  {2}  
        ) AS temp
WHERE   temp.rownum > (  {0} * ( {1} - 1 ))     
ORDER BY temp.[CallTime] DESC", pagesize, pageindex, sqlwhere);
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