<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="ReportStationStatus.aspx.cs" Inherits="SM.WEB.Views.Report.ReportStationStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="站点状态报表"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:设备维护\站点状态报表</span>
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
                                        <button class="button white-gradient" id="new" style="margin-top: 2em; float: right; margin-right: 5px;" onclick="Search();return false;">查  询</button>
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
                    <dt class="closed"><span>站点状态报表</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div id="divtl" style="margin-top: 5px; margin-left: 5px; height: 318px; width: 98%;">
                                    <div id="tl" style="height: 310px;">
                                        <table id="datawin" style="width: auto; height: 300px; overflow-y: auto;"></table>
                                    </div>

                                    <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>

                                </div>
                            </div>


                        </div>

                    </dd>
                </dl>
            </div>
        </div>
    </section>
    <script type="text/javascript">
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
            $("#tll").height(wh - hdls - 230);
            $("#datawin").height(wh - hdls - 240);
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
            Query(1, 10);
        }

        function Query(pageNumber, pageSize) {

            //var opts = $('#datawin').datagrid('options');
            var page = pageNumber;//获取页码
            var pageSize = pageSize;//获取每页多少记录
            var handler = "/Controller/ReportStationStatus.ashx?pageindex=" + page
                + "&pagesize=" + pageSize + "&eid=" + $("#txtid").val() + "&dtstart=" + $("#datetimePickerBegin").val() + "&dtend=" + $("#datetimePickerEnd").val();
            $('#datawin').datagrid({
                //toolbar: "#gridWellToolbar",
                pagination: true,
                rownumbers: true,
                //singleselect: true,
                fitColumns: true,
                //height: 'min-height:200px',
                loadMsg: '正在处理,请稍等。。。',
                emptyMsg: "<span>没有查询到数据</span>",
                url: handler,
                columns: [[
                    { field: 'FaultDesc', title: '状态描述', width: 150 },
                    { field: 'LostTime', title: '时长（sec）', width: 80 },
                    //{ field: 'FaultType', title: '类型', width: 100 },
                    { field: 'FaultBeginTime', title: '开始时间', width: 100 },
                    { field: 'FaultEndTime', title: '结束时间', width: 100 }

                ]],
                onBeforeLoad: function (param) {
                    //var firstLoad = $(this).attr("firstLoad");
                    //if (firstLoad == "false" || typeof (firstLoad) == "undefined") {
                    //    $(this).attr("firstLoad", "true");
                    //    return false;
                    //}
                    //return true;
                }
            });
            //$('#datawin').datagrid('options').url = handler; //设置表格数据的来源URL
            var p = $('#datawin').datagrid('getPager');
            $(p).pagination({
                pageSize: 10, //每页显示的记录条数，默认为10 
                pageList: [10, 20, 30], //可以设置每页记录条数的列表 
                onSelectPage: function (pageNumber, pageSize) {
                    Query(pageNumber, pageSize);//分页查询
                }
            });
            //$('#datawin').datagrid('reload'); //重新加载表格

        }

    </script>
</asp:Content>