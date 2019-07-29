<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="FaultUserInfo.aspx.cs" Inherits="SM.WEB.Views.ProductionManagement.FaultUserInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="设备故障提醒设置"></asp:Label>
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
        </style>
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:系统管理\设备故障提醒设置</span>
        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="width: 200px; min-height: 480px; overflow-y: auto;">
                    <dt class="closed">
                        <span>设备结构树</span>

                    </dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" id="rolelist" style="display: block;">
                                <div style="">
                                    <div class="easyui-panel" style="padding: 5px">
                                        <ul id="tt" class="easyui-tree"></ul>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </dd>
                </dl>
            </div>

        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left; margin-left: 220px;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="min-width: 840px; width: auto">
                    <dt class="closed"><span>提醒用户信息</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding" style="display: block; overflow-y: auto; height: auto;">
                            <div class="RadAjaxPanel">
                                <div style="margin-top: 5px; margin-left: 5px;">
                                    <input type="hidden" id="txtid" value="" />
                                    <div style="float: left; margin-top: 5px; width: 100%;">
                                        <label id="ename" style="margin-left: 50px; font: bold 14px">选择节点：</label>
                                    </div>
                                    <div style="float: left; margin-top: 5px;">
                                        <div style="width: 280px; height: 130px; float: left; border: 1px #ccc solid; margin-left: 45px; overflow-y: auto;">
                                            <div id="dlleft" style="min-height: 130px; width: 100%;"></div>
                                        </div>
                                        <div style="width: 100px; height: 130px; float: left; margin-left: 20px">
                                            <input class="button white-gradient" style="margin-top: 5px; width: 60px; margin-left: 9px; margin-top: 30px;" onclick="SetRight(); return false;" value="设置>>" />
                                            <input class="button white-gradient" style="margin-top: 5px; width: 60px; margin-left: 9px; margin-top: 10px;" onclick="SetLeft(); return false;" value="<<取消" />
                                        </div>
                                        <div style="width: 280px; height: 130px; float: left; border: 1px #ccc solid; margin-left: 20px">
                                            <div id="dlright" style="min-height: 130px; width: 100%;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="min-width: 100%; width: auto; float: left;">
                                <input class="button white-gradient" id="save" style="margin-top: 5px; width: 60px; margin-right: 5px; float: right;" onclick="SaveBase(); return false;" value="保  存" />
                                <label id="msgBase" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px;"></label>
                            </div>
                        </div>

                    </dd>
                </dl>
            </div>

        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left; margin-top: 250px; margin-left: 220px;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="min-width: 840px; width: auto">
                    <dt class="closed"><span>设备故障提醒设置</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div style="margin-top: 5px; margin-left: 5px; height: 188px; width: 100%;">
                                    <div style="height: 180px;">
                                        <table id="datawin" style="width: auto; height: 175px; overflow-y: auto;"></table>
                                    </div>

                                    <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>

                                </div>
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
            $('#tt').tree({
                url: "/Controller/EquipmentDataTrees.ashx",
                method: 'get',
                animate: true,
                onClick: function (node) {
                    //$(this).tree('beginEdit', node.target);
                    getLeft(node.id);
                    getRight(node.id);
                    $("#txtid").val(node.id);
                    $("#ename").html("选择节点：" + node.text);
                    //$(this).tree('getParent',node.target);//获取父亲节点
                }
            });
            Query(1, 10);
        }
        function getLeft(ID) {
            $('#dlleft').datalist({
                url: '/Controller/FaultUserInfoLeft.ashx?eid=' + ID,
                valueField: "UserId",
                textField: "UserName",
                title: "用户列表"
            });
        }
        function getRight(ID) {
            $('#dlright').datalist({
                url: '/Controller/FaultUserInfoRight.ashx?eid=' + ID,
                valueField: "UserId",
                textField: "UserName",
                title: "提醒人员列表"
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

        function ClearAll() {
            $("#ID").val("");
            $("#txtid").val("");
            $("#ParentId").val("");
            $("#EquipmentCode").val("");
            $("#EquipmentName").val("");
            $("#EquipmentDesc").val("");
            $("#Team").val("");
            $("#EquipmentImg").val("");
            $("#PLCIP").val("");
            $("#PLCDB").val("");
            $("#IsPayPoint").val("");
            $("#DesignCycletime").val("");
            $("#DesignJPH").val("");
            $("#EquipmentSupplier").val("");
            $("#Counter").val("");
        }

        function SaveBase() {
            var userlist = "";
            var ID = $("#txtid").val();
            var ename = $("#ename").html().split('：')[1];
            var rows = $("#dlright").datalist("getRows");
            $(rows).each(function (i) {
                var value = rows[i].UserId;
                var text = rows[i].UserName;
                userlist += "|" + value + "_" + text;
            });
            $.post('/Controller/FaultUserInfoEdit.ashx', {
                equipmentId: ID,
                equipmentName: ename,
                UserId: userlist
            }, function (data) {
                if (data == "0") {
                    $("#msgBase").html("设置提醒用户失败！");
                }
                else {
                    $("#msgBase").html("设置提醒用户成功！");
                    Query(1, 10);
                }
            }, "json");
        }
        function Query(pageNumber, pageSize) {

            //var opts = $('#datawin').datagrid('options');
            var page = pageNumber;//获取页码
            var pageSize = pageSize;//获取每页多少记录
            var handler = "/Controller/FaultUserInfoSearch.ashx?pageindex=" + page
                + "&pagesize=" + pageSize;
            $('#datawin').datagrid({
                //toolbar: "#gridWellToolbar",
                pagination: true,
                rownumbers: true,
                //singleselect: true,
                fitColumns: true,
                //height: 'min-height:200px',
                loadMsg: '正在处理,请稍等。。。',
                emptyMsg: "<span>没有查询到数据</span>",
                url: handler,
                columns: [[
                    {
                        field: 'ID', title: '操作', width: 30, align: 'center',
                        formatter: function (value, row, index) {
                            return '<a href="#" onclick="DeleteByEid(\'' + row.EquipmentId + '\',\'' + row.EquipmentName + '\')" style="color:red;font:bold 16px">X</a>'
                        }
                    },
                    { field: 'EquipmentName', title: '节点选择', width: 100 },
                    { field: 'UserList', title: '提醒人员列表', width: 300 }
                ]]
            });
            //$('#datawin').datagrid('options').url = handler; //设置表格数据的来源URL
            var p = $('#datawin').datagrid('getPager');
            $(p).pagination({
                pageSize: 10, //每页显示的记录条数，默认为10 
                pageList: [10, 20, 30], //可以设置每页记录条数的列表 
                onSelectPage: function (pageNumber, pageSize) {
                    Query(pageNumber, pageSize);//分页查询
                }
            });
            $('#datawin').datagrid('reload'); //重新加载表格

        }
        function DeleteByEid(eid, Ename) {
            $.post('/Controller/FaultUserInfoDeleteByEid.ashx', { id: eid, ename: Ename }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    $("#msg").html("删除设备故障提醒设置失败！");
                }
                else {
                    $("#msg").html("删除设备故障提醒设置成功！");
                    Query(1, 10);
                }
            }, "json");
        }
    </script>
</asp:Content>
