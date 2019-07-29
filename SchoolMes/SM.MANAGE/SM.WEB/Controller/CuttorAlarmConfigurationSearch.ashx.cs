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
    /// CuttorAlarmConfigurationSearch 的摘要说明
    /// </summary>
    public class CuttorAlarmConfigurationSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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


                string sqlCount = @"SELECT count(DISTINCT SNO) FROM [dbo].[CuttorAlarmConfiguration](nolock)";
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
FROM    ( SELECT  TOP ( {0} * {1} ) ROW_NUMBER() OVER ( ORDER BY [SNO] ) AS rownum ,
                    f.* from (select u.ID, u.SNO,u.UserList,s.StationList
                    from (select ID,SNO,UserList
                    from (
                   select  distinct ID, SNO,
STUFF((SELECT ';'+UserName FROM [dbo].[CuttorAlarmConfigurationUser](nolock) WHERE TipId = A.ID  FOR XML PATH('')),1,1,'')AS UserList  
FROM [dbo].[CuttorAlarmConfiguration](nolock) AS A
) q) u
 
left join  (
select SNO,StationList
                    from (
                   select  distinct SNO,STUFF((SELECT ';'+StationCode FROM [dbo].[CuttorAlarmConfigurationStation](nolock) WHERE TipId = A.ID  FOR XML PATH('')),1,1,'')AS StationList  
FROM [dbo].[CuttorAlarmConfiguration](nolock) AS A
) x) s on u.SNO=s.SNO
        ) f ) AS temp
WHERE   temp.rownum > (  {0} * ( {1} - 1 ))      
ORDER BY temp.[SNO]  ", pagesize, pageindex);
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