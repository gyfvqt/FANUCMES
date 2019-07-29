<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="ERPOrder.aspx.cs" Inherits="SM.WEB.Views.ERP.ERPOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/Scripts/datagrid-detailview.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="生产计划及生产订单"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:生产计划排产\生产计划及生产订单</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 80px; overflow-y: auto;">
                                <div>
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">计划编号:</div>
                                    <input id="txtERPOrderId" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; float: left;" />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">计划名称:</div>
                                    <input id="txtERPOrderName" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; float: left;" />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">产品编号:</div>
                                    <input id="txtProductionId" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; float: left;" />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">产品名称:</div>
                                    <input id="txtProductionName" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; float: left;" />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">生产下线时间   从:</div>
                                    <%--<input id="datetimePickerBegin" style="width: 220px; height: 28px;" />--%>
                                    <input id="datetimePickerBegin" class="Wdate" style="border-color: #ccc;width: 220px; height: 28px;" type="text" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                    到 
                                    <%--<input id="datetimePickerEnd" style="width: 220px; height: 28px;" />--%>
                                    <input id="datetimePickerEnd" class="Wdate" style="border-color: #ccc;width: 220px; height: 28px;" type="text" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                    <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(); return false;" value="查  询" />

                                </div>


                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">生产计划列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 258px; ">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 300px;overflow-y: auto;">
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
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)生产计划</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div style="margin-top: 5px; margin-left: 5px;">
                                <input id="txtid" style="display: none;" />
                                <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">计划编号:</div>
                                    <input id="ERPOrderId" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">计划名称:</div>
                                    <input id="ERPOrderName" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">产品编号:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="ProductionId" onchange="SelectChange();">
                                        <option value="" selected="selected">请选择</option>
                                    </select><span style="color: red;">*</span><br />

                                </div>
                                <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">产品名称:</div>
                                    <input id="ProductionName" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">产品图号:</div>
                                    <input id="ProductionImg" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">计划数量:</div>
                                    <input id="PlanCount" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span>

                                </div>
                                <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">下线时间:</div>
                                    <%--<input id="EndDate" style="width: 220px; height: 28px;" />--%>
                                    <input id="EndDate" class="Wdate" style="border-color: #ccc;width: 220px; height: 26px;" type="text" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                    <span style="color: red;">*</span>
                                </div>
                            </div>
                        </div>
                    </dd>
                </dl>

            </div>

        </div>
        <div style="display: block; float: left; margin-left: 15px;">
            <input type="button" class="button white-gradient" id="New" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(0); return false;" value="新  增" />
            <input type="button" class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save(); return false;" value="保  存" />
            <input type="button" class="button white-gradient" id="delete" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Delete(); return false;" value="删  除" />
            <input type="button" class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(1); return false;" value="取  消">
            <input type="button" class="button white-gradient" id="split" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Split(); return false;" value="计划分解">

            <ul id="nav" style="margin-top: 5px; margin-left: 5px; float: left;">
                <li><a href="#" class="button white-gradient">自动排产</a>
                    <ul>
                        <li><a href="#" onclick="SetOrderNo('ABAB');return false;" class="button white-gradient" style="top: -90px;">ABAB</a></li>
                        <li><a href="#" onclick="SetOrderNo('AABB');return false;" class="button white-gradient" style="top: -90px;">AABB</a></li>
                    </ul>
                </li>
            </ul>
            <input type="button" class="button white-gradient" id="SetP" style="margin-top: 5px; margin-left: 30px; float: left;" onclick="SetProduction(); return false;" value="订单下达">
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <style type="text/css">
        .qbox {
            width: 95px;
            background-color: rgb(255,255,0);
        }

        #nav {
            line-height: 24px;
            list-style-type: none;
            background: #666;
        }

            #nav a {
                display: block;
                width: 60px;
                text-align: center;
            }

                #nav a:link {
                    color: #666;
                    text-decoration: none;
                }

                #nav a:visited {
                    color: #666;
                    text-decoration: none;
                }

                #nav a:hover {
                    color: #FFF;
                    text-decoration: none;
                    font-weight: bold;
                }

            #nav li {
                float: left;
                width: 60px;
                background: #CCC;
            }

                #nav li a:hover {
                    background: #999;
                }

                #nav li ul {
                    display: none;
                }

                #nav li ul {
                    line-height: 27px;
                    list-style-type: none;
                    text-align: left;
                    /*left: -999em;*/
                    width: 80px;
                    position: absolute;
                }

                    #nav li ul li {
                        float: left;
                        width: 80px;
                        background: #F6F6F6;
                    }


                    #nav li ul a {
                        /*display: block;*/
                        width: 65px;
                        /*_width: 80px;*/
                        height: auto;
                        margin: 0 auto;
                        text-align: left;
                        /*padding-left: 15px;*/
                    }

                #nav li:hover ul {
                    display: block;
                }

                #nav li ul a:link {
                    color: #666;
                    text-decoration: none;
                }

                #nav li ul a:visited {
                    color: #666;
                    text-decoration: none;
                }

                #nav li ul a:hover {
                    color: #F3F3F3;
                    text-decoration: none;
                    font-weight: normal;
                    background: #C00;
                }

                #nav li:hover ul {
                    left: auto;
                }

                #nav li.sfhover ul {
                    left: auto;
                }

        #content {
            clear: left;
        }
    </style>
    <script type="text/javascript">  
        var datax = null;
        $(document).ready(function () {
            var d = new Date();
            d.setTime(d.getTime() - 7 * 24 * 60 * 60 * 1000);
            var s = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
            var d = new Date();
            var s1 = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
            var d = new Date();
            var s2 = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
            //$('#datetimePickerBegin').datetimebox({
            //    //value: s,
            //    showSeconds: true
            //});
            //$('#datetimePickerEnd').datetimebox({
            //    //value: s1,
            //    showSeconds: true
            //});
            //$('#EndDate').datebox({
            //    value: s2,
            //    showSeconds: false
            //});
            getProduct();
            Search();
            $.post('/Controller/LineSearch.ashx', { pageindex: 1, pagesize: 100, lineId: "", lineName: "", lineType: "" }, function (data) {
                datax = data;
            }, "json");
        });

        function getProduct() {
            $.post('/Controller/productionSearch.ashx', { pageindex: 1, pagesize: 100, productionId: "", productionName: "", productionType: "" }, function (data) {

                if (data.rows[0].tips != "没有数据") {
                    var ohtml = '<option value="" selected="selected">请选择</option>';
                    for (var i = 0; i < data.rows.length; i++) {
                        ohtml += '<option value="' + data.rows[i].ProductionId + '">' + data.rows[i].ProductionId + '</option>'
                    }
                    $("#ProductionId").html(ohtml);
                }
            }, "json");
        }
        function SelectChange() {
            var ProductionId = $("#ProductionId").val();
            $.post('/Controller/getProductByPID.ashx', { productionId: ProductionId }, function (data) {
                if (data.rows[0].tips != "没有数据") {
                    $("#ProductionName").val(data.rows[0].ProductionName);
                    $("#ProductionImg").val(data.rows[0].ProductionSheet);
                }
            }, "json");
        }
        function Search() {
            var ERPOrderId = $("#txtERPOrderId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ERPOrderName = $("#txtERPOrderName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ProductionId = $("#txtProductionId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ProductionName = $("#txtProductionName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var BeginTime = $("#datetimePickerBegin").val();
            var EndTime = $("#datetimePickerEnd").val();
            datagridfresh(1, 10, ERPOrderId, ERPOrderName, ProductionId, ProductionName, BeginTime, EndTime);
        }

        function getFItemDetail(index, rowmaster) {
            var ddv = $('#datawin').datagrid('getRowDetail', index).find('table.ddv');
            ddv.datagrid({
                url: "/Controller/ERPOrderDetailView.ashx?Id=" + rowmaster.ID,
                fitColumns: true,
                rownumbers: true,
                loadMsg: '加载中......',
                height: 'auto',
                showFooter: true,
                columns: [[
                    //{ field: 'rownum', width: 30, title: 'NO', align: 'center', halign: 'left' },
                    {
                        field: 'ID', title: '操作', width: 30, align: 'center',
                        formatter: function (value, row, index) {
                            if (row.ID > 0 && row.Status == 2) {
                                return '<input type="checkbox" name ="chkorder" class="' + row.ERPID + '" id="' + row.ID + '">';
                            }
                            else {
                                return "";
                            }
                        }
                    },
                    { field: 'ERPDetailCode', width: 120, title: '订单编号', align: 'center' },
                    { field: 'ProductionCode', width: 100, align: 'center', title: '产品编号' },
                    { field: 'OrderSeq', width: 80, align: 'center', title: '生产顺序' },
                    {
                        field: 'SN', width: 80, align: 'center', halign: 'left', title: '排产序号',
                        formatter: function (value, row, index) {
                            if (row.ID > 0) {
                                return '<input type="text" name="sn' + row.ERPID + '" class="qbox" id="sn' + row.ID + '" value= "' + row.SN + '"/>';
                            }
                            else {
                                return row.SN;
                            }
                        }
                    },
                    {
                        field: 'LineId', width: 130, align: 'center', title: '产线',
                        formatter: function (value, row, index) {
                            if (row.ID > 0) {
                                var ohtml = '<select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 20px; width: 98%;background-color: rgb(255,255,0);"  id="select' + row.ID + '"  name="select' + row.ERPID + '" ><option value="" >请选择</option>';
                                for (var i = 0; i < datax.rows.length; i++) {
                                    if (datax.rows[i].ID == row.LineId) { ohtml += '<option value="' + datax.rows[i].ID + '" selected="selected">' + datax.rows[i].LineName + '</option>'; }
                                    else { ohtml += '<option value="' + datax.rows[i].ID + '">' + datax.rows[i].LineName + '</option>'; }
                                }
                                ohtml += '</select>'
                                return ohtml;
                            }
                            else {
                                return "";
                            }
                        }
                    },
                    { field: 'ProductionName', width: 130, align: 'center', title: '产品名称' },
                    { field: 'DetailCount', width: 80, align: 'center', title: '订单数量' },
                    {
                        field: 'Status', width: 80, align: 'center', title: '当前状态',
                        formatter: function (value, row, index) {
                            switch (row.Status) {
                                case 2: return "已生成"; break;
                                case 3: return "已下达"; break;
                                case 4: return "生产中"; break;
                                case 5: return "已关闭"; break;
                                //default: return "已生成"; break;
                            }
                        }
                    },
                    { field: 'EndDate', width: 130, align: 'center', title: '计划下线日期' },
                    { field: 'CreateTime', width: 130, align: 'center', title: '创建时间' },
                    { field: 'Creator', width: 130, align: 'center', title: '创建人' }
                ]],

                onResize: function () {
                    $('#datawin').datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    setTimeout(function () {
                        $('#datawin').datagrid('fixDetailRowHeight', index);
                    }, 0);
                    ddv.datagrid('reloadFooter', [
                        {
                            EndDate: '<span ><input type="button" class="button white-gradient" id="order' + rowmaster.ID + '" name="' + rowmaster.ID + '" value="订单关闭" onclick="OrderClose(this);return false;"/></span>',
                            CreateTime: '<span ><input type="button" class="button white-gradient" id="save' + rowmaster.ID + '" name="' + rowmaster.ID + '" value="保      存" onclick="OrderSave(this);return false;"/></span>',
                            Creator: '<span ><input type="button" class="button white-gradient" id="cancel' + rowmaster.ID + '" name="' + rowmaster.ID + '" value="取      消" onclick="OrderCancel(this);return false;"/></span>',
                        }
                    ]);
                }
            });
            $('#datagrid').datagrid('fixDetailRowHeight', index);
        }
        function datagridfresh(pageNumber, pageSize, ERPOrderId, ERPOrderName, ProductionId, ProductionName, BeginTime, EndTime) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/ERPOrderSeach.ashx',
                {
                    pageindex: pageNumber,
                    pagesize: pageSize,
                    erpOrderId: ERPOrderId,
                    erpOrderName: ERPOrderName,
                    productionId: ProductionId,
                    productionName: ProductionName,
                    bgintime: BeginTime,
                    endtime: EndTime
                }, function (data) {
                    if (data.rows[0].tips == "没有数据") {
                        $("#datawin").datagrid("loaded");
                        $("#datawin").datagrid({
                            //columns: [data.titleTable],   //动态取标题
                            emptyMsg: "<span>没有查询到数据，请调整一下查询条件！</span>",
                            view: detailview,
                            detailFormatter: function (index, row) {
                                return '<div style="padding:5px"><table class="ddv"></table></div>';
                            },
                            onExpandRow: function (index, row) {
                                getFItemDetail(index, row);
                            },
                            columns: [[
                                { field: 'rownum', width: 30, title: 'No' },
                                {
                                    field: 'ID', title: '操作', width: 30, align: 'center',
                                    formatter: function (value, row, index) {
                                        if (row.ERPStatus == 0) {
                                            return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                        }
                                        else {
                                            return '';
                                        }
                                    }
                                },

                                {
                                    field: 'ERPOrderId', title: '计划编码', width: 100, align: 'center',
                                    formatter: function (value, row, index) {
                                        if (row.ERPStatus == "0") {
                                            return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                                + '","' + row.ERPOrderId
                                                + '","' + row.ERPOrderName
                                                + '","' + row.ProductionId
                                                + '","' + row.ProductionName
                                                + '","' + row.ProductionImg
                                                + '","' + row.PlanCount
                                                + '","' + row.EndDate
                                                + '");\'>' + row.ProductionId + '</a>';
                                        }
                                        else {
                                            return row.ProductionId;
                                        }
                                    }
                                },
                                { field: 'ERPOrderName', width: 150, title: '计划名称', align: 'center' },
                                { field: 'ProductionId', width: 150, title: '产品编号', align: 'center' },
                                { field: 'ProductionName', width: 150, title: '产品名称', align: 'center' },
                                { field: 'PlanCount', width: 50, title: '计划数', align: 'center' },
                                {
                                    field: 'ERPStatus', width: 50, title: '当前状态', align: 'center',
                                    formatter: function (value, row, index) {
                                        switch (row.ERPStatus) {
                                            case "0": return "未分解"; break;
                                            case "1": return "已分解"; break;
                                            case "2": return "已关闭"; break;
                                        }
                                    }
                                },
                                { field: 'EndDate', width: 100, title: '计划下线日期', align: 'center' },
                                { field: 'Createdate', width: 100, title: '创建时间', align: 'center' }


                            ]],
                            onLoadSuccess: function () {
                                $("#datawin").datagrid("loaded");
                            }
                        });
                        $("#datawin").datagrid("loadData", []);  //动态取数据  
                    }
                    else {
                        $("#datawin").datagrid({
                            view: detailview,
                            detailFormatter: function (index, row) {
                                return '<div style="padding:5px"><table class="ddv"></table></div>';
                            },
                            onExpandRow: function (index, row) {
                                getFItemDetail(index, row);
                            },
                            columns: [[
                                { field: 'rownum', width: 30, title: 'No' },
                                {
                                    field: 'ID', title: '操作', width: 30, align: 'center',
                                    formatter: function (value, row, index) {
                                        if (row.ERPStatus == 0) {
                                            return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                        }
                                        else {
                                            return '';
                                        }
                                    }
                                },

                                {
                                    field: 'ERPOrderId', title: '计划编码', width: 100, align: 'center',
                                    formatter: function (value, row, index) {
                                        if (row.ERPStatus == "0") {
                                            return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                                + '","' + row.ERPOrderId
                                                + '","' + row.ERPOrderName
                                                + '","' + row.ProductionId
                                                + '","' + row.ProductionName
                                                + '","' + row.ProductionImg
                                                + '","' + row.PlanCount
                                                + '","' + row.EndDate
                                                + '");\'>' + row.ProductionId + '</a>';
                                        }
                                        else {
                                            return row.ProductionId;
                                        }
                                    }
                                },
                                { field: 'ERPOrderName', width: 150, title: '计划名称', align: 'center' },
                                { field: 'ProductionId', width: 150, title: '产品编号', align: 'center' },
                                { field: 'ProductionName', width: 150, title: '产品名称', align: 'center' },
                                { field: 'PlanCount', width: 50, title: '计划数', align: 'center' },
                                {
                                    field: 'ERPStatus', width: 50, title: '当前状态', align: 'center',
                                    formatter: function (value, row, index) {
                                        switch (row.ERPStatus) {
                                            case "0": return "未分解"; break;
                                            case "1": return "已分解"; break;
                                            case "2": return "已关闭"; break;
                                        }
                                    }
                                },
                                { field: 'EndDate', width: 100, title: '计划下线日期', align: 'center' },
                                { field: 'Createdate', width: 100, title: '创建时间', align: 'center' }


                            ]],
                            onLoadSuccess: function () {
                                $("#datawin").datagrid("loaded");
                                var row = $("#datawin").datagrid("getRows");
                                for (var r = 0; r < row.length; r++) {
                                    $("#datawin").datagrid("expandRow", r);
                                }
                            }
                        });
                        $("#datawin").datagrid("loadData", data.rows);  //动态取数据                    
                        $('#datapager').pagination({
                            total: data.total,
                            pageSize: pageSize,
                            onSelectPage: function (pageNumber, pageSize) {
                                var ERPOrderId = $("#txtERPOrderId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                                var ERPOrderName = $("#txtERPOrderName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                                var ProductionId = $("#txtProductionId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                                var ProductionName = $("#txtProductionName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                                var BeginTime = $("#datetimePickerBegin").val();
                                var EndTime = $("#datetimePickerEnd").val();
                                datagridfresh(pageNumber, pageSize, ERPOrderId, ERPOrderName, ProductionId, ProductionName, BeginTime, EndTime);
                            }
                        });
                    }
                }, "json");
        }
        function Edit(ID, ERPOrderId, ERPOrderName, ProductionId, ProductionName,
            ProductionImg, PlanCount, EndDate) {
            $("#txtid").val(ID);
            $("#ERPOrderId").val(ERPOrderId);
            $("#ERPOrderName").val(ERPOrderName);
            $("#ProductionId").val(ProductionId);
            $("#ProductionName").val(ProductionName);
            $("#ProductionImg").val(ProductionImg);
            $("#PlanCount").val(PlanCount);
            $("#EndDate").val(EndDate);

            SelectChange();

            $("#ERPOrderId").attr("readonly", "readonly");
            $("#ERPOrderId").css("background", "rgb(194, 184, 184)");

            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            $("#ERPOrderId").val("");
            $("#ERPOrderName").val("");
            $("#ProductionId").val("");
            $("#ProductionName").val("");
            $("#ProductionImg").val("");
            $("#PlanCount").val("");
            //$("#EndDate").val("");


            $("#ERPOrderId").removeAttr("readonly");
            $("#ERPOrderId").css("background", "rgb(255, 255, 255)");
            if (obj == 1) {
                $("#listdd").show();
                $("#listinputdd").hide();
            }
            else if (obj == 0) {
                $("#listdd").hide();
                $("#listinputdd").show();
            }
        }
        function Save() {
            if ($("#ERPOrderId").val().trim() == "" ||
                $("#ERPOrderName").val().trim() == "" ||
                $("#ProductionId").val().trim() == "" ||
                $("#PlanCount").val().trim() == "" ||
                $("#EndDate").val().trim() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }
            var reg = /^\d+$/;
            if (!reg.test($("#PlanCount").val())) {
                $("#msg").html("计划数量应为数字！");
                return false;
            }
            var ID = $("#txtid").val();
            var ERPOrderId = $("#ERPOrderId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ERPOrderName = $("#ERPOrderName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ProductionId = $("#ProductionId").val();
            var ProductionName = $("#ProductionName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ProductionImg = $("#ProductionImg").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var PlanCount = $("#PlanCount").val();
            var EndDate = $("#EndDate").val();


            $.post('/Controller/ERPOrderEdit.ashx', {
                id: ID,
                erpOrderId: ERPOrderId,
                erpOrderName: ERPOrderName,
                productionId: ProductionId,
                productionImg: ProductionImg,
                planCount: PlanCount,
                endDate: EndDate
            }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("*保存失败！");
                }
                else {
                    $("#msg").html("*保存成功！");
                    Search();
                    ClearAll(1);
                }
            }, "json");
        }

        function Delete() {
            var deleteid = "";
            $("input[name='dgcheckbox']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                }
            });
            if (deleteid.trim() != "") {
                if (confirm("确定删除数据？")) {
                    $.post('/Controller/ERPOrderDelete.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("*删除失败！");
                        }
                        else {
                            $("#msg").html("*删除成功！");
                            Search();
                            ClearAll(1);
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("*请先选择删除数据！");
            }
        }

        function Split() {
            var deleteid = "";
            $("input[name='dgcheckbox']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                }
            });
            if (deleteid.trim() != "") {
                if (confirm("确定订单分解？")) {
                    $.post('/Controller/ERPOrderSplit.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("订单分解失败！");
                        }
                        else {
                            $("#msg").html("订单分解成功！");
                            Search();
                            ClearAll(1);
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("*请先选择订单数据！");
            }
        }

        function OrderClose(obj) {
            var deleteid = "";
            $("input[class='" + obj.name + "']").each(function (j, item) {
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
        function OrderSave(obj) {
            var deleteid = "";
            var t = "";
            $("input[class='" + obj.name + "']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id + "_" + $("#sn" + item.id).val() + "_" + $("#select" + item.id).val();
                }
            });
            if (deleteid.trim() != "") {
                if (confirm("确定更新订单吗？")) {
                    $.post('/Controller/ERPOrderUpdate.ashx', { id: deleteid }, function (data) {
                        if (data == "0") {
                            $("#msg").html("订单更新失败！");
                        }
                        else {
                            $("#msg").html("订单更新成功！");
                            Search();
                            ClearAll(1);
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("请先选择需要更新的订单！");
            }
        }
        function OrderCancel(obj) {
            Search();
            ClearAll(1);
        }

        function SetProduction() {
            var deleteid = "";
            var t = "";
            var arr = [];
            $("input[name='chkorder']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                    arr.push($("#sn" + item.id).val() + "_" + $("#select" + item.id).val());
                }
            });
            if (arr.length > 0) {
                for (var i = 0; i < arr.length; i++) {
                    for (var j = 0; j < arr.length; j++) {
                        if (arr[i] == arr[j] && i != j) {
                            t += "0";
                        }
                    }
                }
            }
            if (t.indexOf("0") != -1) {
                $("#msg").html("同一线体下达的订单顺序号相同，请确认！");
                return false;
            }
            if (deleteid.trim() != "") {
                if (confirm("确定下达订单吗？")) {
                    $.post('/Controller/ERPOrderProduction.ashx', { id: deleteid }, function (data) {
                        if (data == "0") {
                            $("#msg").html("订单下达失败！");
                        }
                        else {
                            $("#msg").html("订单下达成功！");
                            Search();
                            ClearAll(1);
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("请先选择需要下达的订单！");
            }
        }

        function SetOrderNo(otype) {
            var deleteid = "";
            var t = "";
            var arr = [];
            $("input[name='chkorder']").each(function (j, item) {
                if (item.checked) {
                    //deleteid += "|" + item.id +"_"+$("#sn" + item.id).val() + "_" + $("#select" + item.id).val();
                    arr.push([item.id, $("#sn" + item.id).val()]);
                }
            });
            if (arr.length > 0) {
                if (otype == "AABB") {
                    for (var i = 0; i < arr.length; i++) {
                        $("#sn" + arr[i][0]).val(i < 10 ? "0" + (i + 1) : (i + 1));
                    }
                }
                else if (otype == "ABAB") {
                    var time = arr.length / 2;
                    var dtime = arr.length % 2;
                    if (dtime > 0) {
                        time = (arr.length - 1) / 2 + 1;
                    }
                    //前半段
                    var j = 1;
                    for (var i = 0; i < time; i++) {
                        $("#sn" + arr[i][0]).val(j < 10 ? "0" + j : j);
                        j += 2;
                    }
                    //后半段
                    var q = 2;
                    for (var i = time; i < arr.length; i++) {
                        $("#sn" + arr[i][0]).val(q < 10 ? "0" + q : q);
                        q += 2;
                    }
                }

            }
            $("input[name='chkorder']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id + "_" + $("#sn" + item.id).val() + "_" + $("#select" + item.id).val();
                    //arr.push([item.id, $("#sn" + item.id).val()]);
                }
            });
            //if (t.indexOf("0") != -1) {
            //    $("#msg").html("同一线体下达的订单顺序号相同，请确认！");
            //    return false;
            //}
            if (deleteid.trim() != "") {
                if (confirm("确定生产排产吗？")) {
                    $.post('/Controller/ERPOrderUpdate.ashx', { id: deleteid }, function (data) {
                        if (data == "0") {
                            $("#msg").html("生产排产失败！类型：" + otype);
                        }
                        else {
                            $("#msg").html("生产排产成功！类型：" + otype);
                            Search();
                            ClearAll(1);
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("请先选择生产排产的订单！");
            }
        }
    </script>
</asp:Content>
