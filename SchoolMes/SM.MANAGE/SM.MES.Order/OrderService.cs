using DAL;
using OPCAutomation;
using SM.WEB;
using System;
using System.Collections.Generic;
using System.Data;
using System.ServiceProcess;
using System.Timers;

namespace SM.MES.Order
{
    public partial class OrderService : ServiceBase
    {
        OPCServer objServer;
        OPCGroups objGroups;
        OPCGroup objGroup;
        OPCItems objItems;
        OPCItem[] objChangeItem;
        Array strItemIDs;
        Array lClientHandles;
        Array lserverhandles;
        Array lErrors;
        string State;
        //  int ltransID_Rd = 1;
        // int lCancelID_Rd;
        object RequestedDataTypes = null;
        object AccessPaths = null;
        // Array lerrors_Rd;
        Array lErrors_Wt;
        int lTransID_Wt = 2;
        int lCancelID_Wt;
        int opcQualityState;//OPC与PLC链接状态
                            //状态显示枚举
        private delegate void OPCtimer(string text);
        //OPC与PLC链接状态
        private delegate void OPCtoPlcState(int PLCstate);

        string[] tmpIDs;
        int scount = 0;
        int dcount = 0;
        Timer tim;
        //OPC链接定时器
        Timer OPCconnectTimer;

