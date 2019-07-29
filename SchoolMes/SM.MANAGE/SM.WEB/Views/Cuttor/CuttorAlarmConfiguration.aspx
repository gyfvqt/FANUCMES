<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="CuttorAlarmConfiguration.aspx.cs" Inherits="SM.WEB.Views.Cuttor.CuttorAlarmConfiguration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="换刀提醒设置"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:刀具管理\换刀提醒设置</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">                    
                    <dt id="list-filter"><span>刀具列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 208px; ">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 170px;overflow-y: auto;">
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
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)提醒</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div style="margin-top: 5px; margin-left: 5px;">
                                <input id="txtid" style="display: none;" />
                                <div style="width: 100%; float: left;">
                                    <div style="float: left; margin-top: 5px;width:100px;">换刀提醒编码：</div>
                                    <div style="float: left; margin-top: 5px; margin-left: 45px;">
                                        <input id="SNO" class="k-textbox" maxlength="32" readonly="readonly" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;background: rgb(194, 184, 184);" />
                                                <span style="color: red;">*</span>
                                    </div>
                                    
                                </div>
                                <div style="width: 100%; float: left; margin-top: 5px;min-width:900px;">
                                    <div style="float: left; margin-top: 5px;width:100px;">关联站点：</div>
                                    <div style="float: left; margin-top: 5px;">
                                        <div style=" float: left; margin-left: 45px;">
                                            <div id="dlleftS" style="height: 130px;width: 280px; overflow-y: auto;"></div>
                                        </div>
                                        <div style="width: 100px; height: 130px; float: left; margin-left: 20px">
                                            <input class="button white-gradient" style="margin-top: 5px; width: 60px; margin-left: 9px; margin-top: 30px;" onclick="SetRightS(); return false;" value="设置>>" />
                                            <input class="button white-gradient" style="margin-top: 5px; width: 60px; margin-left: 9px; margin-top: 10px;" onclick="SetLeftS(); return false;" value="<<取消" />
                                        </div>
                                        <div style="float: left; margin-left: 20px;">
                                            <div id="dlrightS" style="height: 130px;width: 280px; overflow-y: auto;"></div>
                                        </div>
                                    </div>
                                </div>
                                <div style="width: 100%; float: left; margin-top: 5px;min-width:900px;">
                                    <div style="float: left; margin-top: 5px;width:100px;">提醒人：</div>
                                    <div style="float: left; margin-top: 5px;">
                                        <div style=" float: left;margin-left: 45px; ">
                                            <div id="dlleft" style="height: 130px;width: 280px; overflow-y: auto;"></div>
                                        </div>
                                        
                                        <div style="width: 100px; height: 130px; float: left; margin-left: 20px">
                                            <input class="button white-gradient" style="margin-top: 5px; width: 60px; margin-left: 9px; margin-top: 30px;" onclick="SetRight(); return false;" value="设置>>" />
                                            <input class="button white-gradient" style="margin-top: 5px; width: 60px; margin-left: 9px; margin-top: 10px;" onclick="SetLeft(); return false;" value="<<取消" />
                                        </div>
                                        <div style=" float: left;  margin-left: 20px;">
                                            <div id="dlright"  style="height: 130px;width: 280px; overflow-y: auto;"></div>
                                        </div>
                                    </div>
                                </div>
                                <div style="width: 100%; float: left; margin-top: 10px;min-width:900px;">
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
        $(document).ready(function () {
            Search(1, 10);
            getLeft("");
            getRight("");
            getLeftS("");
            getRightS("");
        });
        function Search(pageNumber, pageSize) {
            datagridfresh(pageNumber, pageSize);
        }
        
        function datagridfresh(pageNumber, pageSize) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/CuttorAlarmConfigurationSearch.ashx', {
                pageindex: pageNumber, pagesize: pageSize
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
                                    return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';                                    
                                }
                            },                            
                            {
                                field: 'SNO', title: '提醒号', width: 70, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.SNO                                       
                                        + '");\'>' + row.SNO + '</a>';
                                }
                            },
                            { field: 'UserList', width: 150, title: '站点选择', align: 'center' },
                            { field: 'StationList', width: 150, title: '提醒人列表', align: 'center' }
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
                                    return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';                                    
                                }
                            },                            
                            {
                                field: 'SNO', title: '提醒号', width: 70, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.SNO                                       
                                        + '");\'>' + row.SNO + '</a>';
                                }
                            },
                            { field: 'UserList', width: 150, title: '站点选择', align: 'center' },
                            { field: 'StationList', width: 150, title: '提醒人列表', align: 'center' }
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

        function getLeft(ID) {
            $('#dlleft').datalist({
                url: '/Controller/CuttorUserLeft.ashx?eid=' + ID,
                valueField: "UserId",
                textField: "UserName",
                title: "用户列表"
            });
        }
        function getRight(ID) {
            $('#dlright').datalist({
                url: '/Controller/CuttorUserRight.ashx?eid=' + ID,
                valueField: "UserId",
                textField: "UserName",
                title: "提醒人员列表"
            });
        }

        function getLeftS(ID) {
            $('#dlleftS').datalist({
                url: '/Controller/CuttorStationleft.ashx?eid=' + ID,
                valueField: "StationId",
                textField: "StationCode",
                title: "站点列表"
            });
        }
        function getRightS(ID) {
            $('#dlrightS').datalist({
                url: '/Controller/CuttorStationRight.ashx?eid=' + ID,
                valueField: "StationId",
                textField: "StationCode",
                title: "关联站点列表"
            });
        }
        function SetRight() {
            var rows = $("#dlleft").datalist("getSelections");
            $(rows).each(function (i) {
                var value = rows[i].UserId;
                var text = rows[i].UserName;
                var row = {
                    UserId: value,
                    UserName: text
                };
                //添加
                //$("#dl2").datalist("appendRow",row);
                $("#dlright").datalist("insertRow", { index: 0, row: row });//作为第一条
                //删除
                var rowIndex = $("#dlleft").datalist("getRowIndex", rows[i]);
                $("#dlleft").datalist("deleteRow", rowIndex);
            });
            //移动完后重新加载dl2,否则显示不正常
            $("#dlright").datalist("loadData", $("#dlright").datalist('getRows'));

        }
        function SetLeft() {
            var rows = $("#dlright").datalist("getSelections");
            $(rows).each(function (i) {
                var value = rows[i].UserId;
                var text = rows[i].UserName;
                var row = {
                    UserId: value,
                    UserName: text
                };
                //添加
                //$("#dl2").datalist("appendRow",row);
                $("#dlleft").datalist("insertRow", { index: 0, row: row });//作为第一条
                //删除
                var rowIndex = $("#dlright").datalist("getRowIndex", rows[i]);
                $("#dlright").datalist("deleteRow", rowIndex);
            });
            //移动完后重新加载dl2,否则显示不正常
            $("#dlleft").datalist("loadData", $("#dlleft").datalist('getRows'));
        }
        function SetRightS() {
            var rows = $("#dlleftS").datalist("getSelections");
            $(rows).each(function (i) {
                var value = rows[i].StationId;
                var text = rows[i].StationCode;
                var row = {
                    StationId: value,
                    StationCode: text
                };
                //添加
                //$("#dl2").datalist("appendRow",row);
                $("#dlrightS").datalist("insertRow", { index: 0, row: row });//作为第一条
                //删除
                var rowIndex = $("#dlleftS").datalist("getRowIndex", rows[i]);
                $("#dlleftS").datalist("deleteRow", rowIndex);
            });
            //移动完后重新加载dl2,否则显示不正常
            $("#dlrightS").datalist("loadData", $("#dlrightS").datalist('getRows'));

        }
        function SetLeftS() {
            var rows = $("#dlrightS").datalist("getSelections");
            $(rows).each(function (i) {
                var value = rows[i].StationId;
                var text = rows[i].StationCode;
                var row = {
                    StationId: value,
                    StationCode: text
                };
                //添加
                //$("#dl2").datalist("appendRow",row);
                $("#dlleftS").datalist("insertRow", { index: 0, row: row });//作为第一条
                //删除
                var rowIndex = $("#dlrightS").datalist("getRowIndex", rows[i]);
                $("#dlrightS").datalist("deleteRow", rowIndex);
            });
            //移动完后重新加载dl2,否则显示不正常
            $("#dlleftS").datalist("loadData", $("#dlleftS").datalist('getRows'));
        }
        function Edit(ID, SNO) {
            $("#txtid").val(ID);
            $("#SNO").val(SNO);
            getLeft(ID);
            getRight(ID);
            getLeftS(ID);
            getRightS(ID);
            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            $("#SNO").val("");
            getLeft("");
            getRight("");
            getLeftS("");
            getRightS("");
            $("#msg").html("");
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
            var userlist = "";
            var stationlist = "";
            var ID = $("#txtid").val();            
            var rows = $("#dlright").datalist("getRows");
            $(rows).each(function (i) {
                var value = rows[i].UserId;
                var text = rows[i].UserName;
                userlist += "|" + value;
            });
            var rows2 = $("#dlrightS").datalist("getRows");
            $(rows2).each(function (i) {
                var value = rows2[i].StationId;
                var text = rows2[i].StationCode;
                stationlist += "|" + value;
            });
            $.post('/Controller/CuttorAlarmConfigurationEdit.ashx', {
                id: ID,
                station: stationlist,
                user: userlist
            }, function (data) {
                if (data == "0") {
                    $("#msg").html("设置换刀提醒失败！");
                }
                else {
                    $("#msg").html("设置换刀提醒成功！");
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
                    $.post('/Controller/CuttorAlarmConfigurationDelete.ashx', { id: deleteid }, function (data) {

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