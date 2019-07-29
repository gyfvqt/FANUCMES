<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="Role.aspx.cs" Inherits="SM.WEB.Views.UserPermission.Role" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="角色管理"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:系统管理\角色管理</span>
        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="width: 400px; height: 340px;">
                    <dt class="closed" style="background: -ms-linear-gradient(rgb(39, 106, 143), rgb(56, 95, 186));"><span id="PortalContent_lblTest">角色列表</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" id="rolelist" style="display: block;">
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
                    </dd>
                </dl>
            </div>

        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left; margin-left: 420px;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" id="accordionCannedReport" style="width: 600px; ">
                    <dt class="closed" style="background: -ms-linear-gradient(rgb(39, 106, 143), rgb(56, 95, 186));"><span id="PortalContent_lblTest">权限设置</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" id="ptree" style="display: block;overflow-y: scroll; height: 483px;">
                                <ul class="easyui-tree" id="myTree" style="padding-left: 5px;">
                                    <li>
                                        <span>在此设置权限</span>
                                        <ul>
                                            <% if (dsFpermission != null && dsFpermission.Tables[0].Rows.Count > 0)
                                                {
                                                    for (int i = 0; i < dsFpermission.Tables[0].Rows.Count; i++)
                                                    {
                                            %>
                                            <li data-options="state:'open'">

                                                <span>
                                                    <input id="<%=dsFpermission.Tables[0].Rows[i]["ID"].ToString() %>" name="fistpage" type="checkbox" onclick="checkfirst(this)" value="<%=dsFpermission.Tables[0].Rows[i]["MenuName"].ToString() %>" />
                                                    <label for="<%=dsFpermission.Tables[0].Rows[i]["ID"].ToString() %>">
                                                        <%=dsFpermission.Tables[0].Rows[i]["MenuName"].ToString() %>
                                                    </label>
                                                </span>
                                                <ul>
                                                    <% if (dsmenus != null && dsmenus.Tables[0].Rows.Count > 0)
                                                        {
                                                            System.Data.DataRow[] dr = dsmenus.Tables[0].Select("ParentId=" + dsFpermission.Tables[0].Rows[i]["ID"].ToString());
                                                            if (dr.Length > 0)
                                                            {
                                                                for (int j = 0; j < dr.Length; j++)
                                                                {
                                                    %>
                                                    <li>
                                                        <span>
                                                            <input id="<%=dr[j]["ID"].ToString() %>" class="chkMenu" name="<%=dsFpermission.Tables[0].Rows[i]["ID"].ToString() %>" type="checkbox" value="<%=dr[j]["ID"].ToString() %>" />
                                                            <label for="<%=dr[j]["ID"].ToString() %>"><%=dr[j]["MenuName"].ToString() %></label>

                                                        </span>
                                                    </li>
                                                    <%
                                                                }
                                                            }
                                                        }
                                                    %>
                                                </ul>
                                            </li>
                                            <%
                                                    }
                                                }%>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </dd>
                </dl>
            </div>

        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left; margin-top: 350px;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="width: 400px;">
                    <dt class="closed" style="background: -ms-linear-gradient(rgb(39, 106, 143), rgb(56, 95, 186));"><span id="PortalContent_lblTest">新增(编辑)角色</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" id="roleedit" style="display: block;">
                                <input id="txtroleid" style="display: none;" />
                                <label for="txtRolename" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">角色名称:</label>
                                <input id="txtRolename" maxlength="32" name="txtline" class="k-textbox" style="margin: 0 5px 5px 0;  height: 28px;width: 220px;" /><span style="color: red;">*</span><br />
                                <label for="txtRoledesc" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">角色描述:</label>
                                <textarea id="txtRoledesc" maxlength="100" class="k-textbox" style="margin: 0 5px 5px 0; width: 220px; height: 100px;"></textarea>
                            </div>
                        </div>
                    </dd>
                </dl>
            </div>

        </div>
        <div style="display: block; position: absolute; float: left; margin-top: 545px; margin-left: 15px;">
            <button class="button white-gradient" id="new" style="margin-top: 5px; margin-right: 5px; float: left;" onclick="clearrole();return false;">新  增</button>
            <button class="button white-gradient" id="save" style="margin-top: 5px; margin-right: 5px; float: left;" onclick="saverole();return false;">保  存</button>
            <button class="button white-gradient" id="delete" style="margin-top: 5px; margin-right: 5px; float: left;" onclick="deleterole();return false;">删  除</button>
            <button class="button white-gradient" id="cancel" style="margin-top: 5px; margin-right: 5px; float: left;" onclick="clearrole();return false;">取  消</button>
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-right: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">
        $(document).ready(function () {
            datagridfresh(1, 10);


        });
        function checkfirst(obj) {
            //$(obj).click(function () {
            if ($(obj)[0].checked) {
                $("input[name='" + $(obj)[0].id + "']").each(function (j, item) {
                    item.checked = true;
                });
            }
            else {
                $("input[name='" + $(obj)[0].id + "']").each(function (j, item) {
                    item.checked = false;
                });
            }
            //});
        }
        function datagridfresh(pageNumber, pageSize) {
            //ajaxLoading();
            $.post('/Controller/rolesearch.ashx', { pageindex: pageNumber, pagesize: pageSize }, function (data) {

                if (data.rows[0].tips == "没有数据") {
                    //ajaxLoadEnd();
                    $("#msg").html("*没有查询到数据，请调整一下查询条件！");
                }
                else {
                    $("#datawin").datagrid({
                        //columns: [data.titleTable];
                        rownumbers: true,
                        singleselect: false,
                        fitColumns: true,
                        columns: [[
                            //{ field: 'No', width: 30, title: 'No' },
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox" id="' + row.ID + '">';
                                }
                            },
                            //{ field: '角色名称', width: 120, title: '角色名称' },
                            {
                                field: '角色名称', title: '角色名称', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID + '","' + row.角色名称 + '","' + row.角色描述 + '");\'>' + row.角色名称 + '</a>';
                                }
                            },
                            { field: '角色描述', width: 220, title: '角色描述' }

                        ]]
                    });
                    $("#datawin").datagrid("loadData", data.rows);  //动态取数据                    
                }
            }, "json");
        }
        function chkall() {
            if ($("#checkall").is(':checked')) {
                $('#datawin').children(':checkbox').prop('checked', false);
            }
            else {
                $('#datawin').children(':checkbox').prop('checked', false);
            }
        }

        function clearrole() {
            $("#txtroleid").val("");
            $("#txtRolename").val("")
            $("#txtRoledesc").val("")
            $("#msg").html();
            //return false;
            $("input[class='chkMenu']").each(function (j, item) {
                item.checked = false;
            });
            $("input[name='fistpage']").each(function (j, item) {
                item.checked = false;
            });
            $('#datawin').datagrid('clearSelections'); 
        }
        function Edit(ID, RoleName, RoleDesc) {
            $("#txtroleid").val(ID);
            $("#txtRolename").val(RoleName);
            $("#txtRoledesc").val(RoleDesc);
            $("input[class='chkMenu']").each(function (j, item) {
                item.checked = false;
            });
            $("input[name='fistpage']").each(function (j, item) {
                item.checked = false;
            });
            $.post('/Controller/rolepermissions.ashx', { id: ID }, function (data) {

                if (data.rows[0].tips == "没有数据") {
                    //ajaxLoadEnd();
                    $("#msg").html("*没有查询到数据，请调整一下查询条件！");
                }
                else {
                    for (var k = 0; k < data.rows.length; k++) {
                        $("#" + data.rows[k].ID)[0].checked = true;
                    }
                }
            }, "json");
        }
        function saverole() {
            if ($("#txtRolename").val().trim() == "") {
                $("#msg").html("*角色名称不能为空！");
                $("#txtRolename").val("");
                return;
            }
            var ID = $("#txtroleid").val();
            var Rolename = $("#txtRolename").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var Roledesc = $("#txtRoledesc").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var Permissions = "";
            $("input[class='chkMenu']").each(function (j, item) {
                if (item.checked) {
                    Permissions += "|" + item.id;
                }
            });
            $.post('/Controller/roleedit.ashx', { id: ID, rolename: Rolename, roledesc: Roledesc, permissions: Permissions }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("*保存失败！");
                }
                else {
                    $("#msg").html("*保存成功！");
                    datagridfresh(1, 10);
                    clearrole();
                }
            }, "json");
        }
        function deleterole() {
            var deleteid = "";
            $("input[name='dgcheckbox']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                }
            });
            if (deleteid.trim() != "") {
                if (confirm("确定删除数据？")) {
                    $.post('/Controller/roledelete.ashx', { id: deleteid }, function (data) {

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
    </script>
</asp:Content>
