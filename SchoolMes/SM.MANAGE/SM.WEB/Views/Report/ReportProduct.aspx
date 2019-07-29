<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="ReportProduct.aspx.cs" Inherits="SM.WEB.Views.Report.ReportProduct" %>

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
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="生产报表"></asp:Label>
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

            table.gridtable {
                font-family: verdana,arial,sans-serif;
                font-size: 11px;
                color: #333333;
                border-width: 1px;
                border-color: #666666;
                border-collapse: collapse;
            }

            table.gridtable th {
                padding: 4px;
                color: #fff;
                background: #385fba url(/StyleFiles/img/old-browsers/colors/bg_big-menu.png) repeat-x;
                border-color: #385fba;
                -webkit-background-size: 100% 100%;
                -moz-background-size: 100% 100%;
                -o-background-size: 100% 100%;
                background-size: 100% 100%;
                background: -webkit-gradient(linear,left top,left bottom,from(#276a8f),to(#385fba));
                background: -webkit-linear-gradient(top,#276a8f,#385fba);
                background: -moz-linear-gradient(top,#276a8f,#385fba);
                background: -ms-linear-gradient(top,#276a8f,#385fba);
                background: -o-linear-gradient(top,#276a8f,#385fba);
                background: linear-gradient(top,#276a8f,#385fba);
                border-width: 1px;
                /*padding: 2px;*/
                border-style: solid;
                border-color: #fff;
            }

            table.gridtable td {
                border-width: 1px;
                padding: 2px;
                border-style: solid;
                border-color: #666666;
                background-color: #ffffff;
            }
        </style>
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:设备维护\生产报表</span>
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
        <div id="divsearch" class="RadAjaxPanel" style="display: block; position: absolute; float: left; margin-left: 220px;">
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
                    <dt class="closed"><span>生产报表</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div id="divtl" style="margin-top: 5px; margin-left: 5px;   overflow-x: auto;">
                                    <table id="tproduct" class="gridtable" style="margin-top: 5px; margin-left: 5px; ">
                                    </table>
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
            var wdivsearch = $("#divsearch").width();
            $("#dll").height(wh - hdls - 200);
            $("#divtl").height(wh - hdls - 170);
            $("#divtl").width(wdivsearch - 30);
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
            $.post('/Controller/ReportProduct.ashx', { eid: Eid, etype: Etype, dtstart: DST, dtend: DET }, function (data) {
                //头部构成
                var th1 = '<tr><th rowspan="2" style="width:150px;"></th>';
                var th2 = '<tr>';
                var trproduction = '<tr><td style="width:150px;">生产产品数量</td>';
                var k1 = '<tr><td style="width:150px;"></td>';
                var trf2 = '<tr><td style="width:150px;">故障状态时长（Sec）</td>';
                var trf3 = '<tr><td style="width:150px;">堵塞状态时长（Sec）</td>';
                var trf4 = '<tr><td style="width:150px;">缺件状态时长（Sec）</td>';
                var k2 = '<tr><td style="width:150px;"></td>';
                var ftotal = '<tr><td style="width:150px;">故障次数统计</td>';
                var ctotal = '<tr><td style="width:150px;">平均CycleTime统计（Sec）</td>';
                var d = "";
                var totalcolumns = 0;
                if (data.length > 0) {
                    d = data[0].ymd;
                    for (var i = 0; i < data.length; i++) {
                        //头部1部分                        
                        if (d != data[i].ymd) {
                            th1 += '<th style="height:14px;" colspan="' + totalcolumns + '">' + d + '</th>';
                            totalcolumns = 0;
                            d = data[i].ymd
                        }
                        if (i == data.length-1 && d == data[data.length - 1].ymd) {
                            th1 += '<th style="height:14px;" colspan="' + (totalcolumns+1) + '">' + d + '</th>';
                        }
                        totalcolumns += 1;

                        //头部2部分
                        th2 += '<th style="width:40px;height:14px;" >' + data[i].hour + '</th>';

                        //生产产量部分
                        trproduction += '<td style="width:40px;height:14px;" >' + data[i].countproduction + '</td>';

                        //空部分
                        k1 += '<td style="width:40px;height:14px;" ></td>';

                        //缺件部分
                        trf4 += '<td style="width:40px;height:14px;" >' + data[i].countfault4 + '</td>';

                        //堵塞部分
                        trf3 += '<td style="width:40px;height:14px;" >' + data[i].countfault3 + '</td>';

                        //故障部分
                        trf2 += '<td style="width:40px;height:14px;" >' + data[i].countfault2 + '</td>';

                        //空部分
                        k2 += '<td style="width:40px;height:14px;" ></td>';

                        //故障次数部分
                        ftotal += '<td style="width:40px;height:14px;" >' + data[i].countfaulttime + '</td>';

                        //平均CycleTime
                        ctotal += '<td style="width:40px;height:14px;" >' + data[i].cycletimeAVG + '</td>';
                    }

                    th1 += "</tr>";
                    th2 += "</tr>";
                    trproduction = "</tr>";
                    k1 += "</tr>";
                    trf4 += "</tr>";
                    trf3 += "</tr>";
                    trf2 += "</tr>";
                    k2 += "</tr>";
                    ftotal += "</tr>";
                    ctotal += "</tr>";

                    $("#tproduct").html(th1 + th2 + trproduction + k1 + trf4 + trf3 + trf2 + k2 + ftotal + ctotal);
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
