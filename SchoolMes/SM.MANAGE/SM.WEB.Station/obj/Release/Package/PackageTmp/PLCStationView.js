function getAP(station, pcode) {
    $.post('/Controller/PLCStation/TraceabilityResult.ashx', { stationcode: station, productionid: pcode }, function (data) {
        var ohtml = '';
        if (data.length>0) {            
            for (var i = 0; i < data.length; i++) {
                ohtml += '<tr style="background-color: beige;">';
                ohtml += '<td style="background-color: beige;width:40px;">' + (i + 1) + '</td>';
                ohtml += '<td style="width: 50%; background-color: beige;">' + data[i].APDataDesc + '</td>';
                ohtml += '<td style="background-color: beige;" id="AP' + data[i].PLCAPId + '">' + data[i].ParkSn + '</td>';
                ohtml += '</tr>';
            }
            $("#aptableT tbody").html(ohtml);
        }
    }, "json");
}

function getUP(station, pcode) {
    $.post('/Controller/PLCStation/PLCUPResult.ashx', { stationcode: station, productionid: pcode }, function (data) {
        var ohtml = '';
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                ohtml += '<tr style="background-color: beige;">';
                ohtml += '<td style="background-color: beige;width:40px;">' + (i + 1) + '</td>';
                ohtml += '<td style="width: 60%; background-color: beige;">' + data[i].UPDataDesc + '</td>';
                if (data[i].PLCDataResult == "NOK" || data[i].PLCDataResult == "KO") {
                    ohtml += '<td style="background-color: red;" id="UP' + data[i].PLCUPId + '">' + data[i].PLCDataResult + '</td>';
                }
                else if (data[i].PLCDataResult == "OK") {
                    ohtml += '<td style="background-color: green;" id="UP' + data[i].PLCUPId + '">' + data[i].PLCDataResult + '</td>';
                }
                else  {
                    ohtml += '<td style="background-color: beige;" id="UP' + data[i].PLCUPId + '">' + data[i].PLCDataResult + '</td>';
                }
                ohtml += '</tr>';
            }
            $("#aptable tbody").html(ohtml);
        }
    }, "json");
}

function FResize() {
    var h = (window.innerHeight - 120) < 500 ? 500 : (window.innerHeight - 120);
    var w = window.innerWidth < 1024 ? 1024 : window.innerWidth;
    //中间部分高度
    $("#x").height(h);
    $("#x").width(w);
    var hafth = parseInt(h * 0.48);
    $("#process").height(hafth);
    $("#production").height(hafth);
    $("#processsheet").height(hafth);
    $("#processsheetx").height(hafth-100);
    $("#traceability").height(hafth - 80);
    var w3 = parseInt(w * 0.55);
    var w2 = parseInt(w * 0.46);
    var w4 = parseInt(w * 0.40);

    $(".title-bar").width(w);
    $("#process").css({ "width": w3 , "margin-left": "25px" });
    $("#production").css({ "width": w4, "margin-left": w3 + 50 });
    //$("#process").css({ "width": w3 * 2, "margin-left": "25px" });
    //$("#production").css({ "width": w3, "margin-left": w3 * 2 + 50 });
    $("#processsheet").css({ "width": w2, "margin-left": "25px", "margin-top": hafth + 30 + 25 });
    $("#traceability").css({ "width": w2, "margin-left": w2 + 50, "margin-top": hafth + 30 + 25 });
    $("#imgx").css("width", parseInt(w * 0.25));
}
function fullScreen() {
    var el = document.documentElement,
        rfs = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullScreen,
        wscript;

    if (typeof rfs != "undefined" && rfs) {
        rfs.call(el);
        return;
    }

    if (typeof window.ActiveXObject != "undefined") {
        wscript = new ActiveXObject("WScript.Shell");
        if (wscript) {
            wscript.SendKeys("{F11}");
        }
    }
}
function kaishi() {
    var docElm = document.documentElement;
    //W3C 
    if (docElm.requestFullscreen) {
        docElm.requestFullscreen();
    }
    //FireFox 
    else if (docElm.mozRequestFullScreen) {
        docElm.mozRequestFullScreen();
    }
    //Chrome等 
    else if (docElm.webkitRequestFullScreen) {
        docElm.webkitRequestFullScreen();
    }
    //IE11 
    else if (docElm.msRequestFullscreen) {
        docElm.msRequestFullscreen();
    }
    FResize();
}
function TimeRun() {
    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth() + 1;//月份少1
    var date = now.getDate();
    var week = "星期" + "日一二三四五六".split(/(?!\b)/)[now.getDay()];
    var hours = now.getHours();
    if (hours < 10) {
        hours = "0" + hours;
    }
    var minutes = now.getMinutes();
    if (minutes < 10) {
        minutes = "0" + minutes;
    }
    var seconds = now.getSeconds();
    if (seconds < 10) {
        seconds = "0" + seconds;
    }

    $("#md").html(month + "/" + date);
    $("#week").html(week);
    $("#times").html(hours + ":" + minutes);
}

