<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="EquipmentData.aspx.cs" Inherits="SM.WEB.Views.ProductionManagement.EquipmentData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/Scripts/fanuc.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="设备主数据"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:系统管理\设备主数据</span>
        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="width: 200px; min-height: 480px; overflow-y: auto;">
                    <dt class="closed">
                        <span>设备结构树</span>
                        <a href="javascript:void(0)" style="float: right; margin-top: -4px; color: white;" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeitNode()">删除</a>
                        <a href="javascript:void(0)" style="float: right; margin-top: -4px; color: white;" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendNode()">添加</a>

                    </dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" id="rolelist" style="display: block;">
                                <div style="">
                                    <div class="easyui-panel" style="padding: 5px">
                                        <ul id="tt" class="easyui-tree"></ul>
                                    </div>
                                    <div id="mm" class="easyui-menu" style="width: 120px;">
                                        <div onclick="appendNode()" data-options="iconCls:'icon-add'">添加节点</div>
                                        <div onclick="removeitNode()" data-options="iconCls:'icon-remove'">删除节点</div>
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
                <dl class="accordion toggle-mode" style="min-width: 600px; width: auto">
                    <dt class="closed"><span>设备信息</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding" style="display: block; overflow-y: auto; height: auto;">
                            <div class="RadAjaxPanel">
                                <div style="margin-top: 5px; margin-left: 5px;">
                                    <input type="hidden" id="txtid" value="" />
                                    <input type="hidden" id="ParentId" value="" />
                                    <div style="float: left; margin-top: 5px; width: 260px;">
                                        <table>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; font-size: 14px; color: #444; width: 100px;">设备ID:</td>
                                                <td>
                                                    <input id="ID" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 26px; width: 140px; background: rgb(194, 184, 184)" /><span style="color: red;">*</span></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">设备名称:</td>
                                                <td>
                                                    <input id="EquipmentName" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 140px;" /><span style="color: red;">*</span></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">设备描述:</td>
                                                <td>
                                                    <input id="EquipmentDesc" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 140px;" /></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">班组:</td>
                                                <td>
                                                    <input id="Team" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 140px;" /></td>
                                            </tr>
                                            <tr>

                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">设备图片:</td>
                                                <td>
                                                    <input type="file" id="file1" name="file" style="height: 26px; width: 140px;" onchange="ajaxFileUpload(); return false;" />
                                                    <input type="hidden" id="EquipmentImg" />
                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                    <div style="float: left; margin-top: 5px; width: 260px;">
                                        <table>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">机器编码:</td>
                                                <td>
                                                    <input id="EquipmentCode" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 140px;" /></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">PLCDB头部:
                                                </td>
                                                <td>
                                                    <input id="PLCIP" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 140px;" /><span style="color: red;">*</span></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">PLC模板:
                                                </td>
                                                <td>
                                                    <%--<input id="PLCDB" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 140px;" />--%>
                                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 140px;" id="PLCDB">
                                                        <option value="0" selected="selected">请选择</option>
                                                    </select>
                                                    <span style="color: red;">*</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">PayPoint:
                                                </td>
                                                <td>
                                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 140px;" id="IsPayPoint">
                                                        <option value="" selected="selected">请选择</option>
                                                        <option value="1">是</option>
                                                        <option value="0">否</option>
                                                    </select></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">设备类型:
                                                </td>
                                                <td>
                                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 140px;" id="EType">
                                                        <option value="" selected="selected">请选择</option>
                                                        <option value="1">线体</option>
                                                        <option value="2">站点</option>
                                                        <option value="3">设备</option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div style="float: left; margin-top: 5px; width: 260px;">
                                        <table>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">设计CycleTime:</td>
                                                <td>
                                                    <input id="DesignCycletime" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 140px;" /></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">设计JPH:
                                                </td>
                                                <td>
                                                    <input id="DesignJPH" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 140px;" /></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">设备供应商:
                                                </td>
                                                <td>
                                                    <input id="EquipmentSupplier" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 140px;" /></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">单Cycletime生产零件数量:
                                                </td>
                                                <td>
                                                    <input id="Counter" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 140px;" /><span style="color: red;">*</span></td>
                                            </tr>

                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div style="min-width: 100%; width: auto; float: left;">
                                <input type="button" class="button white-gradient" id="save" style="margin-top: 5px; width: 60px; margin-right: 5px; float: right;" onclick="SaveBase(); return false;" value="保  存" />
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
                    <dt class="closed"><span>故障和人工干预</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div style="margin-top: 5px; margin-left: 5px; height: 188px; width: 100%;">
                                    <div style="height: 150px;">
                                        <table id="dataSheet" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                            style="border: solid 1px #add9c0; height: 120px; overflow-y: auto;">
                                            <thead>
                                                <tr>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                    <div id="tb" style="height: auto; display: none;">
                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">新增</a>
                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">取消</a>
                                        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">获取修改</a>--%>
                                    </div>
                                    <label id="msgSheet" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>

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
            getPlcTemplate();
        });
        function Search() {
            $('#tt').tree({
                url: "/Controller/EquipmentDataTrees.ashx",
                method: 'get',
                animate: true,
                onContextMenu: function (e, node) {
                    e.preventDefault();
                    $(this).tree('select', node.target);
                    $('#mm').menu('show', {
                        left: e.pageX,
                        top: e.pageY
                    });
                },
                onClick: function (node) {
                    //$(this).tree('beginEdit', node.target);
                    $("#tb").show();
                    getNodeByid(node.id);
                    getFaultbyEid(node.id);
                    //$(this).tree('getParent',node.target);//获取父亲节点
                }
            });
        }
        function getPlcTemplate() {
            $.post('/Controller/PLCTemplateInfoSearch.ashx', { Id: "" }, function (data) {
                //if (data.rows[0].tips != "没有数据") {
                var ohtml = '<option value="" selected="selected">请选择</option>';
                for (var i = 0; i < data.length; i++) {
                    ohtml += '<option value="' + data[i].ID + '">' + data[i].PLCTemplateName + '</option>';
                }
                $("#PLCDB").html(ohtml);
                //}
            }, "json");
        }
        function appendNode() {
            var t = $('#tt');
            var node = t.tree('getSelected');
            if (node != null && node.id != undefined) {
                t.tree('append', {
                    parent: (node ? node.target : null),
                    data: [{
                        text: '新设备1'
                    }]
                });
                ClearAll();
                $("#EquipmentName").val("新设备1");
                $("#ParentId").val(node.id);
            }
            else {
                $("#msgBase").html("先保存父节点再添加！");
            }

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
            $("#EType").val("");
        }
        function removeitNode() {
            var node = $('#tt').tree('getSelected');
            $('#tt').tree('remove', node.target);
            if (node.id != undefined) {
                $.post('/Controller/EquipmentDataDeleteByid.ashx', {
                    id: node.id,
                    equipmentName: node.EquipmentName
                }, function (data) {
                    if (data == "0") {
                        $("#msgBase").html("删除设备信息失败！");
                    }
                    else {
                        $("#msgBase").html("删除设备信息成功！");
                    }
                }, "json");
            }
        }
        function SaveBase() {
            var ID = $("#txtid").val();
            var ParentId = $("#ParentId").val();
            var EquipmentCode = $("#EquipmentCode").val();
            var EquipmentName = $("#EquipmentName").val();
            var EquipmentDesc = $("#EquipmentDesc").val();
            var Team = $("#Team").val();
            var EquipmentImg = $("#EquipmentImg").val();
            var PLCIP = $("#PLCIP").val();
            var PLCDB = $("#PLCDB").val();
            var IsPayPoint = $("#IsPayPoint").val();
            var DesignCycletime = $("#DesignCycletime").val();
            var DesignJPH = $("#DesignJPH").val();
            var EquipmentSupplier = $("#EquipmentSupplier").val();
            var Counter = $("#Counter").val();
            var EType=$("#EType").val();
            if ($("#EquipmentName").val().trim() == "" || $("#PLCIP").val().trim() == "" || $("#PLCDB").val().trim() == "" || $("#Counter").val().trim() == "") {
                $("#msgBase").html("带*的项目必须输入！");
                return false;
            }
            var reg = /^\d+$/;
            if (!reg.test($("#Counter").val())) {
                $("#msgBase").html("单Cycletime生产零件数量应为数字！");
                return false;
            }
            var reg = /^\d+$/;
            if ($("#DesignCycletime").val().trim() != "" && !reg.test($("#DesignCycletime").val())) {
                $("#msgBase").html("设计CycleTime应为数字！");
                return false;
            }
            if ($("#DesignJPH").val().trim() != "" && !reg.test($("#DesignJPH").val())) {
                $("#msgBase").html("设计JPH应为数字！");
                return false;
            }


            $.post('/Controller/EquipmentDataEdit.ashx', {
                id: ID,
                parentId: ParentId,
                equipmentCode: EquipmentCode,
                equipmentName: EquipmentName,
                equipmentDesc: EquipmentDesc,
                equipmentImg: EquipmentImg,
                team: Team,
                plcIP: PLCIP,
                plcDB: PLCDB,
                isPayPoint: IsPayPoint,
                designCycletime: DesignCycletime,
                designJPH: DesignJPH,
                equipmentSupplier: EquipmentSupplier,
                counter: Counter,
                etype:EType
            }, function (data) {
                if (data == "0") {
                    $("#msgBase").html("保存设备信息失败！");
                }
                else {
                    $("#msgBase").html("保存设备信息成功！");
                    $("#txtid").val(data);
                    $("#ID").val(('000000000'+data).slice(-3));
                    Search();
                    getFaultbyEid($("#txtid").val());
                }
            }, "json");
        }
        function getNodeByid(ID) {
            $.post('/Controller/EquipmentDataByid.ashx', { id: ID }, function (data) {

                if (data.length == 0) {
                    //ajaxLoadEnd();
                    $("#msgBase").html("没有查询到数据！");
                }
                else {
                    $("#ID").val(data[0].EquipmentId);
                    $("#txtid").val(data[0].ID);
                    $("#ParentId").val(data[0].ParentId);
                    $("#EquipmentCode").val(data[0].EquipmentCode);
                    $("#EquipmentName").val(data[0].EquipmentName);
                    $("#EquipmentDesc").val(data[0].EquipmentDesc);
                    $("#Team").val(data[0].Team);
                    $("#EquipmentImg").val(data[0].EquipmentImg);
                    $("#PLCIP").val(data[0].PLCIP);
                    $("#PLCDB").val(data[0].PLCDB);
                    $("#IsPayPoint").val(data[0].IsPayPoint);
                    $("#DesignCycletime").val(data[0].DesignCycletime);
                    $("#DesignJPH").val(data[0].DesignJPH);
                    $("#EquipmentSupplier").val(data[0].EquipmentSupplier);
                    $("#Counter").val(data[0].Counter);
                    $("#EType").val(data[0].EType);
                }
            }, "json");
        }
        function getFaultbyEid(ID) {
            var stype = [{ "value": "故障", "text": "故障" }, { "value": "人工干预", "text": "人工干预" }];//json格式

            $("#dataSheet").datagrid({
                url: "/Controller/FaultCodeInfoByEid.ashx?Id=" + ID,
                toolbar: "#tb",
                fitColumns: true,
                rownumbers: true,
                singleSelect: true,
                loadMsg: '加载中......',
                height: 'auto',
                onClickRow: onClickRow,
                emptyMsg: "<span>没有查询到数据</span>",
                showFooter: true,
                columns: [[
                    {
                        field: 'FaultCode', width: 50, title: '代码', align: 'center', editor: {
                            type: 'validatebox',
                            options: {
                                required: true,
                                validType: ['text', 'length[0,32]']
                            }
                        }
                    },
                    {
                        field: 'FaultType', width: 60, align: 'center', title: '类型', editor: {
                            type: 'combobox',
                            options: {
                                data: stype,
                                valueField: "value",
                                textField: "text",
                                editable: false,
                                panelHeight: 70,
                                required: true
                            }
                        }
                    },
                    {
                        field: 'FaultDesc', width: 150, title: '描述', align: 'center', editor: {
                            type: 'validatebox',
                            options: {
                                required: true,
                                validType: ['text', 'length[0,100]']
                            }
                        }
                    },
                    {
                        field: 'PLCDB', width: 80, align: 'center', title: 'PLC DB地址', editor: {
                            type: 'validatebox',
                            options: {
                                required: true,
                                validType: ['text', 'length[0,32]']
                            }
                        }
                    }


                ]],

                onResize: function () {
                    //$("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    //setTimeout(function () {
                    //    $("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
                    //}, 0);

                }
            });
            //$("#dataTransitInfo").datagrid('fixDetailRowHeight', index);
        }
        var editIndex = undefined;
        function endEditing(optype) {
            if (editIndex == undefined) { return true }
            if ($('#dataSheet').datagrid('validateRow', editIndex)) {
                var ed = $('#dataSheet').datagrid('getEditor', { index: editIndex, field: 'FaultType' });
                var FaultType = $(ed.target).combobox('getText');
                $('#dataSheet').datagrid('getRows')[editIndex]['FaultType'] = FaultType;
                $('#dataSheet').datagrid('endEdit', editIndex);
                if (optype == "C") {
                    editIndex = undefined;
                    return true;
                }
                else if (optype == "E") {
                    if ($('#dataSheet').datagrid('getRows')[editIndex]['FaultCode'].length > 32) {
                        $("#msgSheet").html("代码长度超过了32字符！");
                        editIndex = undefined;
                        return false;
                    }
                    if ($('#dataSheet').datagrid('getRows')[editIndex]['PLCDB'].length > 32) {
                        $("#msgSheet").html("PLCDB长度超过了32字符！");
                        editIndex = undefined;
                        return false;
                    }
                    if ($('#dataSheet').datagrid('getRows')[editIndex]['FaultDesc'].length > 100) {
                        $("#msgSheet").html("描述长度超过了100字符！");
                        editIndex = undefined;
                        return false;
                    }
                    var row = $('#dataSheet').datagrid('getRows')[editIndex];
                    var ID = row.ID == undefined ? "" : row.ID;
                    var EquipmentId = $("#txtid").val();
                    var FaultCode = row.FaultCode.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var FaultDesc = row.FaultDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    FaultType = row.FaultType;
                    var PLCDB = row.PLCDB.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

                    if (FaultCode.trim() == "" || FaultType.trim() == "" || FaultDesc.trim() == "" || PLCDB.trim() == "") {
                        $("#msgSheet").html("各项目必须输入完成！");
                        return false;
                    }

                    $.post('/Controller/FaultCodeInfoEdit.ashx', {
                        id: ID,
                        equipmentId: EquipmentId,
                        faultCode: FaultCode,
                        faultType: FaultType,
                        faultDesc: FaultDesc,
                        plcDB: PLCDB
                    }, function (data) {

                        if (data == "0") {
                            $("#msgSheet").html("故障信息保存失败！");
                            editIndex = undefined;
                            return false;
                        }
                        else {
                            $("#msgSheet").html("故障信息保存成功！");
                            getFaultbyEid($("#txtid").val());
                            editIndex = undefined;
                            return true;
                        }
                    }, "text");
                }

            } else {
                return false;
            }
        }
        function onClickRow(index) {
            if (editIndex != index) {
                if (endEditing("C")) {
                    $('#dataSheet').datagrid('selectRow', index)
                        .datagrid('beginEdit', index);
                    editIndex = index;
                } else {
                    $('#dataSheet').datagrid('selectRow', editIndex);
                }
            }
        }
        function append() {
            if (endEditing("C")) {
                $('#dataSheet').datagrid('appendRow', { status: 'P' });
                editIndex = $('#dataSheet').datagrid('getRows').length - 1;
                $('#dataSheet').datagrid('selectRow', editIndex)
                    .datagrid('beginEdit', editIndex);
            }
        }
        function removeit() {
            if (editIndex == undefined) { return }
            var row = $('#dataSheet').datagrid('getRows')[editIndex];

            var ID = row.ID == undefined ? "" : row.ID;
            var FaultCode = row.FaultCode.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

            $.post('/Controller/FaultCodeInfoDeletebyid.ashx', {
                id: ID,
                faultCode: FaultCode
            }, function (data) {
                if (data == "0") {
                    $("#msgSheet").html("删除失败！");
                }
                else {
                    $("#msgSheet").html("删除成功！");
                    $('#dataSheet').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);
                    editIndex = undefined;
                }
            }, "text");

        }
        function accept() {
            if (endEditing("E")) {
                $('#dataSheet').datagrid('acceptChanges');
            }
        }
        function reject() {
            $('#dataSheet').datagrid('rejectChanges');
            editIndex = undefined;
        }
        function getChanges() {
            var rows = $('#dataSheet').datagrid('getChanges');
            alert(rows.length + ' rows are changed!');
        }
        function ajaxFileUpload() {
            var formData = new FormData();
            formData.append("myfile", document.getElementById("file1").files[0]);

            $.ajax({
                url: "/Views/UserPermission/upload.ashx",
                type: "POST",
                data: formData,
                /**
                *必须false才会自动加上正确的Content-Type
                */
                contentType: false,
                /**
                * 必须false才会避开jQuery对 formdata 的默认处理
                * XMLHttpRequest会对 formdata 进行正确的处理
                */
                processData: false,
                success: function (data) {
                    if (data.status == "true") {
                        $("#EquipmentImg").val(data.msg);
                        $("#msgBase").html("图片上传成功！");
                        var file = document.getElementById('file1');
                        file.outerHTML = file.outerHTML;
                    }
                    if (data.status == "error") {
                        $("#msgBase").html("图片上传失败：" + data.msg);
                    }
                },
                error: function (err) {
                    $("#msgBase").html("图片上传失败！");
                    //$("#imgWait").hide();
                }
            });
        }
    </script>
</asp:Content>

