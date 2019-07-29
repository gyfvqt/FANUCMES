<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PLCStationView.aspx.cs" Inherits="SM.WEB.Station.PLCStationV" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="win8/base.css" rel="stylesheet" />
    <%--<script src="win8/jquery.js"></script>--%>
    <script src="/Scripts/jquery-3.3.1.min.js"></script>
    <script src="win8/jquery.easing.js"></script>
    <script src="win8/base.js"></script>
    <script src="/Scripts/jquery.signalR-2.4.1.min.js"></script>
    <script src="http://<%=HUPIP %>/signalr/hubs"></script>
    <script type="text/javascript">
        $(function () {
            FResize();
            $(window).resize(function () {
                FResize();
            });
            TimeRun();
            var stationid =<%=stationId%>;
            GetProcessSheet(stationid);
            GetStaionPlan();
            var scode ="<%=stationCode%>";
            if (scode != "") {
                //getAP(scode, "");
                //getUP(scode, "");
                $.connection.hub.url = 'http://<%=HUPIP %>/signalr';
                $.connection.hub.logging = true;
                var work = $.connection.IMHub;
                var fromUser = "<%=stationCode%>";
                $.connection.hub.disconnected();

                //对应后端的SendMessage函数，消息接收函数
                work.client.receivePrivateMessage = function (user, message) {
                    if (message != undefined) {
                        //alert(message);
                        var msg = JSON.parse(message);
                        if (msg.RO == "ENDSN") {
                            $("#sn").html(msg.Resault);
                            $("#divsn").html(msg.Resault);
                            $("#PCode").html(msg.ProductionCode);
                            GetProduct(msg.Resault);
                            getAP(scode, msg.Resault);
                            getUP(scode, msg.Resault);
                            GetDefectCount(msg.Resault,stationid)
                        }
                        else if (msg.RO == "UP") {
                            $("#UP" + msg.msid).html(msg.Resault);
                        }
                        else if (msg.RO == "AP") {
                            $("#AP" + msg.msid).html(msg.Resault);
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
                            var username =  "<%=stationCode%>";
                            //发送上线信息
                            work.server.register(username);
                            var message="{\"header\":\"PLC\",\"Body\":\""+username+"\"}";
                            work.server.sendPrivateMessage("StationResault", message);                            
                        }).fail(function () { alert('Could not Connect!'); });
                   }, 5000); // Restart connection after 5 seconds.
                });
                $.connection.hub.stateChanged(function (change) {
                    if (change.newState === $.signalR.connectionState.reconnecting) {
                        $("#StationStatus").html("正在连接服务器......");
                        $("#StationStatus").css("background-color", "red");
                    }
                    else if (change.newState === $.signalR.connectionState.connected) {
                        $("#StationStatus").html("正常");
                        $("#StationStatus").css("background-color", "green");
                    }
                    else if (change.newState === $.signalR.connectionState.disconnected) {
                        $("#StationStatus").html("服务器断开,请刷新页面重连！");
                        $("#StationStatus").css("background-color", "red");
                    }
                });
                //hub连接开启
                $.connection.hub.start().done(function () {
                    var username =  "<%=stationCode%>";
                    //发送上线信息
                    work.server.register(username);
                    var message="{\"header\":\"PLC\",\"Body\":\""+username+"\"}";
                    work.server.sendPrivateMessage("StationResault", message);
                    //点击按钮，发送消息
                    //$('#send').click(function () {
                    //    var friend = $('#username').val();
                    //    //调用后端函数，发送指定消息
                    //    work.server.sendPrivateMessage(friend, $("#message").val());
                    //});
                }).fail(function () { alert('Could not Connect!'); });
            }
        });
        //重新加载用户列表
        var reloadUser = function (userlist) {
            $("#username").empty();
            for (i = 0; i < userlist.length; i++) {
                $("#username").append("<option value=" + userlist[i].UserName + ">" + userlist[i].UserName + "</option>");
            }
        }
        function GetStaionPlan() {
            var planJPH = "<%=PlanCycle%>";
            var ActureReturn = $("#acturecount").html();
            var StationId = "<%=stationId%>";
            $.post('/Controller/GetStationPlan.ashx', { PlanJPH: planJPH, actureReturn:ActureReturn,stationid:StationId}, function (data) {
                
                if (data != "0") {
                    var arr = data.split('|');
                    if (arr.length >= 4) {
                        $("#planjph").html(arr[0]);
                        $("#JPH").html(arr[1]);
                        $("#userate").html(arr[2] + "%");
                        $("#acturecount").html(arr[3]);
                    }                    
                }
            }, "text");
        }        
        setInterval("TimeRun()", 1000 * 5);//每1000毫秒调用一次函数
        setInterval("GetStaionPlan()", 1000 * 60);//每1000毫秒调用一次函数
    </script>    
