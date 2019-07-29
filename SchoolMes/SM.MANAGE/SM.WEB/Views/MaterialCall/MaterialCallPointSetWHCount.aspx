<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="MaterialCallPointSetWHCount.aspx.cs" Inherits="SM.WEB.Views.MaterialCall.MaterialCallPointSetWHCount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="触发点管理"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:物料拉动/触发点管理</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span>触发点</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 80px; overflow-y: auto;">
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">叫料触发点:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="StationId">
                                            <option value="" selected="selected">请选择</option>
                                        </select>
                                    </div>
                                </div>


                                <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(1, 10); return false;" value="查  询" />
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span>物料落点列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 258px; overflow-y: auto;">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 220px;">
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

                </dl>
            </div>
        </div>
        <div style="display: block; float: left; margin-left: 15px;">
            <%--<input type="button" class="button white-gradient" id="New" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(0); return false;" value="新  增" />--%>
            <input type="button" class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="updateUsedTime(); return false;" value="保  存" />
            <%--<input type="button" class="button white-gradient" id="delete" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Delete(); return false;" value="删  除" />--%>
            <input type="button" class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(); return false;" value="取  消" />
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">    
        var stopFirstChangeEvent = true;
        var wsid = "";
        $(document).ready(function () {
            Search(1, 10);
            getStation();

        });
        function Search(pageNumber, pageSize) {
            var StationId = $("#StationId").val();
            datagridfresh(pageNumber, pageSize, StationId);
        }
        function getStation() {
            $.post('/Controller/StationById.ashx', { id: "" }, function (data) {
                var ohtml = "";
                for (var i = 0; i < data.rows.length; i++) {
                    ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].StationName + '</option>';
                }
                //$("#selectStationId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                $("#StationId").html('<option value="" selected="selected">请选择</option>' + ohtml);
            }, "json");
        }

        function datagridfresh(pageNumber, pageSize, StationId) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/MaterialCallPointSearch.ashx', {
                pageindex: pageNumber, pagesize: pageSize,
                stationId: StationId,
                materialCallCode: "",
                materialDataNo: "",
                materialDataName: "",
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
                                field: 'MaterialCallCode', title: '落点编码', width: 70, align: 'center'
                            },
                            { field: 'MaterialDataNo', width: 60, title: '物料编码', align: 'center' },
                            { field: 'MaterialDataName', width: 100, title: '物料名称', align: 'center' },
                            { field: 'BoxType', width: 60, title: '容器类型', align: 'center' },

                            { field: 'BoxTotalNo', width: 50, title: '单箱收容数', align: 'center' },
                            { field: 'DeliverWay', width: 50, title: '路径', align: 'center' },
                            { field: 'StoreName', width: 50, title: '仓位', align: 'center' },
                            { field: 'CallType', width: 60, title: '叫料方式', align: 'center' },
                            { field: 'DeliverType', width: 60, title: '配送方式', align: 'center' },
                            {
                                field: 'WHCount', title: '当前线边库存数量', width: 100, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="text" name="wmscount" class="qbox" id="' + row.ID + '" value= "' + row.WHCount + '"/>';
                                }
                            },
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
                                field: 'MaterialCallCode', title: '落点编码', width: 70, align: 'center'
                            },
                            { field: 'MaterialDataNo', width: 60, title: '物料编码', align: 'center' },
                            { field: 'MaterialDataName', width: 100, title: '物料名称', align: 'center' },
                            { field: 'BoxType', width: 60, title: '容器类型', align: 'center' },

                            { field: 'BoxTotalNo', width: 50, title: '单箱收容数', align: 'center' },
                            { field: 'DeliverWay', width: 50, title: '路径', align: 'center' },
                            { field: 'StoreName', width: 50, title: '仓位', align: 'center' },
                            { field: 'CallType', width: 60, title: '叫料方式', align: 'center' },
                            { field: 'DeliverType', width: 60, title: '配送方式', align: 'center' },
                            {
                                field: 'WHCount', title: '当前线边库存数量', width: 100, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="text" name="wmscount" class="qbox" id="' + row.ID + '" value= "' + row.WHCount + '"/>';
                                }
                            },
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
        function ClearAll() {
            $("#msg").html("");
            Search(1, 10);
        }
        function updateUsedTime() {
            var Wmscount = "";
            var t = "";
            $("input[name='wmscount']").each(function (j, item) {

                var reg = /^\d+$/;
                if (!reg.test(item.value)) {
                    t += "0";
                }
                else {
                    t += "1";
                    Wmscount += "|" + item.id + "_" + item.value;
                }
            });
            if (t.indexOf("0") != -1) {
                $("#msg").html("线边库存数量必须是数字！");
                return false;
            }
            $.post('/Controller/UpdateWHCount.ashx', {
                wmscount: Wmscount
            }, function (data) {

                if (data == "0") {
                    $("#msg").html("线边库存数量更新失败！");
                }
                else {
                    $("#msg").html("线边库存数量更新成功！");
                    Search(1, 10);
                }
            }, "json");
        }
    </script>
</asp:Content>
