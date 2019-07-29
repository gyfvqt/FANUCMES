<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="Store.aspx.cs" Inherits="SM.WEB.Views.WMS.Store" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="仓位维护"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:库存WMS\仓位维护</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div>
                                    <label for="txtStoreNo" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">仓储区域编码:</label>
                                    <input id="txtStoreNo" name="txtStoreNo" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" />
                                    <label style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">仓储区域名称:</label>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="rwlbWarehouseName">
                                    </select>
                                    <label style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">仓储区域类型:</label>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="rwlbWarehouseType">
                                        <option value="" selected="selected">请选择</option>
                                        <option value="原材料与零部件库">原材料与零部件库</option>
                                        <option value="成品仓">成品仓</option>
                                    </select>

                                    <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(); return false;" value="查  询" />

                                </div>

                                <br />
                                <br />
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">仓位列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 158px; overflow-y: auto;">
                                    <%--<div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>--%>
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
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)仓位</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div style="margin-top: 5px; margin-left: 5px;">
                                <input id="txtid" style="display: none;" />
                                <div style="display: block; float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">仓位编码:</div>
                                    <input id="StoreNo" name="StoreNo" maxlength="32" readonly="readonly" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">仓位名称:</div>
                                    <input id="StoreName" name="StoreName" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">仓储区域名称:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="WarehouseName">
                                    </select><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">拣货区域:</div>
                                    <input id="PickArea" name="PickArea" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">最大承重:</div>
                                    <input id="KG" name="KG" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">最大装载数量:</div>
                                    <input id="MaxNo" name="MaxNo" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">是否生效:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="Isenable">
                                        <option value="1" selected="selected">是</option>
                                        <option value="0">否</option>
                                    </select>
                                </div>
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
            $.post('/Controller/warehouseSearch.ashx', { pageindex: 1, pagesize: 100, warehouseNo: "", warehouseName: "", warehouseType: "" }, function (data) {

                if (data.rows[0].tips == "没有数据") {
                    $("#msg").html("*没有查询到数据，请调整一下查询条件！");
                    return false;
                }
                else {
                    var ohtml = "";
                    for (var i = 0; i < data.rows.length; i++) {
                        ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].WarehouseName + '</option>'
                    }
                    $("#rwlbWarehouseName").html('<option value="" selected="selected">请选择</option>' + ohtml);
                    $("#WarehouseName").html(ohtml);

                    var storeNo = $("#txtStoreNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var WarehouseId = $("#rwlbWarehouseName").val();
                    var WarehouseType = $("#rwlbWarehouseType").val();
                    datagridfresh(1, 10, storeNo, WarehouseId, WarehouseType);
                }
            }, "json");

        });
        function Search() {
            var storeNo = $("#txtStoreNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var WarehouseId = $("#rwlbWarehouseName").val();
            var WarehouseType = $("#rwlbWarehouseType").val();
            datagridfresh(1, 10, storeNo, WarehouseId, WarehouseType);
        }

        function datagridfresh(pageNumber, pageSize, StoreNo, WarehouseId, WarehouseType) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/storeSearch.ashx', { pageindex: pageNumber, pagesize: pageSize, storeName: StoreNo, warehouseId: WarehouseId, warehouseType: WarehouseType }, function (data) {

                if (data.rows[0].tips == "没有数据") {                    
                    $("#datawin").datagrid("loaded");
                    $("#datawin").datagrid({
                        //columns: [data.titleTable],   //动态取标题
                        emptyMsg:"<span>没有查询到数据，请调整一下查询条件！</span>",
                        columns: [[
                            { field: 'rownum', width: 30, title: 'No' },
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                }
                            },

                            {
                                field: 'StoreNo', title: '仓位编号', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.StoreNo
                                        + '","' + row.StoreName
                                        + '","' + row.PickArea
                                        + '","' + row.KG
                                        + '","' + row.MaxNo
                                        + '","' + row.IsEnable
                                        + '","' + row.WarehouseId
                                        + '");\'>' + row.StoreNo + '</a>';
                                }
                            },
                            { field: 'StoreName', width: 150, title: '仓位名称', align: 'center' },
                            { field: 'PickArea', width: 100, title: '拣货区域', align: 'center' },
                            { field: 'KG', width: 50, title: '最大承重(kg)', align: 'center' },
                            { field: 'MaxNo', width: 50, title: '最大装载数量', align: 'center' },
                            //{ field: 'MaxNo', width: 50, title: '仓位状态', align: 'center' },
                            {
                                field: 'IsEnable', title: '仓位状态', width: 50, align: 'center',
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
                        emptyMsg:"<span>没有查询到数据，请调整一下查询条件！</span>",
                        columns: [[
                            { field: 'rownum', width: 30, title: 'No' },
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                }
                            },

                            {
                                field: 'StoreNo', title: '仓位编号', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.StoreNo
                                        + '","' + row.StoreName
                                        + '","' + row.PickArea
                                        + '","' + row.KG
                                        + '","' + row.MaxNo
                                        + '","' + row.IsEnable
                                        + '","' + row.WarehouseId
                                        + '");\'>' + row.StoreNo + '</a>';
                                }
                            },
                            { field: 'StoreName', width: 150, title: '仓位名称', align: 'center' },
                            { field: 'PickArea', width: 100, title: '拣货区域', align: 'center' },
                            { field: 'KG', width: 50, title: '最大承重(kg)', align: 'center' },
                            { field: 'MaxNo', width: 50, title: '最大装载数量', align: 'center' },
                            //{ field: 'MaxNo', width: 50, title: '仓位状态', align: 'center' },
                            {
                                field: 'IsEnable', title: '仓位状态', width: 50, align: 'center',
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

                }
            }, "json");
        }
        function Edit(ID, StoreNo, StoreName, PickArea, KG, MaxNo, IsEnable, WarehouseId) {
            $("#txtid").val(ID);
            $("#StoreNo").val(StoreNo);
            $("#StoreName").val(StoreName);
            $("#PickArea").val(PickArea);
            $("#KG").val(KG);
            $("#MaxNo").val(MaxNo);
            $("#Isenable").val(IsEnable);
            $("#WarehouseName").val(WarehouseId);

            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            $("#StoreNo").val("");
            $("#StoreName").val("");
            $("#PickArea").val("");
            $("#KG").val("");
            $("#MaxNo").val("");
            //$("#IsEnable").val(IsEnable);
            //$("#WarehouseName").val(WarehouseId);
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
            if ($("#StoreName").val().trim() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }
            var reg = /^\d+$/;
            if (!reg.test($("#MaxNo").val())) {
                $("#msg").html("最大装载数量必须是正整数！");
                return false;
            }
            var reg = /^\d+(\.\d+)?$/;
            if (!reg.test($("#KG").val())) {
                $("#msg").html("最大承重必须是正数！");
                return false;
            }
            var ID = $("#txtid").val();
            var StoreNo = $("#StoreNo").val();
            var StoreName = $("#StoreName").val();
            var PickArea = $("#PickArea").val();
            var KG = $("#KG").val();
            var MaxNo = $("#MaxNo").val();
            var IsEnable = $("#Isenable").val();
            var WarehouseId = $("#WarehouseName").val();

            $.post('/Controller/storeEdit.ashx', {
                id: ID,
                storeNo: StoreNo,
                kg: KG,
                maxNo: MaxNo,
                storeName: StoreName,
                pickArea: PickArea,
                isEnable: IsEnable,
                warehouseId: WarehouseId
            }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("*保存失败！");
                }
                else {
                    $("#msg").html("*保存成功！");
                    var storeNo = $("#txtStoreNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var WarehouseId = $("#rwlbWarehouseName").val();
                    var WarehouseType = $("#rwlbWarehouseType").val();
                    datagridfresh(1, 10, storeNo, WarehouseId, WarehouseType);
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
                    $.post('/Controller/storeDelete.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("*删除失败！");
                        }
                        else {
                            $("#msg").html("*删除成功！");
                            var storeNo = $("#txtStoreNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var WarehouseId = $("#rwlbWarehouseName").val();
                            var WarehouseType = $("#rwlbWarehouseType").val();
                            datagridfresh(1, 10, storeNo, WarehouseId, WarehouseType);
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