function SignalRInit() {
    if (scode != "") {
        //getAP(scode, "");
        //getUP(scode, "");
        $.connection.hub.url = 'http://<%=HUPIP %>/signalr';
        $.connection.hub.logging = true;
        var work = $.connection.IMHub;
        var fromUser = "<%=stationCode%>";

        //对应后端的SendMessage函数，消息接收函数
        work.client.receivePrivateMessage = function (user, message) {
            if (message != undefined) {
                //alert(message);
                var msg = JSON.parse(message);
                if (msg.RO == "ENDSN") {
                    $("#sn").html(msg.Resault);
                    $("#divsn").html(msg.Resault);
                    $("#PCode").html(msg.ProductionCode);
                    getAP(scode, msg.Resault);
                    getUP(scode, msg.Resault);
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
        //    alert("断了！了！");
        //};
        $.connection.hub.stateChanged(function (change) {
            if (change.newState === $.signalR.connectionState.reconnecting) {
                $("#StationStatus").html("正在连接服务器......");
                $("#StationStatus").css("background-color", "gray");
            }
            else if (change.newState === $.signalR.connectionState.connected) {
                $("#StationStatus").html("正常");
                $("#StationStatus").css("background-color", "green");
            }
            else if (change.newState === $.signalR.connectionState.disconnected) {
                $("#StationStatus").html("服务器断开,请刷新页面重连！");
                $("#StationStatus").css("background-color", "gray");
            }
        });
        //hub连接开启
        $.connection.hub.start().done(function () {
            var username = "<%=stationCode%>";
            //发送上线信息
            work.server.register(username);
            work.server.sendPrivateMessage("StationResault", username);
            //点击按钮，发送消息
            //$('#send').click(function () {
            //    var friend = $('#username').val();
            //    //调用后端函数，发送指定消息
            //    work.server.sendPrivateMessage(friend, $("#message").val());
            //});
        }).fail(function () { alert('Could not Connect!'); });


    }
}

function GetProcessSheet(stationId) {
    $.post('/Controller/PLCStation/GetProcessSheet.ashx', { stationid: stationId}, function (data) {
        var ohtml = '';
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                //ohtml += '<li class="s-mod-item" w="98%" h="30" l="' + (parseInt(i)*36) + '" t="0" bg="#ccc" cbg="#ccc">';
                ohtml += '<div class="round" style="border:1px #ccc solid;background-color:#ccc;padding:5px;margin:5px;">';
                ohtml += '<div  style="text-align: left;color:white;"><span>' + (i + 1) + '    |     ' + data[i].ProcessName+'</span></div>';
                ohtml += '</div>';
                //ohtml += '</li>';
            }
            $("#processsheetx").html(ohtml);
        }
    }, "json");
}

function GetProduct(productionSN) {
    $.post('/Controller/PLCStation/GetStationProduct.ashx', { productionsn: productionSN }, function (data) {
        var ohtml = '';
        if (data.length > 0) {
            $("#imgx").attr("src", data[0].ProductionImg == "" ? "bg.png" : data[0].ProductionImg);
        }
    }, "json");
}

function GetDefectCount(productionSN, StationId) {
    $.post('/Controller/PLCStation/GetDefectCount.ashx', { productionSN: productionSN, stationid: StationId }, function (data) {        
        if (data.length > 0) {
            $("#dcount").html("已开缺陷" + data[0].DCount+"个");
        }
    }, "json");
}

