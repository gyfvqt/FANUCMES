using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAL;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.Data;

namespace SM.WEB.Controller
{
    /// <summary>
    /// EquipmentDataTrees 的摘要说明
    /// </summary>
    public class EquipmentDataTrees : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            try {
                string sql = "select * from EquipmentData(nolock)";
                DataSet ds = SQLHelper.GetDataSet(sql);
                List<EquipmentData> rootNode = new List<EquipmentData>();
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow[] dr = ds.Tables[0].Select("ParentId=0");
                    for (int i = 0; i < dr.Length; i++) {
                        EquipmentData node = new EquipmentData();
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
                        node.EType = dr[i]["EType"].ToString();
                        node.children = GetChild(ds, node);
                        rootNode.Add(node);
                    }
                     
                }
                context.Response.Write(JsonConvert.SerializeObject(rootNode));
                
            }
            catch (Exception ex)
            {
                context.Response.Write(JsonConvert.SerializeObject(new List<EquipmentData>()));
            }
            
        }
        public List<EquipmentData> GetChild(DataSet ds,EquipmentData pnode)
        {
            try
            {
                List<EquipmentData> Nodes = new List<EquipmentData>();
                DataRow[] dr = ds.Tables[0].Select("ParentId="+ pnode.id);
                for (int i = 0; i < dr.Length; i++)
                {
                    EquipmentData node = new EquipmentData();
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
                    node.EType= dr[i]["EType"].ToString();
                    node.children = GetChild(ds, node);
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
    public class EquipmentData {
        public virtual string id { get; set; }
        public virtual string ParentId{ get; set; }
        public virtual string EquipmentCode { get; set; }
        public virtual string text { get; set; }
        public virtual string EquipmentDesc { get; set; }
        public virtual string Team { get; set; }
        public virtual string EquipmentImg { get; set; }
        public virtual string PLCIP { get; set; }
        public virtual string PLCDB { get; set; }
        public virtual string IsPayPoint { get; set; }
        public virtual string DesignCycletime { get; set; }
        public virtual string DesignJPH { get; set; }
        public virtual string EquipmentSupplier { get; set; }
        public virtual string Counter { get; set; }
        public virtual string EType { get; set; }
        public virtual List<EquipmentData> children { get; set; }
    }
}