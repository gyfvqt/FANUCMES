using DAL;
using System;
using System.Data;
using System.Web;
using System.Collections;
using System.Collections.Generic;

namespace SM.WEB.Controller
{
    /// <summary>
    /// AMTicketSplit 的摘要说明
    /// </summary>
    public class AMTicketSplit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string sql = string.Format(@"select * from AMTicket(nolock) where ID={0};select * from AMConfiguration(nolock) where TicketId={0};", ID);
                DataSet dsAmTicket = SQLHelper.GetDataSet(sql);
                var sqlrole = "";
                if (dsAmTicket != null && dsAmTicket.Tables[0].Rows.Count > 0 && dsAmTicket.Tables[1].Rows.Count > 0)
                {
                    DateTime dbegin = Convert.ToDateTime(dsAmTicket.Tables[1].Rows[0]["BeginDate"].ToString());
                    DateTime dend = Convert.ToDateTime(dsAmTicket.Tables[1].Rows[0]["EndDate"].ToString());
                    List<string> ExecuteDateList=new List<string>();
                    var x = dbegin;
                    switch (dsAmTicket.Tables[1].Rows[0]["PeriodType"].ToString()) {
                        case "每天":
                            ExecuteDateList.Add(dsAmTicket.Tables[1].Rows[0]["BeginDate"].ToString());                            
                            while (x.AddDays(1) <= dend)
                            {
                                x = x.AddDays(1);
                                ExecuteDateList.Add(x.ToString("yyyy-MM-dd"));
                            }
                            break;
                        case "每周":
                            string weekdayN = dbegin.DayOfWeek.ToString();
                            var wi = getDay(weekdayN);
                            string[] arrweek = dsAmTicket.Tables[1].Rows[0]["WeekDate"].ToString().Split('|');
                            for (int i = 0; i < arrweek.Length; i++) {
                                if (arrweek[i].Trim() != "")
                                {
                                    DateTime wx = dbegin;
                                    if (wi > int.Parse(arrweek[i].Trim()))
                                    {
                                        wx = dbegin.AddDays(7 + int.Parse(arrweek[i].Trim()) - wi);
                                    }
                                    else if (wi < int.Parse(arrweek[i].Trim()))
                                    {
                                        wx = dbegin.AddDays(int.Parse(arrweek[i].Trim()) - wi);                                        
                                    }
                                    ExecuteDateList.Add(wx.ToString("yyyy-MM-dd"));

                                    while (wx.AddDays(int.Parse(dsAmTicket.Tables[1].Rows[0]["Xweek"].ToString())*7) <= dend)
                                    {
                                        wx = wx.AddDays(int.Parse(dsAmTicket.Tables[1].Rows[0]["Xweek"].ToString()) * 7);
                                        ExecuteDateList.Add(wx.ToString("yyyy-MM-dd"));
                                    }
                                }
                            }                            
                            break;
                        case "每月":
                            DateTime mx;
                            if (int.Parse(dsAmTicket.Tables[1].Rows[0]["Day"].ToString()) > dbegin.Day)
                            {
                                int date = int.Parse(dsAmTicket.Tables[1].Rows[0]["Day"].ToString());
                                int dbeginMonthLastDay = dbegin.AddDays(1 - dbegin.Day).AddMonths(1).AddSeconds(-1).Day;

                                if (date > dbeginMonthLastDay)
                                {
                                    date = dbeginMonthLastDay;
                                }
                                if (DateTime.Parse(dbegin.ToString("yyyy-MM-") + date) <= dend)
                                {
                                    mx = DateTime.Parse(dbegin.ToString("yyyy-MM-") + date);
                                }
                                else
                                {
                                    return;
                                }
                            }
                            else
                            {
                                int date = int.Parse(dsAmTicket.Tables[1].Rows[0]["Day"].ToString());
                                int dbeginMonthLastDay = dbegin.AddDays(1 - dbegin.Day).AddMonths(1).AddSeconds(-1).Day;

                                if (date > dbeginMonthLastDay)
                                {
                                    date = dbeginMonthLastDay;
                                }
                                if (DateTime.Parse(dbegin.AddMonths(1).ToString("yyyy-MM-") + date) <= dend)
                                {
                                    mx = DateTime.Parse(dbegin.AddMonths(1).ToString("yyyy-MM-") + date);
                                }
                                else
                                {
                                    return;
                                }
                            }
                            ExecuteDateList.Add(mx.ToString("yyyy-MM-dd"));
                            
                            while (mx.AddMonths(1) <= dend)
                            {
                                int date = int.Parse(dsAmTicket.Tables[1].Rows[0]["Day"].ToString());
                                int dbeginMonthLastDay = mx.AddMonths(1).AddDays(1 - mx.AddMonths(1).Day).AddMonths(1).AddSeconds(-1).Day;

                                if (date > dbeginMonthLastDay)
                                {
                                    date = dbeginMonthLastDay;
                                }
                                mx = DateTime.Parse(mx.AddMonths(1).ToString("yyyy-MM-") + date);//mx.AddMonths(1);
                                ExecuteDateList.Add(mx.ToString("yyyy-MM-dd"));
                            }
                            break;
                        case "每年":
                            DateTime yx;
                            if (DateTime.Parse(dbegin.ToString("yyyy-")+ dsAmTicket.Tables[1].Rows[0]["Month"].ToString() +"-"+ dsAmTicket.Tables[1].Rows[0]["Day"].ToString() )> dbegin)
                            {
                                
                                if (DateTime.Parse(dbegin.ToString("yyyy-")+ dsAmTicket.Tables[1].Rows[0]["Month"].ToString() + "-" + dsAmTicket.Tables[1].Rows[0]["Day"].ToString()) <= dend)
                                {
                                    yx = DateTime.Parse(dbegin.ToString("yyyy-") + dsAmTicket.Tables[1].Rows[0]["Month"].ToString() + "-" + dsAmTicket.Tables[1].Rows[0]["Day"].ToString());
                                }
                                else
                                {
                                    return;
                                }
                            }
                            else
                            {
                                
                                if (DateTime.Parse(dbegin.AddYears(1).ToString("yyyy-") + dsAmTicket.Tables[1].Rows[0]["Month"].ToString() + "-" + dsAmTicket.Tables[1].Rows[0]["Day"].ToString()) <= dend)
                                {
                                    yx = DateTime.Parse(dbegin.AddYears(1).ToString("yyyy-") + dsAmTicket.Tables[1].Rows[0]["Month"].ToString() + "-" + dsAmTicket.Tables[1].Rows[0]["Day"].ToString());
                                }
                                else
                                {
                                    return;
                                }
                            }
                            ExecuteDateList.Add(yx.ToString("yyyy-MM-dd"));

                            while (yx.AddYears(1) <= dend)
                            {                                
                                yx = yx.AddYears(1);
                                if(yx<dend) ExecuteDateList.Add(yx.ToString("yyyy-MM-dd"));
                            }
                            break;
                    }
                    if (ExecuteDateList.Count > 0)
                    {
                        ExecuteDateList.Sort();
                        for (int k = 0; k < ExecuteDateList.Count; k++)
                        {
                            sqlrole += string.Format(@"insert into AMTicketSplit(TicketDetailCode,TicketId,ExecuteDate,Stratus,UpdateTime) 
                                    values(N'{0}',N'{1}',N'{2}',N'执行',getdate());",
                                    dsAmTicket.Tables[0].Rows[0]["TicketNo"].ToString()+"-"+(k+1).ToString().PadLeft(4,'0'), 
                                    dsAmTicket.Tables[0].Rows[0]["ID"].ToString(), ExecuteDateList[k]);
                        }
                        sqlrole += string.Format(@"update AMTicket set ExecuteStatus=N'执行' where ID = N'{0}';", dsAmTicket.Tables[0].Rows[0]["ID"].ToString());
                        if (sqlrole != "") SQLHelper.ExcuteSQL(sqlrole);
                    }
                }

                if (context.Session["_dsuserinfo"] != null)
                {
                    DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                    SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                        dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                        "开始执行维护任务成功:" + "");
                }

                HttpContext.Current.Response.Write("1");
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("0");
            }
        }
        int getDay(string weekday)
        {
            var w = -1;
            switch (weekday.ToLower())
            {
                case "monday":
                    w= 1;
                    break;
                case "tuesday":
                    w = 1;
                    break;
                case "wednesday":
                    w = 1;
                    break;
                case "thursday":
                    w = 1;
                    break;
                case "friday":
                    w = 1;
                    break;
                case "saturday ":
                    w = 1;
                    break;
                case "sunday":
                    w = 1;
                    break;                
                default:
                    w= -1;
                    break;
            }
            return w;
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