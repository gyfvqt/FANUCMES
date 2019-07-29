using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
namespace Helper
{
    public class SystemLogs
    {
        /// <summary>
        /// 系统日志
        /// </summary>
        /// <param name="UserId"></param>
        /// <param name="UserName"></param>
        /// <param name="RoleName"></param>
        /// <param name="OptionDesc"></param>
        public static void InsertSystemLog(string UserId,string UserName,string RoleName,string OptionDesc)
        {
            try
            {
                string sql = string.Format(@"insert into SystemLogs(CreateTime,UserId,UserName,RoleName,OptionDesc) values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}')",
                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), UserId, UserName, RoleName, OptionDesc);
                SQLHelper.ExcuteSQL(sql);
            }
            catch(Exception ex) {

            }
        }
        /// <summary>
        /// PLClogs
        /// </summary>
        /// <param name="PLCIP"></param>
        /// <param name="OptionDesc"></param>
        public static void InsertPLCLog(string PLCIP,string OptionDesc)
        {
            try
            {
                string sql = string.Format(@"insert into ManufacturingLogs(CreateTime,PLCIP,OptionDesc) values(N'{0}',N'{1}',N'{2}')",
                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), PLCIP, OptionDesc);
                SQLHelper.ExcuteSQL(sql);
            }
            catch (Exception ex)
            {

            }
        }

        /// <summary>
        /// errorlogs
        /// </summary>
        /// <param name="PLCIP"></param>
        /// <param name="OptionDesc"></param>
        public static void InsertErrLog( string OptionDesc)
        {
            try
            {
                string sql = string.Format(@"insert into ErrorLogs(CreateTime,OptionDesc) values(N'{0}',N'{1}')",
                    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), OptionDesc);
                SQLHelper.ExcuteSQL(sql);
            }
            catch (Exception ex)
            {

            }
        }
    }
}