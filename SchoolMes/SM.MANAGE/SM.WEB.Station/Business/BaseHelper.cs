using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Helper;

namespace SM.WEB.Station
{
    public class BaseHelper
    {
        public static DataSet GetStationBase(string IP)
        {
            DataSet ds = new DataSet();
            try
            {
                string sql = string.Format(@"select a.[ID]
      ,a.[StationCode]
      ,a.[StationName]
      ,a.[StationDesc]
      ,a.[StationType]
      ,a.[StationPosition]
      ,a.[StationAsset]
      ,a.[Team]
      ,a.[IP]
      ,a.[ProcessSheet]
      ,a.[IsFirstStation],a.LineId,b.LineName,b.DesignCycle,b.PlanCycle from StationInfo(nolock) a join LineInfo(nolock) b on a.LineId=b.ID where a.IP=N'{0}'", IP);
                ds = SQLHelper.GetDataSet(sql);
                return ds;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public static DataSet GetStationBaseById(string ID)
        {
            DataSet ds = new DataSet();
            try
            {
                string sql = string.Format(@"select a.[ID]
      ,a.[StationCode]
      ,a.[StationName]
      ,a.[StationDesc]
      ,a.[StationType]
      ,a.[StationPosition]
      ,a.[StationAsset]
      ,a.[Team]
      ,a.[IP]
      ,a.[ProcessSheet]
      ,a.[IsFirstStation],a.LineId,b.LineName,b.DesignCycle,b.PlanCycle from StationInfo(nolock) a join LineInfo(nolock) b on a.LineId=b.ID where a.ID=N'{0}'", ID);
                ds = SQLHelper.GetDataSet(sql);
                return ds;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public static DataSet GetAndon(string IP)
        {
            DataSet ds = new DataSet();
            try
            {
                string sql = string.Format(@"  select a.*,b.DesignJPH PlanCycle from AndonConfiguration(nolock) a join EquipmentData(nolock) b on a.LineId=b.ID where a.AndonIP=N'{0}' and b.EType=1 ", IP);
                ds = SQLHelper.GetDataSet(sql);
                return ds;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public static DataSet GetAndonByid(string Id)
        {
            DataSet ds = new DataSet();
            try
            {
                string sql = string.Format(@"  select a.*,b.DesignJPH PlanCycle from AndonConfiguration(nolock) a join EquipmentData(nolock) b on a.LineId=b.ID where a.ID=N'{0}' and b.EType=1 ", Id);
                ds = SQLHelper.GetDataSet(sql);
                return ds;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}