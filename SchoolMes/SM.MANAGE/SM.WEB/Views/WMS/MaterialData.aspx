<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="MaterialData.aspx.cs" Inherits="SM.WEB.Views.WMS.MaterialData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="物料主数据维护"></asp:Label>
    <section id="main" role="main">
        <style type="text/css">
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

            
        </style>
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:库存WMS\物料主数据维护</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div>
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 80px;">物料编号:</div>
                                    <input id="txtMaterialDataNo" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; float: left;" />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 80px;">物料名称:</div>
                                    <input id="txtMaterialDataName" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; float: left;" />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 80px;">供  应  商:</div>
                                    <input id="txtSupplier" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 80px;">仓        位:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px; float: left;" id="selectStore">
                                    </select>

                                    <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(); return false;" value="查  询" />

                                </div>

                                <br />
                                <br />
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">物料主数据列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 158px; overflow-y: auto;">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 150px;">
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
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)物料主数据</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <style type="text/css">
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
                                    }

                                    table.gridtable td {
                                        border-width: 1px;
                                        padding: 2px;
                                        border-style: solid;
                                        border-color: #666666;
                                        background-color: #ffffff;
                                    }
                            </style>

                            <div style="margin-top: 5px; margin-left: 5px; float: left;">
                                <input id="txtid" style="display: none;" />
                                <div style="display: block; float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">物料编号:</div>
                                    <input id="MaterialDataNo" maxlength="32" readonly="readonly" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">物料名称:</div>
                                    <input id="MaterialDataName" name="StoreName" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">容器类型:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="BoxType">
                                        <option value="托盘" selected="selected">托盘</option>
                                        <option value="装箱">装箱</option>
                                    </select><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">单箱收容数:</div>
                                    <input id="BoxTotalNo" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">单箱重量:</div>
                                    <input id="KG" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">零件供应商:</div>
                                    <input id="Supplier" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />

                                </div>
                            </div>
                            <div style="margin-top: 12px; margin-left: 15px; float: left;">
                                <table class="gridtable">
                                    <tr>
                                        <th colspan="3">仓位列表</th>
                                    </tr>
                                    <tr>
                                        <th>NO</th>
                                        <th>仓储区域</th>
                                        <th>仓位</th>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>
                                            <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="warehouse1" onchange="selectWChange(this,'1','')"></select></td>
                                        <td>
                                            <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="store1">
                                                <option value="" selected="selected">请选择</option>
                                            </select></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>
                                            <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="warehouse2" onchange="selectWChange(this,'2','')"></select></td>
                                        <td>
                                            <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="store2">
                                                <option value="" selected="selected">请选择</option>
                                            </select></td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>
                                            <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="warehouse3" onchange="selectWChange(this,'3','')"></select></td>
                                        <td>
                                            <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="store3">
                                                <option value="" selected="selected">请选择</option>
                                            </select></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </dd>
                </dl>
            </div>
        </div>
        <div style="display: block; float: left; margin-left: 15px;">
            <button class="button white-gradient" id="New" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(0);return false;">新  增</button>
            <button class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save();return false;">保  存</button>
            <button class="button white-gradient" id="delete" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Delete();return false;">删  除</button>
            <button class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(1);return false;">取  消</button>

            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">        
        $(document).ready(function () {
            var materialDataNo = $("#txtMaterialDataNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var materialDataName = $("#txtMaterialDataName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var supplier = $("#txtSupplier").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            datagridfresh(1, 10, materialDataNo, materialDataName, supplier, "");
            getWarehourse([]);
            getStoreall();
        });
        function Search() {
            var materialDataNo = $("#txtMaterialDataNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var materialDataName = $("#txtMaterialDataName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var supplier = $("#txtSupplier").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var storeId = $("#selectStore").val();
            datagridfresh(1, 10, materialDataNo, materialDataName, supplier, storeId);
        }
        function getStoreall() {
            $.post('/Controller/storeByWid.ashx', { id: "" }, function (data) {

                if (data.rows[0].tips != "没有数据") {
                    var ohtml = '<option value="" selected="selected">请选择</option>';
                    for (var i = 0; i < data.rows.length; i++) {
                        ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].StoreName + '</option>'
                    }
                    $("#selectStore").html(ohtml);
                }
            }, "json");
        }
        function getWarehourse(obj) {
            $.post('/Controller/warehouseSearch.ashx', { pageindex: 1, pagesize: 100, warehouseNo: "", warehouseName: "", warehouseType: "" }, function (data) {

                if (data.rows[0].tips != "没有数据") {
                    var ohtml = '<option value="" selected="selected">请选择</option>';
                    for (var i = 0; i < data.rows.length; i++) {
                        ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].WarehouseName + '</option>'
                    }
                    $("#warehouse1").html(ohtml);
                    $("#warehouse2").html(ohtml);
                    $("#warehouse3").html(ohtml);
                    if (obj.length > 0) {
                        for (var i = 0; i < obj.length; i++) {
                            $("#warehouse" + i).val(obj[i]);
                        }
                    }
                }
            }, "json");
        }
        function selectWChange(obj, index, val) {
            var ID = $(obj).val();
            $.post('/Controller/storeByWid.ashx', { id: ID }, function (data) {

                if (data.rows[0].tips != "没有数据") {
                    var ohtml = '<option value="" selected="selected">请选择</option>';
                    for (var i = 0; i < data.rows.length; i++) {
                        ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].StoreName + '</option>'
                    }
                    $("#store" + index).html(ohtml);
                    if (val != "") {
                        $("#store" + index).val(val);
                    }
                }
            }, "json");
        }

        function datagridfresh(pageNumber, pageSize, MaterialDataNo, MaterialDataName, Supplier, StoreId) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/materialSearch.ashx', { pageindex: pageNumber, pagesize: pageSize, materialDataNo: MaterialDataNo, materialDataName: MaterialDataName, supplier: Supplier, storeId: StoreId }, function (data) {
                if (data.rows[0].tips == "没有数据") {
                    $("#datawin").datagrid("loaded");
                    $("#datawin").datagrid({
                        //columns: [data.titleTable],   //动态取标题
                        emptyMsg: "<span>没有查询到数据，请调整一下查询条件！</span>",
                        columns: [[
                            { field: 'rownum', width: 30, title: 'No' },
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                }
                            },

                            {
                                field: 'MaterialDataNo', title: '物料编号', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.MaterialDataNo
                                        + '","' + row.MaterialDataName
                                        + '","' + row.BoxType
                                        + '","' + row.KG
                                        + '","' + row.BoxTotalNo
                                        + '","' + row.Supplier
                                        + '","' + row.IsEnable
                                        + '");\'>' + row.MaterialDataNo + '</a>';
                                }
                            },
                            { field: 'MaterialDataName', width: 150, title: '物料名称', align: 'center' },
                            { field: 'BoxType', width: 100, title: '容器类型', align: 'center' },
                            { field: 'KG', width: 50, title: '单箱重量', align: 'center' },
                            { field: 'BoxTotalNo', width: 50, title: '单箱收容数', align: 'center' },
                            { field: 'Supplier', width: 50, title: '供应商', align: 'center' },
                            {
                                field: 'IsEnable', title: '是否生效', width: 50, align: 'center',
                                formatter: function (value, row, index) {
                                    if (row.IsEnable == 0) {
                                        return "否";
                                    }
                                    else {
                                        return "是";
                                    }
                                }
                            }

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
                        emptyMsg: "<span>没有查询到数据，请调整一下查询条件！</span>",
                        columns: [[
                            { field: 'rownum', width: 30, title: 'No' },
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                }
                            },

                            {
                                field: 'MaterialDataNo', title: '物料编号', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.MaterialDataNo
                                        + '","' + row.MaterialDataName
                                        + '","' + row.BoxType
                                        + '","' + row.KG
                                        + '","' + row.BoxTotalNo
                                        + '","' + row.Supplier
                                        + '","' + row.IsEnable
                                        + '");\'>' + row.MaterialDataNo + '</a>';
                                }
                            },
                            { field: 'MaterialDataName', width: 150, title: '物料名称', align: 'center' },
                            { field: 'BoxType', width: 100, title: '容器类型', align: 'center' },
                            { field: 'KG', width: 50, title: '单箱重量', align: 'center' },
                            { field: 'BoxTotalNo', width: 50, title: '单箱收容数', align: 'center' },
                            { field: 'Supplier', width: 50, title: '供应商', align: 'center' },
                            {
                                field: 'IsEnable', title: '是否生效', width: 50, align: 'center',
                                formatter: function (value, row, index) {
                                    if (row.IsEnable == 0) {
                                        return "否";
                                    }
                                    else {
                                        return "是";
                                    }
                                }
                            }

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
                            var materialDataNo = $("#txtMaterialDataNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var materialDataName = $("#txtMaterialDataName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var supplier = $("#txtSupplier").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var storeId = $("#selectStore").val();
                            datagridfresh(1, 10, materialDataNo, materialDataName, supplier, storeId);
                        }
                    });
                }
            }, "json");
        }
        function Edit(ID, MaterialDataNo, MaterialDataName, BoxType, KG, BoxTotalNo, Supplier, IsEnable) {
            $("#txtid").val(ID);
            $("#MaterialDataNo").val(MaterialDataNo);
            $("#MaterialDataName").val(MaterialDataName);
            $("#BoxType").val(BoxType);
            $("#KG").val(KG);
            $("#BoxTotalNo").val(BoxTotalNo);
            $("#Isenable").val(IsEnable);
            $("#Supplier").val(Supplier);

            $.post('/Controller/getmwsByMid.ashx', { id: ID }, function (data) {

                if (data.rows[0].tips != "没有数据") {

                    for (var i = 0; i < data.rows.length; i++) {
                        $("#warehouse" + (i + 1)).val(data.rows[i].WarehouseId);
                        selectWChange("#warehouse" + (i + 1), (i + 1), data.rows[i].StoreId);
                    }

                }
            }, "json");

            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            $("#MaterialDataNo").val("");
            $("#MaterialDataName").val("");
            $("#BoxType").val("");
            $("#KG").val("");
            $("#BoxTotalNo").val("");
            //$("#Isenable").val(IsEnable);
            $("#Supplier").val("");
            $("#warehouse1").val("");
            $("#warehouse2").val("");
            $("#warehouse3").val("");
            $("#store1").html('<option value="" selected="selected">请选择</option>');
            $("#store2").html('<option value="" selected="selected">请选择</option>');
            $("#store3").html('<option value="" selected="selected">请选择</option>');
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
            if ($("#MaterialDataName").val().trim() == "" || $("#BoxTotalNo").val().trim() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }
            var reg = /^\d+$/;
            if (!reg.test($("#BoxTotalNo").val())) {
                $("#msg").html("单箱收容数必须是正整数！");
                return false;
            }
            var reg = /^\d+(\.\d+)?$/;
            if (!reg.test($("#KG").val())) {
                $("#msg").html("单箱重量必须是正数！");
                return false;
            }
            if (($("#store1").val() != "" && $("#store2").val() != "" && $("#store1").val() == $("#store2").val())
                || ($("#store1").val() != "" && $("#store3").val() != "" && $("#store1").val() == $("#store3").val())
                || ($("#store2").val() != "" && $("#store3").val() != "" && $("#store3").val() == $("#store2").val())) {
                $("#msg").html("仓位选择存在相同的仓位！");
                return false;
            }
            var ID = $("#txtid").val();
            var MaterialDataNo = $("#MaterialDataNo").val();
            var MaterialDataName = $("#MaterialDataName").val();
            var BoxType = $("#BoxType").val();
            var KG = $("#KG").val();
            var BoxTotalNo = $("#BoxTotalNo").val();
            var IsEnable = $("#Isenable").val();
            var Supplier = $("#Supplier").val();
            var Wms = "";
            for (var i = 1; i < 4; i++) {
                if ($("#warehouse" + i).val() != "" && $("#store" + i).val() != "") {
                    Wms += "|" + $("#warehouse" + i).val() + "_" + $("#store" + i).val();
                }
            }
            if (Wms == "") {
                $("#msg").html("请在仓位列表中选择！");
                return false;
            }

            $.post('/Controller/materialEdit.ashx', {
                id: ID,
                materialDataNo: MaterialDataNo,
                kg: KG,
                materialDataName: MaterialDataName,
                boxType: BoxType,
                boxTotalNo: BoxTotalNo,
                isEnable: IsEnable,
                supplier: Supplier,
                mws: Wms
            }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("*保存失败！");
                }
                else {
                    $("#msg").html("*保存成功！");
                    var materialDataNo = $("#txtMaterialDataNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var materialDataName = $("#txtMaterialDataName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var supplier = $("#txtSupplier").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var storeId = $("#selectStore").val();
                    datagridfresh(1, 10, materialDataNo, materialDataName, supplier, storeId);
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
                    $.post('/Controller/materialDelete.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("*删除失败！");
                        }
                        else {
                            $("#msg").html("*删除成功！");
                            var materialDataNo = $("#txtMaterialDataNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var materialDataName = $("#txtMaterialDataName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var supplier = $("#txtSupplier").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var storeId = $("#selectStore").val();
                            datagridfresh(1, 10, materialDataNo, materialDataName, supplier, storeId);
                            ClearAll(1);
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("*请先选择删除数据！");
            }
        }

    </script>
</asp:Content>
