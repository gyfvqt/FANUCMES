<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="ReportFaultTop10.aspx.cs" Inherits="SM.WEB.Views.Report.ReportFaultTop10" %>

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
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="TOP10 故障"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:设备维护\TOP10 故障</span>
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
                                        <button class="button white-gradient" style="margin-top: 2em; float: right; margin-right: 5px;" onclick="Search();return false;">查  询</button>
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
                    <dt class="closed"><span>故障和人工干预报表</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div id="divtl" style="margin-top: 5px; margin-left: 5px; height: 318px; width: 98%;">
                                </div>
                                <div id="divDesc" style="width:98%">

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
                    $("#ename").html("选择节点：" + node.text);
                    //$(this).tree('getParent',node.target);//获取父亲节点
                }
            });
            Query();
        }

        function Query() {
            var Eid = $("#txtid").val();
            var DST = $("#datetimePickerBegin").val();
            var DET = $("#datetimePickerEnd").val();
            $.post('/Controller/ReportFaultTop10.ashx', { eid: Eid, dtstart: DST, dtend: DET }, function (data) {
                if (data.length > 0) {
                    var datax = new Array();
                    var datad = new Array();
                    var datal = new Array();
                    var xdivdesc = "";
                    for (var i = 0; i < data.length; i++) {
                        datax.push(i + 1);
                        datad.push(data[i].xcount);
                        datal.push(data[i].faultdesc);
                        xdivdesc += (i + 1) + "." + data[i].faultdesc + "&nbsp;&nbsp;&nbsp;";                        
                    }
                    $("#divDesc").html(xdivdesc);
                    var graduateyear = echarts.init(document.getElementById('divtl'));
                    var option2 = {
                        //title: {
                        //    text: '某地区蒸发量和降水量',
                        //    subtext: '纯属虚构'
                        //},
                        tooltip: {
                            trigger: 'axis'
                        },
                        legend: {
                            data: ['故障类型'],
                            textStyle: { color: '#ccc' }

                        },

                        //toolbox: {
                        //    show: true,
                        //    feature: {
                        //        mark: { show: true },
                        //        dataView: { show: true, readOnly: false },
                        //        magicType: { show: true, type: ['line', 'bar'] },
                        //        restore: { show: true },
                        //        saveAsImage: { show: true }
                        //    }
                        //},
                        calculable: true,
                        xAxis: [
                            {
                                type: 'category',
                                data: datax,
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
                        //grid: { borderWidth: 0, y2: '15%' },
                        series: [
                            {
                                name: '故障类型',
                                type: 'bar',
                                barWidth: 45,
                                itemStyle: {
                                    normal: {
                                        label: {
                                            show: true,
                                            position: 'top'
                                        },
                                        // 随机显示
                                        //color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}

                                        // 定制显示（按顺序）
                                        color: function (params) {
                                            var colorList = ['#C33531', '#EFE42A', '#64BD3D', '#EE9201', '#29AAE3', '#B74AE5', '#0AAF9F', '#E89589', '#16A085', '#4A235A', '#C39BD3 ', '#F9E79F', '#BA4A00', '#ECF0F1', '#616A6B', '#EAF2F8', '#4A235A', '#3498DB'];
                                            return colorList[params.dataIndex];
                                        }

                                    }
                                },
                                //markLine: {
                                //    data: [
                                //        { type: 'average', name: '平均值' }
                                //    ]
                                //},
                                data: datad
                            }
                        ]
                    };
                    graduateyear.setOption(option2);
                }
            }, "json");

        }
        function ClearAll() {
            $("#txtid").val("");
            $("#datetimePickerBegin").val("");
            $("#datetimePickerEnd").val("");
            $("#ename").html("选择节点：" );
        }
    </script>
</asp:Content>