</head>
<body id="B" style="overflow: hidden;">
    <form id="form1" runat="server">
        <input id="hstationCode" type="hidden" value="<%=stationCode %>" />
        <div class="title-bar" style="width: 99.5%; height: 60px; margin: 0 auto; min-width: 1024px; position: fixed; top: 0px;">
            <div style="height: 58px; margin: 1px; float: left; margin-left: 15px;">
                <span id="md" style="color: white; font: bold; position: absolute; margin-top: 5px;"></span>
                <br />
                <span id="week" style="color: white; font: bold"></span>
            </div>
            <div style="height: 58px; margin: 1px; float: left; margin-left: 15px;">
                <span id="times" style="position: absolute; margin-top: 15px; margin-left: 15px; color: white; font-size: 24px; font-weight: bolder;"></span>
            </div>
            <div style="height: 58px; margin: 1px; float: left; margin-left: 105px; border-left: 2px #ffffff solid;">
                <span style="position: absolute; margin-top: 5px; margin-left: 5px; color: white; font-size: 8px; font-weight: bolder;">线体名称</span>
                <span style="position: absolute; margin-top: 20px; margin-left: 15px; color: white; font-size: 18px; font-weight: bolder;">
                    <%=linename %>
                </span>
            </div>
            <div style="height: 58px; margin: 1px; float: left; margin-left: 185px; border-left: 2px #ffffff solid;">
                <span style="position: absolute; margin-top: 5px; margin-left: 5px; color: white; font-size: 8px; font-weight: bolder;">站点名称</span>
                <span style="position: absolute; margin-top: 20px; margin-left: 15px; color: white; font-size: 18px; font-weight: bolder;"><%=stationCode %></span>
            </div>
            <div style="height: 58px; margin: 1px; float: left; margin-left: 195px; border-left: 2px #ffffff solid;">
                <span style="position: absolute; margin-top: 5px; margin-left: 5px; color: white; font-size: 8px; font-weight: bolder;">SN</span>
                <span id="sn" style="position: absolute; margin-top: 20px; margin-left: 15px; color: white; font-size: 18px; font-weight: bolder;"></span>
            </div>
            <div style="height: 58px; margin: 1px; float: left; margin-left: 295px; border-left: 2px #ffffff solid;">
                <span style="position: absolute; margin-top: 5px; margin-left: 5px; color: white; font-size: 8px; font-weight: bolder;">产品编号</span>
                <span id="PCode" style="position: absolute; margin-top: 20px; margin-left: 15px; color: white; font-size: 18px; font-weight: bolder;"></span>
            </div>
            <div style="height: 58px;width:60px; text-align:center;cursor: pointer; float:right;color:white;font-size: 18px; font-weight: bolder;margin-right:50px;margin-top: 20px;" onclick="javascript:window.location.href='Station.aspx'">登 出</div>
        </div>
        <div id="x" style="margin-top: 62px; margin-bottom: 62px; min-width: 1024px; min-height: 500px; background-color: rgb(255,255,255); z-index: -999;">
            <div id="process" style="height: 48%; width: 55%; float: left; position: fixed; margin-top: 15px;">
                <div>
                    <span style="font-size: 18px;">过程质量</span><em id="dcount" style="font: 18px; float: right; margin-right:30px; color: red;"></em>
                </div>
                <hr class="style-three" />
                <div class="s-mod" style="width: 98%; overflow-y: auto; height: 90%;">
                    <table class="bordered" id="aptable">
                        <thead>
                            <tr>
                                <th>序号</th>
                                <th style="width: 50%">缺陷及检验项描述</th>
                                <th>生产数据</th>
                            </tr>
                        </thead>

                        <tbody></tbody>
                    </table>
                </div>

            </div>

            <div id="production" style="height: 48%; width: 40%; float: left; position: fixed; margin-top: 15px;">
                <div>
                    <span style="font-size: 18px;">产品信息</span>
                </div>
                <hr class="style-three" />
                <div style="width: 98%; margin: 0 auto; text-align: left; font: 36px bold #ccc;" id="divsn"></div>
                <div style="width: 98%; margin: 0 auto;">
                    <img id="imgx" src="bg.png" width="390" height="180" />
                </div>
            </div>
            <div id="processsheet" style="width: 38%; float: left; position: fixed;">
                <div>
                    <span style="font-size: 18px;">工艺过程</span><em style="font: 18px; float: right;"><a target="_blank" href="<%=ProcessSheet %>">显示作业指导书</a></em>
                </div>
                <hr class="style-three" />
                <div class="s-mod" style="width: 98%; overflow-y: auto;" id="processsheetx">
                    <%--<ul id="processsheetx">
                        
                    </ul>--%>
                </div>


            </div>
            <div id="traceability" style="width: 44%; float: left; position: fixed;">
                <div>
                    <span style="font-size: 18px;">零件追溯</span>
                </div>
                <hr class="style-three" />
                <div class="s-mod" style="width: 98%; overflow-y: auto; height: 90%;">
                    <table class="bordered" id="aptableT">
                        <thead>
                            <tr>
                                <th>序号</th>
                                <th style="width: 50%">追溯零件描述</th>
                                <th>追溯码</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="title-bar" style="position: fixed; width: 99.5%; height: 60px; margin: 0 auto; bottom: 0px; min-width: 1024px;">
            <div style="height: 58px; margin: 1px; float: left; margin-left: 15px;" onclick="kaishi()">
                <span style="position: absolute; margin-top: 20px; margin-left: 15px; color: white; font-size: 18px; font-weight: bolder;">FANUC</span>
            </div>
            <div style="height: 58px; margin: 1px; float: left; margin-left: 105px; border-left: 2px #ffffff solid;">
                <span id="StationStatus" class="round" style="position: absolute; height: 40px; line-height: 40px; margin: 0 auto; margin-top: 10px; margin-left: 15px; width: 320px; color: white; font-size: 18px; font-weight: bolder; background-color: gray; text-align: center;">正在初始化</span>
            </div>
            <div style="height: 58px; margin: 1px; float: left; margin-left: 355px; border-left: 2px #ffffff solid;">
                <span style="position: absolute; margin-top: 5px; margin-left: 5px; color: white; font-size: 8px; font-weight: bolder;">计划产量</span>
                <span style="position: absolute; margin-top: 20px; margin-left: 15px; color: white; font-size: 18px; font-weight: bolder;" id="planjph"></span>
            </div>
            <div style="height: 58px; margin: 1px; float: left; margin-left: 195px; border-left: 2px #ffffff solid;">
                <span style="position: absolute; margin-top: 5px; margin-left: 5px; color: white; font-size: 8px; font-weight: bolder;">实际产量</span>
                <span style="position: absolute; margin-top: 20px; margin-left: 15px; color: white; font-size: 18px; font-weight: bolder;" id="acturecount">0</span>
            </div>
            <div style="height: 58px; margin: 1px; float: left; margin-left: 185px; border-left: 2px #ffffff solid;">
                <span style="position: absolute; margin-top: 5px; margin-left: 5px; color: white; font-size: 8px; font-weight: bolder;">JPH</span>
                <span style="position: absolute; margin-top: 20px; margin-left: 15px; color: white; font-size: 18px; font-weight: bolder;" id="JPH"></span>
            </div>
            <div style="height: 58px; margin: 1px; float: left; margin-left: 195px; border-left: 2px #ffffff solid;">
                <span style="position: absolute; margin-top: 5px; margin-left: 5px; color: white; font-size: 8px; font-weight: bolder;">设备使用率</span>
                <span style="position: absolute; margin-top: 20px; margin-left: 15px; color: white; font-size: 18px; font-weight: bolder;" id="userate"></span>
            </div>
        </div>
        <script src="PLCStationView.js?x=<%=DateTime.Now.Ticks %>"></script>
    </form>
</body>
</html>
