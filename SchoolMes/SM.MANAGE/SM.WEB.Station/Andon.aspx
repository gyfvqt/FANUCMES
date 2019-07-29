<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Andon.aspx.cs" Inherits="SM.WEB.Station.Andon" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="win8/Andon.css" rel="stylesheet" />
    <script src="win8/jquery.js"></script>
    
    <script src="/Scripts/jquery.signalR-2.4.1.min.js"></script>
    <script src="http://<%=HUPIP %>/signalr/hubs"></script>
    <script type="text/javascript">
        //var myAuto = document.getElementById('myaudio');
        $(function () {
            setInterval("AlarmTime()", 1000);
            //AlarmSetting();
            setInterval("AlarmSetting()", 1000);
            GetStaionPlan();
            var AndonNo = "<%=AndonNo%>";
            var Team = "<%=Team%>";
            var LineId = "<%=LineId%>";
            if (Team != "") {
                GetLineStatus(LineId);
                GetAlarm(Team);
                GetStationAlarm(Team);
            }
            if (LineId != "") GetLineStatus(LineId);
            if (AndonNo != "") {                
                $.connection.hub.url = 'http://<%=HUPIP %>/signalr';
                $.connection.hub.logging = true;
                var work = $.connection.IMHub;
                var fromUser = AndonNo;
                $.connection.hub.disconnected();

                //对应后端的SendMessage函数，消息接收函数
                work.client.receivePrivateMessage = function (user, message) {
                    if (message != undefined) {
                        //alert(message);
                        var msg = JSON.parse(message);
                        if (msg.RO == "AS") {//设备报警开始
                            if (Team != "") GetAlarm(Team);
                        }
                        else if (msg.RO == "AE") {//设备报警结束
                            if (Team != "") GetAlarm(Team);
                        }    
                        else if (msg.RO == "SS") {//站点报警开始
                            GetStationAlarm(Team);
                        }  
                        else if (msg.RO == "SE") {//站点报警结束
                            GetStationAlarm(Team);
                        } 
                        else if (msg.RO == "LS") {//线体状态变化
                            GetLineStatus(LineId);
                            GetStationAlarm(msg.msid);
                            GetAlarm(msg.msid);
                        }  
                        else if (msg.RO == "CS") {//线体状态变化
                            GetStaionPlan();
                        }  
                    }


                };

                //后端SendLogin调用后，产生的loginUser回调
                work.client.onConnected = function (connnectId, userName, OnlineUsers) {
                    //reloadUser(OnlineUsers);
                };
                //work.client.onDisconnect = function (connnectId, userName, OnlineUsers) {
                //    alert("奶奶的断了！断了！了！");
                //};
                $.connection.hub.disconnected(function() {
                   setTimeout(function() {
                       $.connection.hub.start().done(function () {
                            var username =  "<%=AndonNo%>";
                            //发送上线信息
                            work.server.register(username);
                            var message="{\"header\":\"andon\",\"Body\":\""+username+"\"}";                           
                           work.server.sendPrivateMessage("AndonResult", message);
                        }).fail(function () { alert('Could not Connect!'); });
                   }, 5000); // Restart connection after 5 seconds.
                });
                $.connection.hub.stateChanged(function (change) {
                    if (change.newState === $.signalR.connectionState.reconnecting) {
                        $("#spanStatus").html("正在连接......");
                        $("#divStatus").css("background-color", "red");
                    }
                    else if (change.newState === $.signalR.connectionState.connected) {
                        //$("#spanStatus").html("正常");
                        //$("#divStatus").css("background-color", "chartreuse");
                    }
                    else if (change.newState === $.signalR.connectionState.disconnected) {
                        $("#spanStatus").html("断线请重连！");
                        $("#divStatus").css("background-color", "red");
                    }
                });
                //hub连接开启
                $.connection.hub.start().done(function () {
                    var username =  "<%=AndonNo%>";
                    //发送上线信息
                    work.server.register(username);
                    var message="{\"header\":\"andon\",\"Body\":\""+username+"\"}";
                    work.server.sendPrivateMessage("AndonResult", message);
                    //点击按钮，发送消息
                    //$('#send').click(function () {
                    //    var friend = $('#username').val();
                    //    //调用后端函数，发送指定消息
                    //    work.server.sendPrivateMessage(friend, $("#message").val());
                    //});
                }).fail(function () { alert('Could not Connect!'); });


            }
        });
        function GetStaionPlan() {
            var planJPH = "<%=PlanCycle%>";
            var ActureReturn = $("#acturecount").html();
            var StationId = "<%=LineId%>";
            $.post('/Controller/Andon/getAndonPlan.ashx', { PlanJPH: planJPH, actureReturn: "0", lineid: StationId }, function (data) {
                if (data != "0") {
                    var arr = data.split('|');
                    if (arr.length == 4) {
                        $("#planjph").html(arr[0]);
                        $("#JPH").html(arr[1]);
                        $("#userate").html(arr[2] + "%");
                        $("#ActureCount").html(arr[3]);
                    }
                }
            }, "text");
        }
        setInterval("GetStaionPlan()", 1000 * 60);//每1000毫秒调用一次函数
    </script>
