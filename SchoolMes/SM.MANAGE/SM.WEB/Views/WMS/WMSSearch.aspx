<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="WMSSearch.aspx.cs" Inherits="SM.WEB.Views.WMS.WMSSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="物料库存查询"></asp:Label>
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
        </style>
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:库存WMS\物料库存查询</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 80px; overflow-y: auto;">
                                <div>
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">仓储区域:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; float: left; height: 28px; width: 220px;" id="rwlbWarehouseName" onchange="selectWChange(this)">
                                        <option value="" selected="selected">请选择</option>
                                    </select>
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">仓储区域类型:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; float: left; height: 28px; width: 220px;" id="rwlbWarehouseType">
                                        <option value="" selected="selected">请选择</option>
                                        <option value="原材料与零部件库">原材料与零部件库</option>
                                        <option value="成品仓">成品仓</option>
                                    </select>
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">仓位:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; float: left; height: 28px; width: 220px;" id="selectStore">
                                        <option value="" selected="selected">请选择</option>
                                    </select><br />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">物料编号:</div>
                                    <input id="txtMaterialDataNo" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; float: left;" />
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">物料名称:</div>
                                    <input id="txtMaterialDataName" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; float: left;" />
                                    <button class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search();return false;">查  询</button>

                                </div>


                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">仓储区域列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 308px; overflow-y: auto;">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 300px;">
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

                </dl>

            </div>

        </div>
        <div style="display: block; float: left; margin-left: 15px;">
            <input type="button" class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save(); return false;" value="更新库存" />
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <style type="text/css">
        .qbox {
            width: 98%;
            background-color: rgb(255,255,0);
        }
    </style>
    <script type="text/javascript">        
        $(document).ready(function () {
            getWarehourse();
            datagridfresh(1, 10, "", "", "", "", "");
        });

        function getWarehourse() {
            $.post('/Controller/warehouseSearch.ashx', { pageindex: 1, pagesize: 100, warehouseNo: "", warehouseName: "", warehouseType: "" }, function (data) {

                if (data.rows[0].tips != "没有数据") {
                    var ohtml = '<option value="" selected="selected">请选择</option>';
                    for (var i = 0; i < data.rows.length; i++) {
                        ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].WarehouseName + '</option>'
                    }
                    $("#rwlbWarehouseName").html(ohtml);
                }
            }, "json");
        }
        function selectWChange(obj) {
            var ID = $(obj).val();
            $.post('/Controller/storeByWid.ashx', { id: ID }, function (data) {

                if (data.rows[0].tips != "没有数据") {
                    var ohtml = '<option value="" selected="selected">请选择</option>';
                    for (var i = 0; i < data.rows.length; i++) {
                        ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].StoreName + '</option>'
                    }
                    $("#selectStore").html(ohtml);

                }
            }, "json");
        }
        function Search() {
            var WarehouseId = $("#rwlbWarehouseName").val();
            var StoreId = $("#selectStore").val();
            var WarehouseType = $("#rwlbWarehouseType").val();
            var MaterialDataNo = $("#txtMaterialDataNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var MaterialDataName = $("#txtMaterialDataName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            datagridfresh(1, 10, WarehouseId, StoreId, WarehouseType, MaterialDataNo, MaterialDataName);
        }

        function datagridfresh(pageNumber, pageSize, WarehouseId, StoreId, WarehouseType, MaterialDataNo, MaterialDataName) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/WMSSearch.ashx', { pageindex: pageNumber, pagesize: pageSize, warehouseId: WarehouseId, storeId: StoreId, warehouseType: WarehouseType, materialDataNo: MaterialDataNo, materialDataName: MaterialDataName }, function (data) {
                if (data.rows[0].tips == "没有数据") {
                    $("#datawin").datagrid("loaded");
                    $("#datawin").datagrid({
                        //columns: [data.titleTable],   //动态取标题
                        emptyMsg: "<span>没有查询到数据，请调整一下查询条件！</span>",
                        columns: [[
                            { field: 'rownum', width: 30, title: 'No' },
                            { field: 'WarehouseName', width: 80, title: '仓储区域名称', align: 'center' },
                            { field: 'WarehouseType', width: 80, title: '仓储区域类型', align: 'center' },
                            { field: 'StoreNo', width: 80, title: '仓位编号', align: 'center' },
                            { field: 'StoreName', width: 80, title: '仓位名称', align: 'center' },
                            { field: 'MaterialDataNo', width: 80, title: '物料编号', align: 'center' },
                            { field: 'MaterialDataName', width: 80, title: '物料名称', align: 'center' },
                            {
                                field: 'MTotal', title: '库存现有数量', width: 100, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="text" name="wmscount" class="qbox" id="' + row.ID + '" value= "' + row.MTotal + '"/>';
                                }
                            },
                            { field: 'exchangecount', width: 80, title: '计划变更数量', align: 'center' }


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
                        columns: [[
                            { field: 'rownum', width: 30, title: 'No' },
                            { field: 'WarehouseName', width: 80, title: '仓储区域名称', align: 'center' },
                            { field: 'WarehouseType', width: 80, title: '仓储区域类型', align: 'center' },
                            { field: 'StoreNo', width: 80, title: '仓位编号', align: 'center' },
                            { field: 'StoreName', width: 80, title: '仓位名称', align: 'center' },
                            { field: 'MaterialDataNo', width: 80, title: '物料编号', align: 'center' },
                            { field: 'MaterialDataName', width: 80, title: '物料名称', align: 'center' },
                            {
                                field: 'MTotal', title: '库存现有数量', width: 100, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="text" name="wmscount" class="qbox" id="' + row.ID + '" value= "' + row.MTotal + '"/>';
                                }
                            },
                            { field: 'exchangecount', width: 80, title: '计划变更数量', align: 'center' }


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
                            var WarehouseId = $("#rwlbWarehouseName").val();
                            var StoreId = $("#selectStore").val();
                            var WarehouseType = $("#rwlbWarehouseType").val();
                            var MaterialDataNo = $("#txtMaterialDataNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var MaterialDataName = $("#txtMaterialDataName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            datagridfresh(pageNumber, pageSize, WarehouseId, StoreId, WarehouseType, MaterialDataNo, MaterialDataName);
                        }
                    });
                }
            }, "json");
        }
        function Save() {
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
                $("#msg").html("库存必须是数字！");
                return false;
            }
            $.post('/Controller/updateWMS.ashx', {
                wmscount: Wmscount
            }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("*保存失败！");
                }
                else {
                    $("#msg").html("*保存成功！");
                    Search();
                }
            }, "json");
        }



    </script>
</asp:Content>

