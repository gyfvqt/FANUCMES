function FResize() {
    var h = (window.innerHeight - 120) < 500 ? 500 : (window.innerHeight - 120);
    var w = window.innerWidth < 1024 ? 1024 : window.innerWidth;
    //中间部分高度
    $("#x").height(h);
    $("#x").width(w);
    var hafth = parseInt(h * 0.48);
    $("#process").height(hafth);
    $("#process2").height(hafth);
    $("#production").height(hafth);
    $("#processsheet").height(hafth);
    $("#processsheetx").height(hafth-100);
    $("#traceability").height(hafth-100);
    var w3 = parseInt(w * 0.30);
    var w2 = parseInt(w * 0.46);

    $(".title-bar").width(w);
    $("#process").css({ "width": w3, "margin-left": "25px" });
    $("#process2").css({ "width": w3, "margin-left": w3 + 50 });
    $("#production").css({ "width": w3, "margin-left": w3 * 2 + 75 });
    $("#processsheet").css({ "width": w2, "margin-left": "25px", "margin-top": hafth + 30 + 25 });
    $("#traceability").css({ "width": w2, "margin-left": w2 + 50, "margin-top": hafth + 30 + 25 });
    $("#imgx").css("width", w3);

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

function GetProduct(productionSN) {
    $.post('/Controller/PLCStation/GetStationProduct.ashx', { productionsn: productionSN }, function (data) {
        var ohtml = '';
        if (data.length > 0) {
            $("#imgx").attr("src", data[0].ProductionImg == "" ? "bg.png" : data[0].ProductionImg);
        }
    }, "json");
}

function GetProcessSheet(stationId) {
    $.post('/Controller/PLCStation/GetProcessSheet.ashx', { stationid: stationId }, function (data) {
        var ohtml = '';
        var xhtml = '';
        var sn = $("#sn").html();
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                //ohtml += '<li class="s-mod-item" w="98%" h="30" l="' + (parseInt(i)*36) + '" t="0" bg="#ccc" cbg="#ccc">';
                ohtml += '<div class="round" style="border:1px #ccc solid;background-color:#ccc;padding:5px;margin:5px;">';
                ohtml += '<div  style="text-align: left;color:white;"><span>' + (i + 1) + '    |     ' + data[i].ProcessName + '</span></div>';
                ohtml += '</div>';
                //ohtml += '</li>';
                
            }
            var colorarr = ['#e8443a', '#aa5096', '#1CA1E2', '#FFD302', '#8DC027', '#FF0198', '#2b7ab7', '#9B4C13', '#33ac5b','#d92e24', '#922a7b', '#1182BA', '#EAC203', '#76A31B', '#D80683', '#1e669d', '#8F4108', '#209747'];
            var x = (data.length % 3 == 0) ? (data.length / 3) : (data.length / 3 + 1);//计算出行数
            var arr = new Array();         //先声明一维 
            for (var k = 0; k < x; k++) {          //一维长度为5 
                //arr[i] = new Array(i);    //在声明二维 
                for (var j = 0; j < 3; j++) {      //二维长度为5 
                    if ((k * 3 + j) < data.length) //arr[i][j] = data[];
                    {
                        xhtml += '<div id="S' + data[k * 3 + j].ProcessId + '" onclick="InsertDefectbyProcess(\'' + stationId + '\',\'' + sn + '\',\'' + data[k * 3 + j].ProcessId + '\')" class="s-mod-wrap round" style="cursor: pointer;float:left;margin-left:5px ;margin-top:5px; width: 118px; height: 60px;">';
                        xhtml += '<div class="s-mod-def" style="top: 0px; width: 94px; height: 60px;line-height: 60px; background-color: ' + colorarr[k * 3 + j]+';"><span>' + data[k * 3 + j].ProcessName + '</span></div>';                        
                        xhtml += '</div>';
                    }
                }

            } 
            $("#processsheetx").html(ohtml);
            $("#dul").html(xhtml);
        }
    }, "json");
}

