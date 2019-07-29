<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PCStationView.aspx.cs" Inherits="SM.WEB.Station.PCStationView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="win8/base.css" rel="stylesheet" />
    <%--<script src="win8/jquery.js"></script>--%>
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="win8/jquery.easing.js"></script>
    <script src="win8/base.js"></script>
    <script src="pcstationview.js?x=<%=DateTime.Now.Ticks %>"></script>
    <script type="text/javascript">
        $(function () {
            FResize();
            $(window).resize(function () {
                FResize();
            });
            TimeRun();
            var sid = "<%=stationId%>";
            GetProcessSheet(sid);
            GetStaionPlan();
            var scode = "<%=stationCode%>";
            $("#PDSn").blur(function () {
                var sn = $("#PDSn").val();
                if (sn != "") {
                    $("#sn").html(sn);
                    getAP(scode, sn);
                    getQualityCheck(sid, sn);
                    getDefectcount(sid, sn);
                    getErpOrder();
                    IsExitPCStation();
                    $("#PDSn").val("");
                    
                }                
            });
            $("#PDSn").focus();
            
        });

        function GetStaionPlan() {
            var planJPH = "<%=PlanCycle%>";
            var ActureReturn = $("#acturecount").html();
            var StationId = "<%=stationId%>";
            $.post('/Controller/GetStationPlan.ashx', { PlanJPH: planJPH, actureReturn: ActureReturn, stationid: StationId }, function (data) {
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

        var changeinputid;
        function keyDown(e) {
            //IE内核浏览器
            if (navigator.appName == 'Microsoft Internet Explorer') {
                var keycode = event.keyCode;
                var realkey = String.fromCharCode(event.keyCode);
            } else {//非IE内核浏览器
                var keycode = e.which;
                var realkey = String.fromCharCode(e.which);
            }
            // console.log('按键码:' + keycode +  '字符: ' + realkey);

            //监听Ctrl键
            if (keycode == 13) {
                $("input[type=text]").each(function (index, item) {
                    debugger
                    if ($(item).is(':focus')) {
                        if ($(item).val() != "") {
                            debugger
                            $(item).blur();
                        }
                        return false;
                    }
                });
                return false;
            }
            //$("#birthday").change(function () {
            //    console.log($(this).val());
            //    $("#birthday").select();
            //})

            //$("input[type=text]").each(function (index, item) {
            //    $(item).change(function () {
            //        changeinputid = index;
            //        //alert(item.id);
            //    })
            //});

        }
        document.onkeydown = keyDown;
    </script>

</head>
<body id="B" style="overflow: hidden;">
    <form id="form1" runat="server">
        <input type="hidden" id="scodex" value="<%=stationCode %>" />
        <input type="hidden" id="scodexid" value="<%=stationId %>" />
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
                <span id="xstationcode" style="position: absolute; margin-top: 20px; margin-left: 15px; color: white; font-size: 18px; font-weight: bolder;"><%=stationCode %></span>
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
            <div id="process" style="height: 48%; width: 30%; float: left; position: fixed; margin-top: 15px;">
                <div style="width:99%;">
                    <span style="font-size: 18px;">过程质量</span><em id="defectcount" class="round" style="font: 18px; float: right; color: red; ">已开缺陷0个</em><%--<em style="font: 18px; float: right; color: red;">已开缺陷5个</em>--%>
                </div>
                <hr class="style-three"  />
                <div style="width: 98%; overflow-y: auto;" id="dul">
                </div>

            </div>

            <div id="process2" style="height: 48%; width: 30%; float: left; position: fixed; margin-top: 15px;">
                <div>
                    <span style="font-size: 18px;">过程质量</span>
                </div>
                <hr class="style-three" />
                <div id="QualityCheck" style="width: 98%;  overflow-y:auto;height:80%;">
                    <%--<div class="round" style="width: 98%;margin:5px auto;  height: 50px; font: 24px bold;border:2px solid #fff;">
                        <div class="round_left" id="" style="width:15%; text-align: center;color:white;float:left;height: 50px;background-color:green;"><span style="float:left;margin-top:11px;width:100%;">√</span></div>
                        <div style="height: 50px;width:68%; float:left;text-align: center;border-left:2px solid #fff;border-right:2px solid #fff;color:white;background-color:#1CA1E2;"><span style="float:left;margin-top:11px;width:100%;">11414141414141241</span></div>
                        <div class="round_right" style="height: 50px;width: 15%; text-align: center;color:white;float:left;background-color:crimson;"><span style="float:left;margin-top:11px;width:100%;"></span></div>
                    </div>
                    <div class="round" style="width: 98%;margin:5px auto;  height: 50px; font: 24px bold;border:2px solid #fff;">
                        <div class="round_left" id="" style="width:15%; text-align: center;color:white;float:left;height: 50px;background-color:green;"><span style="float:left;margin-top:11px;width:100%;">OK</span></div>
                        <div style="height: 50px;width:68%; float:left;text-align: center;border-left:2px solid #fff;border-right:2px solid #fff;color:white;background-color:#1CA1E2;"><span style="float:left;margin-top:11px;width:100%;">11414141414141241</span></div>
                        <div class="round_right" style="height: 50px;width: 15%; text-align: center;color:white;float:left;background-color:crimson;"><span style="float:left;margin-top:11px;width:100%;">NG</span></div>
                    </div>
                    <div class="round" style="width: 98%;margin:5px auto;  height: 50px; font: 24px bold;border:2px solid #fff;">
                        <div class="round_left" id="" style="width:15%; text-align: center;color:white;float:left;height: 50px;background-color:green;"><span style="float:left;margin-top:11px;width:100%;">OK</span></div>
                        <div style="height: 50px;width:68%; float:left;text-align: center;border-left:2px solid #fff;border-right:2px solid #fff;color:white;background-color:#1CA1E2;"><span style="float:left;margin-top:11px;width:100%;">11414141414141241</span></div>
                        <div class="round_right" style="height: 50px;width: 15%; text-align: center;color:white;float:left;background-color:crimson;"><span style="float:left;margin-top:11px;width:100%;">NG</span></div>
                    </div>   --%>                 
                </div>

            </div>
            <div id="production" style="height: 48%; width: 34%; float: left; position: fixed; margin-top: 15px;">
                <div>
                    <span style="font-size: 18px;">产品信息</span>
                </div>
                <hr class="style-three" />
                <div style="width: 98%; margin: 0 auto; text-align: center; font: 36px bold #ccc;">
                    <input type="text" id="PDSn"  class="round" style="width: 90%; margin: 5px auto; font: 36px bold #ccc;"  />
                </div>
                <div style="width: 98%; margin: 0 auto;">
                    <img id="imgx" src="bg.png" width="390" height="180" />
                </div>
                <div style="width: 98%; margin: 0 auto; text-align: center; font: 36px bold #ccc;">
                    <input type="button" id="CloseProduction" onclick="TransitStation(this)"  class="button white-gradient " style="display:none;width: 90%; margin: 5px auto; font-size: 24px;font-weight:bold; "  value="完     成" />
                    <div id="closestatus"  class="button white-gradient " style="display:none;width: 90%; margin: 5px auto; font-size: 24px;font-weight:bold;">生产已完成</div>
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
                <span id="StationStatus" class="round" style="position: absolute; height: 40px; line-height: 40px; margin: 0 auto; margin-top: 10px; margin-left: 15px; width: 320px; color: white; font-size: 18px; font-weight: bolder; background-color: green; text-align: center;">正常</span>
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
    </form>
</body>
</html>
