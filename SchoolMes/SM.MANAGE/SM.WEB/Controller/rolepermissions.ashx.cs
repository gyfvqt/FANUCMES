using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GF2.MES.Report.Helper;
using DAL;
using System.Data;

namespace SM.WEB.Controller
{
    /// <summary>
    /// rolepermissions 的摘要说明
    /// </summary>
    public class rolepermissions : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                

                string sqlwhere = "";
                if (ID.Trim() != "")
                {
                    sqlwhere += "  AND b.RoleId="+ID.Trim();
                }
                
                string sqlSearch = string.Format(@"SELECT a.ID,a.MenuName,a.MenuDesc,a.ParentId,isnull(d.MenuName,'') as ParentName,ISNULL(b.MenuId,0) permission from dbo.Menus a 
join dbo.[Permissions] b on a.ID=b.MenuId
join dbo.UserRole c on b.RoleId=c.ID
join dbo.Menus d on d.ID=a.ParentId
where 1=1  {0} ",  sqlwhere);
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);

                string jsonText = "";
                JsonHelper jsonHelper = new JsonHelper();
                if (dsSearch != null && dsSearch.Tables[0].Rows.Count > 0)
                {
                    jsonText = jsonHelper.DataTableToJson(dsSearch.Tables[0], 0);
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

                //HttpContext.Current.Response.End();
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