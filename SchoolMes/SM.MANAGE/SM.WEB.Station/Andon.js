function AlarmTime() {
    var d = new Date();
    var showtime = (d.getHours() > 9 ? d.getHours() : ("0" + d.getHours())) + ":" + (d.getMinutes() > 9 ? d.getMinutes() : ("0" + d.getMinutes()) )+ ":" + (d.getSeconds() > 9 ? d.getSeconds() : ("0" + d.getSeconds()));
    var showdate = ((d.getMonth() + 1) > 9 ? (d.getMonth() + 1) : ("0" + (d.getMonth() + 1))) + "月" + (d.getDate() > 9 ? d.getDate():("0" + d.getDate()))+"日";
    $("#currentdate").html(showdate);
    $("#currenttime").html(showtime);
}
function AlarmSetting() {
    $("#divalarm div").each(function (index,item) {
        var id = item.id.substr(1);
        var htime = $("#htime" + id).val();
        var d = new Date();
        var d1 = new Date(htime);
        var dspan = d - d1;
        var dspanx = formatSeconds(dspan / 1000);
        $("#stime"+id).html(dspanx);
    });
    
}

function formatSeconds(value) {
    var secondTime = parseInt(value);// 秒
    var minuteTime = 0;// 分
    var hourTime = 0;// 小时
    if (secondTime > 60) {//如果秒数大于60，将秒数转换成整数
        //获取分钟，除以60取整数，得到整数分钟
        minuteTime = parseInt(secondTime / 60);
        //获取秒数，秒数取佘，得到整数秒数
        secondTime = parseInt(secondTime % 60);
        //如果分钟大于60，将分钟转换成小时
        if (minuteTime > 60) {
            //获取小时，获取分钟除以60，得到整数小时
            hourTime = parseInt(minuteTime / 60);
            //获取小时后取佘的分，获取分钟除以60取佘的分
            minuteTime = parseInt(minuteTime % 60);
        }
    }
    var ss = parseInt(secondTime) > 9 ? parseInt(secondTime) : ("0" + parseInt(secondTime));
    var result = "" +ss ;

    if (minuteTime > 0) {
        var mm = parseInt(minuteTime) > 9 ? parseInt(minuteTime) : ("0" + parseInt(minuteTime));
        result = "" + mm + ":" + result;
    }
    else {
        result = "00:" + result;
    }
    if (hourTime > 0) {
        var hh = parseInt(hourTime) > 9 ? parseInt(hourTime) : ("0" + parseInt(hourTime));
        result = "" + hh + ":" + result;
    }
    else {
        result = "00:" + result;
    }
    return result;
}


function GetAlarm(Team) {
    $.post('/Controller/Andon/getAlarm.ashx', { team: Team }, function (data) {
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                $("#eq" + i).html(data[i].EquipmentName + ":" + data[i].FaultDesc);
            }
        }
        else {
            $("#eq0").html("");
            $("#eq1").html("");
        }
    }, "json");
}

function GetStationAlarm(Team) {
    $.post('/Controller/Andon/getStationAlarm.ashx', { team: Team }, function (data) {
        var ohtml = "";
        var myAuto = document.getElementById('myaudio');
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                ohtml += '<div id="s' + data[i].ID + '" class="Alarm">';
                ohtml += '<div class="AlarmStation">' + data[i].StationCode + '</div>';
                ohtml += '<img src="win8/images/alarm1.png" />';
                var d = new Date();
                var d1 = new Date(data[i].StartTime.replace(/-/g, "/").replace(/T/g, " "));
                var dspan = d - d1;
                var dspanx = formatSeconds(dspan / 1000);
                ohtml += '<span id="stime' + data[i].ID + '" class="AlarmTime" >' + dspanx + '</span>';
                ohtml += '<input type="hidden" id="htime' + data[i].ID + '" value="' + data[i].StartTime.replace(/-/g, "/").replace(/T/g, " ") + '" />';
                ohtml += '</div>';
            }            
            myAuto.play();
        }
        else {            
            myAuto.pause();
            myAuto.load();
        }
        $("#divalarm").html(ohtml);
    }, "json");
}

function GetLineStatus(LineId) {
    $.post('/Controller/Andon/getLineStatus.ashx', { lineid: LineId }, function (data) {        
        if (data.length > 0) {
            switch (data[0].FaultType) {
                case "0":
                    $("#spanStatus").html("休息");
                    $("#divStatus").css("background", "gray");
                    break;
                case "1":
                    $("#spanStatus").html("离线");
                    $("#divStatus").css("background", "gray");
                    break;
                case "2":
                    $("#spanStatus").html("故障停线");
                    $("#divStatus").css("background", "red");
                    break;               
                case "3":
                    $("#spanStatus").html("缺件");
                    $("#divStatus").css("background", "yellow");
                    break;
                case "4":
                    $("#spanStatus").html("堵塞");
                    $("#divStatus").css("background", "blue");
                    break;
                case "5":
                    $("#spanStatus").html("正常");
                    $("#divStatus").css("background", "chartreuse");
                    break;
            }
        }        
    }, "json");
}

function getListStatus(val) {
    switch (val) {
        case "0":
            $("#spanStatus").html("休息");
            $("#divStatus").css("background", "gray");
            break;
        case "1":
            $("#spanStatus").html("离线");
            $("#divStatus").css("background", "gray");
            break;
        case "2":
            $("#spanStatus").html("故障停线");
            $("#divStatus").css("background", "red");
            break;
        case "3":
            $("#spanStatus").html("缺件");
            $("#divStatus").css("background", "yellow");
            break;
        case "4":
            $("#spanStatus").html("堵塞");
            $("#divStatus").css("background", "blue");
            break;
        case "5":
            $("#spanStatus").html("正常");
            $("#divStatus").css("background", "chartreuse");
            break;
    }
}