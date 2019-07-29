using Helper;
using Microsoft.AspNet.SignalR.Client;
using Newtonsoft.Json;
using OPCAutomation;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.ServiceProcess;
using System.Timers;

namespace SM.MES.StationResault
{
    public partial class ServiceStationResault : ServiceBase
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
        List<int> statinindex = new List<int>();
        List<string> stationtabid = new List<string>();
        List<ItemDB> itemsdb = new List<ItemDB>();

        IHubProxy chatHub;
        int initx = 0;
        //Signalr 链接定时器
        Timer SignalRTimer;
        HubConnection connection;
        public ServiceStationResault()
        {
            InitializeComponent();

        }

        protected override void OnStart(string[] args)
        {
            try
            {
                SignalRTimer = new Timer();
                SignalRTimer.Interval = 1500;
                SignalRTimer.Elapsed += new ElapsedEventHandler(SignalRTimer_Tick);
                SignalRTimer.Enabled = true;

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
                SystemLogs.InsertPLCLog("StationResult", ex.Message);
            }
        }

        private void SignalRTimer_Tick(object sender, EventArgs e)
        {
            SignalRTimer.Interval = 10000;
            try
            {
                if (connection == null || connection.State == Microsoft.AspNet.SignalR.Client.ConnectionState.Disconnected)
                {
                    var url = ConfigurationManager.AppSettings["URL"].ToString(); //"http://10.27.163.14:10086";
                    connection = new HubConnection(url);
                    chatHub = connection.CreateHubProxy("IMHub");
                    connection.Start().ContinueWith(t =>
                    {
                        if (!t.IsFaulted)
                        {
                            //连接成功，调用Register方法
                            chatHub.Invoke("Register", "StationResault");
                        }
                    });



                    //客户端接收实现，可以用js，也可以用后端接收
                    var broadcastHandler = chatHub.On<string, string>("receivePrivateMessage", (name, message) =>
                    {
                        //Console.WriteLine("[{0}]{1}: {2}", DateTime.Now.ToString("HH:mm:ss"), name, message);
                        //DO Somethings
                        Message m = JsonConvert.DeserializeObject<Message>(message);

                        if (m.header == "ack")
                        {
                            SystemLogs.InsertPLCLog("StationResult", "发送ACK握手！站点" + m.Body);
                            string messageX = "{\"msid\":\"\",\"Resault\":\"\",\"RO\":\"ack\",\"ProductionCode\":\"\"}";
                            chatHub.Invoke("SendPrivateMessage", m.Body, messageX).ContinueWith(ts =>
                            {
                                if (ts.IsFaulted)
                                {
                                    SystemLogs.InsertPLCLog("StationResult", "发送ACK握手失败！站点" + m.Body);
                                }
                                else
                                {
                                    SystemLogs.InsertPLCLog("StationResult", "发送ACK握手成功！站点" + m.Body);
                                }
                            });
                        }
                        else if (m.header == "PLC")
                        {
                            try
                            {
                                string info = string.Format(@" select a.*,c.PLCTemplateID,c.PLCUPDBAddress,c.UPDataDesc,b.PLCTrigger+'.'+c.PLCUPDBAddress as PLCDB from StationInfo(nolock) a
                          left join PLCTemplateOperationInfo(nolock) b on a.ID=b.PLCStationId
                          left join PLCTemplateInfoDetail(nolock) c on b.PLCTemplateId=c.PLCTemplateID where a.StationCode=N'{0}' ", m.Body);
                                DataSet dsinfo = Helper.SQLHelper.GetDataSet(info);
                                if (dsinfo != null && dsinfo.Tables[0].Rows.Count > 0)
                                {
                                    DataRow[] dr = dsinfo.Tables[0].Select("PLCUPDBAddress='Station2Code'");
                                    if (dr.Length > 0)
                                    {
                                        ItemDB itms = itemsdb.Find(x => x.DBTabid == dr[0]["PLCDB"].ToString());

                                        #region 获取站点编码
                                        SystemLogs.InsertPLCLog("StationResult", objChangeItem[itms.dbseq].ItemID + ":获取站点编码！");
                                        short s = 1;
                                        object val;
                                        object quality;
                                        object t;
                                        objChangeItem[itms.dbseq].Read(s, out val, out quality, out t);
                                        string stationcode = val.ToString();
                                        #endregion

                                        #region 获取产品SN
                                        SystemLogs.InsertPLCLog("StationResult", objChangeItem[itms.dbseq + 1].ItemID + ":获取产品SN！");
                                        objChangeItem[itms.dbseq + 1].Read(s, out val, out quality, out t);
                                        string ProductionSn = val.ToString();
                                        #endregion

                                        #region 获取产品编码
                                        SystemLogs.InsertPLCLog("StationResult", objChangeItem[itms.dbseq + 4].ItemID + ":获取产品编码！");
                                        objChangeItem[itms.dbseq + 4].Read(s, out val, out quality, out t);
                                        string productioncode = val.ToString();
                                        #endregion
                                        
                                        string messageX = "{\"msid\":\"\",\"Resault\":\"" + ProductionSn + "\",\"RO\":\"ENDSN\",\"ProductionCode\":\"" + productioncode + "\"}";
                                        chatHub.Invoke("SendPrivateMessage", stationcode, messageX).ContinueWith(ts =>
                                        {
                                            if (ts.IsFaulted)
                                            {
                                                SystemLogs.InsertPLCLog("StationResult", "发送产品序列号SN失败！站点" + stationcode + "，产品序号：" + ProductionSn);
                                            }
                                        });
                                    }

                                }
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", ex.Message);
                            }
                        }
                        else if (m.header == "andon")
                        {
                            try
                            {

                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "Andon：" + m.Body + "初始化失败" + ex.Message);
                            }
                        }
                    });
                }
            }
            catch (Exception ex)
            {
                SystemLogs.InsertPLCLog("StationResult", ex.Message);
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
                    string sql = @"select * from StationInfo(nolock) where IsFirstStation<>1 and StationType='PLC' ;
                                select c.ID as DBID , a.ID as SID,a.StationCode,b.PLCTrigger,c.PLCUPDBAddress,1 as Nsn,'' as RO,c.UPDataDesc as opdesc from StationInfo(nolock) a 
                                join PLCTemplateOperationInfo(nolock) b on a.ID=b.PLCStationId
                                join PLCTemplateInfoDetail(nolock) c on b.PLCTemplateId=c.PLCTemplateId 
                                where a.IsFirstStation<>1 and a.StationType='PLC'
                                union 
                                select c.PLCUPId as DBID , a.ID as SID,a.StationCode,b.PLCTrigger,c.PLCUPDBAddress,2 as Nsn,'UP' as RO,c.UPDataDesc as opdesc  from StationInfo(nolock) a 
                                join PLCTemplateOperationInfo(nolock) b on a.ID=b.PLCStationId
                                join PLCUPInfo(nolock) c on a.ID=c.PLCStationId 
                                where a.IsFirstStation<>1 and a.StationType='PLC'
                                union 
                                select c.PLCAPId as DBID ,a.ID as SID,a.StationCode,b.PLCTrigger,c.PLCAPDBAddress PLCUPDBAddress,3 as Nsn,'AP' as RO,c.APDataDesc as opdesc  from StationInfo(nolock) a 
                                join PLCTemplateOperationInfo(nolock) b on a.ID=b.PLCStationId
                                join PLCAPInfo(nolock) c on a.ID=c.PLCStationId 
                                where a.IsFirstStation<>1 and a.StationType='PLC'
                                order by SID,Nsn,PLCUPDBAddress";
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
                        SystemLogs.InsertPLCLog("StationResult", "获取站点PLC模板失败！请确认配置！");
                    }
                    else
                    {
                        scount = dsstation.Tables[0].Rows.Count;
                        dcount = dsstation.Tables[1].Rows.Count;
                        int count = dsstation.Tables[1].Rows.Count + 1;
                        tmpIDs = new string[count];
                        int[] tmpCHandles = new int[count];
                        objChangeItem = new OPCItem[count];

                        for (int i = 1; i < count; i++)
                        {
                            tmpCHandles[i] = i;
                            tmpIDs[i] = dsstation.Tables[1].Rows[i - 1]["PLCTrigger"].ToString() + "." + dsstation.Tables[1].Rows[i - 1]["PLCUPDBAddress"].ToString();

                            #region 保存站点和PLCDB关系
                            ItemDB it = new ItemDB();
                            it.dbseq = i;
                            it.DBTabid = dsstation.Tables[1].Rows[i - 1]["PLCTrigger"].ToString() + "." + dsstation.Tables[1].Rows[i - 1]["PLCUPDBAddress"].ToString();
                            it.stationcode = dsstation.Tables[1].Rows[i - 1]["StationCode"].ToString();
                            it.RO = dsstation.Tables[1].Rows[i - 1]["RO"].ToString();
                            it.opdesc = dsstation.Tables[1].Rows[i - 1]["opdesc"].ToString();
                            it.DBid = dsstation.Tables[1].Rows[i - 1]["DBID"].ToString();
                            itemsdb.Add(it);
                            #endregion

                            if (dsstation.Tables[1].Rows[i - 1]["PLCUPDBAddress"].ToString() == "Station0Init")
                            {
                                statinindex.Add(i);
                            }
                        }

                        strItemIDs = (Array)tmpIDs;//必须转成Array型，否则不能调用AddItems方法
                        lClientHandles = (Array)tmpCHandles;
                        // 添加opc标签
                        SystemLogs.InsertPLCLog("StationResult", "添加监控标签！");
                        objItems.AddItems(count - 1, ref strItemIDs, ref lClientHandles, out lserverhandles, out lErrors, RequestedDataTypes, AccessPaths);
                        for (int i = 1; i < count; i++)
                        {
                            objChangeItem[i] = objItems.GetOPCItem(Convert.ToInt32(lserverhandles.GetValue(i)));
                        }
                        //初始化站点编码
                        for (int i = 1; i < count; i++)
                        {
                            if (statinindex.IndexOf(i) >= 0)
                            {
                                SystemLogs.InsertPLCLog("StationResult", dsstation.Tables[1].Rows[i - 1]["PLCTrigger"].ToString() + "初始化站点编码：" + dsstation.Tables[1].Rows[i - 1]["StationCode"].ToString());
                                objChangeItem[i + 2].Write(dsstation.Tables[1].Rows[i - 1]["StationCode"].ToString());
                            }
                        }
                        //SystemLogs.InsertPLCLog("StationResult", "添加监控标签！");
                    }
                    #endregion
                }
            }
            catch (Exception ex)
            {
                objServer.Disconnect();
                SystemLogs.InsertPLCLog("StationResult", ex.Message);
            }
        }
        //每当项数据有变化时执行的事件,采用订阅方式
        void KepGroup_DataChange(int TransactionID, int NumItems, ref Array ClientHandles, ref Array ItemValues, ref Array Qualities, ref Array TimeStamps)
        {
            try
            {
                //为了测试，所以加了控制台的输出，来查看事物ID号
                //Console.WriteLine("********"+TransactionID.ToString()+"*********");
                if (NumItems < 7)
                {
                    for (int i = 0; i < NumItems; i++)
                    {
                        #region PLC 发送0100 进行握手                        
                        if (objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID.IndexOf("Station0Init") > 0)
                        {
                            try
                            {
                                if (ItemValues.GetValue(i + 1).ToString() == "0100")
                                {
                                    SystemLogs.InsertPLCLog("StationResult", "PLC 发送0100 进行握手");
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].Write("0200");
                                    SystemLogs.InsertPLCLog("StationResult", "MES 发送0200 进行反馈");
                                    SystemLogs.InsertPLCLog("StationResult", "产品进站追踪！");
                                    #region 产品追踪
                                    #region 获取站点编码
                                    string stationcode = "";
                                    try
                                    {
                                        SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 2].ItemID + ":获取站点编码！");
                                        short s = 1;
                                        object val;
                                        object quality;
                                        object t;
                                        objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 2].Read(s, out val, out quality, out t);
                                        stationcode = val.ToString();
                                        SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 2].ItemID + ":获取站点编码成功！" + stationcode);
                                    }
                                    catch (Exception ex)
                                    {
                                        SystemLogs.InsertPLCLog("StationResult", "获取站点编码失败！" + ex.Message);
                                    }
                                    #endregion
                                    #region 获取站点当前生产产品序列号
                                    string ProductionSn = "";
                                    try
                                    {
                                        SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) +3].ItemID + ":获取站点当前生产产品序列号！");
                                        short s = 1;
                                        object val;
                                        object quality;
                                        object t;
                                        objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) +3].Read(s, out val, out quality, out t);
                                        ProductionSn = val.ToString();
                                        SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) +3].ItemID + ":获取站点当前生产产品序列号成功！" + ProductionSn);

                                    }
                                    catch (Exception ex)
                                    {
                                        SystemLogs.InsertPLCLog("StationResult", "获取站点当前生产产品序列号失败！" + ex.Message);
                                    }
                                    #endregion
                                    SystemLogs.InsertPLCLog("StationResult", "通知站点监控界面：" + ProductionSn + ";写成品生成实绩成功！");
                                    string message = "{\"msid\":\"\",\"Resault\":\"" + ProductionSn + "\",\"RO\":\"ENDSN\",\"ProductionCode\":\"" + "" + "\"}";
                                    chatHub.Invoke("SendPrivateMessage", stationcode, message).ContinueWith(ts =>
                                    {
                                        if (ts.IsFaulted)
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "发送产品序列号SN失败！站点" + stationcode + "，产品序号：" + ProductionSn);
                                        }
                                        else
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "发送产品序列号SN成功！站点" + stationcode + "，产品序号：" + ProductionSn);
                                        }
                                    });
                                    #endregion
                                }
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "PLC进行握手失败！" + ex.Message);
                            }

                        }
                        #endregion

                        #region 行为代码CO，MES生成产品实绩
                        if (objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID.IndexOf("Station4RO") > 0
                            && ItemValues.GetValue(i + 1).ToString() == "CO")
                        {
                            try
                            {
                                #region 获取握手信号0200
                                string station0init = "";
                                try
                                {
                                    SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + ":获取握手信号0200！");
                                    short s = 1;
                                    object val;
                                    object quality;
                                    object t;
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].Read(s, out val, out quality, out t);
                                    station0init = val.ToString();
                                    SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + ":获取握手信号0200成功！");
                                }
                                catch (Exception ex)
                                {
                                    SystemLogs.InsertPLCLog("StationResult", "获取握手信号0200失败！" + ex.Message);
                                }
                                #endregion

                                #region 获取站点编码
                                string stationcode = "";
                                try
                                {
                                    SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].ItemID + ":获取站点编码！");
                                    short s = 1;
                                    object val;
                                    object quality;
                                    object t;
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].Read(s, out val, out quality, out t);
                                    stationcode = val.ToString();
                                    SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].ItemID + ":获取站点编码成功！" + stationcode);
                                }
                                catch (Exception ex)
                                {
                                    SystemLogs.InsertPLCLog("StationResult", "获取站点编码失败！" + ex.Message);
                                }
                                #endregion

                                #region 获取站点当前生产产品序列号
                                string ProductionSn = "";
                                try
                                {
                                    SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].ItemID + ":获取站点当前生产产品序列号！");
                                    short s = 1;
                                    object val;
                                    object quality;
                                    object t;
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].Read(s, out val, out quality, out t);
                                    ProductionSn = val.ToString();
                                    SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].ItemID + ":获取站点当前生产产品序列号成功！" + ProductionSn);
                                }
                                catch (Exception ex)
                                {
                                    SystemLogs.InsertPLCLog("StationResult", "获取站点当前生产产品序列号失败！" + ex.Message);
                                }
                                #endregion

                                #region 获取产品订单
                                string orderno = "";
                                try
                                {
                                    SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 3].ItemID + ":获取产品订单！");
                                    short s = 1;
                                    object val;
                                    object quality;
                                    object t;
                                    objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 3].Read(s, out val, out quality, out t);
                                    orderno = val.ToString();
                                    SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) + 3].ItemID + ":获取产品订单成功！" + orderno);
                                }
                                catch (Exception ex)
                                {
                                    SystemLogs.InsertPLCLog("StationResult", "获取产品订单失败！" + ex.Message);
                                }
                                #endregion

                                #region 获取站点，产品，订单信息
                                SystemLogs.InsertPLCLog("StationResult", "获取站点，产品，订单信息");
                                string info = string.Format(@"select * from StationInfo(nolock) where StationCode=N'{0}';
                                
                                select a.*,b.ID as ProductionId,b.ProductionSheet from ERPOrderDetails(nolock) a 
                                    join ProductionInfo(nolock) b on a.ProductionCode=b.ProductionId 
                                    where OrderSeq=N'{1}' AND a.Status IN(3,4);", stationcode, orderno);
                                DataSet dsinfo = Helper.SQLHelper.GetDataSet(info);
                                SystemLogs.InsertPLCLog("StationResult", "获取站点，产品，订单信息成功");
                                #endregion

                                #region PLC发送行为代码CO，生成产品实绩
                                try
                                {
                                    if (ItemValues.GetValue(i + 1).ToString() == "CO" && station0init == "0200")
                                    {
                                        try
                                        {
                                            #region 根据产品SN查询判断是否有成品记录
                                            SystemLogs.InsertPLCLog("StationResult", "根据产品SN查询判断是否有成品记录" + ProductionSn);
                                            string sqlsn = string.Format(@"select * from EndProduct(nolock) where EndProductSN=N'{0}'", ProductionSn);
                                            DataSet dssn = SQLHelper.GetDataSet(sqlsn);
                                            SystemLogs.InsertPLCLog("StationResult", "根据产品SN查询判断是否有成品记录结束" + ProductionSn);
                                            string endid = "0";
                                            if (dssn != null && dssn.Tables[0].Rows.Count == 0)
                                            {
                                                SystemLogs.InsertPLCLog("StationResult", "未有成品记录：" + ProductionSn + ";写成品生成实绩！");

                                                string sql = string.Format(@"insert into EndProduct(ERPID,ERPDetailId,EndProductSN,ProductionId,ProductionCode,ProductionName,ProductionSheet,ERPDetailCode,DetailOrderSN,UpdateTime,Status) 
                                        values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}',N'{6}',N'{7}',N'{8}',getdate(),N'1');select SCOPE_IDENTITY();",
                                                    dsinfo.Tables[1].Rows[0]["ERPID"].ToString(), dsinfo.Tables[1].Rows[0]["ID"].ToString(), ProductionSn,
                                                    dsinfo.Tables[1].Rows[0]["ProductionId"].ToString(), dsinfo.Tables[1].Rows[0]["ProductionCode"].ToString(),
                                                    dsinfo.Tables[1].Rows[0]["ProductionName"].ToString(), dsinfo.Tables[1].Rows[0]["ProductionSheet"].ToString(),
                                                    dsinfo.Tables[1].Rows[0]["ERPDetailCode"].ToString(), dsinfo.Tables[1].Rows[0]["OrderSeq"].ToString());
                                                object o = SQLHelper.GetObject(sql);
                                                endid = o.ToString();
                                                SystemLogs.InsertPLCLog("StationResult", "未有成品记录：" + ProductionSn + ";写成品生成实绩成功！");

                                                SystemLogs.InsertPLCLog("StationResult", "通知站点监控界面：" + ProductionSn + ";写成品生成实绩成功！");
                                                string message = "{\"msid\":\"\",\"Resault\":\"" + ProductionSn + "\",\"RO\":\"ENDSN\",\"ProductionCode\":\"" + dsinfo.Tables[1].Rows[0]["ProductionCode"].ToString() + "\"}";
                                                chatHub.Invoke("SendPrivateMessage", stationcode, message).ContinueWith(ts =>
                                                {
                                                    if (ts.IsFaulted)
                                                    {
                                                        SystemLogs.InsertPLCLog("StationResult", "发送产品序列号SN失败！站点" + stationcode + "，产品序号：" + ProductionSn);
                                                    }
                                                    else
                                                    {
                                                        SystemLogs.InsertPLCLog("StationResult", "发送产品序列号SN成功！站点" + stationcode + "，产品序号：" + ProductionSn);
                                                    }
                                                });
                                            }
                                            else
                                            {
                                                SystemLogs.InsertPLCLog("StationResult", "存在产品实绩记录！" + ProductionSn);
                                                endid = dssn.Tables[0].Rows[0]["ID"].ToString();
                                            }
                                            #endregion
                                        }
                                        catch (Exception ex)
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "产品实绩记录失败！" + ex.Message);
                                        }


                                        #region  写实绩完成，发送0300握手信号，结束
                                        try
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + "MES 发送0300握手信号反馈");
                                            objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].Write("0300");
                                            SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + "MES 发送0300握手信号反馈成功");
                                        }
                                        catch (Exception ex)
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + "MES 发送0300握手信号反馈失败");
                                        }
                                        #endregion

                                    }
                                }
                                catch (Exception ex)
                                {

                                }
                                #endregion

                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "行为代码CO，MES生成产品实绩失败！" + ex.Message);
                            }

                        }
                        #endregion

                        #region AP-PLC追溯实绩
                        if (objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID.IndexOf("Station4RO") > 0
                            && ItemValues.GetValue(i + 1).ToString() == "AP")
                        {
                            #region 获取握手信号0200
                            string station0init = "";
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + ":获取握手信号0200！");
                                short s = 1;
                                object val;
                                object quality;
                                object t;
                                objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].Read(s, out val, out quality, out t);
                                station0init = val.ToString();
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + ":获取握手信号0200成功！");
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "获取握手信号0200失败！" + ex.Message);
                            }
                            #endregion

                            #region 获取站点编码
                            string stationcode = "";
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].ItemID + ":获取站点编码！");
                                short s = 1;
                                object val;
                                object quality;
                                object t;
                                objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].Read(s, out val, out quality, out t);
                                stationcode = val.ToString();
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].ItemID + ":获取站点编码成功！" + stationcode);
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "获取站点编码失败！" + ex.Message);
                            }
                            #endregion

                            #region 获取站点当前生产产品序列号
                            string ProductionSn = "";
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].ItemID + ":获取站点当前生产产品序列号！");
                                short s = 1;
                                object val;
                                object quality;
                                object t;
                                objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].Read(s, out val, out quality, out t);
                                ProductionSn = val.ToString();
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].ItemID + ":获取站点当前生产产品序列号成功！" + ProductionSn);
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "获取站点当前生产产品序列号失败！" + ex.Message);
                            }
                            #endregion

                            #region 获取站点，产品，订单信息
                            SystemLogs.InsertPLCLog("StationResult", "获取站点，产品，订单信息");
                            string info = string.Format(@"select * from StationInfo(nolock) where StationCode=N'{0}';                                
                                select a.*,b.ID as ProductionId,b.ProductionSheet,c.ID as endid  from ERPOrderDetails(nolock) a 
                                    join ProductionInfo(nolock) b on a.ProductionCode=b.ProductionId 
									join EndProduct(nolock) c on b.ID=c.ProductionId and a.ProductionCode=c.ProductionCode and a.ERPDetailCode=c.ERPDetailCode
                                    where c.EndProductSN=N'{1}' AND a.Status IN(3,4);",
                                stationcode, ProductionSn);
                            DataSet dsinfo = Helper.SQLHelper.GetDataSet(info);
                            SystemLogs.InsertPLCLog("StationResult", "获取站点，产品，订单信息成功");
                            #endregion

                            #region 如果产品存在过站记录，那么插入产品过站记录
                            string endid = "0";
                            string transistid = "0";
                            try
                            {
                                #region 根据产品SN查询判断是否有成品记录
                                SystemLogs.InsertPLCLog("StationResult", "根据产品SN查询判断是否有成品记录");
                                string sqlsn = string.Format(@"select * from EndProduct(nolock) where EndProductSN=N'{0}'", ProductionSn);
                                DataSet dssn = SQLHelper.GetDataSet(sqlsn);

                                if (dssn != null && dssn.Tables[0].Rows.Count >= 0)
                                {
                                    endid = dssn.Tables[0].Rows[0]["ID"].ToString();
                                }
                                SystemLogs.InsertPLCLog("StationResult", "根据产品SN查询判断是否有成品记录成功");
                                #endregion
                                DataSet ds = LogicStationResult.GetTransit(endid, stationcode);
                                if (ds != null && ds.Tables[0].Rows.Count == 0)
                                {
                                    #region 写数据库过站实绩
                                    SystemLogs.InsertPLCLog("StationResult", "写数据库过站实绩");
                                    string sqlTransit = string.Format(@"insert into ProductTransitInfo(ProductId,ProductCode,StationName,StationDesc,StationType,TransitTime,StationId,StationCode) 
                                                                    values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',GETDATE(),N'{5}',N'{6}');select SCOPE_IDENTITY();",
                                                                        endid, dsinfo.Tables[1].Rows[0]["ProductionCode"].ToString(), dsinfo.Tables[0].Rows[0]["StationName"].ToString(),
                                                                        dsinfo.Tables[0].Rows[0]["StationDesc"].ToString(),
                                                                        dsinfo.Tables[0].Rows[0]["StationType"].ToString(),
                                                                        dsinfo.Tables[0].Rows[0]["ID"].ToString(),
                                                                        dsinfo.Tables[0].Rows[0]["StationCode"].ToString());
                                    transistid = SQLHelper.GetObject(sqlTransit).ToString();
                                    SystemLogs.InsertPLCLog("StationResult", "写数据库过站实绩成功");
                                    #endregion
                                }
                                else if (ds != null && ds.Tables[0].Rows.Count > 0)
                                {
                                    transistid = ds.Tables[0].Rows[0]["ID"].ToString();
                                    #region 写数据库扣料实绩，根据扣料配置进行扣料
                                    //1获取站点所有的扣料零件
                                    SystemLogs.InsertPLCLog("StationResult", "获取站点所有的扣料零件");
                                    string sqlMs = string.Format(@"select a.*,b.ID AS WSID,b.WarehouseId,isnull(b.MTotal,0) as MTotal,isnull(c.UseCount,0) as UseCount ,d.BoxTotalNo
                                                from MaterialCallPoint(nolock) a 
                                                left join Material_W_S(nolock) b on a.StoreId=b.StoreId and a.MaterialId=b.MaterialId
                                                left join PBOM(nolock) c on a.MaterialId=c.MaterialId
                                                left join MaterialData(nolock) d on a.MaterialId=d.ID
                                                where a.StationId=N'{0}'", dsinfo.Tables[0].Rows[0]["ID"].ToString());
                                    DataSet dsms = SQLHelper.GetDataSet(sqlMs);
                                    SystemLogs.InsertPLCLog("StationResult", "获取站点所有的扣料零件成功");
                                    // 2更新线边库存，叫料需求通知
                                    if (dsms != null && dsms.Tables[0].Rows.Count > 0)
                                    {
                                        string sqlupdatems = "";
                                        string sqlnotice = "";
                                        for (int m = 0; m < dsms.Tables[0].Rows.Count; m++)
                                        {
                                            string number = "0";
                                            if (dsms.Tables[0].Rows[0]["CallType"].ToString() == "固定数量")
                                            {
                                                number = dsms.Tables[0].Rows[m]["DeductionCountor"].ToString();
                                            }
                                            else
                                            {
                                                number = dsms.Tables[0].Rows[m]["UseCount"].ToString();
                                            }
                                            sqlupdatems += string.Format(@"update Material_W_S set MTotal=MTotal-{0} where ID={1};", number, dsms.Tables[0].Rows[m]["WSID"].ToString());
                                            if ((Convert.ToInt32(dsms.Tables[0].Rows[m]["MTotal"].ToString()) - Convert.ToInt32(number)) < Convert.ToInt32(dsms.Tables[0].Rows[m]["SaveNumber"].ToString()))
                                            {
                                                sqlnotice += string.Format(@"insert into CallList(MaterialCallPointId,CallCount,CallTime,CallStatus) values(N'{0}',N'{1}',GETDATE(),N'触发');
                                                                  set @a= SCOPE_IDENTITY();
                                                                  update [CallList] set CallCode='FANUC-C-'+ right('00000'+cast(@a as varchar),5) where ID=@a;",
                                                                      dsms.Tables[0].Rows[m]["ID"].ToString(),
                                                                      dsms.Tables[0].Rows[m]["BoxTotalNo"].ToString());
                                            }
                                        }
                                        if (sqlupdatems != "") SQLHelper.ExcuteSQL(sqlupdatems);
                                        SystemLogs.InsertPLCLog("StationResult", "2更新线边库存");
                                        //3叫料需求通知单生成
                                        if (sqlnotice != "") SQLHelper.ExcuteSQL("declare @a int;" + sqlnotice);
                                        SystemLogs.InsertPLCLog("StationResult", "3叫料需求通知单生成");
                                    }
                                    #endregion

                                    #region 写数据库刀具消耗实绩，当超过换刀次数的时候，通过signalR发送通知给用户
                                    SystemLogs.InsertPLCLog("StationResult", "刀具消耗开始");
                                    string sqlupdatecuttor = string.Format(@"update CuttorInfo set UsedTime=UsedTime+SingleTime where StationId=N'{0}' ",
                                        dsinfo.Tables[0].Rows[0]["ID"].ToString());
                                    SQLHelper.ExcuteSQL(sqlupdatecuttor);
                                    SystemLogs.InsertPLCLog("StationResult", "刀具消耗结束");

                                    SystemLogs.InsertPLCLog("StationResult", "获取当前站点刀具信息");
                                    string sqlcuttor = string.Format(@"select * from CuttorInfo(nolock) where StationId=N'{0}'",
                                        dsinfo.Tables[0].Rows[0]["ID"].ToString());
                                    DataSet dscuttor = SQLHelper.GetDataSet(sqlcuttor);
                                    SystemLogs.InsertPLCLog("StationResult", "获取当前站点刀具信息结束");

                                    if (dscuttor != null && dscuttor.Tables[0].Rows.Count > 0)
                                    {
                                        SystemLogs.InsertPLCLog("StationResult", "开始插入换刀提醒");
                                        string sqlnotice = "";
                                        for (int c = 0; c < dscuttor.Tables[0].Rows.Count; c++)
                                        {
                                            if (int.Parse(dscuttor.Tables[0].Rows[c]["UsedTime"].ToString()) >= int.Parse(dscuttor.Tables[0].Rows[c]["AlarmTime"].ToString()))
                                            {
                                                sqlnotice += string.Format(@"insert into Notices(Message,StationId) values(N'{0}',N'{1}');",
                                                    "刀具：" + dscuttor.Tables[0].Rows[c]["CutterCode"].ToString() + "，达到了使用提醒阈值，请注意更换刀具！", dsinfo.Tables[0].Rows[0]["ID"].ToString());
                                            }
                                        }
                                        if (sqlnotice != "") SQLHelper.ExcuteSQL(sqlnotice);
                                        SystemLogs.InsertPLCLog("StationResult", "开始插入换刀提醒结束");
                                    }
                                    #endregion

                                    #region 生产结束计算实绩
                                    SystemLogs.InsertPLCLog("StationResult", "末站点过站更新产品实绩！");
                                    if (dsinfo.Tables[0].Rows[0]["IsFirstStation"].ToString() == "3")
                                    {
                                        var qcount = SQLHelper.GetObject(string.Format(@"select count(1) as qcount from ProductTransitInfo(nolock) where QualityStatus='NOK' and ProductCode=N'{0}'", ProductionSn)).ToString();
                                        if (int.Parse(qcount) > 0)
                                        {
                                            SQLHelper.ExcuteSQL(string.Format(@"update EndProduct set QualityStatus='NOK' ,Status='2',EndTime=GETDATE() where EndProductSN=N'{0}'", ProductionSn));
                                        }
                                        else
                                        {
                                            SQLHelper.ExcuteSQL(string.Format(@"update EndProduct set QualityStatus='OK',Status='2',EndTime=GETDATE() where EndProductSN=N'{0}'", ProductionSn));
                                        }

                                        string sql = string.Format(@"UPDATE ERPOrderDetails SET ActureCount =ActureCount+1,EndDate=GETDATE(),UpdateTime5=GETDATE() WHERE ID=N'{0}'", dsinfo.Tables[1].Rows[0]["ID"].ToString());
                                        SQLHelper.ExcuteSQL(sql);
                                        SystemLogs.InsertPLCLog("StationResult", "最后站点过站订单生产产品数+1!订单ID：" + dsinfo.Tables[1].Rows[0]["ID"].ToString());
                                    }
                                    #endregion
                                }
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "写数据库过站实绩失败!" + ex.Message);
                            }
                            #endregion

                            #region AP追溯
                            try
                            {
                                List<ItemDB> liitms = itemsdb.FindAll(t => t.stationcode == stationcode && t.RO == "AP");
                                if (liitms.Count > 0)
                                {
                                    string sqlap = "";
                                    foreach (ItemDB item in liitms)
                                    {
                                        try
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "站点：" + stationcode + "-AP标签：" + item.DBTabid + ":获取AP信息！");
                                            // 获取站点当前生产产品序列号
                                            short s = 1;
                                            object val;
                                            object quality;
                                            object t;
                                            SystemLogs.InsertPLCLog("StationResult", objChangeItem[item.dbseq].ItemID + ":获取站点当前生产产品序列号！");
                                            objChangeItem[item.dbseq].Read(s, out val, out quality, out t);
                                            string PSn = val.ToString();

                                            //DataSet dsap = SQLHelper.GetDataSet(string.Format(@"select a.* from PLCUPInfo(nolock) a join StationInfo(nolock) b on a.PLCStationId=b.ID  where PLCUPDBAddress=N'{1}' and b.StationCode=N'{0}';", item.DBid, stationcode));

                                            //写数据库实绩
                                            sqlap += string.Format(@"insert into ProductTraceabilityInfo(ProductId,ProductCode,StationName,ItemID,ParkSn,TransitTime,StationId)
                                        values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',GETDATE(),N'{5}');", dsinfo.Tables[1].Rows[0]["endid"].ToString(), ProductionSn,
                                                dsinfo.Tables[0].Rows[0]["StationName"].ToString(), item.DBid, PSn, dsinfo.Tables[0].Rows[0]["ID"].ToString());

                                        }
                                        catch (Exception ex)
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "站点：" + stationcode + "-AP标签：" + item.DBTabid + ":获取AP信息失败！" + ex.Message);
                                        }
                                    }
                                    if (sqlap != "") SQLHelper.ExcuteSQL(sqlap);
                                    SystemLogs.InsertPLCLog("StationResult", "AP追溯实绩成功");
                                    //发送结果到站点监控界面
                                    string message = "{\"msid\":\"\",\"Resault\":\"" + ProductionSn + "\",\"RO\":\"ENDSN\",\"ProductionCode\":\"" + dsinfo.Tables[1].Rows[0]["ProductionCode"].ToString() + "\"}";
                                    //string message = "{\"msid\":\"" + dsinfo.Tables[2].Rows[0]["PLCUPId"].ToString() + "\",\"Resault\":\"" + ProductionSn + "\",\"RO\":\"UP\"}";
                                    chatHub.Invoke("SendPrivateMessage", stationcode, message).ContinueWith(ts =>
                                    {
                                        if (ts.IsFaulted)
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "发送产品追溯实绩失败！站点" + stationcode + "，产品序列号：" + ProductionSn);
                                        }
                                        else
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "发送产品追溯实绩成功！站点" + stationcode + "，产品序列号：" + ProductionSn);
                                        }
                                    });
                                }
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "产品追溯实绩AP失败！" + ex.Message);
                            }
                            #endregion

                            #region 过站状态 更新过站时间和状态
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", "更新产品追溯实绩AP过站时间！");
                                string sqlupdatetransit = string.Format(@"update ProductTransitInfo set TransitTime=getdate() where ID=N'{0}'", transistid);
                                SQLHelper.ExcuteSQL(sqlupdatetransit);
                                SystemLogs.InsertPLCLog("StationResult", "更新产品追溯实绩AP过站时间完成！");                               
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "更新产品追溯实绩AP过站时间失败！" + ex.Message);
                            }
                            #endregion

                            #region  写实绩完成，发送0300握手信号，结束
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + "MES 发送0300握手信号反馈");
                                objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].Write("0300");
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + "MES 发送0300握手信号反馈成功");
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + "MES 发送0300握手信号反馈失败!" + ex.Message);
                            }
                            #endregion
                        }
                        #endregion

                        #region UP-PLC制造过程实绩
                        if (objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID.IndexOf("Station4RO") > 0
                            && ItemValues.GetValue(i + 1).ToString() == "UP")
                        {

                            #region 获取握手信号0200
                            string station0init = "";
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + ":获取握手信号0200！");
                                short s = 1;
                                object val;
                                object quality;
                                object t;
                                objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].Read(s, out val, out quality, out t);
                                station0init = val.ToString();
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + ":获取握手信号0200成功！");
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "获取握手信号0200失败！" + ex.Message);
                            }
                            #endregion

                            #region 获取站点编码
                            string stationcode = "";
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].ItemID + ":获取站点编码！");
                                short s = 1;
                                object val;
                                object quality;
                                object t;
                                objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].Read(s, out val, out quality, out t);
                                stationcode = val.ToString();
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].ItemID + ":获取站点编码成功！" + stationcode);
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "获取站点编码失败！" + ex.Message);
                            }
                            #endregion

                            #region 获取站点当前生产产品序列号
                            string ProductionSn = "";
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].ItemID + ":获取站点当前生产产品序列号！");
                                short s = 1;
                                object val;
                                object quality;
                                object t;
                                objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].Read(s, out val, out quality, out t);
                                ProductionSn = val.ToString();
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].ItemID + ":获取站点当前生产产品序列号成功！" + ProductionSn);
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "获取站点当前生产产品序列号失败！" + ex.Message);
                            }
                            #endregion

                            #region 获取站点，产品，订单信息
                            SystemLogs.InsertPLCLog("StationResult", "获取站点，产品，订单信息");
                            string info = string.Format(@"select * from StationInfo(nolock) where StationCode=N'{0}';                                
                                select a.*,b.ID as ProductionId,b.ProductionSheet,c.ID as endid  from ERPOrderDetails(nolock) a 
                                    join ProductionInfo(nolock) b on a.ProductionCode=b.ProductionId 
									join EndProduct(nolock) c on b.ID=c.ProductionId and a.ProductionCode=c.ProductionCode and a.ERPDetailCode=c.ERPDetailCode
                                    where c.EndProductSN=N'{1}' AND a.Status IN(3,4);",
                                stationcode, ProductionSn);
                            DataSet dsinfo = Helper.SQLHelper.GetDataSet(info);
                            SystemLogs.InsertPLCLog("StationResult", "获取站点，产品，订单信息成功");
                            #endregion

                            #region 如果产品存在过站记录，那么插入产品过站记录
                            string endid = "0";
                            string transistid = "0";
                            try
                            {
                                #region 根据产品SN查询判断是否有成品记录
                                SystemLogs.InsertPLCLog("StationResult", "根据产品SN查询判断是否有成品记录");
                                string sqlsn = string.Format(@"select * from EndProduct(nolock) where EndProductSN=N'{0}'", ProductionSn);
                                DataSet dssn = SQLHelper.GetDataSet(sqlsn);

                                if (dssn != null && dssn.Tables[0].Rows.Count >= 0)
                                {
                                    endid = dssn.Tables[0].Rows[0]["ID"].ToString();
                                }
                                SystemLogs.InsertPLCLog("StationResult", "根据产品SN查询判断是否有成品记录成功");
                                #endregion
                                DataSet ds = LogicStationResult.GetTransit(endid, stationcode);
                                if (ds != null && ds.Tables[0].Rows.Count == 0)
                                {
                                    #region 写数据库过站实绩
                                    SystemLogs.InsertPLCLog("StationResult", "写数据库过站实绩");
                                    string sqlTransit = string.Format(@"insert into ProductTransitInfo(ProductId,ProductCode,StationName,StationDesc,StationType,TransitTime,StationId,StationCode) 
                                                                    values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',GETDATE(),N'{5}',N'{6}');select SCOPE_IDENTITY();",
                                                                        endid, dsinfo.Tables[1].Rows[0]["ProductionCode"].ToString(), dsinfo.Tables[0].Rows[0]["StationName"].ToString(),
                                                                        dsinfo.Tables[0].Rows[0]["StationDesc"].ToString(),
                                                                        dsinfo.Tables[0].Rows[0]["StationType"].ToString(),
                                                                        dsinfo.Tables[0].Rows[0]["ID"].ToString(),
                                                                        dsinfo.Tables[0].Rows[0]["StationCode"].ToString());
                                    transistid = SQLHelper.GetObject(sqlTransit).ToString();
                                    SystemLogs.InsertPLCLog("StationResult", "写数据库过站实绩成功");
                                    #endregion
                                }
                                else if (ds != null && ds.Tables[0].Rows.Count > 0)
                                {
                                    transistid = ds.Tables[0].Rows[0]["ID"].ToString();
                                    #region 写数据库扣料实绩，根据扣料配置进行扣料
                                    //1获取站点所有的扣料零件
                                    SystemLogs.InsertPLCLog("StationResult", "获取站点所有的扣料零件");
                                    string sqlMs = string.Format(@"select a.*,b.ID AS WSID,b.WarehouseId,isnull(b.MTotal,0) as MTotal,isnull(c.UseCount,0) as UseCount ,d.BoxTotalNo
                                                from MaterialCallPoint(nolock) a 
                                                left join Material_W_S(nolock) b on a.StoreId=b.StoreId and a.MaterialId=b.MaterialId
                                                left join PBOM(nolock) c on a.MaterialId=c.MaterialId
                                                left join MaterialData(nolock) d on a.MaterialId=d.ID
                                                where a.StationId=N'{0}'", dsinfo.Tables[0].Rows[0]["ID"].ToString());
                                    DataSet dsms = SQLHelper.GetDataSet(sqlMs);
                                    SystemLogs.InsertPLCLog("StationResult", "获取站点所有的扣料零件成功");
                                    // 2更新线边库存，叫料需求通知
                                    if (dsms != null && dsms.Tables[0].Rows.Count > 0)
                                    {
                                        string sqlupdatems = "";
                                        string sqlnotice = "";
                                        for (int m = 0; m < dsms.Tables[0].Rows.Count; m++)
                                        {
                                            string number = "0";
                                            if (dsms.Tables[0].Rows[0]["CallType"].ToString() == "固定数量")
                                            {
                                                number = dsms.Tables[0].Rows[m]["DeductionCountor"].ToString();
                                            }
                                            else
                                            {
                                                number = dsms.Tables[0].Rows[m]["UseCount"].ToString();
                                            }
                                            sqlupdatems += string.Format(@"update Material_W_S set MTotal=MTotal-{0} where ID={1};", number, dsms.Tables[0].Rows[m]["WSID"].ToString());
                                            if ((Convert.ToInt32(dsms.Tables[0].Rows[m]["MTotal"].ToString()) - Convert.ToInt32(number)) < Convert.ToInt32(dsms.Tables[0].Rows[m]["SaveNumber"].ToString()))
                                            {
                                                sqlnotice += string.Format(@"insert into CallList(MaterialCallPointId,CallCount,CallTime,CallStatus) values(N'{0}',N'{1}',GETDATE(),N'触发');
                                                                  set @a= SCOPE_IDENTITY();
                                                                  update [CallList] set CallCode='FANUC-C-'+ right('00000'+cast(@a as varchar),5) where ID=@a;",
                                                                      dsms.Tables[0].Rows[m]["ID"].ToString(),
                                                                      dsms.Tables[0].Rows[m]["BoxTotalNo"].ToString());
                                            }
                                        }
                                        if (sqlupdatems != "") SQLHelper.ExcuteSQL(sqlupdatems);
                                        SystemLogs.InsertPLCLog("StationResult", "2更新线边库存");
                                        //3叫料需求通知单生成
                                        if (sqlnotice != "") SQLHelper.ExcuteSQL("declare @a int;" + sqlnotice);
                                        SystemLogs.InsertPLCLog("StationResult", "3叫料需求通知单生成");
                                    }
                                    #endregion

                                    #region 写数据库刀具消耗实绩，当超过换刀次数的时候，通过signalR发送通知给用户
                                    SystemLogs.InsertPLCLog("StationResult", "刀具消耗开始");
                                    string sqlupdatecuttor = string.Format(@"update CuttorInfo set UsedTime=UsedTime+SingleTime where StationId=N'{0}' ",
                                        dsinfo.Tables[0].Rows[0]["ID"].ToString());
                                    SQLHelper.ExcuteSQL(sqlupdatecuttor);
                                    SystemLogs.InsertPLCLog("StationResult", "刀具消耗结束");

                                    SystemLogs.InsertPLCLog("StationResult", "获取当前站点刀具信息");
                                    string sqlcuttor = string.Format(@"select * from CuttorInfo(nolock) where StationId=N'{0}'",
                                        dsinfo.Tables[0].Rows[0]["ID"].ToString());
                                    DataSet dscuttor = SQLHelper.GetDataSet(sqlcuttor);
                                    SystemLogs.InsertPLCLog("StationResult", "获取当前站点刀具信息结束");

                                    if (dscuttor != null && dscuttor.Tables[0].Rows.Count > 0)
                                    {
                                        SystemLogs.InsertPLCLog("StationResult", "开始插入换刀提醒");
                                        string sqlnotice = "";
                                        for (int c = 0; c < dscuttor.Tables[0].Rows.Count; c++)
                                        {
                                            if (int.Parse(dscuttor.Tables[0].Rows[c]["UsedTime"].ToString()) >= int.Parse(dscuttor.Tables[0].Rows[c]["AlarmTime"].ToString()))
                                            {
                                                sqlnotice += string.Format(@"insert into Notices(Message,StationId) values(N'{0}',N'{1}');",
                                                    "刀具：" + dscuttor.Tables[0].Rows[c]["CutterCode"].ToString() + "，达到了使用提醒阈值，请注意更换刀具！", dsinfo.Tables[0].Rows[0]["ID"].ToString());
                                            }
                                        }
                                        if (sqlnotice != "") SQLHelper.ExcuteSQL(sqlnotice);
                                        SystemLogs.InsertPLCLog("StationResult", "开始插入换刀提醒结束");
                                    }
                                    #endregion

                                    #region 生产结束计算实绩
                                    SystemLogs.InsertPLCLog("StationResult", "末站点过站更新产品实绩！");
                                    if (dsinfo.Tables[0].Rows[0]["IsFirstStation"].ToString() == "3")
                                    {
                                        var qcount = SQLHelper.GetObject(string.Format(@"select count(1) as qcount from ProductTransitInfo(nolock) where QualityStatus='NOK' and ProductCode=N'{0}'", ProductionSn)).ToString();
                                        if (int.Parse(qcount) > 0)
                                        {
                                            SQLHelper.ExcuteSQL(string.Format(@"update EndProduct set QualityStatus='NOK' ,Status='2',EndTime=GETDATE() where EndProductSN=N'{0}'", ProductionSn));
                                        }
                                        else
                                        {
                                            SQLHelper.ExcuteSQL(string.Format(@"update EndProduct set QualityStatus='OK',Status='2',EndTime=GETDATE() where EndProductSN=N'{0}'", ProductionSn));
                                        }

                                        string sql = string.Format(@"UPDATE ERPOrderDetails SET ActureCount =ActureCount+1,EndDate=GETDATE(),UpdateTime5=GETDATE() WHERE ID=N'{0}'", dsinfo.Tables[1].Rows[0]["ID"].ToString());
                                        SQLHelper.ExcuteSQL(sql);
                                        SystemLogs.InsertPLCLog("StationResult", "最后站点过站订单生产产品数+1!订单ID：" + dsinfo.Tables[1].Rows[0]["ID"].ToString());
                                    }
                                    #endregion
                                }
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "写数据库过站实绩失败!" + ex.Message);
                            }
                            #endregion
                            var transitstatus = "OK";
                            #region UP追溯
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", "站点" + stationcode + "UP开始！");
                                List<ItemDB> liitms = itemsdb.FindAll(t => t.stationcode == stationcode && t.RO == "UP");
                                if (liitms.Count > 0)
                                {
                                    string sqlap = "";
                                    foreach (ItemDB item in liitms)
                                    {
                                        try
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "站点：" + stationcode + "-UP标签：" + item.DBTabid + ":获取UP信息！");
                                            // 获取站点当前生产产品序列号
                                            short s = 1;
                                            object val;
                                            object quality;
                                            object t;
                                            SystemLogs.InsertPLCLog("StationResult", objChangeItem[item.dbseq].ItemID + ":获取站点当前生产产品序列号！");
                                            objChangeItem[item.dbseq].Read(s, out val, out quality, out t);
                                            string PSn = val.ToString();

                                            //DataSet dsap = SQLHelper.GetDataSet(string.Format(@"select a.* from PLCUPInfo(nolock) a join StationInfo(nolock) b on a.PLCStationId=b.ID  where PLCUPDBAddress=N'{1}' and b.StationCode=N'{0}';", item.DBid, stationcode));

                                            //    //写数据库实绩
                                            //    sqlap += string.Format(@"insert into ProductTraceabilityInfo(ProductId,ProductCode,StationName,ItemID,ParkSn,TransitTime,StationId)
                                            //values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',GETDATE(),N'{5}');", dsinfo.Tables[1].Rows[0]["ID"].ToString(), ProductionSn,
                                            //        dsinfo.Tables[0].Rows[0]["StationName"].ToString(), item.DBid, PSn, dsinfo.Tables[0].Rows[0]["ID"].ToString());
                                            //写数据库实绩
                                            sqlap += string.Format(@"insert into ProductPLCTraceabilityInfo(ProductId,ProductCode,PLCDataDesc,PLCDataResult,StationName,UpdateTime,ItemId,StationId)
                                                            values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',GETDATE(),N'{5}',N'{6}');", dsinfo.Tables[1].Rows[0]["endid"].ToString(), ProductionSn,
                                                 item.opdesc, PSn, dsinfo.Tables[0].Rows[0]["StationName"].ToString(), item.DBid, dsinfo.Tables[0].Rows[0]["ID"].ToString());

                                            if (PSn == "NOK") transitstatus = "NOK";
                                        }
                                        catch (Exception ex)
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "站点：" + stationcode + "-UP标签：" + item.DBTabid + ":获取UP信息失败！" + ex.Message);
                                        }
                                    }
                                    if (sqlap != "") SQLHelper.ExcuteSQL(sqlap);
                                    SystemLogs.InsertPLCLog("StationResult", "UP追溯实绩成功");
                                    //发送结果到站点监控界面
                                    string message = "{\"msid\":\"\",\"Resault\":\"" + ProductionSn + "\",\"RO\":\"ENDSN\",\"ProductionCode\":\"" + dsinfo.Tables[1].Rows[0]["ProductionCode"].ToString() + "\"}";
                                    //string message = "{\"msid\":\"" + dsinfo.Tables[2].Rows[0]["PLCUPId"].ToString() + "\",\"Resault\":\"" + ProductionSn + "\",\"RO\":\"UP\"}";
                                    chatHub.Invoke("SendPrivateMessage", stationcode, message).ContinueWith(ts =>
                                    {
                                        if (ts.IsFaulted)
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "发送产品追溯实绩失败！站点" + stationcode + "，产品序列号：" + ProductionSn);
                                        }
                                        else
                                        {
                                            SystemLogs.InsertPLCLog("StationResult", "发送产品追溯实绩成功！站点" + stationcode + "，产品序列号：" + ProductionSn);
                                        }
                                    });
                                }
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "产品实绩UP失败！" + ex.Message);
                            }
                            #endregion

                            #region 过站状态 更新过站时间和状态
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", "更新产品追溯实绩UP过站时间！");
                                string sqlupdatetransit = string.Format(@"update ProductTransitInfo set TransitTime=getdate(),QualityStatus=N'{1}' where ID=N'{0}'", transistid, transitstatus);
                                SQLHelper.ExcuteSQL(sqlupdatetransit);
                                SystemLogs.InsertPLCLog("StationResult", "更新产品追溯实绩UP过站时间完成！");                                
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", "更新产品追溯实绩UP过站时间失败！" + ex.Message);
                            }
                            #endregion

                            #region  写实绩完成，发送0300握手信号，结束
                            try
                            {
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + "MES 发送0300握手信号反馈");
                                objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].Write("0300");
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + "MES 发送0300握手信号反馈成功");
                            }
                            catch (Exception ex)
                            {
                                SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 4].ItemID + "MES 发送0300握手信号反馈失败!" + ex.Message);
                            }
                            #endregion
                        }
                        #endregion

                        #region 产品追踪
                        //if (objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID.IndexOf("Station4RO") > 0
                        //    && ItemValues.GetValue(i + 1).ToString() == "SI")
                        //{
                        //    SystemLogs.InsertPLCLog("StationResult", "产品进站追踪！");
                        //    #region 获取站点编码
                        //    string stationcode = "";
                        //    try
                        //    {
                        //        SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].ItemID + ":获取站点编码！");
                        //        short s = 1;
                        //        object val;
                        //        object quality;
                        //        object t;
                        //        objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].Read(s, out val, out quality, out t);
                        //        stationcode = val.ToString();
                        //        SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 2].ItemID + ":获取站点编码成功！" + stationcode);
                        //    }
                        //    catch (Exception ex)
                        //    {
                        //        SystemLogs.InsertPLCLog("StationResult", "获取站点编码失败！" + ex.Message);
                        //    }
                        //    #endregion
                        //    #region 获取站点当前生产产品序列号
                        //    string ProductionSn = "";
                        //    try
                        //    {
                        //        SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].ItemID + ":获取站点当前生产产品序列号！");
                        //        short s = 1;
                        //        object val;
                        //        object quality;
                        //        object t;
                        //        objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].Read(s, out val, out quality, out t);
                        //        ProductionSn = val.ToString();
                        //        SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 1].ItemID + ":获取站点当前生产产品序列号成功！" + ProductionSn);

                        //    }
                        //    catch (Exception ex)
                        //    {
                        //        SystemLogs.InsertPLCLog("StationResult", "获取站点当前生产产品序列号失败！" + ex.Message);
                        //    }
                        //    #endregion
                        //    SystemLogs.InsertPLCLog("StationResult", "通知站点监控界面：" + ProductionSn + ";写成品生成实绩成功！");
                        //    string message = "{\"msid\":\"\",\"Resault\":\"" + ProductionSn + "\",\"RO\":\"ENDSN\",\"ProductionCode\":\"" + "" + "\"}";
                        //    chatHub.Invoke("SendPrivateMessage", stationcode, message).ContinueWith(ts =>
                        //    {
                        //        if (ts.IsFaulted)
                        //        {
                        //            SystemLogs.InsertPLCLog("StationResult", "发送产品序列号SN失败！站点" + stationcode + "，产品序号：" + ProductionSn);
                        //        }
                        //        else
                        //        {
                        //            SystemLogs.InsertPLCLog("StationResult", "发送产品序列号SN成功！站点" + stationcode + "，产品序号：" + ProductionSn);
                        //        }
                        //    });
                        //}
                        #endregion

                        #region 站点报警
                        //if (objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID.IndexOf("Station8Error") > 0)
                        //{
                        //    SystemLogs.InsertPLCLog("StationResult", "站点报警！");
                        //    #region 获取站点编码
                        //    string stationcode = "";
                        //    try
                        //    {
                        //        SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 6].ItemID + ":获取站点编码！");
                        //        short s = 1;
                        //        object val;
                        //        object quality;
                        //        object t;
                        //        objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 6].Read(s, out val, out quality, out t);
                        //        stationcode = val.ToString();
                        //        SystemLogs.InsertPLCLog("StationResult", objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1)) - 6].ItemID + ":获取站点编码成功！" + stationcode);
                        //    }
                        //    catch (Exception ex)
                        //    {
                        //        SystemLogs.InsertPLCLog("StationResult", "获取站点编码失败！" + ex.Message);
                        //        return;
                        //    }
                        //    #endregion
                        //    try
                        //    {
                        //        #region 获取andon
                        //        string sqlstation = string.Format(@"select * from StationInfo(nolock) where StationCode=N'{0}'", stationcode);
                        //        DataSet dsstation = SQLHelper.GetDataSet(sqlstation);
                        //        DataSet dsandon = new DataSet();
                        //        if (dsstation != null && dsstation.Tables[0].Rows.Count > 0)
                        //        {
                        //            if (ItemValues.GetValue(i + 1).ToString() == "1")
                        //            {
                        //                string sqlAlarm = string.Format(@"insert into FaultInfo(StationId,StartTime,LineOrSatation) values(N'{0}',GETDATE(),N'{1}')",
                        //                    dsstation.Tables[0].Rows[0]["ID"].ToString(), 1);
                        //                SQLHelper.ExcuteSQL(sqlAlarm);
                        //            }
                        //            if (ItemValues.GetValue(i + 1).ToString() == "0")
                        //            {
                        //                string sqlAlarm = string.Format(@"update FaultInfo set EndTime=GETDATE() where StationId=N'{0}' and EndTime is null ",
                        //                    dsstation.Tables[0].Rows[0]["ID"].ToString());
                        //                SQLHelper.ExcuteSQL(sqlAlarm);
                        //            }
                        //            string sqlandon = string.Format(@"select * from AndonConfiguration(nolock) where Team=N'{0}'", dsstation.Tables[0].Rows[0]["Team"].ToString());
                        //            dsandon = SQLHelper.GetDataSet(sqlandon);
                        //        }
                        //        #endregion

                        //        SystemLogs.InsertPLCLog("StationResult", "通知Andon监控！");
                        //        if (dsandon != null && dsandon.Tables[0].Rows.Count > 0)
                        //        {
                        //            string message = "{\"msid\":\"\",\"Resault\":\"" + "" + "\",\"RO\":\"SS\",\"ProductionCode\":\"" + "" + "\"}";
                        //            chatHub.Invoke("SendPrivateMessage", dsandon.Tables[0].Rows[0]["AndonNo"].ToString(), message).ContinueWith(ts =>
                        //            {
                        //                if (ts.IsFaulted)
                        //                {
                        //                    SystemLogs.InsertPLCLog("StationResult", "通知Andon监控失败-站点：" + stationcode);
                        //                }
                        //                else
                        //                {
                        //                    SystemLogs.InsertPLCLog("StationResult", "通知Andon监控成功-站点：" + stationcode);
                        //                }
                        //            });
                        //        }
                        //    }
                        //    catch (Exception ex)
                        //    {
                        //        SystemLogs.InsertPLCLog("StationResult", "通知Andon监控！"+ ex);
                        //        return;
                        //    }
                            
                        //}
                        #endregion
                    }

                }
                else
                {
                    initx += 1;
                }
            }
            catch (Exception ex)
            {
                SystemLogs.InsertPLCLog("StationResult", ex.Message);
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
                    SystemLogs.InsertPLCLog("StationResult", "释放所有组资源！");
                }
                if (null != objServer)
                {
                    objServer.Disconnect();
                    objServer = null;
                    objItems = null;
                    GC.Collect();
                    SystemLogs.InsertPLCLog("StationResult", "断开连接OPC释放所有组资源！");
                }
            }
            catch (Exception ex)
            {
                SystemLogs.InsertPLCLog("StationResult", ex.Message);
            }
        }
    }

    public class ItemDB
    {
        /// <summary>
        /// 站点编码
        /// </summary>
        public virtual string stationcode { get; set; }
        /// <summary>
        /// kepware标签的ID
        /// </summary>
        public virtual string DBTabid { get; set; }
        /// <summary>
        /// kepware标签存在内存里面的顺序号
        /// </summary>
        public virtual int dbseq { get; set; }
        /// <summary>
        /// 行为代码UP/AP
        /// </summary>
        public virtual string RO { get; set; }
        /// <summary>
        /// 操作描述
        /// </summary>
        public virtual string opdesc { get; set; }
        /// <summary>
        /// DB ID
        /// </summary>
        public virtual string DBid { get; set; }
    }
    [Serializable()]
    public class Message
    {
        public virtual string header { get; set; }
        public virtual string Body { get; set; }
    }
}
