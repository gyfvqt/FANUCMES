<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="ErrorLogs.aspx.cs" Inherits="SM.WEB.Views.UserPermission.ErrorLogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="执行日志"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:系统管理\执行日志</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section" style="background: -ms-linear-gradient(rgb(39, 106, 143), rgb(56, 95, 186));"><span id="PortalContent_lblTest">查询条件</span></dt>
                    <dd id="listsectiondd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div>
                                    <label for="datetimePickerBegin" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">开始时间:</label>
                                    <input id="datetimePickerBegin" class="Wdate" style="height: 26px;border-color: #c5c5c5;" type="text" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                    <label for="datetimePickerEnd" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">结束时间:</label>
                                    <input id="datetimePickerEnd" class="Wdate" style="height: 26px;border-color: #c5c5c5;" type="text" onClick="WdatePicker({el:this,dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                    <button class="button white-gradient" id="new" style="margin-top: 2em; float: right; margin-right: 5px;" onclick="Search();return false;">查  询</button>
                                    <%--<button class="button white-gradient" id="get" style="margin-top: 2em; float: right; margin-right: 5px;">查  询</button>--%>
                                </div>

                                <br />
                                <br />
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">用户操作日志</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 428px;">
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
                    <div class="new-row"></div>

                </dl>

            </div>

        </div>
        <div style="display: block; position: absolute; float: left; margin-top: 545px; margin-left: 15px;">
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-right: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">        
        $(document).ready(function () {
            //var d = new Date();
            //d.setTime(d.getTime() - 1 * 24 * 60 * 60 * 1000);
            //var s = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
            //var d = new Date();
            //var s1 = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();

            //$('#datetimePickerBegin').datetimebox({
            //    value: s,
            //    showSeconds: true
            //});
            //$('#datetimePickerEnd').datetimebox({
            //    value: s1,
            //    showSeconds: true
            //});


        });
        function Search() {
            DTSTART = $("#datetimePickerBegin").val();
            DTEND = $("#datetimePickerEnd").val();

            datagridfresh(1, 10, DTSTART, DTEND);
        }
        function datagridfresh(pageNumber, pageSize, DTSTART, DTEND) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/errorLogs.ashx', { pageindex: pageNumber, pagesize: pageSize, dtstart: DTSTART, dtend: DTEND }, function (data) {

                if (data.rows[0].tips == "没有数据") {
                    $("#msg").html("*没有查询到数据，请调整一下查询条件！");
                    $("#datawin").datagrid("loaded");
                }
                else {
                    $("#datawin").datagrid({
                        columns: [data.titleTable],   //动态取标题
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

                            DTSTART = $("#datetimePickerBegin").val();
                            DTEND = $("#datetimePickerEnd").val();

                            datagridfresh(pageNumber, pageSize, DTSTART, DTEND);
                        }
                    });

                }
            }, "json");
        }
    </script>
</asp:Content>
