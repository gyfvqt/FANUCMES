using DAL;
using GF2.MES.Report.Helper;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// WMSSearch 的摘要说明
    /// </summary>
    public class WMSSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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

                string WarehouseId = HttpContext.Current.Request.Params["warehouseId"];
                string StoreId = HttpContext.Current.Request.Params["storeId"];
                string WarehouseType = HttpContext.Current.Request.Params["warehouseType"];
                string MaterialDataNo = HttpContext.Current.Request.Params["materialDataNo"];
                string MaterialDataName = HttpContext.Current.Request.Params["materialDataName"];
                string sqlwhere = "";

                if (WarehouseId.Trim() != "")
                {
                    sqlwhere += " AND a.WarehouseId = N'" + WarehouseId.Trim() + "'";
                }
                if (StoreId.Trim() != "")
                {
                    sqlwhere += " AND a.StoreId like N'" + StoreId.Trim() + "'";
                }

                if (WarehouseType.Trim() != "")
                {
                    sqlwhere += " AND b.WarehouseType like N'%" + WarehouseType.Trim() + "%'";
                }
                if (MaterialDataNo.Trim() != "")
                {
                    sqlwhere += " AND d.MaterialDataNo like N'%" + MaterialDataNo.Trim() + "%'";
                }
                if (MaterialDataName.Trim() != "")
                {
                    sqlwhere += " AND d.MaterialDataName like N'%" + MaterialDataName.Trim() + "%'";
                }

                string sqlCount = string.Format(@"select count(1) from  Material_W_S(nolock) a
                        join Warehouse(nolock) b on a.WarehouseId =b.ID
                        join Store(nolock) c on a.StoreId=c.ID
                        join MaterialData(nolock) d on d.ID=a.MaterialId
                        where 1=1  {0}", sqlwhere);
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
                        FROM    ( SELECT TOP ( {0} * {1} )
                                            ROW_NUMBER() OVER ( ORDER BY a.[ID] DESC ) AS rownum ,
                                            a.*,b.WarehouseName,b.WarehouseType,c.StoreName,c.StoreNo,d.MaterialDataName,d.MaterialDataNo 
                        from Material_W_S(nolock) a
                        join Warehouse(nolock) b on a.WarehouseId =b.ID
                        join Store(nolock) c on a.StoreId=c.ID
                        join MaterialData(nolock) d on d.ID=a.MaterialId 
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