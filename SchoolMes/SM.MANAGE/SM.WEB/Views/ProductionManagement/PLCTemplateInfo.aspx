<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="PLCTemplateInfo.aspx.cs" Inherits="SM.WEB.Views.ProductionManagement.PLCTemplateInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/Scripts/jquery.scrollTo.min.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="PLC模板"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:生产数据管理\PLC模板</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt id="list-filter"><span id="PortalContent_Label1">PLC模板</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 188px; overflow-y: auto;">
                                    <%--<div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>--%>
                                    <div style="height: 150px;">
                                        <table id="datawin" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                            style="border: solid 1px #add9c0; height: 140px; overflow-y: auto;">
                                            <thead>
                                                <tr>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                    <button class="button white-gradient" id="New" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(0);return false;">新  增</button>
                                    <%--<button class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save();return false;">保  存</button>--%>
                                    <button class="button white-gradient" id="delete" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Delete();return false;">删  除</button>
                                    <button class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(1);return false;">取  消</button>

                                    <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>

                                </div>
                                
                            </div>

                        </div>
                    </dd>

                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)模板</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block; height: 50px;">
                            <div style="margin-top: 5px;">
                                <input id="txtid" style="display: none;" />
                                <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">PLC模板名称:</div>
                                <input id="txtPLCTemplateName" name="txtPLCTemplateName" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><span style="color: red;">*</span>
                                <input type="button" class="button white-gradient" style="margin-right: 15px; float: right;" onclick="SaveNext(); return false;" value="下一步>>" />

                            </div>
                        </div>


                    </dd>
                    <dt class="closed"><span>PLC模板明细</span></dt>
                    <dd id="listinputdd2">
                        <div class="RadAjaxPanel" id="divplcdeltail" style="display: none; width: 100%;">
                            <div style="margin-top: 5px; margin-left: 5px; height: 188px; width: 100%;">
                                <div style="height: 150px;">
                                    <table id="dataSheet" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                        style="border: solid 1px #add9c0; height: 120px; overflow-y: auto;">
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
                                <label id="msgSheet" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>

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
        });
        function Search() {
            datagridfresh("");
        }

        function datagridfresh(ID) {
            $("#datawin").datagrid({
                url: "/Controller/PLCTemplateInfoSearch.ashx?Id=" + ID,
                //toolbar: "#tb",
                fitColumns: true,
                rownumbers: true,
                singleSelect: true,
                loadMsg: '加载中......',
                height: 'auto',
                onClickRow: onClickRow,
                emptyMsg: "<span>没有查询到数据</span>",
                showFooter: true,
                columns: [[
                    {
                        field: 'ID', title: '操作', width: 15, align: 'center',
                        formatter: function (value, row, index) {
                            return '<input type="checkbox" name="dgcheckbox" value="' + row.IsEnable + '" id="' + row.ID + '">';
                        }
                    },
                    {
                        field: 'PLCTemplateName', width: 100, title: 'PLC模板名称', align: 'center',
                        formatter: function (value, row, index) {
                            return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                + '","' + row.PLCTemplateName
                                + '");\'>' + row.PLCTemplateName + '</a>';
                        }
                    },
                    {
                        field: 'UpdateTime', width: 150, align: 'center', title: '最后修改时间'
                    },
                    {
                        field: 'Updator', width: 100, align: 'center', title: '修改人'
                    }

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
        }
        function SaveNext() {
            $("#divplcdeltail").show();
            $.scrollTo("#msgSheet", 500);
            Save();
            //getPLCDetailbyid($("#txtid").val());
        }
        function getPLCDetailbyid(ID) {
            $("#dataSheet").datagrid({
                url: "/Controller/PLCTemplateInfoDetailSearch.ashx?Id=" + ID,
                toolbar: "#tb",
                fitColumns: true,
                rownumbers: true,
                singleSelect: true,
                loadMsg: '加载中......',
                height: 'auto',
                onClickRow: onClickRow,
                emptyMsg: "<span>没有查询到数据</span>",
                showFooter: true,
                columns: [[
                    {
                        field: 'PLCUPDBAddress', width: 100, title: 'PLC地址', align: 'center', editor: {
                            type: 'validatebox',
                            options: {
                                required: true
                            }
                        }
                    },
                    //{
                    //    field: 'UPDataLength', width: 150, align: 'center', title: '数据长度', editor: {
                    //        type: 'validatebox',
                    //        options: {
                    //            required: true
                    //        }
                    //    }
                    //},
                    {
                        field: 'UPDataDesc', width: 150, align: 'center', title: '数据描述', editor: {
                            type: 'validatebox',
                            options: {
                                required: true,
                                validType: ['text', 'length[0,100]']
                            }
                        }
                    },

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
        }
        var editIndex = undefined;
        function endEditing(optype) {
            if (editIndex == undefined) { return true }
            if ($('#dataSheet').datagrid('validateRow', editIndex)) {
                //var ed = $('#dataSheet').datagrid('getEditor', { index: editIndex, field: 'ProcessType' });
                //var ProcessType = $(ed.target).combobox('getText');
                //$('#dataSheet').datagrid('getRows')[editIndex]['ProcessType'] = ProcessType;
                $('#dataSheet').datagrid('endEdit', editIndex);
                if (optype == "C") {
                    editIndex = undefined;
                    return true;
                }
                else if (optype == "E") {

                    if ($('#dataSheet').datagrid('getRows')[editIndex]['UPDataDesc'].length > 100) {
                        $("#msgSheet").html("数据描述长度超过了100字符！");
                        editIndex = undefined;
                        return false;
                    }
                    var row = $('#dataSheet').datagrid('getRows')[editIndex];
                    var ID = row.ID == undefined ? "" : row.ID;
                    var PLCTemplateID = $("#txtid").val();
                    var PLCUPDBAddress = row.PLCUPDBAddress.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    //var UPDataLength = row.UPDataLength.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var UPDataDesc = row.UPDataDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var reg = /^\d+$/;
                    //if (!reg.test(PLCUPDBAddress) || !reg.test(UPDataLength)) {
                    //    $("#msgSheet").html("数据偏移量或数据长度必须是数字！");
                    //    editIndex = undefined;
                    //    return false;
                    //}


                    $.post('/Controller/PLCTemplateInfoDetailEdit.ashx', {
                        id: ID,
                        plcTemplateID: PLCTemplateID,
                        plcUPDBAddress: PLCUPDBAddress,
                        //upDataLength: UPDataLength,
                        upDataDesc: UPDataDesc
                    }, function (data) {

                        if (data == "0") {
                            $("#msgSheet").html("保存明细失败！");
                            editIndex = undefined;
                            return false;
                        }
                        else {
                            $("#msgSheet").html("保存明细成功！");
                            //$('#dataSheet').datagrid('getRows')[editIndex]['ProcessId'] = ID;
                            //$('#dataSheet').datagrid('getRows')[editIndex]['PCStationId'] = PCStationId;
                            getPLCDetailbyid($("#txtid").val());
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
                    $('#dataSheet').datagrid('selectRow', index)
                        .datagrid('beginEdit', index);
                    editIndex = index;
                } else {
                    $('#dataSheet').datagrid('selectRow', editIndex);
                }
            }
        }
        function append() {
            if (endEditing("C")) {
                $('#dataSheet').datagrid('appendRow', { status: 'P' });
                editIndex = $('#dataSheet').datagrid('getRows').length - 1;
                $('#dataSheet').datagrid('selectRow', editIndex)
                    .datagrid('beginEdit', editIndex);
            }
        }
        function removeit() {
            if (editIndex == undefined) { return }
            var row = $('#dataSheet').datagrid('getRows')[editIndex];

            var ID = row.ID == undefined ? "" : row.ID;
            var UPDataDesc = row.UPDataDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

            $.post('/Controller/StationPrecessDeletebyid.ashx', {
                id: ID,
                upDataDesc: UPDataDesc
            }, function (data) {
                if (data == "0") {
                    $("#msgSheet").html("删除明细失败！");
                }
                else {
                    $("#msgSheet").html("删除明细成功！");
                    $('#dataSheet').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);
                    editIndex = undefined;
                }
            }, "text");

        }
        function accept() {
            if (endEditing("E")) {
                $('#dataSheet').datagrid('acceptChanges');
            }
        }
        function reject() {
            $('#dataSheet').datagrid('rejectChanges');
            editIndex = undefined;
        }
        function getChanges() {
            var rows = $('#dataSheet').datagrid('getChanges');
            alert(rows.length + ' rows are changed!');
        }

        function Edit(ID, PLCTemplateName) {
            $("#txtid").val(ID);
            $("#txtPLCTemplateName").val(PLCTemplateName);
            $("#divplcdeltail").show();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            $("#PLCTemplateName").val("");

            if (obj == 1) {
                $("#listinputdd").hide();
                $("#divplcdeltail").hide();
                Search();
            }
            else if (obj == 0) {
                $("#listinputdd").show();
            }
        }
        function Save() {
            if ($("#txtPLCTemplateName").val().trim() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }

            var ID = $("#txtid").val();
            var PLCTemplateName = $("#txtPLCTemplateName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');


            $.post('/Controller/PLCTemplateInfoEdit.ashx', {
                id: ID,
                plcTemplateName: PLCTemplateName
            }, function (data) {

                if (data == "0") {
                    $("#msg").html("保存失败！");
                }
                else {
                    $("#msg").html("保存成功！");
                    $("#txtid").val(data);
                    Search();
                    getPLCDetailbyid($("#txtid").val());
                }
            }, "json");
        }

        function Delete() {
            var deleteid = "";
            $("input[name='dgcheckbox']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                }
                //if (item.value == "1") {
                //    $("#msg").html("*必须失效的线体才可以删除！");
                //    return false;
                //}
            });
            if (deleteid.trim() != "") {
                if (confirm("确定删除数据？")) {
                    $.post('/Controller/PLCTemplateInfoDeleteByid.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("删除失败！");
                        }
                        else {
                            $("#msg").html("删除成功！");
                            Search();
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