</head>
<body class="linen">
    <form id="form1" runat="server">
        <div class="Top">
            <div class="Line1">
                <div class="GridLeft">
                    <span class="span1">计划产量</span>
                    <span id="planjph" class="span2" style="color: blue;">0</span>
                </div>
                <div class="GridMiddle">
                    <span class="span3"><%=linename %></span>
                </div>
                <div class="GridRight">
                    <span class="span1">实绩产量</span>
                    <span id="ActureCount" class="span2" style="color: chartreuse;">0</span>
                </div>
            </div>
            <div class="Line2">
                <div class="GridLeft">
                    <span class="span1">JPH</span>
                    <span id="JPH" class="span2" style="color: blue;">0</span>
                </div>
                <div id="divStatus" class="GridMiddle" style="background: chartreuse;">
                    <span id="spanStatus" class="span3">正      常</span>
                </div>
                <div class="GridRight">
                    <span class="span1">设备使用率</span>
                    <span id="userate" class="span2" style="color: chartreuse;">0</span>
                </div>
            </div>
        </div>
        <div class="Middle" style="border-bottom: 1px solid green;">
            <div id="divalarm" style="position: relative; width: 100%; height: 100%; top: 5%;">
                <%--<div id="salarm" class="Alarm">
                    <div class="AlarmStation">OP01001</div>
                    <img src="win8/images/alarm1.png" />
                    <span id="alarm1" class="AlarmTime" >08:20:00</span>
                    <input type="hidden" id="htime1" value="2019-05-18 22:41:00" />
                </div>--%>                
            </div>
        </div>
        <div class="Foot">
            <div style="position: relative; width: 99%; height: 100%;">
                <div style="position: relative;float: left; width: 74%; height: 100%; line-height: 100%;">
                    <div class="equipmentalarm" style="top:0;border-bottom:1px solid #fff;color:red;"><span id="eq0" ></span></div>
                    <%--<div class="equipmentalarm" style="top:24%;border-bottom:1px solid #fff;"><span >qq</span></div>
                    <div class="equipmentalarm" style="top:49%;border-bottom:1px solid #fff;"><span >qq</span></div>--%>
                    <div class="equipmentalarm" style="top:50%;color:darkorange;"><span id="eq1"></span></div>
                </div>
                <div style="position: relative; float: left; width: 25%; height: 100%; line-height: 100%; border-left: 1px solid #fff;">
                    <span class="CurrentTimeTitle">当前时间</span>
                    <span id="currentdate" class="CurrentTimeDate">05月18日</span>
                    <span id="currenttime" class="CurrentTime">20:00:01</span>
                </div>
            </div>
        </div>
        <audio id="myaudio" src="alarm.mp3" controls="controls"  loop="loop" style="display:none;"/>
        <script src="/Andon.js?id=<%=DateTime.Now.Ticks %>"></script>
    </form>
</body>
</html>