function getAP(station, pcode) {
    $.post('/Controller/PCStation/PCtTraceabily.ashx', { stationcode: station, productionid: pcode }, function (data) {
        var ohtml = '';
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                ohtml += '<tr >';
                ohtml += '<td style="background-color: beige;width:40px;">' + (i + 1) + '</td>';
                ohtml += '<td style="width: 50%; background-color: beige;">' + data[i].TraceabilityDesc + '</td>';
                if (data[i].ParkSn != "") {
                    ohtml += '<td style="background-color: beige;" id="AP' + data[i].TraceabilityId + '">' + data[i].ParkSn + '</td>';
                }
                else {
                    ohtml += '<td style="background-color: beige;" id="AP' + data[i].TraceabilityId + '"><input type="text" maxlength="128" onblur="TResult(this);return false;" id="T' + i + '" class="round" style="width: 90%; margin: 5px auto; font: 24px bold #ccc;border:2px solid #1CA1E2;" /></td>';
                }
                ohtml += '</tr>';
            }
            $("#aptableT tbody").html(ohtml);
            $("#T0").focus();
        }
    }, "json");    
}

function TResult(obj) {
    var Tsn = $(obj).val();
    if (Tsn == "") { return; }
    var TID = $(obj).parent().attr('id').substring(2);
    var scode = $("#scodex").val();
    var pcode = $("#sn").html();
    var nextid = parseInt( $(obj).attr('id').substring(1))+1;
    $.post('/Controller/PCStation/InsertTraceability.ashx', { stationcode: scode, productionid: pcode, tsn: Tsn, tid: TID }, function (data) {
        debugger
        if (data == "1") {
            $(obj).parent().html(Tsn);
            if ($("#T" + nextid)[0] != undefined) {
                $("#T" + nextid).focus();
            }
            else {
                $("#PDSn").focus();
            }

        }
    }, "json");  
}

function getQualityCheck(station, pcode) {
    $.post('/Controller/PCStation/PCStationQuality.ashx', { stationid: station, productionid: pcode }, function (data) {
        var ohtml = '';
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                ohtml += '<div class="round" style="width: 98%;margin:5px auto;  height: 50px; font: 24px bold;border:2px solid #fff;">';
                if (data[i].LastStatus == "OK") {
                    ohtml += '<div class="round_left"  style="width:15%; text-align: center;color:white;float:left;height: 50px;background-color:green;"><span style="float:left;margin-top:11px;width:100%;">√</span></div>';
                    ohtml += '<div style="height: 50px;width:68%; float:left;text-align: center;border-left:2px solid #fff;border-right:2px solid #fff;color:white;background-color:#1CA1E2;"><span style="float:left;margin-top:11px;width:100%;">' + data[i].QualityDesc + '</span></div>';
                    ohtml += '<div class="round_right" style="height: 50px;width: 15%; text-align: center;color:white;float:left;background-color:crimson;"><span style="float:left;margin-top:11px;width:100%;"></span></div>';
                }
                else if (data[i].LastStatus == "NOK") {
                    ohtml += '<div class="round_left"  style="width:15%; text-align: center;color:white;float:left;height: 50px;background-color:green;"><span style="float:left;margin-top:11px;width:100%;"></span></div>';
                    ohtml += '<div style="height: 50px;width:68%; float:left;text-align: center;border-left:2px solid #fff;border-right:2px solid #fff;color:white;background-color:#1CA1E2;"><span style="float:left;margin-top:11px;width:100%;">' + data[i].QualityDesc + '</span></div>';
                    ohtml += '<div class="round_right" style="height: 50px;width: 15%; text-align: center;color:white;float:left;background-color:crimson;"><span style="float:left;margin-top:11px;width:100%;">X</span></div>';
                }
                else {
                    ohtml += '<div class="round_left"  style="cursor: pointer;width:15%; text-align: center;color:white;float:left;height: 50px;background-color:green;" id="QOK' + data[i].QualityId + '" onclick="InsertDefect(\'' + station + '\',\'' + pcode + '\',\'' + data[i].QualityId  + '\',\'OK\')"><span style="float:left;margin-top:11px;width:100%;">OK</span></div>';
                    ohtml += '<div style="height: 50px;width:68%; float:left;text-align: center;border-left:2px solid #fff;border-right:2px solid #fff;color:white;background-color:#1CA1E2;"><span style="float:left;margin-top:11px;width:100%;">' + data[i].QualityDesc + '</span></div>';
                    ohtml += '<div class="round_right" style="cursor: pointer;height: 50px;width: 15%; text-align: center;color:white;float:left;background-color:crimson;" id="QNG' + data[i].QualityId + '" onclick="InsertDefect(\'' + station + '\',\'' + pcode + '\',\'' + data[i].QualityId + '\',\'NOK\')"><span style="float:left;margin-top:11px;width:100%;" >NG</span></div>';
                }                
                ohtml += '</div>';
            }
            $("#QualityCheck").html(ohtml);
        }
    }, "json");
}

