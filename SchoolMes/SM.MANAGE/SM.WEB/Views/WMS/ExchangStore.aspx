<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="ExchangStore.aspx.cs" Inherits="SM.WEB.Views.WMS.ExchangStore" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="转储单管理"></asp:Label>
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

            .fileter {
                float: left;
            }

                .fileter tr td {
                    font-weight: bold;
                    text-transform: uppercase;
                    font-size: 14px;
                    color: #444;
                    width: 90px;
                    height: 26px;
                    vertical-align: middle;
                }
        </style>
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:库存WMS\转储单管理</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span>查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 150px; overflow-y: auto;">
                                <div style="width: 100%; float: left;">
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">物料编号:</td>
                                            <td>
                                                <input id="txtMaterialDataNo" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" /></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">物料名称:</td>
                                            <td>
                                                <input id="txtMaterialDataName" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" /></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">创建人:</td>
                                            <td>
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px;" id="selectCuserId">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">仓位:</td>
                                            <td>
                                                <input id="txtStoreName" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" /></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">开票数量:</td>
                                            <td>
                                                <input id="txtTicketNumber" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" /></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">更新人:</td>
                                            <td>
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px;" id="selectUuserId">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">行为描述:</td>
                                            <td>
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px;" id="selectExchangeType">
                                                    <option value="" selected="selected">请选择</option>
                                                    <option value="库存入库">库存入库</option>
                                                    <option value="库存出库">库存出库</option>
                                                    <option value="库存转储">库存转储</option>
                                                </select>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">转入仓位:</td>
                                            <td>
                                                <input id="txtInStoreName" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" /></td>
                                        </tr>

                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">状态:</td>
                                            <td>
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px;" id="selectStatus">
                                                    <option value="" selected="selected">请选择</option>
                                                    <option value="发起">发起</option>
                                                    <option value="确认">确认</option>
                                                </select></td>
                                        </tr>

                                    </table>

                                    <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(1, 10); return false;" value="查  询" />

                                </div>
                                <div style="width: 100%; float: left;">
                                    <span style="text-align: right; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">创建时间    从:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="CreateTimeB" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                        到 
                                                <input id="CreateTimeE" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                    </div>
                                </div>
                                <div style="width: 100%; float: left; margin-top: 5px;">
                                    <span style="text-align: right; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">更新时间    从:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="UpdateTimeB" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                        到 
                                                <input id="UpdateTimeE" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span>转储单列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 208px; overflow-y: auto;">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 180px;">
                                        <table id="datawin" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                            style="border: solid 1px #add9c0; overflow-y: auto;">
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
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)转储单</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div style="margin-top: 5px; margin-left: 5px;">
                                <input id="txtid" style="display: none;" />
                                <div style="width: 100%; float: left;">
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">物料编号:</td>
                                            <td style="width: 220px;">
                                                <input id="MaterialDataNo" style="border: 1px #ccc; width: 200px; margin: 0 5px 5px 0; height: 24px; float: left;" />
                                                <span style="color: red;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">物料名称:</td>
                                            <td style="width: 220px;">
                                                <input id="MaterialDataName" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 26px; width: 200px; background: rgb(194, 184, 184); float: left;" />
                                                <span style="color: red; float: left;">*</span>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">行为描述:</td>
                                            <td style="width: 220px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 200px; float: left;" id="ExchangeType">
                                                    <option value="" selected="selected">请选择</option>
                                                    <option value="库存入库">库存入库</option>
                                                    <option value="库存出库">库存出库</option>
                                                    <option value="库存转储">库存转储</option>
                                                </select><span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">仓储区域:</td>
                                            <td style="width: 220px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 200px; float: left;" id="WarehouseId" onchange="getStore(this,'StoreId')">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">仓位:</td>
                                            <td style="width: 220px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 200px; float: left;" id="StoreId">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">开票数量:</td>
                                            <td style="width: 220px;">
                                                <input id="TicketNumber" class="k-textbox" maxlength="8" style="margin: 0 5px 5px 0; height: 26px; width: 200px; float: left;" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">转入仓储区域:</td>
                                            <td style="width: 220px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 200px; float: left;" id="InWarehouseId" onchange="getStore(this,'InStoreId')">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">转入仓位:</td>
                                            <td style="width: 220px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 200px; float: left;" id="InStoreId">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right"></td>
                                            <td></td>
                                        </tr>
                                    </table>

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
            <input type="button" class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(1); return false;" value="取  消" />
            <input type="button" class="button white-gradient" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Confirm(); return false;" value="确认转储单" />
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">    
        var stopFirstChangeEvent = true;
        var whid = "";
        var wsid = "";
        var inwhid = "";
        var inwsid = "";
        $(document).ready(function () {
            Search(1, 10);
            getUser();
            getMaterial();
        });
        function Search(pageNumber, pageSize) {
            var MaterialDataNo = $("#txtMaterialDataNo").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var MaterialDataName = $("#txtMaterialDataName").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var StoreName = $("#txtStoreName").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var TicketNumber = $("#txtTicketNumber").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var ExchangeType = $("#selectExchangeType").val();
            var InStoreName = $("#txtInStoreName").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var ExStatus = $("#selectStatus").val();
            var CuserId = $("#selectCuserId").val();
            var UuserId = $("#selectUuserId").val();
            var CreateTimeB = $("#CreateTimeB").val();
            var CreateTimeE = $("#CreateTimeE").val();
            var UpdateTimeB = $("#UpdateTimeB").val();
            var UpdateTimeE = $("#UpdateTimeE").val();
            datagridfresh(pageNumber, pageSize, MaterialDataNo, MaterialDataName, StoreName, TicketNumber, ExchangeType, InStoreName, CuserId, UuserId, CreateTimeB, CreateTimeE, UpdateTimeB, UpdateTimeE, ExStatus);
        }
        function getMaterial() {
            $('#MaterialDataNo').combobox({
                url: '/Controller/BomMaterialByMCode.ashx?materialDataNo=',
                valueField: 'ID',
                textField: 'MaterialDataNo',
                mode: 'remote',
                editable: true,
                panelHeight: 70,
                required: true,
                onChange: function (rec) {
                    var url = '/Controller/BomMaterialByMCode.ashx?materialDataNo=' + $(this).combobox("getText");
                    $(this).combobox('reload', url);
                },
                onSelect: function (rec) {
                    if (stopFirstChangeEvent) {
                        stopFirstChangeEvent = false;
                        return;
                    }
                    $("#MaterialDataName").val(rec.MaterialDataName);
                    getWareHouse(rec.ID);
                    stopFirstChangeEvent = true
                }

            });
        }
        function getWareHouse(MaterialId) {
            $.post('/Controller/getWMSByMid.ashx', { mid: MaterialId }, function (data) {
                var ohtml = "";

                for (var i = 0; i < data.length; i++) {
                    ohtml += '<option value="' + data[i].ID + '">' + data[i].WarehouseName + '</option>';

                }
                $("#WarehouseId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                $("#InWarehouseId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                if (whid != "") $("#WarehouseId").val(whid);
                if (inwhid != "") $("#InWarehouseId").val(inwhid);
            }, "json");
        }
        function getWareHousex(MaterialId, value, invalue) {
            $.post('/Controller/getWMSByMid.ashx', { mid: MaterialId }, function (data) {
                var ohtml = "";

                for (var i = 0; i < data.length; i++) {
                    ohtml += '<option value="' + data[i].ID + '">' + data[i].WarehouseName + '</option>';

                }
                $("#WarehouseId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                $("#InWarehouseId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                if (value != undefined) $("#WarehouseId").val(value);
                if (invalue != undefined) $("#InWarehouseId").val(invalue);
            }, "json");
        }
        function getStore(obj, id) {
            var MaterialId = $("#MaterialDataNo").combobox("getValue");
            var Wid = $(obj).val();
            $.post('/Controller/getWMSMWId.ashx', { mid: MaterialId, wid: Wid }, function (data) {
                var shtml = "";
                for (var i = 0; i < data.length; i++) {
                    shtml += '<option value="' + data[i].ID + '">' + data[i].StoreName + '</option>';
                }
                $("#" + id).html('<option value="" selected="selected">请选择</option>' + shtml);
                if (id == 'StoreId' && wsid != "") $("#" + id).val(wsid);
                if (id == 'InStoreId' && inwsid!="") $("#" + id).val(inwsid);
            }, "json");
        }
        function getStorex(whid, id, value) {
            var MaterialId = $("#MaterialDataNo").combobox("getValue");
            var Wid = whid;
            $.post('/Controller/getWMSMWId.ashx', { mid: MaterialId, wid: Wid }, function (data) {
                var shtml = "";
                for (var i = 0; i < data.length; i++) {
                    shtml += '<option value="' + data[i].ID + '">' + data[i].StoreName + '</option>';
                }
                $("#" + id).html('<option value="" selected="selected">请选择</option>' + shtml);
                $("#" + id).val(value);
            }, "json");
        }
        function getUser() {
            $.post('/Controller/userSearch.ashx', { pageindex: 1, pagesize: 1000, userId: "", email: "", phoneNumber: "" }, function (data) {

                if (data.rows[0].tips == "没有数据") {
                    $("#msg").html("没有查询到用户！");
                    return false;
                }
                else {
                    var ohtml = "";
                    for (var i = 0; i < data.rows.length; i++) {
                        ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].LastName + data.rows[i].FirstName + '</option>'
                    }
                    $("#selectCuserId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                    $("#selectUuserId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                }
            }, "json");
        }
        function datagridfresh(pageNumber, pageSize, MaterialDataNo, MaterialDataName, StoreName, TicketNumber, ExchangeType, InStoreName, CuserId, UuserId, CreateTimeB, CreateTimeE, UpdateTimeB, UpdateTimeE, ExStatus) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/ExchangStoreSearch.ashx', {
                pageindex: pageNumber, pagesize: pageSize,
                materialDataNo: MaterialDataNo,
                materialDataName: MaterialDataName,
                storeName: StoreName,
                ticketNumber: TicketNumber,
                exchangeType: ExchangeType,
                inStoreName: InStoreName,
                cuserId: CuserId,
                uuserId: UuserId,
                createTimeB: CreateTimeB,
                createTimeE: CreateTimeE,
                updateTimeB: UpdateTimeB,
                updateTimeE: UpdateTimeE,
                status: ExStatus
            }, function (data) {

                if (data.rows[0].tips == "没有数据") {
                    $("#datawin").datagrid("loaded");
                    $("#datawin").datagrid({
                        //columns: [data.titleTable],   //动态取标题
                        fitColumns: true,
                        rownumbers: true,
                        emptyMsg: "<span>没有查询到数据</span>",
                        columns: [[
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    if (row.ExStatus == "确认") {
                                        return "";
                                    }
                                    else {
                                        return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                    }
                                }
                            },
                            {
                                field: 'MaterialDataNo', title: '物料编号', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    if (row.ExStatus == "确认") {
                                        return row.MaterialDataNo;
                                    } else {
                                        return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                            + '","' + row.MaterialId
                                            + '","' + row.MaterialDataNo
                                            + '","' + row.MaterialDataName
                                            + '","' + row.WarehouseId
                                            + '","' + row.StoreId
                                            + '","' + row.TicketNumber
                                            + '","' + row.ExchangeType
                                            + '","' + row.InWarehouseId
                                            + '","' + row.InStoreId
                                            + '");\'>' + row.MaterialDataNo + '</a>';
                                    }
                                }
                            },
                            { field: 'MaterialDataName', width: 100, title: '物料名称', align: 'center' },
                            { field: 'StoreName', width: 100, title: '仓位', align: 'center' },
                            { field: 'TicketNumber', width: 50, title: '开票数量', align: 'center' },
                            { field: 'ExchangeType', width: 50, title: '行为描述', align: 'center' },
                            { field: 'InStoreName', width: 50, title: '转入仓位', align: 'center' },
                            { field: 'ExStatus', width: 50, title: '转储状态', align: 'center' },
                            { field: 'CreateTime', width: 50, title: '创建时间', align: 'center' },
                            { field: 'Creator', width: 50, title: '创建人', align: 'center' },
                            { field: 'UpdateTime', width: 50, title: '更新时间', align: 'center' },
                            { field: 'Updator', width: 50, title: '更新人', align: 'center' }
                        ]],
                        onLoadSuccess: function () {
                            $("#datawin").datagrid("loaded");
                        }
                    });
                    $("#datawin").datagrid("loadData", []);  //动态取数据   
                }
                else {
                    $("#datawin").datagrid({
                        //columns: [data.titleTable],   //动态取标题
                        fitColumns: true,
                        rownumbers: true,
                        emptyMsg: "<span>没有查询到数据</span>",
                        columns: [[
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    if (row.ExStatus == "确认") {
                                        return "";
                                    }
                                    else {
                                        return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                    }
                                }
                            },
                            {
                                field: 'MaterialDataNo', title: '物料编号', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    if (row.ExStatus == "确认") {
                                        return row.MaterialDataNo;
                                    } else {
                                        return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                            + '","' + row.MaterialId
                                            + '","' + row.MaterialDataNo
                                            + '","' + row.MaterialDataName
                                            + '","' + row.WarehouseId
                                            + '","' + row.StoreId
                                            + '","' + row.TicketNumber
                                            + '","' + row.ExchangeType
                                            + '","' + row.InWarehouseId
                                            + '","' + row.InStoreId
                                            + '");\'>' + row.MaterialDataNo + '</a>';
                                    }
                                }
                            },
                            { field: 'MaterialDataName', width: 100, title: '物料名称', align: 'center' },
                            { field: 'StoreName', width: 100, title: '仓位', align: 'center' },
                            { field: 'TicketNumber', width: 50, title: '开票数量', align: 'center' },
                            { field: 'ExchangeType', width: 50, title: '行为描述', align: 'center' },
                            { field: 'InStoreName', width: 50, title: '转入仓位', align: 'center' },
                            { field: 'ExStatus', width: 50, title: '转储状态', align: 'center' },
                            { field: 'CreateTime', width: 50, title: '创建时间', align: 'center' },
                            { field: 'Creator', width: 50, title: '创建人', align: 'center' },
                            { field: 'UpdateTime', width: 50, title: '更新时间', align: 'center' },
                            { field: 'Updator', width: 50, title: '更新人', align: 'center' }
                        ]],
                        onLoadSuccess: function () {
                            $("#datawin").datagrid("loaded");
                        }
                    });
                    $("#datawin").datagrid("loadData", data.rows);  //动态取数据                    
                    $('#datapager').pagination({
                        total: data.total,
                        pageSize: pageSize,
                        onSelectPage: function (pageNumber, pageSize) {
                            Search(pageNumber, pageSize);
                        }
                    });
                }
            }, "json");
        }

        function Edit(ID, MaterialId, MaterialDataNo, MaterialDataName, WarehouseId, StoreId, TicketNumber, ExchangeType, InWarehouseId, InStoreId) {
            $("#txtid").val(ID);
            //$("#MaterialDataNo").val(MaterialId);
            whid = WarehouseId;
            inwhid = InWarehouseId;
            wsid = StoreId;
            inwsid = InStoreId;
            $("#MaterialDataNo").combobox('setText', MaterialDataNo);
            $("#MaterialDataNo").combobox('setValue', MaterialId);
            $("#MaterialDataNo").combobox('disable');
            $("#MaterialDataName").val(MaterialDataName);
            
            //$("#WarehouseId").unbind("onchange");
            //setTimeout(function () {
            //    getWareHousex(MaterialId, WarehouseId, InWarehouseId);
            //    getStorex(WarehouseId, "StoreId", StoreId);
            //    getStorex(InWarehouseId, "InStoreId", InStoreId);
            //}, 1000);
            getWareHouse(MaterialId);
            getStorex(WarehouseId, "StoreId", StoreId);
            getStorex(InWarehouseId, "InStoreId", InStoreId);
            //$("#WarehouseId").val(WarehouseId);
            $("#TicketNumber").val(TicketNumber);
            $("#ExchangeType").val(ExchangeType);
            //$("#InWarehouseId").val(InWarehouseId);
            //$("#InStoreId").val(InStoreId);

            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            //$("#MaterialDataNo").val("");
            $("#MaterialDataNo").combobox('setText', '');
            $("#MaterialDataNo").combobox('setValue', '');
            $("#MaterialDataNo").combobox('enable');
            $("#MaterialDataName").val("");
            $("#ExchangeType").val("");
            $("#WarehouseId").val("");
            $("#StoreId").val("");
            $("#TicketNumber").val("");
            $("#InWarehouseId").val("");
            $("#InStoreId").val("");
            $('#datawin').datagrid('clearSelections');
            whid = "";
            wsid = "";
            inwhid = "";
            inwsid = "";
            if (obj == 1) {
                $("#listdd").show();
                $("#listinputdd").hide();
            }
            else if (obj == 0) {
                $("#listdd").hide();
                $("#listinputdd").show();
            }
            $('#datawin').datagrid('clearSelections');
        }
        function Save() {
            if ($("#MaterialDataNo").combobox("getValue") == "" || $("#MaterialDataNo").val() == "" || $("#MaterialDataName").val().trim() == ""
                || $("#ExchangeType").val() == "" || $("#WarehouseId").val() == "" || $("#StoreId").val() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }
            if ($("#ExchangeType").val() == "库存转储" && ($("#InWarehouseId").val() == "" || $("#InStoreId").val() == "")) {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }
            if ($("#ExchangeType").val() == "库存转储" && $("#StoreId").val() == $("#InStoreId").val() && $("#WarehouseId").val() == $("#InWarehouseId").val()) {
                $("#msg").html("库存转储调拨不能是相同的库位！");
                return false;
            }
            var reg = /^\d+$/;
            if (!reg.test($("#TicketNumber").val())) {
                $("#msg").html("开票数量必须是正整数！");
                return false;
            }
            //var reg = /^\d+(\.\d+)?$/;
            //if (!reg.test($("#KG").val())) {
            //    $("#msg").html("最大承重必须是正数！");
            //    return false;
            //}
            var ID = $("#txtid").val();
            var MaterialId = $("#MaterialDataNo").combobox("getValue");
            var MaterialDataNo = $("#MaterialDataNo").combobox("getText");
            var MaterialDataName = $("#MaterialDataName").val();
            var ExchangeType = $("#ExchangeType").val();
            var WarehouseId = $("#WarehouseId").val();
            var StoreId = $("#StoreId").val();
            var TicketNumber = $("#TicketNumber").val();
            var InWarehouseId = $("#InWarehouseId").val();
            var InStoreId = $("#InStoreId").val();


            $.post('/Controller/ExchangStoreEdit.ashx', {
                id: ID,
                materialId: MaterialId,
                materialDataNo: MaterialDataNo,
                exchangeType: ExchangeType,
                ticketNumber: TicketNumber,
                warehouseId: WarehouseId,
                storeId: StoreId,
                inWarehouseId: InWarehouseId,
                inStoreId: InStoreId,
                materialDataName: MaterialDataName
            }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("*保存失败！");
                }
                else {
                    $("#msg").html("*保存成功！");
                    Search(1, 10);
                    ClearAll(1);
                }
            }, "json");
        }

        function Confirm() {
            var deleteid = "";
            $("input[name='dgcheckbox']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                }
            });
            if (deleteid.trim() != "") {
                if (confirm("确定确认转储吗？")) {
                    $.post('/Controller/ExchangStoreConfirm.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("确认转储失败！");
                        }
                        else {
                            $("#msg").html("确认转储成功！");
                            Search(1, 10);
                            ClearAll(1);
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("请先选择删除数据！");
            }
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
                    $.post('/Controller/ExchangStoreDelete.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("删除失败！");
                        }
                        else {
                            $("#msg").html("删除成功！");
                            Search(1, 10);
                            ClearAll(1);
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("请先选择删除数据！");
            }
        }
    </script>
</asp:Content>

