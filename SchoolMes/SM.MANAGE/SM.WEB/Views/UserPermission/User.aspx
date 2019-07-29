<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="SM.WEB.Views.UserPermission.User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="用户管理"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:系统管理\用户管理</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">用户查找条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div>
                                    <label for="txtUserId" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">用户ID:</label>
                                    <input id="txtUserId" name="txtUserId" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 120px;" />
                                    <label for="txtEmail" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">Email地址:</label>
                                    <input id="txtEmail" name="txtEmail" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 120px;" />
                                    <label for="txtPhoneNumber" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">手机号码:</label>
                                    <input id="txtPhoneNumber" name="txtPhoneNumber" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 120px;" />

                                    <button class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search();return false;">查  询</button>

                                </div>

                                <br />
                                <br />
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">用户列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 328px;">
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

                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)用户</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div id="ctl00_PortalContent_RadAjaxPanelOutput" style="margin-top: 5px; margin-left: 5px;">

                                <input id="txtid" style="display: none;" />

                                <div style="display: block; float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">用户Id:</div>
                                    <input id="txtEUserId" name="txtEUserId" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">姓:</div>
                                    <input id="txtLastName" name="txtLastName" maxlength="8" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">名:</div>
                                    <input id="txtFirstName" name="txtFirstName" maxlength="8" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />

                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">用户角色:</div>
                                    <%--<input class="easyui-combobox" id="rwlb" name="rwlb" style="width: 220px;" data-options="valueField:'id', textField:'text', panelHeight:'auto'">--%>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="rwlb"></select><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">Email地址:</div>
                                    <input id="txtEEmail" name="txtEEmail" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">手机号码:</div>
                                    <input id="txtEPhoneNo" name="txtEPhoneNo" maxlength="16" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />

                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">用户描述:</div>
                                    <textarea id="txtUserdesc" maxlength="100" class="k-textbox" style="margin: 0 5px 5px 0; width: 220px; height: 100px;"></textarea>
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
            <button class="button white-gradient" id="updatepassword" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="UpdatePsw();return false;">重置密码</button>
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">        
        $(document).ready(function () {
            Search();
            getRole();
        });
        function Search() {
            var UserId = $("#txtUserId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var Email = $("#txtEmail").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var PhoneNumber = $("#txtPhoneNumber").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            datagridfresh(1, 10, UserId, Email, PhoneNumber);
        }
        function getRole() {
            $.post('/Controller/getRoleCombobox.ashx', function (data) {

                if (data.rows[0].tips == "没有数据") {
                    $("#msg").html("*没有查询到数据，请调整一下查询条件！");
                }
                else {
                    //$("#rwlb").combobox("loadData", data.rows);
                    //$("#rwlb").combobox("select", data.rows[0].id);
                    var innerHtml = "";
                    for (var i = 0; i < data.rows.length; i++) {
                        innerHtml += '<option value="' + data.rows[i].id + '" >' + data.rows[i].text + '</option>';
                    }
                    $("#rwlb").html(innerHtml);
                }
            }, "json");
        }
        function datagridfresh(pageNumber, pageSize, UserId, Email, PhoneNumber) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/userSearch.ashx', { pageindex: pageNumber, pagesize: pageSize, userId: UserId, email: Email, phoneNumber: PhoneNumber }, function (data) {

                if (data.rows[0].tips == "没有数据") {
                    $("#msg").html("*没有查询到数据，请调整一下查询条件！");
                    $("#datawin").datagrid("loaded");
                }
                else {
                    $("#datawin").datagrid({
                        //columns: [data.titleTable],   //动态取标题
                        rownumbers: true,
                            singleselect: false,
                            fitColumns: true,
                        columns: [[
                            //{ field: 'rownum', width: 30, title: 'No' },
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox" id="' + row.ID + '">';
                                }
                            },

                            {
                                field: 'UserId', title: '用户ID', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.UserId
                                        + '","' + row.LastName
                                        + '","' + row.FirstName
                                        + '","' + row.RoleId
                                        + '","' + row.Email
                                        + '","' + row.PhoneNumber
                                        + '","' + row.UserDesc
                                        + '");\'>' + row.UserId + '</a>';
                                }
                            },
                            { field: 'LastName', width: 50, title: '姓', align: 'center', },
                            { field: 'FirstName', width: 50, title: '名', align: 'center', },
                            { field: 'RoleName', width: 150, title: '角色', align: 'center', },
                            { field: 'Email', width: 150, title: 'Email地址', align: 'center', },
                            { field: 'PhoneNumber', width: 150, title: '手机号码', align: 'center', }

                        ]],
                        onLoadSuccess: function () {
                            $("#datawin").datagrid("loaded");
                        }
                    });
                    $("#datawin").datagrid("loadData", data.rows);  //动态取数据
                    //$("#datawin").datagrid("loadData", (function () {

                    //    return data.rows;//[]需要加载的数据                        
                    //})());
                    $("#datawin").datagrid("loaded");
                    $('#datapager').pagination({
                        total: data.total,
                        pageSize: pageSize,
                        onSelectPage: function (pageNumber, pageSize) {
                            var UserId = $("#txtUserId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var Email = $("#txtEmail").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var PhoneNumber = $("#txtPhoneNumber").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            datagridfresh(pageNumber, pageSize, UserId, Email, PhoneNumber);
                        }
                    });

                }
            }, "json");
        }
        function Edit(ID, UserId, LastName, FirstName, RoleId, Email, PhoneNumber, UserDesc) {
            $("#txtid").val(ID);
            $("#txtEUserId").val(UserId);
            $("#txtLastName").val(LastName);
            $("#txtFirstName").val(FirstName);
            $("#txtEEmail").val(Email);
            $("#txtEPhoneNo").val(PhoneNumber);
            $("#txtUserdesc").val(UserDesc);
            $("#rwlb").val(RoleId);

            $("#txtEUserId").attr("readonly", "readonly");
            $("#txtEUserId").css("background", "rgb(194, 184, 184)");
            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            $("#txtEUserId").val("");
            $("#txtLastName").val("");
            $("#txtFirstName").val("");
            $("#txtEEmail").val("");
            $("#txtEPhoneNo").val("");
            $("#txtUserdesc").val("");
            $("#txtEUserId").removeAttr("readonly");
            $("#txtEUserId").css("background", "rgb(255, 255, 255)");
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
            var ID = $("#txtid").val();
            var UserId = $("#txtEUserId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var LastName = $("#txtLastName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var FirstName = $("#txtFirstName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var RoleId = $("#rwlb").val();
            var Email = $("#txtEEmail").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var PhoneNumber = $("#txtEPhoneNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var UserDesc = $("#txtUserdesc").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            $.post('/Controller/userEdit.ashx', {
                id: ID,
                userid: UserId,
                lastName: LastName,
                firstName: FirstName,
                roleId: RoleId,
                email: Email,
                phoneNumber: PhoneNumber,
                userdesc: UserDesc
            }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("*保存失败！");
                }
                else {
                    $("#msg").html("*保存成功！");
                    var UserId = $("#txtUserId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var Email = $("#txtEmail").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var PhoneNumber = $("#txtPhoneNumber").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    datagridfresh(1, 10, UserId, Email, PhoneNumber);
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
                    $.post('/Controller/userDelete.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("*删除失败！");
                        }
                        else {
                            $("#msg").html("*删除成功！");
                            datagridfresh(1, 10);
                            clearrole();
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("*请先选择删除数据！");
            }
        }
        function UpdatePsw() {
            var deleteid = "";
            $("input[name='dgcheckbox']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                }
            });
            if (deleteid.trim() != "") {
                if (confirm("确定要重置用户密码吗？")) {
                    $.post('/Controller/updatePsw.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("*重置密码失败！");
                        }
                        else {
                            $("#msg").html("*重置密码成功！");
                            var UserId = $("#txtUserId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var Email = $("#txtEmail").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var PhoneNumber = $("#txtPhoneNumber").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            datagridfresh(1, 10, UserId, Email, PhoneNumber);
                            ClearAll(1);
                        }
                    }, "json");
                }

            }
            else {
                $("#msg").html("*请先选择需要重置密码的用户！");
            }
        }
    </script>
</asp:Content>
