using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;

namespace SM.WEB.Station.Controller.Dashboard
{
    public class BaseReport
    {
        public List<string> liequipment = new List<string>();
        public static List<EquipmentData> GetEquipmentTree(string nodeid)
        {
            
            try
            {
                string sql = "select * from EquipmentData(nolock)";
                DataSet ds = SQLHelper.GetDataSet(sql);
                List<EquipmentData> rootNode = new List<EquipmentData>();
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow[] dr = ds.Tables[0].Select("ParentId="+ nodeid);
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
                        node.children = GetChild(ds, node);
                        rootNode.Add(node);
                    }

                }

                return rootNode;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public static List<EquipmentData> GetChild(DataSet ds, EquipmentData pnode)
        {
            try
            {
                List<EquipmentData> Nodes = new List<EquipmentData>();
                DataRow[] dr = ds.Tables[0].Select("ParentId=" + pnode.id);
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
    }

    
}