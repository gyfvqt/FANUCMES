<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="CuttorInfo.aspx.cs" Inherits="SM.WEB.Views.Cuttor.CuttorInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="刀具主数据"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:刀具管理\刀具主数据</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span>查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 80px; overflow-y: auto;">
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top:4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">刀具系列号:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="txtCutterCode" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" />
                                    </div>
                                </div>
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right;  margin-top:4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">刀具名称:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="txtCutterName" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" />
                                    </div>
                                </div>
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top:4px;  width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">刀具状态:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px;" id="selectStatus">
                                            <option value="" selected="selected">请选择</option>
                                            <option value="使用中">使用中</option>
                                            <option value="停用">停用</option>
                                        </select>
                                    </div>
                                </div>
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top:4px;  width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">关联站点:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px;" id="selectStationId">
                                            <option value="" selected="selected">请选择</option>
                                        </select>
                                    </div>
                                </div>
                                <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(1, 10); return false;" value="查  询" />
                            </div>
                        </div>
                    </dd>
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
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)刀具</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div style="margin-top: 5px; margin-left: 5px;">
                                <input id="txtid" style="display: none;" />
                                <div style="width: 100%; float: left;">
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">刀具系列号:</td>
                                            <td style="width: 170px;">
                                                <input id="CutterCode" class="k-textbox" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">刀具图纸号:</td>
                                            <td style="width: 170px;">
                                                <input id="CutterImg" class="k-textbox" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red; float: left;">*</span>

                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">刀具名称:</td>
                                            <td style="width: 170px;">
                                                <input id="CutterName" class="k-textbox" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">刀具描述:</td>
                                            <td style="width: 170px;">
                                                <input id="CutterDesc" class="k-textbox" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">刀具供应商:</td>
                                            <td style="width: 170px;">
                                                <input id="CutterSupplier" class="k-textbox" maxlength="100" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">仓位:</td>
                                            <td style="width: 170px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="StoreId">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">最大切削速度:</td>
                                            <td style="width: 170px;">
                                                <input id="Speed" class="k-textbox" maxlength="8" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">最大加工次数:</td>
                                            <td style="width: 170px;">
                                                <input id="LimitTime" class="k-textbox" maxlength="8" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                            </td>
                                        </tr>

                                    </table>
                                </div>
                                <div style="width: 100%; float: left; margin-top: 5px;">
                                    <hr />
                                </div>
                                <div style="width: 100%; float: left; margin-top: 5px;">
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">换刀预警:</td>
                                            <td style="width: 170px;">
                                                <input id="AlarmTime" class="k-textbox" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">当前加工次数:</td>
                                            <td style="width: 170px;">
                                                <input id="UsedTime" class="k-textbox" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />

                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">关联站点:</td>
                                            <td style="width: 170px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="StationId">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">刀具状态:</td>
                                            <td style="width: 170px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc;float: left; height: 26px; width: 150px;" id="Status">
                                                    <option value="" selected="selected">请选择</option>
                                                    <option value="使用中">使用中</option>
                                                    <option value="停用">停用</option>
                                                </select><span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right">单件加工次数:</td>
                                            <td style="width: 170px;">
                                                <input id="SingleTime" class="k-textbox" maxlength="8" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right"></td>
                                            <td style="width: 170px;"></td>
                                        </tr>
                                    </table>

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
            <input type="button" class="button white-gradient" id="update" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="updateUsedTime(); return false;" value="更新当前加工次数" />
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">    
        var stopFirstChangeEvent = true;
        $(document).ready(function () {
            Search(1, 10);
            getStation();
            getStore();
        });
        function Search(pageNumber, pageSize) {
            var CutterCode = $("#txtCutterCode").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var CutterName = $("#txtCutterName").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var Status = $("#selectStatus").val();
            var StationId = $("#selectStationId").val();

            datagridfresh(pageNumber, pageSize, CutterCode, CutterName, Status, StationId);
        }
        function getStation() {
            $.post('/Controller/StationById.ashx', { id: "" }, function (data) {
                var ohtml = "";
                for (var i = 0; i < data.rows.length; i++) {
                    ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].StationName + '</option>';
                }
                $("#selectStationId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                $("#StationId").html('<option value="" selected="selected">请选择</option>' + ohtml);
            }, "json");
        }
        function getStore() {
            $.post('/Controller/storeSearch.ashx', { pageindex: 1, pagesize: 1000, storeName: "", warehouseId: "", warehouseType: "" }, function (data) {
                var ohtml = "";
                for (var i = 0; i < data.rows.length; i++) {
                    ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].StoreName + '</option>';
                }
                $("#StoreId").html('<option value="" selected="selected">请选择</option>' + ohtml);
            }, "json");
        }
        function datagridfresh(pageNumber, pageSize, CutterCode, CutterName, Status, StationId) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/CuttorInfoSearch.ashx', {
                pageindex: pageNumber, pagesize: pageSize,
                cutterCode: CutterCode,
                cutterName: CutterName,
                status: Status,
                stationId: StationId
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
                                    if (row.ExStatus == "确认") {
                                        return "";
                                    }
                                    else {
                                        return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                    }
                                }
                            },
                            { field: 'CutterImg', width: 70, title: '刀具图纸号', align: 'center' },
                            {
                                field: 'CutterCode', title: '刀具系列号', width: 70, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.CutterCode
                                        + '","' + row.CutterName
                                        + '","' + row.CutterSupplier
                                        + '","' + row.CutterDesc
                                        + '","' + row.CutterImg
                                        + '","' + row.Speed
                                        + '","' + row.LimitTime
                                        + '","' + row.AlarmTime
                                        + '","' + row.StationId
                                        + '","' + row.SingleTime
                                        + '","' + row.UsedTime
                                        + '","' + row.Status
                                        + '");\'>' + row.CutterCode + '</a>';
                                }
                            },
                            { field: 'CutterName', width: 60, title: '刀具名称', align: 'center' },
                            { field: 'CutterDesc', width: 100, title: '刀具描述', align: 'center' },
                            { field: 'AlarmTime', width: 60, title: '换刀预警次数', align: 'center' },
                            {
                                field: 'UsedTime', width: 60, title: '当前使用次数', align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="text" name="wmscount" class="qbox" id="' + row.ID + '" value= "' + row.UsedTime + '"/>';
                                }
                            },
                            { field: 'Status', width: 50, title: '刀具状态', align: 'center' },
                            { field: 'LastUseTime', width: 100, title: '最后一次状态改变', align: 'center' },
                            { field: 'StationName', width: 50, title: '关联站点', align: 'center' },
                            { field: 'SingleTime', width: 80, title: '单件加工次数', align: 'center' }
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
                                    if (row.ExStatus == "确认") {
                                        return "";
                                    }
                                    else {
                                        return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                    }
                                }
                            },
                            { field: 'CutterImg', width: 70, title: '刀具图纸号', align: 'center' },
                            {
                                field: 'CutterCode', title: '刀具系列号', width: 70, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.CutterCode
                                        + '","' + row.CutterName
                                        + '","' + row.CutterSupplier
                                        + '","' + row.CutterDesc
                                        + '","' + row.CutterImg
                                        + '","' + row.Speed
                                        + '","' + row.LimitTime
                                        + '","' + row.AlarmTime
                                        + '","' + row.StationId
                                        + '","' + row.SingleTime
                                        + '","' + row.UsedTime
                                        + '","' + row.Status
                                        + '","' + row.StoreId
                                        + '");\'>' + row.CutterCode + '</a>';
                                }
                            },
                            { field: 'CutterName', width: 60, title: '刀具名称', align: 'center' },
                            { field: 'CutterDesc', width: 100, title: '刀具描述', align: 'center' },
                            { field: 'AlarmTime', width: 60, title: '换刀预警次数', align: 'center' },
                            {
                                field: 'UsedTime', width: 60, title: '当前使用次数', align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="text" name="wmscount" class="qbox" id="' + row.ID + '" value= "' + row.UsedTime + '"/>';
                                }
                            },
                            { field: 'Status', width: 50, title: '刀具状态', align: 'center' },
                            { field: 'LastUseTime', width: 100, title: '最后一次状态改变', align: 'center' },
                            { field: 'StationName', width: 50, title: '关联站点', align: 'center' },
                            { field: 'SingleTime', width: 80, title: '单件加工次数', align: 'center' }
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

        function Edit(ID, CutterCode, CutterName, CutterSupplier, CutterDesc, CutterImg, Speed, LimitTime, AlarmTime, StationId, SingleTime, UsedTime, Status,StoreId) {
            $("#txtid").val(ID);
            $("#CutterCode").val(CutterCode)
            $("#CutterName").val(CutterName);
            $("#CutterSupplier").val(CutterSupplier)
            $("#CutterDesc").val(CutterDesc);
            $("#CutterImg").val(CutterImg);
            $("#Speed").val(Speed);
            $("#LimitTime").val(LimitTime);
            $("#AlarmTime").val(AlarmTime);
            $("#StationId").val(StationId);
            $("#SingleTime").val(SingleTime);
            $("#UsedTime").val(UsedTime);
            $("#Status").val(Status);
            $("#StoreId").val(StoreId);

            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            $("#CutterCode").val("");
            $("#CutterName").val("");
            $("#CutterSupplier").val("")
            $("#CutterDesc").val("");
            $("#CutterImg").val("");
            $("#Speed").val("");
            $("#LimitTime").val("");
            $("#AlarmTime").val("");
            $("#StationId").val("");
            $("#SingleTime").val("");
            $("#UsedTime").val("");
            $("#Status").val("");
            $("#StoreId").val("");

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
            if ($("#CutterCode").val() == "" || $("#CutterImg").val() == "" || $("#AlarmTime").val().trim() == ""
                || $("#StationId").val() == "" || $("#Status").val() == "" || $("#SingleTime").val() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }

            var reg = /^\d+$/;
            if (!reg.test($("#Speed").val())) {
                $("#msg").html("最大切削速度必须是正整数！");
                return false;
            }
            if (!reg.test($("#LimitTime").val())) {
                $("#msg").html("最大加工次数必须是正整数！");
                return false;
            }
            if (!reg.test($("#AlarmTime").val())) {
                $("#msg").html("换刀报警必须是正整数！");
                return false;
            }
            if (!reg.test($("#SingleTime").val())) {
                $("#msg").html("单件加工次数必须是正整数！");
                return false;
            }
            if (!reg.test($("#UsedTime").val())) {
                $("#msg").html("当前加工次数必须是正整数！");
                return false;
            }

            var ID = $("#txtid").val();
            var CutterCode = $("#CutterCode").val();
            var CutterName = $("#CutterName").val();
            var CutterSupplier = $("#CutterSupplier").val()
            var CutterDesc = $("#CutterDesc").val();
            var CutterImg = $("#CutterImg").val();
            var Speed = $("#Speed").val();
            var LimitTime = $("#LimitTime").val();
            var AlarmTime = $("#AlarmTime").val();
            var StationId = $("#StationId").val();
            var SingleTime = $("#SingleTime").val();
            var UsedTime = $("#UsedTime").val();
            var Status = $("#Status").val();
            var StoreId=$("#StoreId").val();


            $.post('/Controller/CuttorInfoEdit.ashx', {
                id: ID,
                cutterCode: CutterCode,
                cutterName: CutterName,
                cutterSupplier: CutterSupplier,
                cutterDesc: CutterDesc,
                cutterImg: CutterImg,
                speed: Speed,
                limitTime: LimitTime,
                alarmTime: AlarmTime,
                stationId: StationId,
                singleTime: SingleTime,
                usedTime: UsedTime,
                status: Status,
                storeId:StoreId
            }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("保存失败！");
                }
                else {
                    $("#msg").html("保存成功！");
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
                    $.post('/Controller/CuttorInfoDelete.ashx', { id: deleteid }, function (data) {

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
                $("#msg").html("当前加工次数必须是数字！");
                return false;
            }
            $.post('/Controller/CuttorInfoUpdateUsedTime.ashx', {
                wmscount: Wmscount
            }, function (data) {

                if (data == "0") {
                    $("#msg").html("当前加工次数更新失败！");
                }
                else {
                    $("#msg").html("当前加工次数更新成功！");
                    //Search(1,10);
                }
            }, "json");
        }
    </script>
</asp:Content>

