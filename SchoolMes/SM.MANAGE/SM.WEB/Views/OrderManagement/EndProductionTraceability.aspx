<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="EndProductionTraceability.aspx.cs" Inherits="SM.WEB.Views.OrderManagement.EndProductionTraceability" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/Scripts/datagrid-detailview.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="零件追溯查询"></asp:Label>
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

            .graybox {
                background: rgb(194, 184, 184);
            }

            .qbox {
                width: 98%;
                background-color: rgb(255,255,0);
            }
        </style>
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:订单管理\零件追溯查询</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 100px; overflow-y: auto;">
                                <div>
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">成品SN:</div>
                                    <input id="txtEndProductSN" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 120px; float: left;" />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">产品编号:</div>
                                    <input id="txtProductionId" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 120px; float: left;" />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">产品名称:</div>
                                    <input id="txtProductionName" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 120px; float: left;" />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">零件追溯码:</div>
                                    <input id="txtParkSn" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 120px; float: left;" />

                                    <br />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">
                                        下线时间 ： 从
                                    <input id="datetimePickerBegin" class="Wdate" style="height: 26px;border-color: #c5c5c5;" type="text" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                        到 
                                    
                                        <input id="datetimePickerEnd" class="Wdate" style="height: 26px;border-color: #c5c5c5;" type="text" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                    </div>
                                    <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(); return false;" value="查  询" />

                                </div>


                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">成品列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 258px; ">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 220px;overflow-y: auto;">
                                        <table id="datawin" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                            style="border: solid 1px #add9c0;">
                                            <thead>
                                                <tr>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>


                                </div>

                            </div>

                        </div>
                    </dd>
                    <dt class="closed" id="list-output"><span>成品详情</span><span onclick="ClearAll();return false;" style="float: right; margin-right: 15px;">返回</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>基本信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px;">
                                                    <input id="txtid" style="display: none;" />
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">成品SN:</div>
                                                        <input id="EndProductSN" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">产品编号:</div>
                                                        <input id="ProductionCode" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">产品名称:</div>
                                                        <input id="ProductionName" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                                    </div>
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">产品图号:</div>
                                                        <input id="ProductionSheet" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">当前状态:</div>
                                                        <input id="Status" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">最后更新时间:</div>
                                                        <input id="UpdateTime" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                                    </div>
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">订单编号:</div>
                                                        <input id="ERPDetailCode" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">订单顺序号:</div>
                                                        <input id="DetailOrderSN" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                                    </div>
                                                </div>
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>

                        <div class="RadAjaxPanel" style="display: block;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>产品追踪信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px; height: 150px; overflow-y: auto;">
                                                    <div style="height: 150px;">
                                                        <table id="dataTransitInfo" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                                            style="border: solid 1px #add9c0;">
                                                            <thead>
                                                                <tr>
                                                                </tr>
                                                            </thead>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>

                        <div class="RadAjaxPanel" style="display: block;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>零件追溯信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px; height: 150px; overflow-y: auto;">
                                                    <div style="height: 150px;">
                                                        <table id="dataTraceability" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                                            style="border: solid 1px #add9c0;">
                                                            <thead>
                                                                <tr>
                                                                </tr>
                                                            </thead>
                                                        </table>
                                                    </div>
                                                </div>

                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>

                        <div class="RadAjaxPanel" style="display: block;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>PLC上传过程质量信息及检验数据</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px; height: 188px; overflow-y: auto;">
                                                    <div style="height: 150px;">
                                                        <table id="dataPLCTraceability" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                                            style="border: solid 1px #add9c0;">
                                                            <thead>
                                                                <tr>
                                                                </tr>
                                                            </thead>
                                                        </table>
                                                    </div>
                                                    <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="PLCClose(); return false;" value="过程质量问题关闭" />
                                                    <label id="msgt" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                </div>
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>

                        <div class="RadAjaxPanel" style="display: block;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>手工录入过程质量信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px; height: 188px; overflow-y: auto;">
                                                    <div style="height: 150px;">
                                                        <table id="dataDefect" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                                            style="border: solid 1px #add9c0;">
                                                            <thead>
                                                                <tr>
                                                                </tr>
                                                            </thead>
                                                        </table>
                                                    </div>
                                                    <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="DefectClose(); return false;" value="过程质量问题关闭" />
                                                    <label id="msgd" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                </div>
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>


                    </dd>
                </dl>

            </div>

        </div>
        <div style="display: block; float: left; margin-left: 15px;">
            <%--<input type="button" class="button white-gradient" id="New" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="OrderClose(); return false;" value="订单关闭" />--%>

            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>

        </div>
    </section>
    <style type="text/css">
        .qbox {
            width: 95px;
            background-color: rgb(255,255,0);
        }
    </style>
    <script type="text/javascript">  
        var datax = null;
        $(document).ready(function () {
            //var d = new Date();
            //d.setTime(d.getTime() - 7 * 24 * 60 * 60 * 1000);
            //var s = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
            //var d = new Date();
            //var s1 = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
            //var d = new Date();
            //var s2 = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
            //$('#datetimePickerBegin').datetimebox({
            //    //value: s,
            //    showSeconds: true
            //});
            //$('#datetimePickerEnd').datetimebox({
            //    //value: s1,
            //    showSeconds: true
            //});
            //$('#dateCreateTime').datebox({
            //    //value: s2,
            //    showSeconds: false
            //});
            //getProduct();
            Search();
            //$.post('/Controller/LineSearch.ashx', { pageindex: 1, pagesize: 100, lineId: "", lineName: "", lineType: "" }, function (data) {
            //    datax = data;
            //}, "json");
        });


        function Search() {
            var EndProductSN = $("#txtEndProductSN").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            //var ERPDetailCode = $("#txtERPDetailCode").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ProductionId = $("#txtProductionId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ProductionName = $("#txtProductionName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ParkSn = $("#txtParkSn").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            //var StationName = $("#sStationName").val();
            var BeginTime = $("#datetimePickerBegin").val();
            var EndTime = $("#datetimePickerEnd").val();
            //var CreateTime = $("#dateCreateTime").val();
            datagridfresh(1, 10, EndProductSN, ProductionId, ProductionName, ParkSn, BeginTime, EndTime);
        }

        function datagridfresh(pageNumber, pageSize, EndProductSN, ProductionId, ProductionName, ParkSn, BeginTime, EndTime) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/EndProductionTraceability.ashx',
                {
                    pageindex: pageNumber,
                    pagesize: pageSize,
                    endProductSN: EndProductSN,
                    productionCode: ProductionId,
                    productionName: ProductionName,
                    parkSn: ParkSn,
                    bgintime: BeginTime,
                    endtime: EndTime
                }, function (data) {
                    if (data.rows[0].tips != "没有数据") {
                        $("#datawin").datagrid("loaded");
                        $("#datawin").datagrid({
                            rownumbers: true,
                            singleselect: false,
                            fitColumns: true,
                            emptyMsg: "<span>没有查询到数据，请调整一下查询条件！</span>",
                            columns: [[
                                //{ field: 'rownum', width: 30, title: 'NO', align: 'center' },
                                {

                                    field: 'EndProductSN', width: 100, align: 'center', title: '成品SN',
                                    formatter: function (value, row, index) {
                                        return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                            + '","' + row.EndProductSN
                                            + '","' + row.ERPDetailCode
                                            + '","' + row.ProductionCode
                                            + '","' + row.ProductionName
                                            + '","' + row.ProductionSheet
                                            + '","' + row.UpdateTime
                                            + '","' + row.Status
                                            + '","' + row.DetailOrderSN
                                            + '");\'>' + row.EndProductSN + '</a>';
                                    }
                                },

                                { field: 'ProductionCode', width: 130, align: 'center', title: '产品编号' },
                                { field: 'ProductionName', width: 120, title: '产品名称', align: 'center' },
                                { field: 'ParkSn', width: 120, title: '零件追溯码', align: 'center' },

                                { field: 'TransitTime', width: 130, align: 'center', title: '录入时间' },
                                { field: 'StationName', width: 100, align: 'center', title: '录入站点' },
                                { field: 'EndTime', width: 80, align: 'center', title: '成品下线时间' }
                            ]],

                            onLoadSuccess: function () {
                                $("#datawin").datagrid("loaded");
                                //var row = $("#datawin").datagrid("getRows");
                                //for (var r = 0; r < row.length; r++) {
                                //    $("#datawin").datagrid("expandRow", r);
                                //}
                            }
                        });
                        $("#datawin").datagrid("loadData", data.rows);  //动态取数据                    
                        $('#datapager').pagination({
                            total: data.total,
                            pageSize: pageSize,
                            onSelectPage: function (pageNumber, pageSize) {
                                var EndProductSN = $("#txtEndProductSN").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');                                
                                var ProductionId = $("#txtProductionId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                                var ProductionName = $("#txtProductionName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                                var ParkSn = $("#txtParkSn").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');                                
                                var BeginTime = $("#datetimePickerBegin").val();
                                var EndTime = $("#datetimePickerEnd").val();                                
                                datagridfresh(pageNumber, pageSize, EndProductSN, ProductionId, ProductionName, ParkSn, BeginTime, EndTime);
                            }
                        });
                    }
                    else {
                        $("#datawin").datagrid("loaded");
                        $("#datawin").datagrid({
                            rownumbers: true,
                            singleselect: false,
                            fitColumns: true,
                            emptyMsg: "<span>没有查询到数据，请调整一下查询条件！</span>",
                            columns: [[
                                //{ field: 'rownum', width: 30, title: 'NO', align: 'center' },
                                {

                                    field: 'EndProductSN', width: 100, align: 'center', title: '成品SN',
                                    formatter: function (value, row, index) {
                                        return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                            + '","' + row.EndProductSN
                                            + '","' + row.ERPDetailCode
                                            + '","' + row.ProductionCode
                                            + '","' + row.ProductionName
                                            + '","' + row.ProductionSheet
                                            + '","' + row.UpdateTime
                                            + '","' + row.Status
                                            + '","' + row.DetailOrderSN
                                            + '");\'>' + row.EndProductSN + '</a>';
                                    }
                                },

                                { field: 'ProductionCode', width: 130, align: 'center', title: '产品编号' },
                                { field: 'ProductionName', width: 120, title: '产品名称', align: 'center' },
                                { field: 'ParkSn', width: 120, title: '零件追溯码', align: 'center' },

                                { field: 'TransitTime', width: 130, align: 'center', title: '录入时间' },
                                { field: 'StationName', width: 100, align: 'center', title: '录入站点' },
                                { field: 'EndTime', width: 80, align: 'center', title: '成品下线时间' }
                            ]],

                            onLoadSuccess: function () {
                                $("#datawin").datagrid("loaded");
                                //var row = $("#datawin").datagrid("getRows");
                                //for (var r = 0; r < row.length; r++) {
                                //    $("#datawin").datagrid("expandRow", r);
                                //}
                            }
                        });
                        $("#datawin").datagrid("loadData", []);  //动态取数据   
                    }
                }, "json");
        }
        function Edit(ID, EndProductSN, ERPDetailCode, ProductionCode, ProductionName, ProductionSheet, UpdateTime, Status, DetailOrderSN) {
            $("#txtid").val(ID);
            $("#EndProductSN").val(EndProductSN);
            $("#ERPDetailCode").val(ERPDetailCode);
            $("#ProductionCode").val(ProductionCode);
            $("#ProductionName").val(ProductionName);
            $("#ProductionSheet").val(ProductionSheet);
            $("#UpdateTime").val(UpdateTime);
            if (Status == "1") $("#Status").val("生产");
            else if (Status == "2") $("#Status").val("下线");
            else if (Status == "3") $("#Status").val("报废");

            $("#DetailOrderSN").val(DetailOrderSN);

            $("#listdd").hide();
            $("#listinputdd").show();
            ProductTransit(ID);
            ProductTraceability(ID);
            ProductPLCTraceabilityInfo(ID);
            ProductDefectInfo(ID);
        }
        function ProductTransit(ID) {
            //$("#dataTransitInfo").datagrid("loading");
            $("#dataTransitInfo").datagrid({
                url: "/Controller/ProductTransitInfobyPid.ashx?Id=" + ID,
                fitColumns: true,
                rownumbers: true,
                loadMsg: '加载中......',
                height: 'auto',
                emptyMsg: "<span>没有查询到数据</span>",
                showFooter: true,
                columns: [[
                    //{ field: 'rownum', width: 30, title: 'NO', align: 'center' },

                    { field: 'StationName', width: 150, title: '站点名称', align: 'center' },
                    { field: 'StationDesc', width: 130, align: 'center', title: '站点描述' },
                    { field: 'StationType', width: 100, align: 'center', title: '站点类型' },
                    {
                        field: 'TransitTime', width: 130, align: 'center', title: '过站时间'
                    },
                    { field: 'QualityStatus', width: 130, align: 'center', title: '过站质量状态' }
                ]],

                onResize: function () {
                    //$("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    //setTimeout(function () {
                    //    $("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
                    //}, 0);

                }
            });
            //$("#dataTransitInfo").datagrid('fixDetailRowHeight', index);

        }
        function ProductTraceability(ID) {
            //$("#dataTransitInfo").datagrid("loading");
            $("#dataTraceability").datagrid({
                url: "/Controller/ProductTraceabilityInfo.ashx?Id=" + ID,
                fitColumns: true,
                rownumbers: true,
                loadMsg: '加载中......',
                height: 'auto',
                emptyMsg: "<span>没有查询到数据</span>",
                showFooter: true,
                columns: [[
                    //{ field: 'rownum', width: 30, title: 'NO', align: 'center' },                                
                    { field: 'ParkSn', width: 250, title: '零件追溯码', align: 'center' },
                    { field: 'StationName', width: 130, align: 'center', title: '站点描述' },
                    { field: 'TransitTime', width: 130, align: 'center', title: '站点类型' }
                ]],

                onResize: function () {
                    //$("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    //setTimeout(function () {
                    //    $("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
                    //}, 0);

                }
            });
            //$("#dataTransitInfo").datagrid('fixDetailRowHeight', index);

        }
        function ProductPLCTraceabilityInfo(ID) {
            //$("#dataTransitInfo").datagrid("loading");
            $("#dataPLCTraceability").datagrid({
                url: "/Controller/ProductPLCTraceabilityInfo.ashx?Id=" + ID,
                fitColumns: true,
                rownumbers: true,
                loadMsg: '加载中......',
                height: 'auto',
                emptyMsg: "<span>没有查询到数据</span>",
                showFooter: true,
                columns: [[
                    {
                        field: 'ID', title: '操作', width: 30, align: 'center',
                        formatter: function (value, row, index) {
                            if (row.PLCDataResult == "NOK") {
                                return '<input type="checkbox" name="dgcheckboxplc"  id="' + row.ID + '">';
                            }
                            else {
                                return "";
                            }
                        }
                    },
                    { field: 'PLCDataDesc', width: 250, title: '数据描述', align: 'center' },
                    {
                        field: 'PLCDataResult', width: 130, align: 'center', title: '生产数据',
                        styler: function (value, row, index) {
                            if (row.PLCDataResult == "OK") {
                                return "background:rgb(0,255,0);color:rgb(255,255,255);";
                            }
                            else if (row.PLCDataResult == "NOK") {
                                return "background:rgb(255,0,0);color:rgb(255,255,255);";
                            }
                            //else {
                            //    return row.PLCDataResult
                            //}

                        }
                    },
                    { field: 'LastStatus', width: 130, align: 'center', title: '当前状态' },
                    { field: 'Updator', width: 130, align: 'center', title: '最后编辑人员' }
                ]],

                onResize: function () {
                    //$("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    //setTimeout(function () {
                    //    $("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
                    //}, 0);

                }
            });
            //$("#dataTransitInfo").datagrid('fixDetailRowHeight', index);

        }
        function ProductDefectInfo(ID) {
            //$("#dataTransitInfo").datagrid("loading");
            $("#dataDefect").datagrid({
                url: "/Controller/ProductDefectInfo.ashx?Id=" + ID,
                fitColumns: true,
                rownumbers: true,
                loadMsg: '加载中......',
                height: 'auto',
                emptyMsg: "<span>没有查询到数据</span>",
                showFooter: true,
                columns: [[
                    {
                        field: 'ID', title: '操作', width: 30, align: 'center',
                        formatter: function (value, row, index) {
                            if (row.LastStatus == "NOK") { return '<input type="checkbox" name="dgcheckboxd"  id="' + row.ID + '">'; }
                            else { return ""; }
                        }
                    },
                    { field: 'DefectCode', width: 130, title: '过程质量编码', align: 'center' },
                    { field: 'DefectDesc', width: 130, align: 'center', title: '过程质量描述' },
                    { field: 'StationName', width: 130, title: '录入站点', align: 'center' },
                    { field: 'UpdateTime', width: 130, align: 'center', title: '录入时间' },
                    {
                        field: 'LastStatus', width: 130, align: 'center', title: '当前状态',
                        styler: function (value, row, index) {
                            if (row.LastStatus == "OK") {
                                return "background:rgb(0,255,0);color:rgb(255,255,255);";
                            }
                            else if (row.LastStatus == "NOK") {
                                return "background:rgb(255,0,0);color:rgb(255,255,255);";
                            }
                            //else {
                            //    return row.PLCDataResult
                            //}

                        }
                    },
                    { field: 'LastUpdator', width: 130, align: 'center', title: '最后编辑人员' }
                ]],

                onResize: function () {
                    //$("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    //setTimeout(function () {
                    //    $("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
                    //}, 0);

                }
            });
            //$("#dataTransitInfo").datagrid('fixDetailRowHeight', index);

        }
        function ClearAll() {
            $("#listdd").show();
            $("#listinputdd").hide();
        }
        function OrderClose() {
            var deleteid = "";
            $("input[name='dgcheckbox']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                }
            });
            if (deleteid.trim() != "") {
                if (confirm("确定关闭订单吗？")) {
                    $.post('/Controller/ERPOrderClose.ashx', { id: deleteid }, function (data) {
                        if (data == "0") {
                            $("#msg").html("订单关闭失败！");
                        }
                        else {
                            $("#msg").html("订单关闭成功！");
                            Search();
                            ClearAll(1);
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("请先选择需要关闭的订单！");
            }
        }
        function PLCClose() {
            var deleteid = "";
            $("input[name='dgcheckboxplc']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                }
            });
            if (deleteid.trim() != "") {
                if (confirm("确定关闭PLC过程质量问题吗？")) {
                    $.post('/Controller/ProductPLCTraceabilityInfoClose.ashx', { id: deleteid }, function (data) {
                        if (data == "0") {
                            $("#msgt").html("PLC过程质量问题关闭失败！");
                        }
                        else {
                            $("#msgt").html("PLC过程质量问题关闭成功！");
                            ProductPLCTraceabilityInfo($("#txtid").val());
                        }
                    }, "json");
                }

            }
            else {
                $("#msgt").html("请先选择需要关闭的PLC过程质量问题！");
            }
        }
        function DefectClose() {
            var deleteid = "";
            $("input[name='dgcheckboxd']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                }
            });
            if (deleteid.trim() != "") {
                if (confirm("确定关闭手工录入过程质量问题吗？")) {
                    $.post('/Controller/ProductDefectInfoClose.ashx', { id: deleteid }, function (data) {
                        if (data == "0") {
                            $("#msgd").html("手工录入过程质量问题关闭失败！");
                        }
                        else {
                            $("#msgd").html("手工录入过程质量问题关闭成功！");
                            ProductDefectInfo($("#txtid").val());
                        }
                    }, "json");
                }

            }
            else {
                $("#msgd").html("请先选择需要关闭的手工录入过程质量问题！");
            }
        }
    </script>
</asp:Content>
