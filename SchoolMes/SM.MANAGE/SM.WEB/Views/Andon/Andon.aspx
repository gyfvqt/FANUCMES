<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="Andon.aspx.cs" Inherits="SM.WEB.Views.Andon.Andon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="ANDON配置"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:ANDON\ANDON配置</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    
                    <dt id="list-filter"><span id="PortalContent_Label1">Andon列表</span></dt>
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

                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)Andon</span></dt>
                    <dd id="listinputdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div style="margin-top: 5px; margin-left: 5px;">
                                <input id="txtid" style="display: none;" />
                                <div style="display: block; float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">Andon编码:</div>
                                    <input id="AndonNo" maxlength="32" readonly="readonly" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">Andon名称:</div>
                                    <input id="AndonName"  maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">对应线体:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="Line">
                                        <option value="" selected="selected">请选择</option>                                        
                                    </select><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px; ">AndonIP:</div>
                                    <input id="AndonIP"  maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px; ">班组:</div>
                                    <input id="Team"  maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />
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
            getline();
            Search();
        });
        function Search() {            
            datagridfresh(1, 100);
        }
        function getline() {
            $.post('/Controller/AndonLine.ashx',  function (data) {
                if (data.length>0) {   
                    var Linehtml = '<option value="" selected="selected">请选择</option>';
                    for (var i = 0; i < data.length; i++) {
                        Linehtml += '<option value="' + data[i].ID + '" >' + data[i].EquipmentName + '</option>'
                    }
                    $("#Line").html(Linehtml);
                }
            }, "json");
        }
        function datagridfresh(pageNumber, pageSize) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/AndonSearch.ashx', { pageindex: pageNumber, pagesize: pageSize}, function (data) {
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
                                field: 'AndonNo', title: 'Andon编号', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.AndonNo
                                        + '","' + row.AndonName
                                        + '","' + row.LineId
                                        + '","' + row.Team
                                        + '");\'>' + row.AndonNo + '</a>';
                                }
                            },
                            { field: 'AndonName', width: 150, title: 'Andon名称', align: 'center' },
                            { field: 'LineName', width: 150, title: '对应线体', align: 'center' },
                            { field: 'AndonIP', width: 150, title: 'IP', align: 'center' },
                            { field: 'Team', width: 150, title: '班组', align: 'center' }


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
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                }
                            },

                            {
                                field: 'AndonNo', title: 'Andon编号', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.AndonNo
                                        + '","' + row.AndonName
                                        + '","' + row.LineId
                                        + '","' + row.AndonIP
                                        + '","' + row.Team
                                        + '");\'>' + row.AndonNo + '</a>';
                                }
                            },
                            { field: 'AndonName', width: 150, title: 'Andon名称', align: 'center' },
                            { field: 'LineName', width: 150, title: '对应线体', align: 'center' },
                            { field: 'AndonIP', width: 150, title: 'IP', align: 'center' },
                            { field: 'Team', width: 150, title: '班组', align: 'center' }


                        ]],
                        onLoadSuccess: function () {
                            $("#datawin").datagrid("loaded");
                        }
                    });
                    $("#datawin").datagrid("loadData", data.rows);  //动态取数据                    

                }
            }, "json");
        }
        function Edit(ID, AndonNo, AndonName, LineId,AndonIP,Team) {
            $("#txtid").val(ID);
            $("#AndonNo").val(AndonNo);
            $("#AndonName").val(AndonName);
            $("#Line").val(LineId);
            $("#AndonIP").val(AndonIP);
            $("#Team").val(Team);
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            $("#AndonNo").val("");
            $("#AndonName").val("");
            $("#Line").val("");   
            $("#AndonIP").val("");
            $("#Team").val("");

            $('#datawin').datagrid('clearSelections');
        }
        function Save() {
            if ($("#AndonName").val().trim() == ""||$("#Line").val().trim() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }

            var ID = $("#txtid").val();
            var AndonNo = $("#AndonNo").val();
            var AndonName = $("#AndonName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var LineId = $("#Line").val();
            var LineName =  $("#Line").find("option:selected").text();
            var AndonIP= $("#AndonIP").val();
            var Team= $("#Team").val();

            $.post('/Controller/AndonEdit.ashx', {
                id: ID,
                andonNo: AndonName,
                andonName: AndonName,
                lineId: LineId,
                lineName: LineName,
                andonIP: AndonIP,
                team: Team
            }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("*保存失败！");
                }
                else {
                    $("#msg").html("*保存成功！");                   
                    datagridfresh(1, 100);
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
                    $.post('/Controller/AndonDelte.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("*删除失败！");
                        }
                        else {
                            $("#msg").html("*删除成功！");                            
                            datagridfresh(1, 100);
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