﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace SM.WEB.Station.Controller
{
    /// <summary>
    /// GetStationPlan 的摘要说明
    /// </summary>
    public class GetStationPlan : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string PlanJph = HttpContext.Current.Request.Params["PlanJPH"];
                string ActureReturn = HttpContext.Current.Request.Params["actureReturn"];
                string StationId = HttpContext.Current.Request.Params["stationid"];

                double totalSpandTime = 0;
                double totalshifttime = 0;

                string sqlSearch = @"select * from WorkShift(nolock)";
                DataSet dsSearch = SQLHelper.GetDataSet(sqlSearch);
                DateTime dt = DateTime.Now;
                DateTime dtbegin, dtend;
                dtbegin = dtend = dt;
                DateTime dtbeginx, dtendx;
                dtbeginx = dtendx = dt;
                string result = "0";
                if (dsSearch != null && dsSearch.Tables[0].Rows.Count > 0)
                {
                    
                    //获取当前班次的开始时间和结束时间
                    for (int i = 0; i < dsSearch.Tables[0].Rows.Count; i++)
                    {
                        dtbegin = DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["BeginTime"].ToString().Trim());
                        dtend= DateTime.Parse(dt.ToString("yyyy-MM-dd ") + dsSearch.Tables[0].Rows[i]["EndTime"].ToString().Trim());
                        if (dtbegin >= dtend) dtend=dtend.AddDays(1);//跨天结束时间加1天
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

                    //var a = int.Parse(PlanJph) * totalSpandTime / totalshifttime;
                    var a = int.Parse(PlanJph) * totalSpandTime / 60;
                    //var b = int.Parse(ActureReturn) / totalshifttime;

                    string sql = string.Format(@"select * from StationInfo(nolock) where ID=N'{0}'", StationId);
                    DataSet dss = SQLHelper.GetDataSet(sql);
                    if (dss != null && dss.Tables[0].Rows.Count > 0)
                    {
                        StationId = dss.Tables[0].Rows[0]["StationAsset"].ToString();
                    }

                    //获取故障停线时间总长
                    double faulttime = 0;
                    DataSet dsfault = SQLHelper.GetDataSet(string.Format(@"select a.* from FaultInfo(nolock)a
                                          JOIN EquipmentData(nolock) b on a.parentid = b.ID
                                          where  LineOrSatation = 3 and b.ParentId = N'{0}' and FaultType <> 5
                                          AND  StartTime >= N'{1}' and StartTime <= N'{2}' ", StationId,dtbeginx,dtendx));
                    if (dsfault != null && dsfault.Tables[0].Rows.Count > 0)
                    {
                        for (int i = 0; i < dsfault.Tables[0].Rows.Count; i++)
                        {
                            if (DateTime.Parse(dsfault.Tables[0].Rows[i]["EndTime"].ToString()) > dtendx)
                            {
                                faulttime += (dtendx - DateTime.Parse(dsfault.Tables[0].Rows[i]["EndTime"].ToString())).TotalMinutes;
                            }
                            else
                            {
                                faulttime += (DateTime.Parse(dsfault.Tables[0].Rows[i]["EndTime"].ToString())
                                    - DateTime.Parse(dsfault.Tables[0].Rows[i]["StartTime"].ToString())).TotalMinutes;
                            }
                        }                        

                    }
                    var c = ((totalshifttime - faulttime) / totalshifttime * 100).ToString("f1");

                    //根据设备CycleTime获取生产实际
                    var Acture = SQLHelper.GetObject(string.Format(@"select count(1) as xcount from CycleTimeInfo(nolock) a
                              JOIN EquipmentData(nolock) b on a.ParentId = b.ID
                             where  b.ParentId = N'{0}'  and a.IsPayPoint=1  AND  EndTime>=N'{1}' and EndTime<=N'{2}'", StationId, dtbeginx, dtendx)).ToString();
                    //返回结果
                    var b = int.Parse(Acture) / (totalshifttime / 60);
                    result = a.ToString("f0")+"|"+b.ToString("f1")+"|"+c + "|" + Acture;
                    if (totalshifttime == 0) result = "0|0|0|0"; 
                }
                
                HttpContext.Current.Response.Write(result);

            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("0");
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