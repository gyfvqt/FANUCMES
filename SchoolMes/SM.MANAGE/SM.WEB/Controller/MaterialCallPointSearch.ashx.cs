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
    /// MaterialCallPointSearch 的摘要说明
    /// </summary>
    public class MaterialCallPointSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
                string StationId = HttpContext.Current.Request.Params["stationId"];

                string sqlwhere = "";

                if (MaterialCallCode.Trim() != "")
                {
                    sqlwhere += " AND a.MaterialCallCode like N'%" + MaterialCallCode.Trim() + "%'";
                }
                if (MaterialDataNo.Trim() != "")
                {
                    sqlwhere += " AND b.MaterialDataNo like N'%" + MaterialDataNo.Trim() + "%'";
                }
                if (MaterialDataName.Trim() != "")
                {
                    sqlwhere += " AND b.MaterialDataName like N'%" + MaterialDataName.Trim() + "%'";
                }
                if (StationId.Trim() != "")
                {
                    sqlwhere += " AND a.StationId like N'%" + StationId.Trim() + "%'";
                }


                string sqlCount = string.Format(@"select count(1) from MaterialCallPoint(nolock) a  left join MaterialData(nolock) b on a.MaterialId=b.ID 
                        where 1=1  {0}", sqlwhere);
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
FROM    ( SELECT TOP ( {0} * {1} )
                    ROW_NUMBER() OVER ( ORDER BY a.[ID] DESC ) AS rownum ,
                    a.*,b.MaterialDataNo,b.MaterialDataName,b.BoxType,b.BoxTotalNo,b.Supplier,c.StoreName
            from MaterialCallPoint(nolock) a  left join MaterialData(nolock) b on a.MaterialId=b.ID left join Store(nolock) c on a.StoreId=c.ID
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