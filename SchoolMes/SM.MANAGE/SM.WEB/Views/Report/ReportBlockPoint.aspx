<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="ReportBlockPoint.aspx.cs" Inherits="SM.WEB.Views.Report.ReportBlockPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <link href="/echarts/css/bootstrap.css" rel="stylesheet" />
    <%--<script src="/build/dist/echarts.js"></script>--%>
    <script src="/echarts/js/echarts.min.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="瓶颈分析"></asp:Label>
    <section id="main" role="main">
        <style>
            .background {
                max-width: 100%;
                height: auto;
                position: relative;
                display: block;
                margin: 0 auto;
            }

                .background img {
                    width: 100%;
                    height: 100%;
                    display: block;
                }
        </style>
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:设备维护\瓶颈分析</span>
        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="width: 200px; min-height: 480px; overflow-y: auto;">
                    <dt class="closed">
                        <span>设备结构树</span>

                    </dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" id="rolelist" style="display: block;">
                                <div style="">
                                    <div class="easyui-panel" style="padding: 5px">
                                        <ul id="tt" class="easyui-tree"></ul>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </dd>
                </dl>
            </div>

        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left; margin-left: 220px;">
            <div class="with-mid-padding">
                <dl id="dls" class="accordion toggle-mode" style="min-width: 840px; width: auto">
                    <dt class="closed"><span>查询条件</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding" style="display: block; overflow-y: auto; height: auto;">
                            <div class="RadAjaxPanel">
                                <div style="margin-top: 5px; margin-left: 5px;">
                                    <input type="hidden" id="txtid" value="" />
                                    <input type="hidden" id="EType" value="" />
                                    <div style="float: left; margin-top: 5px; width: 100%;">
                                        <label id="ename" style="margin-left: 15px; font: bold 14px">选择节点：</label>
                                    </div>
                                    <div style="float: left; margin-top: 5px; width: 100%;">
                                        <div style="width: 120px; float: left; margin-left: 15px;">
                                            <div style="width: 100%;">生产时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;从：</div>
                                        </div>
                                        <div style="float: left; margin-left: 15px;">
                                            <div style="float: left;">
                                                <input id="datetimePickerBegin" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                            </div>
                                            <span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    </span>
                                            <div style="float: left;">
                                                <input id="datetimePickerEnd" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                            </div>

                                        </div>
                                        <button class="button white-gradient" style="margin-top: 2em; float: right; margin-right: 5px;" onclick="ClearAll();return false;">清  空</button>
                                        <button class="button white-gradient" style="margin-top: 2em; float: right; margin-right: 5px;" onclick="Query();return false;">查  询</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </dd>
                </dl>
            </div>

        </div>
        <div id="dll" class="RadAjaxPanel" style="display: block; position: absolute; float: left; margin-top: 150px; margin-left: 220px;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="min-width: 840px; width: auto">
                    <dt class="closed"><span>瓶颈分析</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div id="divtl" style="margin-top: 5px; margin-left: 5px; height: 318px; width: 98%;">
                                </div>
                                <div id="divDesc" style="width: 98%">
                                </div>
                            </div>


                        </div>

                    </dd>
                </dl>
            </div>
        </div>
    </section>
    <script type="text/javascript">

        //require(
        //    [
        //        'echarts',
        //        'echarts/chart/bar'   // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表

        //    ],
        //    function (ec) {
        //        graduateyear = ec.init(document.getElementById('divtl'));


        //        graduateyear.setOption(option2);
        //    }
        //);

        $(document).ready(function () {
            Search();
            FResize();
        });
        function FResize() {
            var wh = window.innerHeight;
            var hdls = $("#dls").height();
            var wdls = $("#dls").width();
            $("#dll").height(wh - hdls - 200);
            $("#divtl").height(wh - hdls - 220);
            $("#dll").css("margin-top", hdls + 20);
        }
        function Search() {
            $('#tt').tree({
                url: "/Controller/EquipmentDataTrees.ashx",
                method: 'get',
                animate: true,
                onClick: function (node) {
                    //$(this).tree('beginEdit', node.target);
                    //getLeft(node.id);
                    //getRight(node.id);
                    $("#txtid").val(node.id);
                    $("#EType").val(node.EType);
                    $("#ename").html("选择节点：" + node.text);
                    //$(this).tree('getParent',node.target);//获取父亲节点
                }
            });
            //Query();
        }

        function Query() {
            var Eid = $("#txtid").val();
            var Etype = $("#EType").val();
            var DST = $("#datetimePickerBegin").val();
            var DET = $("#datetimePickerEnd").val();
            if (Eid == "" || Etype == "" || DST == "" || DET == "") {
                return;
            }
            $.post('/Controller/ReportBlockPoint.ashx', { eid: Eid, etype: Etype, dtstart: DST, dtend: DET }, function (data) {
                if (data.length > 0) {
                    var x = new Array();
                    var f1 = new Array();
                    var f2 = new Array();
                    var f3 = new Array();
                    var f4 = new Array();
                    var f5 = new Array();
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            x.push(data[i].EquipmentName);
                            f1.push(data[i].f1);
                            f2.push(data[i].f2);
                            f3.push(data[i].f3);
                            f4.push(data[i].f4);
                            f5.push(data[i].f5);
                        }
                        
                    }
                    var graduateyear = echarts.init(document.getElementById('divtl'));
                    option2 = {
                        tooltip: {
                            trigger: 'axis',
                            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                            }
                        },
                        legend: {
                            data: ['离线状态', '设备故障或停线', '堵塞', '缺件', '工作正常'],
                            textStyle: { color: '#ccc' },
                            color: ['gray', 'red', 'blue', 'yellow', 'green']
                        },
                        //toolbox: {
                        //    show: true,
                        //    feature: {
                        //        mark: { show: true },
                        //        dataView: { show: true, readOnly: false },
                        //        magicType: { show: true, type: ['line', 'bar', 'stack', 'tiled'] },
                        //        restore: { show: true },
                        //        saveAsImage: { show: true }
                        //    }
                        //},
                        calculable: true,
                        yAxis: [
                            {
                                type: 'value',
                                splitLine: {
                                    show: false
                                },
                                axisLabel: {
                                    textStyle: { color: '#ccc' }
                                }
                            }
                        ],
                        xAxis: [
                            {
                                type: 'category',
                                //data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
                                data:x,
                                splitLine: {
                                    show: false
                                },
                                axisTick: {
                                    alignWithLabel: true
                                },

                                axisLabel: {
                                    textStyle: { color: '#ccc' }
                                }
                            }
                        ],
                        grid: { borderWidth: 0, y2: '10%' },
                        series: [
                            {
                                name: '离线状态',
                                type: 'bar',
                                stack: '总量',
                                barWidth: 45,
                                itemStyle: {
                                    normal: { label: { show: true, position: 'inside' }, color: function (params) { return 'gray'; } }
                                },
                                //data: [320, 302, 301, 334, 390, 330, 320]
                                data:f1
                            },
                            {
                                name: '设备故障或停线',
                                type: 'bar',
                                stack: '总量',
                                barWidth: 45,
                                itemStyle: { normal: { label: { show: true, position: 'inside' }, color: function (params) { return 'red'; } } },
                                //data: [120, 132, 101, 134, 90, 230, 210]
                                data:f2
                            },
                            {
                                name: '堵塞',
                                type: 'bar',
                                stack: '总量',
                                barWidth: 45,
                                itemStyle: { normal: { label: { show: true, position: 'inside' }, color: function (params) { return 'blue'; } } },
                                //data: [220, 182, 191, 234, 290, 330, 310]
                                data:f3
                            },
                            {
                                name: '缺件',
                                type: 'bar',
                                stack: '总量',
                                barWidth: 45,
                                itemStyle: {
                                    normal: { label: { show: true, position: 'inside', textStyle: { color: 'black' } }, color: function (params) { return 'yellow'; } }
                                },
                                //data: [150, 212, 201, 154, 190, 330, 410]
                                data:f4
                            },
                            {
                                name: '工作正常',
                                type: 'bar',
                                stack: '总量',
                                barWidth: 45,
                                itemStyle: { normal: { label: { show: true, position: 'inside' }, color: function (params) { return 'chartreuse'; } } },
                                //data: [820, 832, 901, 934, 1290, 1330, 1320]
                                data:f5
                            }
                        ]
                    };
                    graduateyear.setOption(option2);
                }
            }, "json");

        }
        function ClearAll() {
            $("#txtid").val("");
            $("#EType").val("");
            $("#datetimePickerBegin").val("");
            $("#datetimePickerEnd").val("");
            $("#ename").html("选择节点：");
        }
    </script>
</asp:Content>
