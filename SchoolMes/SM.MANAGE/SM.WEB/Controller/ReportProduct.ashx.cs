using DAL;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Data;
using System.Web;

namespace SM.WEB.Controller
{
    /// <summary>
    /// ReportProduct 的摘要说明
    /// </summary>
    public class ReportProduct : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string EId = HttpContext.Current.Request.Params["eid"];
                string EType = HttpContext.Current.Request.Params["etype"];
                string DTSTART = HttpContext.Current.Request.Params["dtstart"];
                string DTEND = HttpContext.Current.Request.Params["dtend"];

                DateTime dtbeginx, dtendx;
                dtbeginx = DateTime.Parse(DTSTART);
                dtendx = DateTime.Parse(DTEND);
                //通过Cycletime 获取产量
                //DataSet dsProduction=SQLHelper.GetDataSet(string.Format)

                string sql = "";
                if (EType == "1")//线体
                {
                    sql = string.Format(@"select 
                                 a.starttime,isnull(a.endtime,N'{1}') endtime, b.ID,
                                b.EquipmentName,a.FaultType from FaultInfo(nolock) a
                                JOIN EquipmentData(nolock) b on a.parentid=b.ID and a.FaultType<>5 and b.ParentId=N'{2}'
                                where StartTime>=N'{0}' AND StartTime<=N'{1}'; --调试时候注释
                                SELECT a.EId,a.StartTime,a.EndTime,b.ID,b.ParentId,DATEDIFF(minute,starttime,isnull(endtime,getdate())) as cycletime FROM CycleTimeInfo(NOLOCK) a 
                                join EquipmentData(nolock) b on a.ParentId=b.ID and a.IsPayPoint=1 and b.ParentId=N'{2}'
                                where a.EndTime>=N'{0}' and a.EndTime<N'{1}';
                                ", dtbeginx.ToString("yyyy-MM-dd HH:mm:ss"), dtendx.ToString("yyyy-MM-dd HH:mm:ss"), EId);
                }
                else if (EType == "2")//站点
                {
                    sql = string.Format(@"select 
                                 a.starttime,isnull(a.endtime,N'{1}') endtime, b.ID,
                                b.EquipmentName,a.FaultType from FaultInfo(nolock) a
                                JOIN EquipmentData(nolock) b on a.parentid=b.ID and a.FaultType<>5 and b.ID=N'{2}'
                                where StartTime>=N'{0}' AND StartTime<=N'{1}'; --调试时候注释
                                SELECT a.EId,a.StartTime,a.EndTime,b.ID,b.ParentId,DATEDIFF(minute,starttime,isnull(endtime,getdate())) as cycletime FROM CycleTimeInfo(NOLOCK) a 
                                join EquipmentData(nolock) b on a.ParentId=b.ID and a.IsPayPoint=1 and b.ID=N'{2}'
                                where a.EndTime>=N'{0}' and a.EndTime<N'{1}';
                                 ", dtbeginx.ToString("yyyy-MM-dd HH:mm:ss"), dtendx.ToString("yyyy-MM-dd HH:mm:ss"), EId);
                }
                else if (EType == "3")//设备
                {
                    sql = string.Format(@"select 
                                 a.starttime,isnull(a.endtime,N'{1}') endtime, b.ID,
                                b.EquipmentName,a.FaultType from FaultInfo(nolock) a
                                JOIN EquipmentData(nolock) b on a.StationId=b.ID and a.FaultType<>5 and b.ID=N'{2}'
                                where StartTime>=N'{0}' AND StartTime<=N'{1}'; --调试时候注释
                                SELECT a.EId,a.StartTime,a.EndTime,b.ID,b.ParentId,DATEDIFF(minute,starttime,isnull(endtime,getdate())) as cycletime FROM CycleTimeInfo(NOLOCK) a 
                                  join EquipmentData(nolock) b on a.EId=b.ID and a.IsPayPoint=1 and b.ID=N'{2}'
                                  where a.EndTime>=N'{0}' and a.EndTime<N'{1}';
                                ", dtbeginx.ToString("yyyy-MM-dd HH:mm:ss"), dtendx.ToString("yyyy-MM-dd HH:mm:ss"), EId);
                }
                if (sql != "")
                {
                    DataSet ds = SQLHelper.GetDataSet(sql);
                    DataTable dtresult = new DataTable();
                    dtresult.Columns.Add("ymd");
                    dtresult.Columns.Add("hour");
                    dtresult.Columns.Add("countproduction");
                    dtresult.Columns.Add("countfault2");//故障
                    dtresult.Columns.Add("countfault3");//堵塞
                    dtresult.Columns.Add("countfault4");//缺件
                    dtresult.Columns.Add("countfaulttime");//故障次数
                    dtresult.Columns.Add("cycletimeAVG");//平均CycleTime

                    DateTime dtfor = dtbeginx;
                    DateTime dtendfor;
                    for (int i = 0; dtfor < dtendx; i++)
                    {
                        
                        dtfor = DateTime.Parse(dtfor.ToString("yyyy-MM-dd HH") + ":00:00");
                        dtendfor = DateTime.Parse(dtfor.ToString("yyyy-MM-dd HH") + ":59:59");
                        DataRow dr = dtresult.NewRow();
                        //获取年月日
                        dr["ymd"] = dtfor.ToString("yyyy-MM-dd");
                        //获取小时
                        dr["hour"] = dtfor.ToString("HH");
                        //获取此小时内生产数量
                        DataRow[] x = ds.Tables[1].Select("EndTime>='" + dtfor + "' and EndTime<='" + dtendfor + "'");
                        dr["countproduction"] = x.Length == 0 ? "" : x.Length.ToString();
                        //获取此小时内的平均CycleTime
                        if (x.Length > 0)
                        {
                            double totaltime = 0;
                            for (int k = 0; k < x.Length; k++)
                            {
                                totaltime += double.Parse(x[k]["cycletime"].ToString());
                            }
                            dr["cycletimeAVG"] = (totaltime / x.Length).ToString("f0");
                        }
                        else
                        {
                            dr["cycletimeAVG"] = "";
                        }
                        //获取此小时内故障
                        DataRow[] y = ds.Tables[0].Select(@"(starttime>='" + dtfor.ToString("yyyy-MM-dd HH:mm:ss") + "' and endtime<='" + dtendfor.ToString("yyyy-MM-dd HH:mm:ss") + "') " +//时间段落在查询时间段内的部分
                            "or (starttime>='" + dtfor.ToString("yyyy-MM-dd HH:mm:ss") + "' and (endtime is null)) " +//时间段在后部交叉部分
                            "or (starttime<'" + dtfor.ToString("yyyy-MM-dd HH:mm:ss") + "' and endtime<'" + dtendfor.ToString("yyyy-MM-dd HH:mm:ss") + "' and endtime>'" + dtfor.ToString("yyyy-MM-dd HH:mm:ss") + "' )");//时间段在前段交叉部分
                        //获取故障次数
                        dr["countfaulttime"] = y.Length == 0 ? "" : y.Length.ToString();

                        //获取故障明细
                        double total2 = 0;
                        double total3 = 0;
                        double total4 = 0;
                        for (int j = 0; j < y.Length; j++)
                        {
                            DateTime dx2s = dtfor;
                            DateTime dx2e = dtendfor;
                            if (dx2s <= DateTime.Parse(y[j]["starttime"].ToString()))
                            //统计时间段开始时间小于故障开始时间，那么按照故障开始时间算，否则按照时间段开始时间算                                
                            {
                                dx2s = DateTime.Parse(y[j]["starttime"].ToString());
                            }

                            if (dx2e >= DateTime.Parse(y[j]["endtime"].ToString()))
                            //统计时间段结束时间大于故障结束时间，那么按照故障结束时间算，否则按照时间段结束时间算   
                            {
                                dx2e = DateTime.Parse(y[j]["endtime"].ToString());
                            }
                            //故障
                            if (y[j]["FaultType"].ToString() == "2")
                            {
                                total2 += (dx2e - dx2s).TotalSeconds;
                            }
                            else if (y[j]["FaultType"].ToString() == "3")
                            {
                                total3 += (dx2e - dx2s).TotalSeconds;
                            }
                            else if (y[j]["FaultType"].ToString() == "4")
                            {
                                total4 += (dx2e - dx2s).TotalSeconds;
                            }
                        }

                        dr["countfault2"] = total2 == 0 ? "" : total2.ToString("f0");
                        dr["countfault3"] = total3 == 0 ? "" : total3.ToString("f0");
                        dr["countfault4"] = total4 == 0 ? "" : total4.ToString("f0");

                        dtresult.Rows.Add(dr);
                        dtresult.AcceptChanges();
                        dtfor = dtfor.AddHours(1);
                    }

                    string result = JsonConvert.SerializeObject(dtresult, new DataTableConverter());
                    HttpContext.Current.Response.Write(result);

                }
            }
            catch (Exception ex)
            { }

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