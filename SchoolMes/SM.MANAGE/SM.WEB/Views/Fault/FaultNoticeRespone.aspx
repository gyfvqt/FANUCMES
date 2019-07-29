<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="FaultNoticeRespone.aspx.cs" Inherits="SM.WEB.Views.Fault.FaultNoticeRespone" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="故障通知单–执行人查看并执行"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:设备维护/故障通知单–执行人查看并执行</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span>查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 80px; overflow-y: auto;">
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">故障名称:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="txtFaultName" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" />
                                    </div>
                                </div>
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">任务状态:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="txtExecuteStatus">
                                            <option value="" selected="selected">请选择</option>
                                            <option value="新建">新建</option>
                                            <option value="执行">执行</option>
                                        </select>
                                    </div>
                                </div>
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">创建人:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="txtCreator">
                                            <option value="" selected="selected">请选择</option>
                                        </select>
                                    </div>
                                </div>
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">执行人:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="txtUserId">
                                            <option value="" selected="selected">请选择</option>
                                        </select>
                                    </div>
                                </div>
                                <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(1, 10); return false;" value="查  询" />
                                <div style="float: left; width: 100%;">
                                    <span style="text-align: right; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">创建时间    从:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="CreateTimeB" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                        到 
                                                <input id="CreateTimeE" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span>故障通知单列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 208px; overflow-y: auto;">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 170px;">
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
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)故障通知单</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div style="margin-top: 5px; margin-left: 5px;">
                                <input id="txtid" style="display: none;" />
                                <div style="width: 100%; float: left;">
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right; vertical-align: middle;">通知单号:</td>
                                            <td style="width: 170px;">
                                                <input id="TicketNo" class="k-textbox" readonly="readonly" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left; background: rgb(194, 184, 184);" />
                                                <span style="color: red;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right; vertical-align: middle;">故障名称:</td>
                                            <td style="width: 170px;">
                                                <input id="FaultName" maxlength="32" class="k-textbox" style="border: 1px #ccc solid; width: 150px; margin: 0 5px 5px 0;width: 150px; height: 26px; float: left;" />
                                                <span style="color: red;">*</span>

                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right; vertical-align: middle;">任务执行人:</td>
                                            <td style="width: 170px;">
                                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="UserId">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right; vertical-align: middle;"></td>
                                            <td style="width: 170px;"></td>
                                        </tr>
                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right; vertical-align:auto;">故障描述:</td>
                                            <td style="width: 340px;" rowspan="2">
                                                <textarea id="FaultDesc" maxlength="100" class="k-textbox" style="margin: 0 5px 5px 0; height: 52px; width: 300px; float: left;" ></textarea>
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
                                            <td style="width: 90px; height: 26px; text-align: right; vertical-align: middle;">设备名称:</td>
                                            <td style="width: 170px;">
                                                <%--<select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="EquipmentId">
                                                    <option value="" selected="selected">请选择</option>
                                                </select>--%>
                                                <input id="EquipmentId" style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" />
                                                <span style="color: red;">*</span>
                                            </td>
                                        </tr>

                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right; vertical-align: middle;">设备描述:</td>
                                            <td style="width: 170px;">
                                                <input id="EquipmentDesc" class="k-textbox" readonly="readonly" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left; background: rgb(194, 184, 184);" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>

                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right; vertical-align: middle;">班组:</td>
                                            <td style="width: 170px;">
                                                <input id="Team" class="k-textbox" readonly="readonly" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left; background: rgb(194, 184, 184);" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>

                                    </table>
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right; vertical-align: middle;">机器编码:</td>
                                            <td style="width: 170px;">
                                                <input id="EquipmentCode" class="k-textbox" readonly="readonly" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left; background: rgb(194, 184, 184);" />
                                                <span style="color: red; float: left;">*</span>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div id="divReturnLine" style="width: 100%; float: left; margin-top: 5px;display:none;">
                                    <hr />
                                </div>
                                <div id="divReturn" style="width: 100%; float: left; margin-top: 5px;display:none;">
                                    <table class="fileter">
                                        <tr>
                                            <td style="width: 90px; height: 26px; text-align: right; ">故障处理回执:</td>
                                            <td style="width: 170px;">
                                                <textarea id="FaultReturn" maxlength="300" class="k-textbox" style="margin: 0 5px 5px 0; height: 52px; width: 600px; float: left;" ></textarea>
                                            </td>
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
            <%--<input type="button" class="button white-gradient" id="New" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(0); return false;" value="新  增" />--%>
            <%--<input type="button" class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save(); return false;" value="保  存" />--%>
            <%--<input type="button" class="button white-gradient" id="delete" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Delete(); return false;" value="删  除" />--%>
            <input type="button" class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(1); return false;" value="取  消" />
            <input type="button" class="button white-gradient" id="rsave" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save(); return false;" value="执行通知单" />
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">    
        var stopFirstChangeEvent = true;
        var wsid = "";
        $(document).ready(function () {
            Search(1, 10);
            getUser();
            getEquipment();

        });
        function Search(pageNumber, pageSize) {
            var FaultName = $("#txtFaultName").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var ExecuteStatus = $("#txtExecuteStatus").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var Creator = $("#txtCreator").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var UserId = $("#txtUserId").val().replace('/\,/g', '，').replace('/\;/g', '；');
            var CreateTimeB = $("#CreateTimeB").val();
            var CreateTimeE = $("#CreateTimeE").val();
            datagridfresh(pageNumber, pageSize, FaultName, ExecuteStatus, Creator, UserId, CreateTimeB, CreateTimeE);
        }
        function getUser() {
            $.post('/Controller/userSearch.ashx', { pageindex: 1, pagesize: 1000, userId: "", email: "", phoneNumber: "" }, function (data) {
                var ohtml = "";
                for (var i = 0; i < data.rows.length; i++) {
                    ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].FirstName + data.rows[i].FirstName + '</option>';
                }
                $("#txtUserId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                $("#txtCreator").html('<option value="" selected="selected">请选择</option>' + ohtml);
                $("#UserId").html('<option value="" selected="selected">请选择</option>' + ohtml);
            }, "json");
        }
        function getEquipment() {
            $("#EquipmentId").combotree({
                url: "/Controller/EquipmentDataTrees.ashx",
                required: true,
                editable: false,
                onSelect: function (rec) {
                    $("#EquipmentDesc").val(rec.EquipmentDesc);
                    $("#Team").val(rec.Team);
                    $("#EquipmentCode").val(rec.EquipmentCode);
                }
                //,
                //onChange:function (rec) {
                //    $("#EquipmentDesc").val(rec.EquipmentDesc);
                //    $("#Team").val(rec.Team);
                //    $("#EquipmentCode").val(rec.EquipmentCode);
                //}
            });
        }
        function datagridfresh(pageNumber, pageSize, FaultName, ExecuteStatus, Creator, UserId, CreateTimeB, CreateTimeE) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/FaultNoticeSearch.ashx', {
                pageindex: pageNumber, pagesize: pageSize,
                faultName: FaultName,
                executeStatus: ExecuteStatus,
                creator: Creator,
                userId: UserId,
                btime: CreateTimeB,
                etime: CreateTimeE
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
                                field: 'TicketNo', title: '故障通知单号', width: 70, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.TicketNo                                        
                                        + '","' + row.FaultName
                                        + '","' + row.FaultDesc
                                        + '","' + row.EquipmentId
                                        + '","' + row.UserId
                                        + '","' + row.Creator
                                        + '","' + row.FaultReturn
                                        + '","Execute");\'>' + row.TicketNo + '</a>';
                                }
                            },
                            { field: 'FaultName', width: 160, title: '故障名称', align: 'center' },
                            { field: 'ExecuteStatus', width: 100, title: '任务状态', align: 'center' },
                            { field: 'CreateName', width: 100, title: '创建人', align: 'center' },
                            { field: 'CreateTime', width: 100, title: '创建时间', align: 'center' },
                            { field: 'Executor', width: 100, title: '更新人', align: 'center' }

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
                                field: 'TicketNo', title: '故障通知单号', width: 70, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.TicketNo                                        
                                        + '","' + row.FaultName
                                        + '","' + row.FaultDesc
                                        + '","' + row.EquipmentId
                                        + '","' + row.UserId
                                        + '","' + row.Creator
                                        + '","' + row.FaultReturn
                                        + '","Execute");\'>' + row.TicketNo + '</a>';
                                }
                            },
                            { field: 'FaultName', width: 160, title: '故障名称', align: 'center' },
                            { field: 'ExecuteStatus', width: 100, title: '任务状态', align: 'center' },
                            { field: 'CreateName', width: 100, title: '创建人', align: 'center' },
                            { field: 'CreateTime', width: 100, title: '创建时间', align: 'center' },
                            { field: 'Executor', width: 100, title: '更新人', align: 'center' }

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
        function getEQbyId(ID) {
            $.post('/Controller/EquipmentDataByid.ashx', { id: ID }, function (data) {
                if (data.length > 0) {
                    $("#EquipmentDesc").val(data[0].EquipmentDesc);
                    $("#Team").val(data[0].Team);
                    $("#EquipmentCode").val(data[0].EquipmentCode);
                }
            }, "json");
        }
        
        function Edit(ID, TicketNo, FaultName, FaultDesc, EquipmentId, UserId, Creator, FaultReturn, xtype) {
            $("#txtid").val(ID);
            $("#TicketNo").val(TicketNo);          
            wsid = EquipmentId;
            $("#EquipmentId").combotree('setValue', EquipmentId);
            getEQbyId(EquipmentId);
            $("#FaultName").val(FaultName)
            $("#FaultDesc").val(FaultDesc);
            $("#UserId").val(UserId);
            $("#FaultReturn").val(FaultReturn);


            
            if (xtype == "Edit") {
                $("#EquipmentId").combotree('enable');
                $("#FaultName").removeAttr("readonly");
                $("#FaultName").css("background", "rgb(255, 255, 255)");
                $("#FaultDesc").removeAttr("readonly");
                $("#FaultDesc").css("background", "rgb(255, 255, 255)");
                $("#UserId").removeAttr("disabled");
                $("#UserId").css("background", "rgb(255, 255, 255)");
                $("#divReturnLine").hide();
                $("#divReturn").hide();
            }
            else if (xtype == "Execute") {
                $("#EquipmentId").combotree('disable');
                $("#FaultName").attr("readonly", "readonly");
                $("#FaultName").css("background", "rgb(194, 184, 184)");
                $("#FaultDesc").attr("readonly", "readonly");
                $("#FaultDesc").css("background", "rgb(194, 184, 184)");
                $("#UserId").attr("disabled", "disabled");
                $("#UserId").css("background", "rgb(194, 184, 184)");
                $("#divReturnLine").show();
                $("#divReturn").show();
            }
            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            wsid = "";
            $("#txtid").val("");
            $("#TicketNo").val("");       

            $("#EquipmentId").combotree('setValue', "");
            $("#FaultName").val("")
            $("#FaultDesc").val("");
            $("#UserId").val("");
            $("#FaultReturn").val("");           
            
            $("#EquipmentId").combotree('enable');
            $("#FaultName").removeAttr("readonly");
            $("#FaultName").css("background", "rgb(255, 255, 255)");
            $("#FaultDesc").removeAttr("readonly");
            $("#FaultDesc").css("background", "rgb(255, 255, 255)");
            $("#UserId").removeAttr("disabled");
            $("#UserId").css("background", "rgb(255, 255, 255)");
            $("#divReturnLine").hide();
            $("#divReturn").hide();
            
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
            if ($("#EquipmentId").combotree("getValue") == "" || $("#FaultName").val() == "" || $("#UserId").val().trim() == "") {
                $("#msg").html("带*的项目必须输入！");
                return false;
            }     


            var ID = $("#txtid").val();
            var TicketNo = $("#TicketNo").val();
            var EquipmentId = $("#EquipmentId").combotree("getValue");
            var FaultName = $("#FaultName").val()
            var FaultDesc = $("#FaultDesc").val();            
            var FaultReturn = $("#FaultReturn").val();
            var UserId = $("#UserId").val();  

            $.post('/Controller/FaultNoticeEdit.ashx', {
                id: ID,
                faultName: FaultName,
                faultDesc: FaultDesc,
                faultReturn: FaultReturn,
                equipmentId: EquipmentId,
                userId: UserId
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
                    $.post('/Controller/FaultNoticeDelete.ashx', { id: deleteid }, function (data) {

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