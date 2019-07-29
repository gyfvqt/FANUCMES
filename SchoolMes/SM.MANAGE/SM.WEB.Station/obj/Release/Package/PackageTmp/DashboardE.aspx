<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardE.aspx.cs" Inherits="SM.WEB.Station.DashboardE" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="/echarts/css/bootstrap.css" rel="stylesheet" />
    <link href="/echarts/css/index.css?x=1" rel="stylesheet" />
    <script src="/echarts/js/jquery.min.js"></script>
    <script src="build/dist/echarts.js"></script>
    <script src="ichartjs-master/ichart.1.2.1.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="lineid" value="<%=lineid %>"  />
        <div style="text-align: center; clear: both;">
            <!--头部-->
            <div class="header">
                生产监控（<%=linename %>）
                <a href="javascript:;" class="a-access">
                    <button id="times" class="button type1">
                    </button>
                </a>
            </div>
            <!--主体-->
            <div class="main clearfix">
                <div class="main-leftE">
                    <div id="TL" class="border-container" style="height: 330px;">
                        <div class="name-title">
                            瓶颈分析
                        </div>
                        <div id="radar"></div>
                        <span class="top-left border-span"></span>
                        <span class="top-right border-span"></span>
                        <span class="bottom-left border-span"></span>
                        <span class="bottom-right border-span"></span>
                    </div>
                    <div id="BL" class="border-container">
                        <div class="name-title">
                            Top10故障分析
                        </div>
                        <div id="graduateyear"></div>
                        <div style="color:#fff;font-weight:bold;" id="faultdesc">
                            <span>1.真的</span><span>2.假的</span><span>1</span><span>1</span>
                        </div>
                        <span class="top-left border-span"></span>
                        <span class="top-right border-span"></span>
                        <span class="bottom-left border-span"></span>
                        <span class="bottom-right border-span"></span>
                    </div>
                </div>
                <div class="main-middleE">
                    <div id="TM" class="border-container">
                        <div class="name-title">
                            设备状态
                        </div>
                        <div id="edubalance" class="round" style="width: 99%; height: 80%;">
                            <div id="dive" class="round" style="float: left; width: 46%; margin: 2%; background-color: #0094ff; height: 100%; line-height: 40px;">
                                <div id="divEtime">
                                    <span style="width: 100%; text-align: center; font-size: 150%; font-weight: bold; color: #fff;">累计运行时间</span><br />
                                    <span id="totalRuntime" style="width: 100%; text-align: center; font-size: 250%; font-weight: bold; color: #fff;">0</span><br />
                                    <span style="width: 100%; text-align: center; font-size: 150%; font-weight: bold; color: #fff;">累计停机时间</span><br />
                                    <span id="totalFaultTime" style="width: 100%; text-align: center; font-size: 250%; font-weight: bold; color: #fff;">0</span>
                                </div>
                            </div>
                            <div id="divj" class="round" style="float: left; width: 46%; margin: 2%; background-color: #0094ff; height: 100%; line-height: 28px;">
                                <div id="divJPH">
                                    <span style="width: 100%; text-align: center; font-size: 150%; font-weight: bold; color: #fff;">线体设计JPH</span><br />
                                    <span id="designJPH" style="width: 100%; text-align: center; font-size: 250%; font-weight: bold; color: #fff;">0</span><br />
                                    <span style="width: 100%; text-align: center; font-size: 150%; font-weight: bold; color: #fff;">线体实际JPH</span><br />
                                    <span id="JPH" style="width: 100%; text-align: center; font-size: 250%; font-weight: bold; color: #fff;">0</span><br />
                                    <span style="width: 100%; text-align: center; font-size: 150%; font-weight: bold; color: #fff;">设备使用率</span><br />
                                    <span id="OEE" style="width: 100%; text-align: center; font-size: 250%; font-weight: bold; color: #fff;">0</span>
                                </div>
                            </div>
                        </div>

                        <span class="top-left border-span"></span>
                        <span class="top-right border-span"></span>
                        <span class="bottom-left border-span"></span>
                        <span class="bottom-right border-span"></span>
                    </div>
                    <div id="BM" class="border-container">
                        <div class="name-title">
                            线体OEE
                        </div>
                        <div id="changedetail"></div>
                        <span class="top-left border-span"></span>
                        <span class="top-right border-span"></span>
                        <span class="bottom-left border-span"></span>
                        <span class="bottom-right border-span"></span>
                    </div>
                </div>
            </div>
        </div>
        <script src="DashboardE.js?x=1"></script>
        <script type="text/javascript">

            $(document).ready(function () {
                FResize();
                //GetTLChart();
            });
            $(window).resize(function () {
                FResize();
                //GetTLChart();
                //option.series[0].data[0].value = (Math.random() * 100).toFixed(2) - 0;
                //radar.setOption(option);
                //option1.series[0].data[0].value = 100;
                //mapadd.setOption(option1);
                
            });
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
                var nowTime = year + "/" + month + "/" + date + " " + hours + ":" + minutes + ":" + seconds;
                $("#times").html(nowTime);
            }
            setInterval("TimeRun()", 1000);//每1000毫秒调用一次函数
            setInterval("setRadar()", 1000*30);//每1000毫秒调用一次函数
            setInterval("setOEE()", 1000*30);//每1000毫秒调用一次函数
            setInterval("setTop10()", 1000*30);//每1000毫秒调用一次函数
            
            function FResize() {
                var winH = (window.innerHeight - 120) < 500 ? 500 : (window.innerHeight - 120);
                var TopH = parseInt(winH * 0.5);
                var BottomH = parseInt(winH * 0.5);
                $("#TL").css("height", TopH);
                $("#TM").css("height", TopH);
                $("#BL").css("height", BottomH);
                $("#BM").css("height", BottomH);

                $("#changedetail").css("height", parseInt(BottomH * 0.8));
                $("#radar").css("height", parseInt(TopH * 0.8));
                $("#graduateyear").css("height", parseInt(BottomH * 0.8));
                var divEtimeTop = parseInt(($("#dive").height() - $("#divEtime").height()) / 2);
                var divJPHTop = parseInt(($("#divj").height() - $("#divJPH").height()) / 2);
                $("#divEtime").css("margin-top",divEtimeTop);
                $("#divJPH").css("margin-top",divJPHTop);

                //option3.xAxis[0].data = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
                //option3.series[0].data = [320, 302, 301, 334, 390, 330, 320];
                //option3.series[1].data = [320, 302, 301, 334, 390, 330, 320];
                //option3.series[2].data = [320, 302, 301, 334, 390, 330, 320];
                //option3.series[3].data = [320, 302, 301, 334, 390, 330, 320];
                //option3.series[4].data = [320, 302, 301, 334, 390, 330, 320];
                //radar.hideLoading();
                //radar.setOption(option3);
                setRadar();
                setTop10();
                setOEE();
                changedetail.resize();
                radar.resize();
                graduateyear.resize();
            }

        </script>
    </form>
</body>
</html>
