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
    /// FaultNoticeSearch 的摘要说明
    /// </summary>
    public class FaultNoticeSearch : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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

                string FaultName = HttpContext.Current.Request.Params["faultName"];
                string ExecuteStatus = HttpContext.Current.Request.Params["executeStatus"];
                
                string Creator = HttpContext.Current.Request.Params["creator"];
                string UserId = HttpContext.Current.Request.Params["userId"];
                string CallTimeB = HttpContext.Current.Request.Params["btime"];
                string CallTimeE = HttpContext.Current.Request.Params["etime"];
                string sqlwhere = "";

                if (FaultName.Trim() != "")
                {
                    sqlwhere += " AND a.FaultName like N'%" + FaultName.Trim() + "%'";
                }
                if (ExecuteStatus.Trim() != "")
                {
                    sqlwhere += " AND a.ExecuteStatus like N'%" + ExecuteStatus.Trim() + "%'";
                }
                if (Creator.Trim() != "")
                {
                    sqlwhere += " AND a.Creator like N'%" + Creator.Trim() + "%'";
                }
                if (UserId.Trim() != "")
                {
                    sqlwhere += " AND a.UserId like N'%" + UserId.Trim() + "%'";
                }
                
                if (CallTimeB.Trim() != "")
                {
                    sqlwhere += " AND a.CreateTime >= N'" + CallTimeB.Trim() + "'";
                }
                if (CallTimeE.Trim() != "")
                {
                    sqlwhere += " AND a.CreateTime <= N'" + CallTimeE.Trim() + "'";
                }


                string sqlCount = string.Format(@"select count(1) from FaultNotice(nolock) a 
                        left join UserInfo(nolock) b on a.Creator=b.ID 
                        left join UserInfo(nolock) c on a.UserId=c.ID 
                        where 1=1  {0}", sqlwhere);
                DataSet dscount = SQLHelper.GetDataSet(sqlCount);
                string sqlSearch = string.Format(@"SELECT  temp.* 
FROM    ( SELECT TOP ( {0} * {1} )
                    ROW_NUMBER() OVER ( ORDER BY a.[ID] DESC ) AS rownum ,
                    a.*,b.FirstName+b.LastName as CreateName,c.FirstName+c.LastName as Executor,a.ID as XID
                    from FaultNotice(nolock) a 
                    left join UserInfo(nolock) b on a.Creator=b.ID 
                    left join UserInfo(nolock) c on a.UserId=c.ID 
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