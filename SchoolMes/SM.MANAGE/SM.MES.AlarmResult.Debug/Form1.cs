using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Helper;
using System.Configuration;
using Microsoft.AspNet.SignalR.Client;
using Newtonsoft.Json;
using OPCAutomation;


namespace SM.MES.AlarmResult.Debug
{
    public partial class Form1 : Form
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
        public Form1()
        {
            InitializeComponent();
            try
            {
                SignalRTimer = new Timer();
                SignalRTimer.Interval = 1500;
                SignalRTimer.Tick += SignalRTimer_Tick;
                SignalRTimer.Enabled = true;

                OPCconnectTimer = new Timer();
                OPCconnectTimer.Interval = 1000;
                OPCconnectTimer.Tick +=OPCconnectTimer_Tick;
                OPCconnectTimer.Enabled = true;

                //初始化链接状态定时器
                tim = new Timer();//定义一个1S的定时器；
                tim.Interval = 1500;
                tim.Tick += theout;//定时时间到后执行theout事件；
                tim.Enabled = true; ;//是否执行System.Timers.Timer.Elapsed事件；
                                     //(1)创建opc server对象
                objServer = new OPCServer();
                //objChangeItem = new OPCItem[4];
            }
            catch (Exception ex)
            {
                SystemLogs.InsertPLCLog("AndonResult", ex.Message);
            }
        }

