<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="PBOM.aspx.cs" Inherits="SM.WEB.Views.ProductionManagement.PBOM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="BOM管理"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:生产数据管理\BOM管理</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">BOM编辑</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 50px; overflow-y: auto;">
                                <div>
                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">
                                        产品编码:
                                    <input id="txtProductionId" style="border: 1px #ccc; width: 220px; margin: 0 5px 5px 0; height: 26px;" /><span style="color: red;">*</span>
                                    </div>

                                    <div style="padding-bottom: .3em; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">
                                        产品名称:
                                    <input id="txtProductionName" type="text" readonly="readonly" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px; background: rgb(194, 184, 184);" />
                                    </div>

                                    <%--<input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(); return false;" value="查  询" />--%>
                                </div>


                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">BOM列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 358px; overflow-y: auto;">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="min-height: 350px;">
                                        <table id="datawin" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                            style="border: solid 1px #add9c0;">
                                            <thead>
                                                <tr>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                    <div id="tb" style="height: auto">
                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">新增</a>
                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">取消</a>
                                        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">获取修改</a>--%>
                                    </div>

                                </div>

                            </div>

                        </div>
                    </dd>

                </dl>

            </div>

        </div>
        <div style="display: block; float: left; margin-left: 15px;">
            <%--<input type="button" class="button white-gradient" id="New" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(0); return false;" value="新  增" />
            <input type="button" class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save(); return false;" value="保  存" />
            <input type="button" class="button white-gradient" id="delete" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Delete(); return false;" value="删  除" />--%>
            <%--<input type="button" class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(1); return false;" value="取  消">--%>
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
        var stopFirstChangeEvent=true
        $(document).ready(function () {
            //getProduct("");
            $('#txtProductionId').combobox({
                url: '/Controller/BomProduction.ashx?productionId=',
                valueField: 'ID',
                textField: 'ProductionId',
                mode: 'remote',
                
                onChange: function (rec) {
                    var url = '/Controller/BomProduction.ashx?productionId=' + $('#txtProductionId').combobox("getText");
                    $('#txtProductionId').combobox('reload', url);
                },
                onSelect: function (rec) {
                    if (stopFirstChangeEvent) {
                        stopFirstChangeEvent = false;
                        return;
                    }

                    $.post('/Controller/productionByid.ashx', { id: rec.ID }, function (data) {
                        $("#txtProductionName").val(data.rows[0].ProductionName);
                        Search();
                        stopFirstChangeEvent = true;
                    }, "json");
                }

            });

            //datagridfresh(1, 10, "", "", "");
        });

        function getProduct(ProductionId) {
            $.post('/Controller/BomProduction.ashx', { productionId: ProductionId }, function (d) {
                d.push({ "ID": "", "ProductionId": "请选择" })
                $('#txtProductionId').combobox({
                    data: d,
                    valueField: 'ID',
                    textField: 'ProductionId',
                    mode: 'remote',
                    onChange: function (rec) {
                        var url = '/Controller/BomProduction.ashx?productionId=' + $('#txtProductionId').combobox("getText");
                        $('#txtProductionId').combobox('reload', url);
                    },
                    onSelect: function (rec) {
                        //$('#txtProductionId').combobox("setValue", rec.ID);
                        if (rec.ID != "") {
                            $.post('/Controller/productionByid.ashx', { id: rec.ID }, function (data) {
                                $("#txtProductionName").val(data.rows[0].ProductionName);
                                Search();
                            }, "json");
                        }
                        else {
                            $("#txtProductionName").val("请选择产品");
                        }
                    }
                    //,
                    //onChange: function (rec) {
                    //    var url = '/Controller/BomProduction.ashx?productionId=' + $('#txtProductionId').combobox("getText");
                    //    $('#txtProductionId').combobox('reload', url);
                    //}
                });
            }, "json");
        }
        function Search() {

            var ProductionId = $("#txtProductionId").val();
            datagridfresh(1, 10, ProductionId);
        }

        function datagridfresh(pageNumber, pageSize, ProductionId) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/BomSearch.ashx', { pageindex: pageNumber, pagesize: pageSize, productionId: ProductionId }, function (data) {
                if (data.rows[0].tips == "没有数据") {
                    $("#datawin").datagrid("loaded");
                    $("#datawin").datagrid({
                        toolbar: "#tb",
                        rownumbers: true,
                        singleselect: false,
                        fitColumns: true,
                        onClickRow: onClickRow,
                        emptyMsg: "<span>没有查询到数据</span>",
                        columns: [[
                            {
                                field: 'MaterialDataNo', title: '物料编码', width: 120, align: 'center', editor: {
                                    type: 'combobox',
                                    options: {
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
                                        }
                                        //,
                                        //onSelect: function (rec) {
                                        //    //$('#txtProductionId').combobox("setValue", rec.ID);
                                        //    $.post('/Controller/productionByid.ashx', { id: rec.ID }, function (data) {
                                        //        $("#txtProductionName").val(data.rows[0].ProductionName);
                                        //    }, "json");
                                        //}

                                    }
                                }
                            },
                            { field: 'MaterialDataName', width: 150, title: '物料名称', align: 'center' },
                            {
                                field: 'UseCount', width: 50, title: '数量', align: 'center', editor: {
                                    type: 'validatebox',
                                    options: {
                                        required: true,
                                        validType: ['text', 'length[0,16]']
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
                        toolbar: "#tb",
                        rownumbers: true,
                        singleselect: false,
                        fitColumns: true,
                        onClickRow: onClickRow,
                        emptyMsg: "<span>没有查询到数据</span>",
                        columns: [[
                            {
                                field: 'MaterialDataNo', title: '物料编码', width: 120, align: 'center', editor: {
                                    type: 'combobox',
                                    options: {
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
                                        }
                                        //,
                                        //onSelect: function (rec) {
                                        //    //$('#txtProductionId').combobox("setValue", rec.ID);
                                        //    $.post('/Controller/productionByid.ashx', { id: rec.ID }, function (data) {
                                        //        $("#txtProductionName").val(data.rows[0].ProductionName);
                                        //    }, "json");
                                        //}

                                    }
                                }
                            },
                            { field: 'MaterialDataName', width: 150, title: '物料名称', align: 'center' },
                            {
                                field: 'UseCount', width: 50, title: '数量', align: 'center', editor: {
                                    type: 'validatebox',
                                    options: {
                                        required: true,
                                        validType: ['text', 'length[0,16]']
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
                            var ProductionId = $('#txtProductionId').combobox("getValue");
                            datagridfresh(pageNumber, pageSize, ProductionId);
                        }
                    });
                }
            }, "json");
        }

        function ClearAll(obj) {
            $("#txtid").val("");
            $("#ProductionId").val("");
            $("#ProductionName").val("");
            $("#ProductionType").val("");
            $("#ProductionSheet").val("");
            $("#LineId").val("");
            $("#Batch").val("");
            $("#StoreId").val("");
            $("#hidProductionImg").val("");
            $("#ProductionDesc").val("");
            $("#IsEnable").val("1");

            $("#ProductionId").removeAttr("readonly");
            $("#ProductionId").css("background", "rgb(255, 255, 255)");
            if (obj == 1) {
                $("#listdd").show();
                $("#listinputdd").hide();
            }
            else if (obj == 0) {
                $("#listdd").hide();
                $("#listinputdd").show();
            }
        }
        var editIndex = undefined;
        function endEditing(optype) {
            if (editIndex == undefined) { return true }
            if ($('#datawin').datagrid('validateRow', editIndex)) {
                var ed = $('#datawin').datagrid('getEditor', { index: editIndex, field: 'MaterialDataNo' });
                var MaterialDataNo = $(ed.target).combobox('getText');
                var MaterialId = $(ed.target).combobox('getValue');
                $('#datawin').datagrid('getRows')[editIndex]['MaterialDataNo'] = MaterialDataNo;
                $('#datawin').datagrid('endEdit', editIndex);
                if (optype == "C") {
                    editIndex = undefined;
                    return true;
                }
                else if (optype == "E") {
                    //if ($('#datawin').datagrid('getRows')[editIndex]['ProcessName'].length > 32) {
                    //    $("#msg").html("工艺名称长度超过了32字符！");
                    //    return false;
                    //}
                    //if ($('#datawin').datagrid('getRows')[editIndex]['ProcessDesc'].length > 100) {
                    //    $("#msg").html("工艺描述长度超过了100字符！");
                    //    return false;
                    //}
                    var row = $('#datawin').datagrid('getRows')[editIndex];
                    var ID = row.ID == undefined ? "" : row.ID;
                    var ProductionId = $('#txtProductionId').combobox("getValue");
                    var UseCount = row.UseCount;
                    //var ProcessDesc = row.ProcessDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var reg = /^\d+$/;
                    if (!reg.test(UseCount)) {
                        $("#msg").html("数量必须是数字！");
                        editIndex = undefined;
                        return false;
                    }

                    if (MaterialDataNo.trim() == "" || UseCount.trim() == "" || MaterialId.trim() == "") {
                        $("#msg").html("物料编码和数量必须输入！");
                        editIndex = undefined;
                        return false;
                    }

                    $.post('/Controller/BomEdit.ashx', {
                        id: ID,
                        productionId: ProductionId,
                        materialId: MaterialId,
                        materialCode: MaterialDataNo,
                        useCount: UseCount
                    }, function (data) {

                        if (data == "0") {
                            $("#msg").html("BOM信息保存失败！");
                            editIndex = undefined;
                            return false;
                        }
                        else {
                            $("#msg").html("BOM信息保存成功！");
                            Search();
                            editIndex = undefined;
                            return true;
                        }
                    }, "text");
                }

            } else {
                return false;
            }
        }
        function onClickRow(index) {
            if (editIndex != index) {
                if (endEditing("C")) {
                    $('#datawin').datagrid('selectRow', index)
                        .datagrid('beginEdit', index);
                    editIndex = index;
                } else {
                    $('#datawin').datagrid('selectRow', editIndex);
                }
            }
        }
        function append() {
            if (endEditing("C")) {
                $('#datawin').datagrid('appendRow', { status: 'P' });
                editIndex = $('#datawin').datagrid('getRows').length - 1;
                $('#datawin').datagrid('selectRow', editIndex)
                    .datagrid('beginEdit', editIndex);
            }
        }
        function removeit() {
            if (editIndex == undefined) { return }
            var row = $('#datawin').datagrid('getRows')[editIndex];
            var ID = row.ID == undefined ? "" : row.ID;
            var ed = $('#datawin').datagrid('getEditor', { index: editIndex, field: 'MaterialDataNo' });
            var MaterialDataNo = $(ed.target).combobox('getText');


            $.post('/Controller/BomDeleteByid.ashx', {
                id: ID,
                materialCode: MaterialDataNo
            }, function (data) {
                if (data == "0") {
                    $("#msg").html("删除BOM信息失败！");
                }
                else {
                    $("#msg").html("删除BOM信息成功！");
                    $('#datawin').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);
                    editIndex = undefined;
                }
            }, "text");

        }
        function accept() {
            if (endEditing("E")) {
                $('#datawin').datagrid('acceptChanges');
            }
        }
        function reject() {
            $('#datawin').datagrid('rejectChanges');
            editIndex = undefined;
        }
        function getChanges() {
            var rows = $('#datawin').datagrid('getChanges');
            alert(rows.length + ' rows are changed!');
        }


    </script>
</asp:Content>
