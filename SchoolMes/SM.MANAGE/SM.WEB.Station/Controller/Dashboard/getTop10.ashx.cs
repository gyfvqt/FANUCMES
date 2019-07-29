using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Station.Controller.Dashboard
{
    /// <summary>
    /// getTop10 的摘要说明
    /// </summary>
    public class getTop10 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string EId = HttpContext.Current.Request.Params["eid"];

            double totalSpandTime = 0;
            double totalshifttime = 0;

            string sqlSearch = @"select * from WorkShift(nolock)";
            DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);
            DateTime dt = DateTime.Now;
            DateTime dtbegin, dtend;
            dtbegin = dtend = dt;
            DateTime dtbeginx, dtendx;
            dtbeginx = dtendx = dt;
            
            if (dsSearch != null && dsSearch.Tables[0].Rows.Count > 0)
            {

                //获取当前班次的开始时间和结束时间
                for (int i = 0; i < dsSearch.Tables[0].Rows.Count; i++)
                {
                    dtbegin = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["BeginTime"].ToString().Trim());
                    dtend = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["EndTime"].ToString().Trim());
                    if (dtbegin >= dtend) dtend = dtend.AddDays(1);//跨天结束时间加1天
                    if (dtbegin <= dt && dt <= dtend)
                    {
                        dtbeginx = dtbegin;
                        dtendx = dtend;
                    }
                }
                totalSpandTime = (dt - dtbeginx).TotalMinutes;
                totalshifttime = (dtendx - dtbeginx).TotalMinutes;
                //获取班次小休
                DataSet dsrest = SQLHelper.GetDataSet("select * from Rest(nolock)");
                double spandrest = 0;
                if (dsrest != null && dsrest.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < dsrest.Tables[0].Rows.Count; i++)
                    {
                        dtbegin = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["BeginTime"].ToString().Trim());
                        dtend = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["EndTime"].ToString().Trim());
                        if (dtbegin >= dtend) dtend = dtend.AddDays(1);//跨天结束时间加1天
                        if (dt >= dtend)
                        {
                            spandrest = (dtend - dtbegin).TotalMinutes;
                        }
                        else if (dt > dtbegin && dt <= dtend)
                        {
                            spandrest = (dt - dtbegin).TotalMinutes;
                        }
                        totalSpandTime -= spandrest;
                        totalshifttime -= spandrest;
                    }
                }
            }
            string sqle = "select * from EquipmentData(nolock)";
            DataSet ds = SQLHelper.GetDataSet(sqle);
            List<EquipmentData> rootNode = new List<EquipmentData>();
            string lieid = EId;
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                DataRow[] dr = ds.Tables[0].Select("ParentId=" + EId);
                for (int i = 0; i < dr.Length; i++)
                {
                    EquipmentData node = new EquipmentData();
                    lieid += "," + dr[i]["ID"].ToString();
                    node.id = dr[i]["ID"].ToString();
                    node.ParentId = dr[i]["ParentId"].ToString();
                    node.EquipmentCode = dr[i]["EquipmentCode"].ToString();
                    node.text = dr[i]["EquipmentName"].ToString();
                    node.EquipmentDesc = dr[i]["EquipmentDesc"].ToString();
                    node.Team = dr[i]["Team"].ToString();
                    node.EquipmentImg = dr[i]["EquipmentImg"].ToString();
                    node.PLCIP = dr[i]["PLCIP"].ToString();
                    node.PLCDB = dr[i]["PLCDB"].ToString();
                    node.IsPayPoint = dr[i]["IsPayPoint"].ToString();
                    node.DesignCycletime = dr[i]["DesignCycletime"].ToString();
                    node.DesignJPH = dr[i]["DesignJPH"].ToString();
                    node.EquipmentSupplier = dr[i]["EquipmentSupplier"].ToString();
                    node.Counter = dr[i]["Counter"].ToString();
                    node.children = GetChild(ds, node,ref lieid);
                    rootNode.Add(node);
                }

            }
            string sqlwhere = "";
            //测试时候注释
            //sqlwhere += " AND EquipmentId in (" + lieid.Trim() + ")";
            
            //sqlwhere += " AND FaultBeginTime>=N'" + dtbeginx.ToString("yyyy-MM-dd HH:mm:ss") + "'";
            //sqlwhere += " AND FaultBeginTime<=N'" + dtbeginx.ToString("yyyy-MM-dd HH:mm:ss") + "'";
            
            string sql = string.Format(@" select top 10 equipmentid,faultid,faultdesc, count(1) as xcount from EquipmentFault(nolock) where 1=1 {0}
                            group by equipmentid,faultid,faultdesc 
                            order by xcount desc", sqlwhere);
            DataSet dsr = SQLHelper.GetDataSet(sql);

            string result = JsonConvert.SerializeObject(dsr.Tables[0], new DataTableConverter());
            HttpContext.Current.Response.Write(result);

        }
        public List<EquipmentData> GetChild(DataSet ds, EquipmentData pnode,ref string lieid)
        {
            try
            {
                List<EquipmentData> Nodes = new List<EquipmentData>();
                DataRow[] dr = ds.Tables[0].Select("ParentId=" + pnode.id);
                for (int i = 0; i < dr.Length; i++)
                {
                    EquipmentData node = new EquipmentData();
                    node.id = dr[i]["ID"].ToString();
                    lieid += ","+ dr[i]["ID"].ToString();
                    node.ParentId = dr[i]["ParentId"].ToString();
                    node.EquipmentCode = dr[i]["EquipmentCode"].ToString();
                    node.text = dr[i]["EquipmentName"].ToString();
                    node.EquipmentDesc = dr[i]["EquipmentDesc"].ToString();
                    node.Team = dr[i]["Team"].ToString();
                    node.EquipmentImg = dr[i]["EquipmentImg"].ToString();
                    node.PLCIP = dr[i]["PLCIP"].ToString();
                    node.PLCDB = dr[i]["PLCDB"].ToString();
                    node.IsPayPoint = dr[i]["IsPayPoint"].ToString();
                    node.DesignCycletime = dr[i]["DesignCycletime"].ToString();
                    node.DesignJPH = dr[i]["DesignJPH"].ToString();
                    node.EquipmentSupplier = dr[i]["EquipmentSupplier"].ToString();
                    node.Counter = dr[i]["Counter"].ToString();
                    node.children = GetChild(ds, node,ref lieid);
                    Nodes.Add(node);
                }
                return Nodes;
            }
            catch (Exception ex)
            {
                return new List<EquipmentData>();
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