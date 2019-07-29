<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="MaterialCallPoint.aspx.cs" Inherits="SM.WEB.Views.MaterialCall.MaterialCallPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="物料落点管理"></asp:Label>
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
                    /*vertical-align: middle;*/
                }
        </style>
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:物料拉动/物料落点管理</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span>查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 80px; overflow-y: auto;">
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">落点编码:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="txtMaterialCallCode" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" />
                                    </div>
                                </div>
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">物料编号:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="txtMaterialDataNo" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" />
                                    </div>
                                </div>
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">物料名称:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="txtMaterialDataName" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" />
                                    </div>
                                </div>

                                <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(1, 10); return false;" value="查  询" />
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span>物料落点列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 208px; overflow-y: auto;">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 170px;">
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
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)物料落点</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div style="margin-top: 5px; margin-left: 5px;">
                                <input id="txtid" style="display: none;" />
                                <div style="width: 100%; float: left;">
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">零件落点编码:</td>
                                            <td style="width: 170px;">
                                                <input id="MaterialCallCode" class="k-textbox" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">物料编码:</td>
                                            <td style="width: 170px;">
                                                <input id="MaterialId" style="border: 1px #ccc solid; width: 150px; margin: 0 5px 5px 0; height: 26px; float: left;" />
                                                <span style="color: red;">*</span>

                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">物料描述:</td>
                                            <td style="width: 170px;">
                                                <input id="MaterialDataName" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left; background: rgb(194, 184, 184);" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">容器类型:</td>
                                            <td style="width: 170px;">
                                                <input id="BoxType" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left; background: rgb(194, 184, 184);" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">单箱收容数:</td>
                                            <td style="width: 170px;">
                                                <input id="BoxTotalNo" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left; background: rgb(194, 184, 184);" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">零件供应商:</td>
                                            <td style="width: 170px;">
                                                <input id="Supplier" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left; background: rgb(194, 184, 184);" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;"></td>
                                            <td style="width: 170px;"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">叫料触发点:</td>
                                            <td style="width: 170px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="StationId">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                            </td>
                                        </tr>

                                    </table>
                                </div>
                                <div style="width: 100%; float: left; margin-top: 5px;">
                                    <hr />
                                </div>
                                <div style="width: 100%; float: left; margin-top: 5px;">
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">仓位:</td>
                                            <td style="width: 170px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="StoreId">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                                <span style="color: red;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">叫料方式:</td>
                                            <td style="width: 170px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="CallType" onchange="SelectCallType(this)">
                                                    <option value="" selected="selected">请选择</option>
                                                    <option value="固定数量">固定数量</option>
                                                    <option value="按BOM数量">按BOM数量</option>
                                                </select>
                                                <span style="color: red;">*</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">单次扣减数:</td>
                                            <td style="width: 170px;">
                                                <input id="DeductionCountor" class="k-textbox" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">配送方式:</td>
                                            <td style="width: 170px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; float: left; height: 26px; width: 150px;" id="DeliverType">
                                                    <option value="" selected="selected">请选择</option>
                                                    <option value="人工拣料">人工拣料</option>
                                                    <option value="机器人拣料">机器人拣料</option>
                                                </select><span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">安全库存:</td>
                                            <td style="width: 170px;">
                                                <input id="SaveNumber" class="k-textbox" maxlength="8" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">延迟叫料:</td>
                                            <td style="width: 170px;">
                                                <input id="DelayTime" class="k-textbox" maxlength="8" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;">路径:</td>
                                            <td style="width: 170px;">
                                                <input id="DeliverWay" class="k-textbox" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right;vertical-align:middle;"></td>
                                            <td style="width: 170px;"></td>
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
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">    
        var stopFirstChangeEvent = true;
        var wsid = "";
        $(document).ready(function () {
            Search(1, 10);
            getStation();
            getMaterial();

        });
        function Search(pageNumber, pageSize) {
            var MaterialCallCode = $("#txtMaterialCallCode").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var MaterialDataNo = $("#txtMaterialDataNo").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var MaterialDataName = $("#txtMaterialDataName").val().replace('/\,/g', '，').replace('/\;/g', '；');

            datagridfresh(pageNumber, pageSize, MaterialCallCode, MaterialDataNo, MaterialDataName);
        }
        function getStation() {
            $.post('/Controller/StationById.ashx', { id: "" }, function (data) {
                var ohtml = "";
                for (var i = 0; i < data.rows.length; i++) {
                    ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].StationName + '</option>';
                }
                //$("#selectStationId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                $("#StationId").html('<option value="" selected="selected">请选择</option>' + ohtml);
            }, "json");
        }
        function getStore(MaterialId) {
            $.post('/Controller/getStoreWMSbyMid.ashx', { mid: MaterialId }, function (data) {
                var shtml = "";
                for (var i = 0; i < data.length; i++) {
                    shtml += '<option value="' + data[i].ID + '">' + data[i].StoreName + '</option>';
                }
                $("#StoreId").html('<option value="" selected="selected">请选择</option>' + shtml);
                $("#StoreId").val(wsid);
            }, "json");
        }
        function datagridfresh(pageNumber, pageSize, MaterialCallCode, MaterialDataNo, MaterialDataName) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/MaterialCallPointSearch.ashx', {
                pageindex: pageNumber, pagesize: pageSize,
                materialCallCode: MaterialCallCode,
                materialDataNo: MaterialDataNo,
                materialDataName: MaterialDataName,
                stationId: ""
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
                                field: 'MaterialCallCode', title: '落点编码', width: 70, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.MaterialCallCode
                                        + '","' + row.MaterialId
                                        + '","' + row.StoreId
                                        + '","' + row.CallType
                                        + '","' + row.DeductionCountor
                                        + '","' + row.DeliverType
                                        + '","' + row.SaveNumber
                                        + '","' + row.DelayTime
                                        + '","' + row.DeliverWay
                                        + '","' + row.StationId
                                        + '","' + row.MaterialDataNo
                                        + '","' + row.MaterialDataName
                                        + '","' + row.BoxType
                                        + '","' + row.BoxTotalNo
                                        + '","' + row.Supplier
                                        + '");\'>' + row.MaterialCallCode + '</a>';
                                }
                            },
                            { field: 'MaterialDataNo', width: 60, title: '物料编码', align: 'center' },
                            { field: 'MaterialDataName', width: 100, title: '物料名称', align: 'center' },
                            { field: 'BoxType', width: 60, title: '容器类型', align: 'center' },

                            { field: 'BoxTotalNo', width: 50, title: '单箱收容数', align: 'center' },
                            { field: 'DeliverWay', width: 50, title: '路径', align: 'center' },
                            { field: 'StoreName', width: 50, title: '仓位', align: 'center' },
                            { field: 'CallType', width: 60, title: '叫料方式', align: 'center' },
                            { field: 'DeliverType', width: 60, title: '配送方式', align: 'center' }
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
                                field: 'MaterialCallCode', title: '落点编码', width: 70, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.MaterialCallCode
                                        + '","' + row.MaterialId
                                        + '","' + row.StoreId
                                        + '","' + row.CallType
                                        + '","' + row.DeductionCountor
                                        + '","' + row.DeliverType
                                        + '","' + row.SaveNumber
                                        + '","' + row.DelayTime
                                        + '","' + row.DeliverWay
                                        + '","' + row.StationId
                                        + '","' + row.MaterialDataNo
                                        + '","' + row.MaterialDataName
                                        + '","' + row.BoxType
                                        + '","' + row.BoxTotalNo
                                        + '","' + row.Supplier
                                        + '");\'>' + row.MaterialCallCode + '</a>';
                                }
                            },
                            { field: 'MaterialDataNo', width: 60, title: '物料编码', align: 'center' },
                            { field: 'MaterialDataName', width: 100, title: '物料名称', align: 'center' },
                            { field: 'BoxType', width: 60, title: '容器类型', align: 'center' },

                            { field: 'BoxTotalNo', width: 50, title: '单箱收容数', align: 'center' },
                            { field: 'DeliverWay', width: 50, title: '路径', align: 'center' },
                            { field: 'StoreName', width: 50, title: '仓位', align: 'center' },
                            { field: 'CallType', width: 60, title: '叫料方式', align: 'center' },
                            { field: 'DeliverType', width: 60, title: '配送方式', align: 'center' }
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
        function getMaterial() {
            $('#MaterialId').combobox({
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
                    $("#BoxType").val(rec.BoxType);
                    $("#BoxTotalNo").val(rec.BoxTotalNo);
                    $("#Supplier").val(rec.Supplier);
                    //$("#MaterialDataName").val(rec.MaterialDataName);
                    getStore(rec.ID);
                    stopFirstChangeEvent = true
                }

            });
        }
        function SelectCallType(obj) {
            if ($(obj).val() == "固定数量") {
                $("#DeductionCountor").removeAttr("readonly");
                $("#DeductionCountor").css("background", "rgb(255, 255, 255)");
            }
            else {
                $("#DeductionCountor").attr("readonly", "readonly");
                $("#DeductionCountor").css("background", "rgb(194, 184, 184)");
            }
        }
        function Edit(ID, MaterialCallCode, MaterialId, StoreId, CallType, DeductionCountor, DeliverType, SaveNumber, DelayTime, DeliverWay, StationId, MaterialDataNo, MaterialDataName, BoxType, BoxTotalNo, Supplier) {
            $("#txtid").val(ID);
            $("#MaterialCallCode").val(MaterialCallCode);
            $("#MaterialCallCode").attr("readonly", "readonly");
            $("#MaterialCallCode").css("background", "rgb(194, 184, 184)");

            $("#MaterialId").combobox("setValue", MaterialId);
            $("#MaterialId").combobox("setText", MaterialDataNo);
            $("#MaterialId").combobox("disable");
            wsid = StoreId;
            getStore(MaterialId);
            $("#CallType").val(CallType)
            $("#DeductionCountor").val(DeductionCountor);
            $("#DeliverType").val(DeliverType);
            $("#DelayTime").val(DelayTime);
            $("#DeliverWay").val(DeliverWay);

            $("#SaveNumber").val(SaveNumber);
            $("#StationId").val(StationId);
            $("#MaterialDataName").val(MaterialDataName);
            $("#BoxType").val(BoxType);
            $("#BoxTotalNo").val(BoxTotalNo);
            $("#Supplier").val(Supplier);
            if ($(CallType).val() == "固定数量") {
                $("#DeductionCountor").removeAttr("readonly");
                $("#DeductionCountor").css("background", "rgb(255, 255, 255)");
            }
            else {
                $("#DeductionCountor").attr("readonly", "readonly");
                $("#DeductionCountor").css("background", "rgb(194, 184, 184)");
            }
            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            wsid = "";
            $("#txtid").val("");
            $("#MaterialCallCode").val("");
            $("#MaterialCallCode").removeAttr("readonly");
            $("#MaterialCallCode").css("background", "rgb(255, 255, 255)");

            $("#MaterialId").combobox("setValue", "");
            $("#MaterialId").combobox("setText", "");
            $("#MaterialId").combobox("enable");

            getStore($("#MaterialId").combobox("getValue"));
            $("#CallType").val("")
            $("#DeductionCountor").val("");
            $("#DeliverType").val("");
            $("#DelayTime").val("");
            $("#DeliverWay").val("");

            $("#SaveNumber").val("");
            $("#StationId").val("");

            $("#MaterialDataName").val("");
            $("#BoxType").val("");
            $("#BoxTotalNo").val("");
            $("#Supplier").val("");

            $('#datawin').datagrid('clearSelections');

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
            if ($("#MaterialId").combobox("getValue") == "" || $("#MaterialCallCode").val() == "" || $("#StoreId").val().trim() == ""
                || $("#StationId").val() == "" || $("#CallType").val() == "" || $("#DeliverType").val() == "" || $("#SaveNumber").val() == ""
                || $("#DelayTime").val() == "" || $("#DeliverWay").val() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }
            var reg = /^\d+$/;
            if ($("#CallType").val() == "固定数量" && $("#DeductionCountor").val() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }
            else if ($("#CallType").val() == "固定数量" && $("#DeductionCountor").val() != "") {
                if (!reg.test($("#DeductionCountor").val())) {
                    $("#msg").html("单次扣减数量必须是正整数！");
                    return false;
                }
            }

            if (!reg.test($("#SaveNumber").val())) {
                $("#msg").html("安全库存必须是正整数！");
                return false;
            }
            if (!reg.test($("#DelayTime").val())) {
                $("#msg").html("延迟必须是正整数！");
                return false;
            }


            var ID = $("#txtid").val();
            var MaterialCallCode = $("#MaterialCallCode").val();
            var MaterialId = $("#MaterialId").combobox("getValue");
            var StoreId = $("#StoreId").val()
            var CallType = $("#CallType").val();
            var DeductionCountor = $("#CallType").val() == "固定数量" ? $("#DeductionCountor").val() : "0";
            var DeliverType = $("#DeliverType").val();
            var SaveNumber = $("#SaveNumber").val();
            var DelayTime = $("#DelayTime").val();
            var DeliverWay = $("#DeliverWay").val();
            var StationId = $("#StationId").val();



            $.post('/Controller/MaterialCallPointEdit.ashx', {
                id: ID,
                materialCallCode: MaterialCallCode,
                materialId: MaterialId,
                storeId: StoreId,
                callType: CallType,
                deductionCountor: DeductionCountor,
                deliverType: DeliverType,
                saveNumber: SaveNumber,
                delayTime: DelayTime,
                deliverWay: DeliverWay,
                stationId: StationId
            }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("保存失败！");
                }
                else {
                    $("#msg").html("保存成功！");
                    Search(1, 10);
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
                    $.post('/Controller/MaterialCallPointDelete.ashx', { id: deleteid }, function (data) {

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

        function updateUsedTime() {
            var Wmscount = "";
            var t = "";
            $("input[name='wmscount']").each(function (j, item) {

                var reg = /^\d+$/;
                if (!reg.test(item.value)) {
                    t += "0";
                }
                else {
                    t += "1";
                    Wmscount += "|" + item.id + "_" + item.value;
                }
            });
            if (t.indexOf("0") != -1) {
                $("#msg").html("当前加工次数必须是数字！");
                return false;
            }
            $.post('/Controller/CuttorInfoUpdateUsedTime.ashx', {
                wmscount: Wmscount
            }, function (data) {

                if (data == "0") {
                    $("#msg").html("当前加工次数更新失败！");
                }
                else {
                    $("#msg").html("当前加工次数更新成功！");
                    //Search(1,10);
                }
            }, "json");
        }
    </script>
</asp:Content>
