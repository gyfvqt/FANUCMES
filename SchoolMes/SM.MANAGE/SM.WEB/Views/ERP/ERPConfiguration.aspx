<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="ERPConfiguration.aspx.cs" Inherits="SM.WEB.Views.ERPConfiguration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="ERP集成接口"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:生产计划排产\ERP集成接口</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">基本信息</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 120px; overflow-y: auto;">
                                <div style="margin-top: 5px; margin-left: 5px;">
                                    <input id="txtid" style="display: none;" />
                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 120px;">FTP服务器IP:</div>
                                        <input id="FTPIP" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 120px;">文件路径:</div>
                                        <input id="Path" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 320px;" /><span style="color: red;">*</span><br />
                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 120px;">是否生效:</div>
                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="IsEnable">
                                            <option value="1" selected="selected">是</option>
                                            <option value="0">否</option>
                                        </select>


                                    </div>
                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">

                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 120px;">文件名:</div>
                                        <input id="FileName" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />
                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 120px;">读取频率（分钟）:</div>
                                        <input id="GetRate" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">字段读取设置</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 268px; overflow-y: auto;">
                                    <%--<div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>--%>
                                    <div style="height: 260px;">
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
            
            <input type="button" class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save();return false;" value="保  存"/>
           <input type="button" class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(1); return false;" value="取  消">
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">        
        $(document).ready(function () {
            erpsearch();
            datagridfresh();
        });
        

        function erpsearch() {
            var ID = $("#txtid").val();
            $.post('/Controller/ERPInterfaceSearch.ashx', { id: ID }, function (data) {
                if (data.rows[0].tips != "没有数据") {
                    $("#txtid").val(data.rows[0].ID);
                    $("#FTPIP").val(data.rows[0].FTPIP);
                    $("#FileName").val(data.rows[0].FileName);
                    $("#Path").val(data.rows[0].Path);
                    $("#GetRate").val(data.rows[0].GetRate);
                    $("#IsEnable").val(data.rows[0].IsEnable);
                }
            }, "json");
        }
        function datagridfresh() {
            $("#datawin").datagrid("loading");
            $.post('/Controller/ERPInterfaceRuleSearch.ashx', function (data) {
                if (data.rows[0].tips == "没有数据") {
                    $("#datawin").datagrid("loaded");
                    $("#datawin").datagrid({
                        //columns: [data.titleTable],   //动态取标题
                        emptyMsg: "<span>没有查询到数据，请调整一下查询条件！</span>",
                        columns: [[
                            { field: 'rownum', width: 30, title: 'No' },
                            //{
                            //    field: 'ID', title: '操作', width: 30, align: 'center',
                            //    formatter: function (value, row, index) {
                            //        return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                            //    }
                            //},

                            //{
                            //    field: 'WarehouseNo', title: '仓储区域编号', width: 120, align: 'center',
                            //    formatter: function (value, row, index) {
                            //        return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                            //            + '","' + row.WarehouseNo
                            //            + '","' + row.WarehouseType
                            //            + '","' + row.WarehouseName
                            //            + '");\'>' + row.WarehouseNo + '</a>';
                            //    }
                            //},
                            { field: 'ColumnName', width: 150, title: '字段名称', align: 'center' },
                            {
                                field: 'BeginChar', width: 100, title: '数据起始位', align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="text" name="BeginChar" class="qbox" id="BeginChar' + row.ID + '" value= "' + row.BeginChar + '"/>';
                                }
                            },
                            {
                                field: 'DataLength', width: 100, title: '字段长度', align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="text" name="DataLength" class="qbox" id="DataLength' + row.ID + '" value= "' + row.DataLength + '"/>';
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
                        columns: [[
                            { field: 'ID', width: 30, title: 'No' },
                            //{
                            //    field: 'ID', title: '操作', width: 30, align: 'center',
                            //    formatter: function (value, row, index) {
                            //        return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                            //    }
                            //},

                            //{
                            //    field: 'WarehouseNo', title: '仓储区域编号', width: 120, align: 'center',
                            //    formatter: function (value, row, index) {
                            //        return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                            //            + '","' + row.WarehouseNo
                            //            + '","' + row.WarehouseType
                            //            + '","' + row.WarehouseName
                            //            + '");\'>' + row.WarehouseNo + '</a>';
                            //    }
                            //},
                            { field: 'ColumnName', width: 150, title: '字段名称', align: 'center' },
                            {
                                field: 'BeginChar', width: 100, title: '数据起始位', align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="text" name="BeginChar" class="qbox" id="' + row.ID + '" value= "' + row.BeginChar + '"/>';
                                }
                            },
                            {
                                field: 'DataLength', width: 100, title: '字段长度', align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="text" name="DataLength" class="qbox" id="DataLength' + row.ID + '" value= "' + row.DataLength + '"/>';
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
        //function Edit(ID, WarehouseNo, WarehouseType, WarehouseName) {
        //    $("#txtid").val(ID);
        //    $("#txtLineId").val(WarehouseNo);
        //    $("#txtLineName").val(WarehouseName);
        //    $("#WarehouseType").val(WarehouseType);
        //    $("#listdd").hide();
        //    $("#listinputdd").show();
        //}
        function ClearAll(obj) {
            erpsearch();
            datagridfresh();
        }
        function Save() {
            if ($("#FTPIP").val().trim() == "" ||
                $("#FileName").val().trim() == "" ||
                $("#Path").val().trim() == "" ||
                $("#GetRate").val().trim() == "" ||
                $("#IsEnable").val().trim() == ""
            ) {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }

            
            var reg = /((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/;
            if (!reg.test($("#FTPIP").val().trim())) {
                $("#msg").html("请输入正确的FTP服务器IP！");
                return false;
            }
            var reg = /^\d+$/;
            if (!reg.test($("#GetRate").val().trim())) {
                $("#msg").html("获取频率必须是数字的分钟数！");
                return false;
            }

            var ID = $("#txtid").val();
            var FTPIP = $("#FTPIP").val();
            var FileName = $("#FileName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var Path = $("#Path").val();
            var GetRate = $("#GetRate").val();
            var IsEnable = $("#IsEnable").val();


            $.post('/Controller/ERPInterfaceEdit.ashx', {
                id: ID,
                ftpip: FTPIP,
                fileName: FileName,
                path: Path,
                getRate: GetRate,
                isEnable: IsEnable
            }, function (data) {

                if (data == "0") {                    
                    $("#msg").html("基本信息保存失败！");
                }
                else {
                    $("#msg").html("基本信息保存成功！");                    
                }
            }, "json");

            var Erprule = "";
            var t = "";
            $("input[name='BeginChar']").each(function (j, item) {

                var id = item.id;
                var reg = /^\d+$/;
                if (!reg.test(item.value)||!reg.test($("#DataLength" + id).val())) {
                    t += "0";
                }
                else {
                    t += "1";
                    Erprule += "|" + id + "_" + item.value + "_" + $("#DataLength" + id).val();
                }
            });
            if (t.indexOf("0")!=-1) {
                $("#msg").html("数据起始位或字段长度必须是数字！");
                return false;
            }
            $.post('/Controller/ERPInterfaceRuleEdit.ashx', {
                erprule: Erprule
            }, function (data) {

                if (data == "0") {                    
                    $("#msg").html("字段读取设置保存失败！");
                }
                else {
                    $("#msg").html("字段读取设置保存成功！");
                    //Search();
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
                    $.post('/Controller/warehouseDelete.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("*删除失败！");
                        }
                        else {
                            $("#msg").html("*删除成功！");
                            var WarehouseNo = $("#txtUserId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var WarehouseName = $("#txtEmail").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var WarehouseType = $("#rwlbWarehouseType").val();
                            datagridfresh(1, 10, WarehouseNo, WarehouseName, WarehouseType);
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