        public OrderService()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            try
            {
                OPCconnectTimer = new Timer();
                OPCconnectTimer.Interval = 1000;
                OPCconnectTimer.Elapsed += new ElapsedEventHandler(OPCconnectTimer_Tick);
                OPCconnectTimer.Enabled = true;




                //初始化链接状态定时器
                tim = new Timer();//定义一个1S的定时器；
                tim.Interval = 1500;
                tim.Elapsed += new ElapsedEventHandler(theout);//定时时间到后执行theout事件；
                tim.Enabled = true; ;//是否执行System.Timers.Timer.Elapsed事件；
                                     //(1)创建opc server对象
                objServer = new OPCServer();
                //objChangeItem = new OPCItem[4];
            }
            catch (Exception ex)
            {
                SystemLogs.InsertPLCLog("Order2PLC", ex.Message);
            }
        }
        /// <summary>
        /// OPC初始化
        /// 当定时时间到触发下面事件
        /// 开机后延迟1秒开始初始化OPC，以后10秒检查与OPC链接转态，如果断开链接就重新链接并初始化OPC
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void OPCconnectTimer_Tick(object sender, EventArgs e)
        {
            try
            {

                OPCconnectTimer.Interval = 10000;
                if (objServer.ServerState != 1)
                {

                    //连接opc server                    
                    objServer.Connect("Kepware.KEPServerEX.V5", "");
                    #region 获取所有线体首站点以及PLC模板
                    string sql = @"select * from StationInfo(nolock) where IsFirstStation=1;
                                select a.ID as SID,a.StationCode,b.PLCTrigger,C.* from StationInfo(nolock) a 
                                join PLCTemplateOperationInfo(nolock) b on a.ID=b.PLCStationId
                                join PLCTemplateInfoDetail(nolock) c on b.PLCTemplateId=c.PLCTemplateId 
                                where a.IsFirstStation=1
                                order by a.ID,c.ID";
                    DataSet dsstation = SQLHelper.GetDataSet(sql);
                    #endregion
                    //(2)建立一个opc组集合
                    objGroups = objServer.OPCGroups;
                    //(3)建立一个opc组
                    objGroup = objGroups.Add(null); //Group组名字可有可无
                    //(4)添加opc标签
                    objGroup.IsActive = true; //设置该组为活动状态，连接PLC时，设置为非活动状态也一样
                    objGroup.IsSubscribed = true; //设置异步通知
                    objGroup.UpdateRate = 250;
                    objServer.OPCGroups.DefaultGroupDeadband = 0;
                    objGroup.DataChange += new DIOPCGroupEvent_DataChangeEventHandler(KepGroup_DataChange);
                    objGroup.AsyncReadComplete += new DIOPCGroupEvent_AsyncReadCompleteEventHandler(AsyncReadComplete);
                    objGroup.AsyncWriteComplete += new DIOPCGroupEvent_AsyncWriteCompleteEventHandler(AsyncWriteComplete);
                    objItems = objGroup.OPCItems; //建立opc标签集合
                    #region 循环创建连接并监控PLC地址 
                    if (dsstation == null || dsstation.Tables[0].Rows.Count <= 0 || dsstation.Tables[1].Rows.Count <= 0)
                    {
                        SystemLogs.InsertPLCLog("Order2PLC", "获取站点PLC模板失败！请确认配置！");
                    }
                    else
                    {
                        scount = dsstation.Tables[0].Rows.Count;
                        dcount = dsstation.Tables[1].Rows.Count;
                        int count = dsstation.Tables[1].Rows.Count + 1;
                        tmpIDs = new string[count];
                        int[] tmpCHandles = new int[count];
                        objChangeItem = new OPCItem[count];
                        List<int> statinindex = new List<int>();
                        for (int i = 1; i < count; i++)
                        {
                            tmpCHandles[i] = i;
                            tmpIDs[i] = dsstation.Tables[1].Rows[i - 1]["PLCTrigger"].ToString() + "." + dsstation.Tables[1].Rows[i - 1]["PLCUPDBAddress"].ToString();
                            if (dsstation.Tables[1].Rows[i - 1]["PLCUPDBAddress"].ToString() == "Order0Init")
                            {
                                statinindex.Add(i);
                            }
                        }

                        strItemIDs = (Array)tmpIDs;//必须转成Array型，否则不能调用AddItems方法
                        lClientHandles = (Array)tmpCHandles;
                        // 添加opc标签
                        SystemLogs.InsertPLCLog("Order2PLC", "添加监控标签！");
                        objItems.AddItems(count - 1, ref strItemIDs, ref lClientHandles, out lserverhandles, out lErrors, RequestedDataTypes, AccessPaths);
                        for (int i = 1; i < count; i++)
                        {
                            objChangeItem[i] = objItems.GetOPCItem(Convert.ToInt32(lserverhandles.GetValue(i)));
                        }
                        for (int i = 1; i < count; i++)
                        {
                            if (statinindex.IndexOf(i) >= 0)
                            {
                                SystemLogs.InsertPLCLog("Order2PLC", dsstation.Tables[1].Rows[i - 1]["PLCTrigger"].ToString() + "初始化站点编码：" + dsstation.Tables[1].Rows[i - 1]["StationCode"].ToString());
                                objChangeItem[i + 3].Write(dsstation.Tables[1].Rows[i - 1]["StationCode"].ToString());
                            }
                        }
                        //SystemLogs.InsertPLCLog("Order2PLC", "添加监控标签！");
                    }
                    #endregion
                }
            }
            catch (Exception ex)
            {
                objServer.Disconnect();
                SystemLogs.InsertPLCLog("Order2PLC", ex.Message);
            }
        }
        //每当项数据有变化时执行的事件,采用订阅方式
        void KepGroup_DataChange(int TransactionID, int NumItems, ref Array ClientHandles, ref Array ItemValues, ref Array Qualities, ref Array TimeStamps)
        {
            try
            {
                //为了测试，所以加了控制台的输出，来查看事物ID号
                //Console.WriteLine("********"+TransactionID.ToString()+"*********");
                if (scount != 0 && dcount != 0)
                {
                    int xcount = dcount / scount;
                    for (int i = 0; i < NumItems; i++)
                    {
                        if (Convert.ToInt32(ClientHandles.GetValue(i + 1)) % xcount == 1)
                        {
                            if (ItemValues.GetValue(i + 1) != null)
                            {                                
                                if (ItemValues.GetValue(i + 1).ToString() == "0100")
                                {
                                    //第一次握手   
                                    SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID+ ":第一次握手！");
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].Write("0200");

                                    //写订单到PLC
                                    //获取站点编码
                                    SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 3].ItemID + ":获取站点编码！");
                                    short s = 1;
                                    object val;
                                    object quality;
                                    object t;
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 3].Read(s, out val, out quality, out t);//objItems.GetOPCItem(Array.IndexOf(tmpIDs, triger + ".Order3StationCode")).Value;
                                    string stationcode = val.ToString();
                                    //获取上一订单号
                                    SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 6].ItemID + ":获取上一订单号！");
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 6].Read(s, out val, out quality, out t);//objItems.GetOPCItem(Array.IndexOf(tmpIDs, triger + ".Order6LastOrderNo")).Value;
                                    string orderlastno = val.ToString();
                                    //线体code
                                    SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID + ":获取线体code！");
                                    string linecode = stationcode.Substring(0, 2);

                                    //获取线体下一订单
                                    
                                    string nextorder = "";
                                    if (orderlastno != "9999")
                                    {
                                        nextorder = (Convert.ToInt32(orderlastno) + 1).ToString().PadLeft(4, '0');
                                    }
                                    else
                                    {
                                        nextorder = "0001";
                                    }
                                    SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID + ":获取线体下一订单！"+ nextorder);
                                    string sql = string.Format(@"select top 1 a.*,b.LineId FROM [ERPOrderDetails](nolock)a
                                      join LineInfo(nolock) b on a.LineId =b.ID
                                       where Status in(3,4) and OrderSeq >= '{0}' and b.LineId='{1}' 
                                       order by OrderSeq", nextorder, linecode);
                                    DataSet ds = SQLHelper.GetDataSet(sql);

                                    if (ds != null && ds.Tables[0].Rows.Count > 0)
                                    {
                                        //下发订单
                                        //订单顺序号
                                        SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 4].ItemID + ":下发订单顺序号！"+ ds.Tables[0].Rows[0]["OrderSeq"].ToString());
                                        objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 4].Write(ds.Tables[0].Rows[0]["OrderSeq"].ToString());
                                        //产品编码
                                        SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 5].ItemID + ":下发产品编码！"+ ds.Tables[0].Rows[0]["ProductionCode"].ToString());
                                        objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 5].Write(ds.Tables[0].Rows[0]["ProductionCode"].ToString());
                                        //订单数量
                                        SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 7].ItemID + ":下发订单数量！"+ ds.Tables[0].Rows[0]["DetailCount"].ToString());
                                        objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 7].Write(ds.Tables[0].Rows[0]["DetailCount"].ToString());

                                        //下发完成                                        
                                        SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID + ":更新订单状态为4生产！");
                                        sql = string.Format(@"update ERPOrderDetails set Status=4 where OrderSeq=N'{0}' and LineId=N'{1}'", ds.Tables[0].Rows[0]["OrderSeq"].ToString(), int.Parse(linecode).ToString());
                                        SQLHelper.ExcuteSQL(sql);
                                        SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID + ":更新订单状态为4生产，成功！");
                                        objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].Write("0300");
                                        SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID + ":下发完成,写0300标志！");
                                    }
                                    else
                                    {
                                        //没有订单写状态到PLC并记录系统日志
                                        //未有订单
                                        SystemLogs.InsertPLCLog("Order2PLC", "无订单下达！写0301标志");
                                        objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].Write("0301");                                        
                                    }
                                }
                                if (ItemValues.GetValue(i + 1).ToString() == "0400")
                                {
                                    //第二次握手PLC发送0400信号，表示线体接受订单成功
                                    SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID + ":第二次握手PLC发送0400信号，表示线体接受订单成功！");
                                    short s = 1;
                                    object val;
                                    object quality;
                                    object t;
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 4].Read(s, out val, out quality, out t);
                                    string orderseq = val.ToString();
                                                                       
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 3].Read(s, out val, out quality, out t);
                                    string stationcode = val.ToString();

                                    string linecode = stationcode.Substring(0, 2);
                                    SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID + ":更新订单状态为4生产！");
                                    string sql = string.Format(@"update ERPOrderDetails set Status=4 where OrderSeq=N'{0}' and LineId=N'{1}'", orderseq, int.Parse(linecode).ToString());
                                    SQLHelper.ExcuteSQL(sql);
                                    SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID + ":更新订单状态为4生产，成功！");
                                    //第三次握手，重置PLC握手信号
                                    SystemLogs.InsertPLCLog("Order2PLC", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID + ":重置PLC握手信号，0000！");
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].Write("0000");
                                }
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                SystemLogs.InsertPLCLog("Order2PLC", ex.Message);
            }
        }
        //异步写入成功
        private void AsyncWriteComplete(int TransactionID, int NumItems, ref Array ClientHandles, ref Array Errors)
        {
            //MessageBox.Show("数据写入成功！");
        }
        //异步读取成功
        void AsyncReadComplete(int TransactionID, int NumItems, ref Array ClientHandles, ref Array ItemValues, ref Array Qualities, ref Array TimeStamps, ref Array Errors)
        {
            //MessageBox.Show("读取完成");
            //label11.Text = "连上";
        }
        /// <summary>
        /// 状态显示定时器触发事件
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        private void theout(object sender, EventArgs e)
        {
            tim.Interval = 1500;
            //OPC链接状态
            State = objServer.ServerState.ToString();
            //SetOPCstate(State);
            //OPC与PLC链接状态
            //opcQualityState = opcQualityJudge();
            //changeLightStatus(opcQualityState);
        }

        /// <summary>
        /// 判断OPC与PLC链接状态，返回值1时表示链接，返回值0表示断开。
        /// 依次判断各个OPC项的质量信息，有一个变量质量为0时认为断开。
        /// </summary>
        /// <returns></returns>
        private int opcQualityJudge()
        {
            int[] opcQuality = new int[4];
            for (int i = 1; i < 4; i++)
            {
                opcQuality[i] = objChangeItem[i].Quality;
                if (opcQuality[i] != 192)
                {
                    return 0;
                }
            }
            return 1;
        }

        protected override void OnStop()
        {
            try
            {
                //释放所有组资源
                if (null != objGroup)
                {
                    objGroup.DataChange -= new DIOPCGroupEvent_DataChangeEventHandler(KepGroup_DataChange);
                    objGroup.AsyncWriteComplete -= new DIOPCGroupEvent_AsyncWriteCompleteEventHandler(AsyncWriteComplete);
                    objGroup = null;
                    objServer.OPCGroups.RemoveAll();
                    SystemLogs.InsertPLCLog("Order2PLC", "释放所有组资源！");
                }
                if (null != objServer)
                {
                    objServer.Disconnect();
                    objServer = null;
                    objItems = null;                    
                    GC.Collect();
                    SystemLogs.InsertPLCLog("Order2PLC", "断开连接OPC释放所有组资源！");
                }
            }
            catch (Exception ex)
            {
                SystemLogs.InsertPLCLog("Order2PLC", ex.Message);
            }
        }
    }
}
