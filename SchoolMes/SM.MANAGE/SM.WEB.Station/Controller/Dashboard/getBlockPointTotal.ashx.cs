﻿using Helper;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
namespace SM.WEB.Station.Controller.Dashboard
{
    /// <summary>
    /// getBlockPointTotal 的摘要说明
    /// </summary>
    public class getBlockPointTotal : IHttpHandler
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
            string sql = string.Format(@"select f.EquipmentName,f.ID,max(isnull(case when f.FaultType=1 then faultminute end,0)) f1,
                                max(isnull(case when f.FaultType=2 then faultminute end,0)) f2,
                                max(isnull(case when f.FaultType=3 then faultminute end,0)) f3,
                                max(isnull(case when f.FaultType=4 then faultminute end,0)) f4
                                from (select 
                                 sum(DATEDIFF(minute,starttime,isnull(endtime,getdate()))) faultminute, b.ID,
                                b.EquipmentName,a.FaultType from FaultInfo(nolock) a
                                JOIN EquipmentData(nolock) b on a.parentid=b.ID and a.FaultType<>5 and b.ParentId=N'{2}'
                                where StartTime>=N'{0}' AND StartTime<=N'{1}' --调试时候注释
                                group by b.EquipmentName, b.ID,a.FaultType
                                ) f
                                group by f.EquipmentName,f.ID ", dtbeginx.ToString("yyyy-MM-dd HH:mm:ss"), dtendx.ToString("yyyy-MM-dd HH:mm:ss"),EId);
            DataSet ds= SQLHelper.GetDataSet(sql);

            string sqlequipment = string.Format(@"select ID,EquipmentName from EquipmentData(nolock) where ParentId=N'{0}'", EId);
            DataSet dsreault = SQLHelper.GetDataSet(sqlequipment);

            dsreault.Tables[0].Columns.Add("f1");
            dsreault.Tables[0].Columns.Add("f2");
            dsreault.Tables[0].Columns.Add("f3");
            dsreault.Tables[0].Columns.Add("f4");
            dsreault.Tables[0].Columns.Add("f5");
            
            var f5 = 0;
            for (int i = 0; i < dsreault.Tables[0].Rows.Count; i++)
            {
                DataRow[] dr = ds.Tables[0].Select("ID=" + dsreault.Tables[0].Rows[i]["ID"].ToString());
                if (dr.Length > 0)
                {
                    dsreault.Tables[0].Rows[i]["f1"] = dr[0]["f1"].ToString();
                    dsreault.Tables[0].Rows[i]["f2"] = dr[0]["f2"].ToString();
                    dsreault.Tables[0].Rows[i]["f3"] = dr[0]["f3"].ToString();
                    dsreault.Tables[0].Rows[i]["f4"] = dr[0]["f4"].ToString();
                }
                else
                {
                    dsreault.Tables[0].Rows[i]["f1"] = 0;
                    dsreault.Tables[0].Rows[i]["f2"] = 0;
                    dsreault.Tables[0].Rows[i]["f3"] = 0;
                    dsreault.Tables[0].Rows[i]["f4"] = 0;
                }
                f5 = int.Parse(totalshifttime.ToString());
                for (int k = 2; k < dsreault.Tables[0].Columns.Count - 1; k++)
                {
                    f5 -= int.Parse(dsreault.Tables[0].Rows[i][k].ToString());
                }
                dsreault.Tables[0].Rows[i]["f5"] = f5;
            }
            string result = JsonConvert.SerializeObject(dsreault.Tables[0], new DataTableConverter());
            HttpContext.Current.Response.Write(result);

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