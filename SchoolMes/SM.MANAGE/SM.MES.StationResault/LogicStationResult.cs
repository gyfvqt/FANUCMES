using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Helper;
using System.Data;

namespace SM.MES.StationResault
{
    public class LogicStationResult
    {
        /// <summary>
        /// 获取过站记录
        /// </summary>
        /// <param name="ProductionSn"></param>
        /// <param name="StationCode"></param>
        /// <returns></returns>
        public static DataSet GetTransit(string ProductionSn, string StationCode)
        {
            try
            {
                SystemLogs.InsertPLCLog("StationResult", "查找产品的过站记录：站点-" + StationCode + ";产品SN-" + ProductionSn);
                string sql = string.Format(@"select * from ProductTransitInfo(nolock) where ProductId=N'{0}' and StationCode=N'{1}'", ProductionSn, StationCode);
                DataSet ds = SQLHelper.GetDataSet(sql);
                SystemLogs.InsertPLCLog("StationResult", "查找产品的过站记录成功：站点-" + StationCode + ";产品SN-" + ProductionSn);
                return ds;

            }
            catch (Exception ex)
            {
                SystemLogs.InsertPLCLog("StationResult", "查找产品的过站记录失败：站点-" + StationCode + ";产品SN-" + ProductionSn + "--" + ex.Message);
                return null;
            }
        }
    }
}
