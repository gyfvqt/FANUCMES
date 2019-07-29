<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="Line.aspx.cs" Inherits="SM.WEB.Views.ProductionManagement.Line" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="生产线管理"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:生产数据管理\生产线管理</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div>
                                    <label for="txtUserId" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">线体编码:</label>
                                    <input id="txtUserId" name="txtUserId" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 120px;" />
                                    <label for="txtEmail" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">线体名称:</label>
                                    <input id="txtEmail" name="txtEmail" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 120px;" />
                                    <label for="txtPhoneNumber" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">线体类型:</label>
                                    <input id="txtPhoneNumber" name="txtPhoneNumber" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 120px;" />

                                    <button class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search();return false;">查  询</button>

                                </div>

                                <br />
                                <br />
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">线体列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 258px; ">
                                    <%--<div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>--%>
                                    <div style="height: 220px;overflow-y:auto;">
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

                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)线体</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div  style="margin-top: 5px; margin-left: 5px;">

                                <input id="txtid" style="display: none;" />

                                <div style="display: block; float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">线体编码:</div>
                                    <input id="txtLineId" name="txtLineId" maxlength="32" readonly="readonly" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px; background: rgb(194, 184, 184);" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">线体名称:</div>
                                    <input id="txtLineName" name="txtLineName" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">线体类型:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="rwlbLineType">
                                        <option value="M-Assembly" selected="selected">M-Assembly</option>
                                        <option value="A-Machining">A-Machining</option>
                                    </select><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">设计产能:</div>
                                    <input id="txtDesignCycle" name="txtDesignCycle" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">计划产能:</div>
                                    <input id="txtPlanCycle" name="txtPlanCycle" maxlength="16" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">线体PLCDB:</div>
                                    <input id="txtPLCBD" name="txtPlanCycle" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">是否生效:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="Isenable">
                                        <option value="1" selected="selected">是</option>
                                        <option value="0">否</option>
                                    </select>
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
            Search();
        });
        function Search() {
            var LineId = $("#txtUserId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var LineName = $("#txtEmail").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var LineType = $("#txtPhoneNumber").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            datagridfresh(1, 10, LineId, LineName, LineType);
        }

        function datagridfresh(pageNumber, pageSize, LineId, LineName, LineType) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/LineSearch.ashx', { pageindex: pageNumber, pagesize: pageSize, lineId: LineId, lineName: LineName, lineType: LineType }, function (data) {

                if (data.rows[0].tips == "没有数据") {
                    $("#datawin").datagrid({
                        //columns: [data.titleTable],   //动态取标题
                        rownumbers: true,
                            singleselect: false,
                            fitColumns: true,
                        emptyMsg:"<span>没有查询到数据，请调整一下查询条件！</span>",
                        columns: [[
                            //{ field: 'rownum', width: 30, title: 'No' },
                            {
                                field: 'ID', title: '操作', width: 15, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox" value="'+row.IsEnable+'" id="' + row.ID + '">';
                                }
                            },

                            {
                                field: 'LineId', title: '线体编码', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.LineId
                                        + '","' + row.LineName
                                        + '","' + row.LineType
                                        + '","' + row.DesignCycle
                                        + '","' + row.PlanCycle
                                        + '","' + row.IsEnable
                                        + '","' + row.PLCDB
                                        + '");\'>' + row.LineId + '</a>';
                                }
                            },
                            { field: 'LineName', width: 150, title: '线体名称', align: 'center' },
                            { field: 'LineType', width: 50, title: '线体类型', align: 'center' },
                            { field: 'DesignCycle', width: 50, title: '设计产能', align: 'center' },
                            { field: 'PlanCycle', width: 50, title: '计划产能', align: 'center' },
                            {
                                field: 'IsEnable', title: '是否生效', width: 50, align: 'center',
                                formatter: function (value, row, index) {
                                    if (row.IsEnable == 0) {
                                        return "否";
                                    }
                                    else {
                                        return "是";
                                    }
                                }
                            }

                        ]],
                        onLoadSuccess: function () {
                            $("#datawin").datagrid("loaded");
                        }
                    });
                    $("#datawin").datagrid("loadData", []);  //动态取数据  
                    $("#datawin").datagrid("loaded");
                }
                else {
                    $("#datawin").datagrid({
                        //columns: [data.titleTable],   //动态取标题
                        rownumbers: true,
                            singleselect: false,
                            fitColumns: true,
                        columns: [[
                            //{ field: 'rownum', width: 15, title: 'No' },
                            {
                                field: 'ID', title: '操作', width: 15, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox" value="'+row.IsEnable+'" id="' + row.ID + '">';
                                }
                            },

                            {
                                field: 'LineId', title: '线体编码', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.LineId
                                        + '","' + row.LineName
                                        + '","' + row.LineType
                                        + '","' + row.DesignCycle
                                        + '","' + row.PlanCycle
                                        + '","' + row.IsEnable
                                        + '","' + row.PLCDB
                                        + '");\'>' + row.LineId + '</a>';
                                }
                            },
                            { field: 'LineName', width: 150, title: '线体名称', align: 'center' },
                            { field: 'LineType', width: 50, title: '线体类型', align: 'center' },
                            { field: 'DesignCycle', width: 50, title: '设计产能', align: 'center' },
                            { field: 'PlanCycle', width: 50, title: '计划产能', align: 'center' },
                            {
                                field: 'IsEnable', title: '是否生效', width: 50, align: 'center',
                                formatter: function (value, row, index) {
                                    if (row.IsEnable == 0) {
                                        return "否";
                                    }
                                    else {
                                        return "是";
                                    }
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
        function Edit(ID, LineId, LineName, LineType, DesignCycle, PlanCycle, IsEnable,PLCDB) {
            $("#txtid").val(ID);
            $("#txtLineId").val(LineId);
            $("#txtLineName").val(LineName);
            $("#rwlbLineType").val(LineType);
            $("#txtDesignCycle").val(DesignCycle);
            $("#txtPlanCycle").val(PlanCycle);
            $("#txtPLCDB").val(PLCDB);
            $("#Isenable").val(IsEnable);


            $("#txtEUserId").attr("readonly", "readonly");
            $("#txtEUserId").css("background", "rgb(194, 184, 184)");
            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            $("#txtLineId").val("");
            $("#txtLineName").val("");
            //$("#rwlbLineType").val("");
            $("#txtDesignCycle").val("");
            $("#txtPlanCycle").val("");
            $("#PLCDB").val();


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
            if ($("#txtLineName").val().trim() == "" || $("#txtDesignCycle").val().trim() == "" || $("#txtPlanCycle").val().trim() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }
            var reg = /^\d+$/;
            if (!reg.test($("#txtDesignCycle").val()) || !reg.test($("#txtPlanCycle").val())) {
                $("#msg").html("产能必须是正整数！");
                return false;
            }


            var ID = $("#txtid").val();
            var LineId = $("#txtLineId").val();
            var LineName = $("#txtLineName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var LineType = $("#rwlbLineType").val();
            var DesignCycle = $("#txtDesignCycle").val();
            var PlanCycle = $("#txtPlanCycle").val();
            var PLCDB = $("#txtPLCDB").val();
            var IsEnable = $("#Isenable").val();

            $.post('/Controller/LineEdit.ashx', {
                id: ID,
                lineid: LineId,
                lineName: LineName,
                lineType: LineType,
                designCycle: DesignCycle,
                planCycle: PlanCycle,
                isEnable: IsEnable,
                plcdb:PLCDB
            }, function (data) {

                if (data == "0") {
                    //ajaxLoadEnd();
                    //alert("保存失败！");
                    $("#msg").html("*保存失败！");
                }
                else {
                    $("#msg").html("*保存成功！");
                    var LineId = $("#txtUserId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var LineName = $("#txtEmail").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var LineType = $("#txtPhoneNumber").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    datagridfresh(1, 10, LineId, LineName, LineType);
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
                if (item.value == "1") {
                    $("#msg").html("*必须失效的线体才可以删除！");
                    return false;
                }
            });
            if (deleteid.trim() != "") {
                if (confirm("确定删除数据？")) {
                    $.post('/Controller/LineDelete.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("*删除失败！");
                        }
                        else {
                            $("#msg").html("*删除成功！");
                            var LineId = $("#txtUserId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var LineName = $("#txtEmail").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var LineType = $("#txtPhoneNumber").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            datagridfresh(1, 10, LineId, LineName, LineType);
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