        private void SignalRTimer_Tick(object sender, EventArgs e)
        {
            SignalRTimer.Interval = 10000;
            try
            {
                if (connection == null || connection.State == Microsoft.AspNet.SignalR.Client.ConnectionState.Disconnected)
                {
                    var url = ConfigurationManager.AppSettings["URL"].ToString();
                    connection = new HubConnection(url);
                    chatHub = connection.CreateHubProxy("IMHub");
                    connection.Start().ContinueWith(t =>
                    {
                        if (!t.IsFaulted)
                        {
                            //连接成功，调用Register方法
                            chatHub.Invoke("Register", "AndonResult");
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
                            SystemLogs.InsertPLCLog("AndonResult", "发送ACK握手！Andon:" + m.Body);
                            string messageX = "{\"msid\":\"\",\"Resault\":\"\",\"RO\":\"ack\",\"ProductionCode\":\"\"}";
                            chatHub.Invoke("SendPrivateMessage", m.Body, messageX).ContinueWith(ts =>
                            {
                                if (ts.IsFaulted)
                                {
                                    SystemLogs.InsertPLCLog("AndonResult", "发送ACK握手失败！站点" + m.Body);
                                }
                                else
                                {
                                    SystemLogs.InsertPLCLog("AndonResult", "发送ACK握手成功！站点" + m.Body);
                                }
                            });
                        }
                    });
                }
            }
            catch (Exception ex)
            {
                SystemLogs.InsertPLCLog("AndonResult", "Andon发送ACK握手失败" + ex.Message);
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
                    #region 获取所有监控信息点
                    string sql = @"select a.ID,a.EquipmentId,a.ParentId,a.EquipmentCode,a.EquipmentName,a.Team,a.PLCIP+'.'+b.PLCDB as PLCDB,b.FaultCode,b.FaultDesc,b.FaultType,b.ID AS FaultId,a.EType,'1' as alarmtype,a.IsPayPoint
                                    from EquipmentData(nolock) a 
                                    join FaultCodeInfo(nolock) b on a.ID=b.EquipmentId
union 
select a.ID,a.EquipmentId,a.ParentId,a.EquipmentCode,a.EquipmentName,a.Team,a.PLCIP+'.'+b.PLCUPDBAddress as PLCDB,'' FaultCode,b.UPDataDesc,'' FaultType,b.ID AS FaultId,a.EType,'0' as alarmtype,a.IsPayPoint
                                    from EquipmentData(nolock) a 
                                    join PLCTemplateInfoDetail(nolock) b on a.PLCDB=b.PLCTemplateID
order by EquipmentId,alarmtype asc";
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
                    if (dsstation == null || dsstation.Tables[0].Rows.Count <= 0 )
                    {
                        SystemLogs.InsertPLCLog("AndonResult", "获取PLC报警配置失败！请确认配置！");
                    }
                    else
                    {
                        scount = dsstation.Tables[0].Rows.Count;
                        int count = dsstation.Tables[0].Rows.Count + 1;
                        tmpIDs = new string[count + dcount];
                        int[] tmpCHandles = new int[count];
                        objChangeItem = new OPCItem[count];
                        //设备部分
                        for (int i = 1; i < count; i++)
                        {
                            tmpCHandles[i] = i;
                            tmpIDs[i] = dsstation.Tables[0].Rows[i - 1]["PLCDB"].ToString();

                            #region 保存站点和PLCDB关系
                            ItemDB it = new ItemDB();
                            it.dbseq = i;
                            it.DBTabid = dsstation.Tables[0].Rows[i - 1]["PLCDB"].ToString();
                            it.Team = dsstation.Tables[0].Rows[i - 1]["Team"].ToString();
                            it.FaultDesc = dsstation.Tables[0].Rows[i - 1]["FaultDesc"].ToString();
                            it.FaultCode = dsstation.Tables[0].Rows[i - 1]["FaultCode"].ToString();
                            it.FaultType = dsstation.Tables[0].Rows[i - 1]["FaultType"].ToString();
                            it.ID = dsstation.Tables[0].Rows[i - 1]["ID"].ToString();
                            it.ParentId = dsstation.Tables[0].Rows[i - 1]["ParentId"].ToString();
                            it.FaultId = dsstation.Tables[0].Rows[i - 1]["FaultId"].ToString();
                            it.EquipmentCode = dsstation.Tables[0].Rows[i - 1]["EquipmentCode"].ToString();
                            it.EquipmentName = dsstation.Tables[0].Rows[i - 1]["EquipmentName"].ToString();
                            it.EquipmentId = dsstation.Tables[0].Rows[i - 1]["EquipmentId"].ToString();
                            it.EType = dsstation.Tables[0].Rows[i - 1]["EType"].ToString();
                            it.alarmtype = dsstation.Tables[0].Rows[i - 1]["alarmtype"].ToString();
                            it.IsPayPoint = dsstation.Tables[0].Rows[i - 1]["IsPayPoint"].ToString();

                            itemsdb.Add(it);
                            #endregion

                            if (dsstation.Tables[0].Rows[i - 1]["PLCDB"].ToString().IndexOf("E0AssetID") >= 0)
                            {
                                statinindex.Add(i);
                            }
                        }

                        strItemIDs = (Array)tmpIDs;//必须转成Array型，否则不能调用AddItems方法
                        lClientHandles = (Array)tmpCHandles;
                        // 添加opc标签
                        SystemLogs.InsertPLCLog("AndonResult", "添加监控标签！");
                        objItems.AddItems(count-1, ref strItemIDs, ref lClientHandles, out lserverhandles, out lErrors, RequestedDataTypes, AccessPaths);
                        for (int i = 1; i < (count); i++)
                        {
                            objChangeItem[i] = objItems.GetOPCItem(Convert.ToInt32(lserverhandles.GetValue(i)));
                        }
                        //初始化站点编码
                        for (int i = 1; i < count; i++)
                        {
                            if (statinindex.IndexOf(i) >= 0)
                            {
                                SystemLogs.InsertPLCLog("StationResult", dsstation.Tables[0].Rows[i - 1]["PLCDB"].ToString() + "初始化AssetID：" + dsstation.Tables[0].Rows[i - 1]["EquipmentId"].ToString());
                                objChangeItem[i].Write(dsstation.Tables[0].Rows[i - 1]["EquipmentId"].ToString());
                            }
                        }
                    }
                    #endregion
                }
            }
            catch (Exception ex)
            {
                objServer.Disconnect();
                SystemLogs.InsertPLCLog("AndonResult", ex.Message);
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
                        //if (objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID.IndexOf("Station0Init") > 0)
                        //{
                        //    try
                        //    {
                        //        if (ItemValues.GetValue(i + 1).ToString() == "0100")
                        //        {
                        //            SystemLogs.InsertPLCLog("AndonResult", "PLC 发送0100 进行握手");
                        //            objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].Write("0200");
                        //            SystemLogs.InsertPLCLog("AndonResult", "MES 发送0200 进行反馈");
                        //        }
                        //    }
                        //    catch (Exception ex)
                        //    {
                        //        SystemLogs.InsertPLCLog("AndonResult", "PLC进行握手失败！" + ex.Message);
                        //    }

                        //}
                        #endregion

                        #region 设备离散报警实绩
                        var DBTAB = objChangeItem[Convert.ToInt32(ClientHandles.GetValue(i + 1))].ItemID;
                        ItemDB DBinfo = itemsdb.Find(t => t.DBTabid == DBTAB);
                        if (ItemValues.GetValue(i + 1).ToString() == "1" && DBinfo.alarmtype == "1")
                        {
                            if (DBinfo != null)
                            {
                                string sql = string.Format(@"insert into EquipmentFault(EquipmentId,FaultId,FaultCode,FaultDesc,FaultType,FaultBeginTime) 
                                            values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',GETDATE())", DBinfo.ID, DBinfo.FaultId, DBinfo.FaultCode, DBinfo.FaultDesc, DBinfo.FaultType);
                                SQLHelper.ExcuteSQL(sql);
                                sql = string.Format(@"select * from AndonConfiguration(nolock) where Team=N'{0}'", DBinfo.Team);
                                DataSet dsAndon = SQLHelper.GetDataSet(sql);
                                if (dsAndon != null && dsAndon.Tables[0].Rows.Count > 0)
                                {
                                    for (int k = 0; k < dsAndon.Tables[0].Rows.Count; k++)
                                    {
                                        //发送结果到站点监控界面
                                        string message = "{\"msid\":\"\",\"Resault\":\"" + DBinfo.FaultCode + "：" + DBinfo.FaultDesc + "\",\"RO\":\"AS\",\"Team\":\"" + DBinfo.Team + "\"}";
                                        chatHub.Invoke("SendPrivateMessage", dsAndon.Tables[0].Rows[k]["AndonNo"].ToString(), message).ContinueWith(ts =>
                                        {
                                            if (ts.IsFaulted)
                                            {
                                                SystemLogs.InsertPLCLog("AndonResult", "发送报警实绩失败！CODE：" + DBinfo.FaultCode + "，描述：" + DBinfo.FaultDesc);
                                            }
                                            else
                                            {
                                                SystemLogs.InsertPLCLog("AndonResult", "发送报警实绩成功！CODE：" + DBinfo.FaultCode + "，描述：" + DBinfo.FaultDesc);
                                            }
                                        });
                                    }
                                }

                                SystemLogs.InsertPLCLog("AndonResult", DBTAB + "报警");
                            }

                        }
                        if (ItemValues.GetValue(i + 1).ToString() == "0" && DBinfo.alarmtype == "1")
                        {
                            if (DBinfo != null)
                            {
                                string sql = string.Format(@"update EquipmentFault set FaultEndTime= GETDATE(),LostTime=DATEDIFF (second,FaultBeginTime, GETDATE()) 
                                    where FaultId=N'{1}' and FaultEndTime is null and EquipmentId=N'{0}'", DBinfo.ID, DBinfo.FaultId);
                                SQLHelper.ExcuteSQL(sql);
                                sql = string.Format(@"select * from AndonConfiguration(nolock) where Team=N'{0}'", DBinfo.Team);
                                DataSet dsAndon = SQLHelper.GetDataSet(sql);
                                if (dsAndon != null && dsAndon.Tables[0].Rows.Count > 0)
                                {
                                    for (int k = 0; k < dsAndon.Tables[0].Rows.Count; k++)
                                    {
                                        //发送结果到站点监控界面
                                        string message = "{\"msid\":\"\",\"Resault\":\"" + DBinfo.FaultCode + "：" + DBinfo.FaultDesc + "\",\"RO\":\"AE\",\"Team\":\"" + DBinfo.Team + "\"}";
                                        chatHub.Invoke("SendPrivateMessage", dsAndon.Tables[0].Rows[k]["AndonNo"].ToString(), message).ContinueWith(ts =>
                                        {
                                            if (ts.IsFaulted)
                                            {
                                                SystemLogs.InsertPLCLog("AndonResult", "发送解除报警实绩失败！CODE：" + DBinfo.FaultCode + "，描述：" + DBinfo.FaultDesc);
                                            }
                                            else
                                            {
                                                SystemLogs.InsertPLCLog("AndonResult", "发送解除报警实绩成功！CODE：" + DBinfo.FaultCode + "，描述：" + DBinfo.FaultDesc);
                                            }
                                        });
                                    }
                                }
                                SystemLogs.InsertPLCLog("AndonResult", DBTAB + "解除报警");
                            }

                        }
                        #endregion

                        #region  线体，站点，设备报警
                        if (DBinfo.alarmtype == "0" && DBTAB.IndexOf("E2AssetStatus") >= 0)
                        {
                            if (DBinfo != null)
                            {
                                string sql = "";
                                if (DBinfo.EType == "3")
                                {
                                    var dnow = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                                    #region 关闭上设备上一个报警，进行新的报警
                                    SystemLogs.InsertPLCLog("AndonResult", "关闭上设备上一个报警，进行新的报警" + DBinfo.ID);
                                    sql = string.Format(@"update FaultInfo set EndTime= GETDATE() where StationId=N'{0}' and EndTime is null and LineOrSatation=3;
                                insert into FaultInfo(StationId,StartTime,FaultType,LineOrSatation,parentid) values(N'{0}',N'{3}',N'{1}',3,N'{2}');", DBinfo.ID, ItemValues.GetValue(i + 1).ToString(), DBinfo.ParentId, dnow);
                                    SQLHelper.ExcuteSQL(sql);
                                    #endregion 

                                    #region 判断站点设备新报警是否优先于现有站点报警
                                    SystemLogs.InsertPLCLog("AndonResult", "判断站点设备新报警是否优先于现有站点报警" + DBinfo.ID);
                                    var status = int.Parse(ItemValues.GetValue(i + 1).ToString());
                                    sql = string.Format(@"select top 1 * from FaultInfo(nolock) where StationId=N'{0}' and EndTime is null and LineOrSatation=3 order by FaultType asc", DBinfo.ParentId);
                                    DataSet dsEA = SQLHelper.GetDataSet(sql);
                                    string o = SQLHelper.GetObject(string.Format(@"select ParentId from EquipmentData(nolock) where ID=N'{0}' ", DBinfo.ParentId)).ToString();
                                    if (dsEA != null && dsEA.Tables[0].Rows.Count > 0)
                                    {
                                        //关闭当前站点的报警，新开一条报警
                                        SystemLogs.InsertPLCLog("AndonResult", "站点设备新报警是否优先于现有站点报警,关闭当前站点的报警，新开一条报警" + DBinfo.ID);
                                        if (status < int.Parse(dsEA.Tables[0].Rows[0]["FaultType"].ToString()))
                                        {
                                            sql = string.Format(@"update FaultInfo set EndTime= GETDATE() where StationId=N'{0}' and EndTime is null and LineOrSatation=2;
                                insert into FaultInfo(StationId,StartTime,FaultType,LineOrSatation,parentid) values(N'{0}',N'{3}',N'{1}',2,N'{2}');", DBinfo.ParentId, ItemValues.GetValue(i + 1).ToString(), o, dnow);
                                            SQLHelper.ExcuteSQL(sql);
                                        }
                                    }
                                    #endregion

                                    #region 发送报警到Andon
                                    SystemLogs.InsertPLCLog("AndonResult", "发送报警到Andon" + DBinfo.ID);
                                    sql = string.Format(@"select * from AndonConfiguration(nolock) where Team=N'{0}'", DBinfo.Team);
                                    DataSet dsAndon = SQLHelper.GetDataSet(sql);
                                    if (dsAndon != null && dsAndon.Tables[0].Rows.Count > 0)
                                    {
                                        for (int k = 0; k < dsAndon.Tables[0].Rows.Count; k++)
                                        {
                                            //发送结果到站点监控界面
                                            string message = "{\"msid\":\"" + DBinfo.Team + "\",\"Resault\":\"" + ItemValues.GetValue(i + 1).ToString() + "\",\"RO\":\"LS\",\"LineID\":\"" + o + "\"}";
                                            chatHub.Invoke("SendPrivateMessage", dsAndon.Tables[0].Rows[k]["AndonNo"].ToString(), message).ContinueWith(ts =>
                                            {
                                                if (ts.IsFaulted)
                                                {
                                                    SystemLogs.InsertPLCLog("AndonResult", "发送线体状态实绩失败！LineId：" + DBinfo.ID);
                                                }
                                                else
                                                {
                                                    SystemLogs.InsertPLCLog("AndonResult", "发送线体状态实绩成功！LineId：" + DBinfo.ID);
                                                }
                                            });
                                        }
                                    }
                                    #endregion
                                }



                            }

                        }
                        #endregion

                        #region CycleTime计数
                        if (DBinfo.alarmtype == "0" && (DBinfo.EType == "2" || DBinfo.EType == "3")  && DBTAB.IndexOf("E1CycleTime") >= 0)
                        {
                            if (DBinfo != null)
                            {
                                if (ItemValues.GetValue(i + 1).ToString() == "1")
                                {
                                    //Cycle start 
                                    SystemLogs.InsertPLCLog("AndonResult", "Cycle start ：" + DBinfo.ID);
                                    string sql = string.Format(@"insert into CycleTimeInfo(EId,StartTime,ParentId,IsPayPoint) values(N'{0}',N'{1}',N'{2}',N'{3}')",
                                        DBinfo.ID, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), DBinfo.ParentId, DBinfo.IsPayPoint);
                                    SQLHelper.ExcuteSQL(sql);
                                    SystemLogs.InsertPLCLog("AndonResult", "Cycle start 结束：" + DBinfo.ID);

                                }
                                if (ItemValues.GetValue(i + 1).ToString() == "0")
                                {
                                    //Cycle end 
                                    SystemLogs.InsertPLCLog("AndonResult", "Cycle end ：" + DBinfo.ID);
                                    string sql = string.Format(@"update CycleTimeInfo set EndTime=GETDATE() where EId=N'{0}' and EndTime is null", DBinfo.ID);
                                    SQLHelper.ExcuteSQL(sql);
                                    SystemLogs.InsertPLCLog("AndonResult", "Cycle end 结束：" + DBinfo.ID);

                                    #region 发送报警到Andon
                                    SystemLogs.InsertPLCLog("AndonResult", "发送报警到Andon" + DBinfo.ID);

                                    sql = string.Format(@"select * from AndonConfiguration(nolock) where Team=N'{0}'", DBinfo.Team);
                                    DataSet dsAndon = SQLHelper.GetDataSet(sql);
                                    if (dsAndon != null && dsAndon.Tables[0].Rows.Count > 0)
                                    {
                                        for (int k = 0; k < dsAndon.Tables[0].Rows.Count; k++)
                                        {
                                            //发送结果到站点监控界面
                                            string message = "{\"msid\":\"" + DBinfo.Team + "\",\"Resault\":\"" + ItemValues.GetValue(i + 1).ToString() + "\",\"RO\":\"CS\",\"LineID\":\"\"}";
                                            chatHub.Invoke("SendPrivateMessage", dsAndon.Tables[0].Rows[k]["AndonNo"].ToString(), message).ContinueWith(ts =>
                                            {
                                                if (ts.IsFaulted)
                                                {
                                                    SystemLogs.InsertPLCLog("AndonResult", "发送线体状态实绩失败！LineId：" + DBinfo.ID);
                                                }
                                                else
                                                {
                                                    SystemLogs.InsertPLCLog("AndonResult", "发送线体状态实绩成功！LineId：" + DBinfo.ID);
                                                }
                                            });
                                        }
                                    }
                                    #endregion

                                }
                            }
                        }
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
                SystemLogs.InsertPLCLog("AndonResult", ex.Message);
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
    }

    public class ItemDB
    {
        /// <summary>
        /// 设备ID
        /// </summary>
        public virtual string ID { get; set; }
        /// <summary>
        /// 上级设备ID
        /// </summary>
        public virtual string ParentId { get; set; }
        /// <summary>
        /// 设备代码
        /// </summary>
        public virtual string EquipmentCode { get; set; }
        /// <summary>
        /// 设备名称
        /// </summary>
        public virtual string EquipmentName { get; set; }
        /// <summary>
        /// 班组
        /// </summary>
        public virtual string Team { get; set; }
        /// <summary>
        /// kepware标签的ID
        /// </summary>
        public virtual string DBTabid { get; set; }
        /// <summary>
        /// kepware标签存在内存里面的顺序号
        /// </summary>
        public virtual int dbseq { get; set; }
        /// <summary>
        /// 报警定义ID
        /// </summary>
        public virtual string FaultId { get; set; }
        /// <summary>
        /// 报警定义描述
        /// </summary>
        public virtual string FaultDesc { get; set; }
        /// <summary>
        /// 报警定义编码
        /// </summary>
        public virtual string FaultCode { get; set; }
        /// <summary>
        /// 报警类型
        /// </summary>
        public virtual string FaultType { get; set; }
        /// <summary>
        /// 设备ID
        /// </summary>
        public virtual string EquipmentId { get; set; }
        /// <summary>
        /// 设备类型
        /// </summary>
        public virtual string EType { get; set; }
        /// <summary>
        /// 报警类型
        /// </summary>
        public virtual string alarmtype { get; set; }
        /// <summary>
        /// 是否是最后站点
        /// </summary>
        public virtual string IsPayPoint { get; set; }
    }
    [Serializable()]
    public class Message
    {
        public virtual string header { get; set; }
        public virtual string Body { get; set; }
    }
}