function InsertDefect(stationid, productionsn, qualityid, resault) {
    $.post('/Controller/PCStation/InsertPCStationQuality.ashx', { stationid: stationid, productionid: productionsn, okng: resault, qid: qualityid }, function (data) {
        if (data != "-1") {
            //$(obj).parent().html(Tsn);
            //$("#QOK" + qualityid).focus();
            if (resault == "OK") {
                $("#QOK" + qualityid).html('<span style="float:left;margin-top:11px;width:100%;font:bolder;">√</span>');
                $("#QNG" + qualityid).html('<span style="float:left;margin-top:11px;width:100%;"></span>');
            }
            else if (resault == "NOK") {
                $("#QOK" + qualityid).html('<span style="float:left;margin-top:11px;width:100%;"></span>');
                $("#QNG" + qualityid).html('<span style="float:left;margin-top:11px;width:100%;font:bolder;">X</span>');
            }
            $("#QOK" + qualityid).removeAttr("onclick");
            $("#QNG" + qualityid).removeAttr("onclick");
            $("#defectcount").html("已开缺陷" + data + "个");
        }
    }, "json");  
}
function InsertDefectbyProcess(stationid, productionsn, qualityid) {

    if (productionsn == "" && $("#sn").html() == "") {
        return false;
    }
    else {
        productionsn = $("#sn").html();
        if (productionsn == "") {
            return false;
        }
    }
    $.post('/Controller/PCStation/InsertDefectByProcess.ashx', { stationid: stationid, productionid: productionsn,  qid: qualityid }, function (data) {
        if (data != "-1") {        
            
            $("#defectcount").html("已开缺陷" + data + "个");
        }
    }, "json");
}
function getDefectcount(stationid, productionsn) {
    $.post('/Controller/PCStation/getDefectcount.ashx', { stationid: stationid, productionid: productionsn }, function (data) {
        if (data != "-1") {
            $("#defectcount").html("已开缺陷" + data + "个");
        }
    }, "text");
}
function TransitStation(obj) {
    var productionsn = $("#sn").html();
    var stationid = $("#scodexid").val();
    if (productionsn != "" && stationid != "") { 
    $.post('/Controller/PCStation/PCStationTransit.ashx', { stationid: stationid, productionid: productionsn }, function (data) {
        if (data != "-1") {
            $(obj).hide();
        }
        }, "text");
    }
}

function getErpOrder() { 
    var productionsn = $("#sn").html();
    
    if (productionsn != "" ) {
        $.post('/Controller/PCStation/GetProdcution.ashx', { productionid: productionsn }, function (data) {
            if (data.length>0) {
                $("#PCode").html(data[0].ProductionCode);
            }
        }, "json");
    }
}

function IsExitPCStation() {
    var productionsn = $("#sn").html();
    var stationid = $("#scodexid").val();
    if (productionsn != "" && stationid != "") {
        $.post('/Controller/PCStation/IsExitPCStation.ashx', { stationid: stationid, productionid: productionsn }, function (data) {
            if (data == "1") {                
                $("#CloseProduction").hide();
                $("#closestatus").show();
            }
            if (data == "0") {
                $("#closestatus").hide();
                $("#CloseProduction").show();
            }
        }, "text");
    }
}