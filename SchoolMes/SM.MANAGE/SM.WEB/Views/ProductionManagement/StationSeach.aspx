<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="StationSeach.aspx.cs" Inherits="SM.WEB.Views.ProductionManagement.StationSeach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/Scripts/jquery.scrollTo.min.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="站点管理"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:生产数据管理\站点管理</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 70px; overflow-y: auto;">
                                <div>
                                    <div style="font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">
                                        站点编码:
                                    <input id="txtStationCode" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 120px; border: solid 1px #ccc;" />
                                    </div>
                                    <div style="font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">
                                        站点名称:
                                    <input id="txtStationName" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 120px; border: solid 1px #ccc;" />
                                    </div>
                                    <div style="font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">
                                        站点描述:
                                    <input id="txtStationDesc" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 120px; border: solid 1px #ccc;" />
                                    </div>
                                    <div style="font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        站点类型:
                                    <input id="txtStationType" type="text" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 120px; border: solid 1px #ccc;" />
                                    </div>
                                    <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(); return false;" value="查  询" />

                                </div>


                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span id="PortalContent_Label1">站点列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: auto;overflow-y: auto; ">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 250px;">
                                        <table id="datawin" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                            style="border: solid 1px #add9c0;">
                                            <thead>
                                                <tr>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                    <input type="button" class="button white-gradient" id="New" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(0); return false;" value="新  增" />
                                    <%--<input type="button" class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save(); return false;" value="保  存" />--%>
                                    <input type="button" class="button white-gradient" id="delete" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Delete(); return false;" value="删  除" />
                                    <input type="button" class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(1); return false;" value="取  消">
                                    <input type="button" class="button white-gradient" id="setEnable" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="SetEnable(); return false;" value="生效/失效" />
                                    <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                </div>

                            </div>

                        </div>
                    </dd>
                    <dt class="closed" id="list-output"><span>站点详情</span><span onclick="ClearAll(1);return false;" style="float: right; margin-right: 15px;">返回</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>站点类型设置</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px;">
                                                    <input id="txtid" style="display: none;" />
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">对应产线:</div>
                                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 220px;" id="LineId">
                                                            <option value="" selected="selected">请选择</option>
                                                        </select><span style="color: red;">*</span><br />

                                                    </div>
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">站点类型:</div>
                                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 220px;" id="StationType">
                                                            <option value="" selected="selected">请选择</option>
                                                            <option value="PC">PC</option>
                                                            <option value="PLC">PLC</option>
                                                        </select><span style="color: red;">*</span><br />
                                                    </div>
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                    </div>
                                                </div>
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>
                        <div class="RadAjaxPanel" style="display: block;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>基本信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px;">

                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">站点编号:</div>
                                                        <input id="StationCode" maxlength="32" class="k-textbox" readonly="readonly" style="margin: 0 5px 5px 0; height: 26px; width: 220px; background: rgb(194, 184, 184);" /><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">站点名称:</div>
                                                        <input id="StationName" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><span style="color: red;">*</span><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">站点功能:</div>
                                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 220px;" id="isfirst" >
                                                            <option value="0" selected="selected">通用站点</option>
                                                            <option value="1">CO订单下发站点</option>
                                                            <option value="2">SN关联站点</option>
                                                            <option value="3">线体结束站点</option>
                                                        </select><br />

                                                    </div>
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">站点位置:</div>
                                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 220px;" id="StationPosition" >
                                                            <option value="" selected="selected">请选择</option>
                                                            <option value="标准站点">标准站点</option>
                                                            <option value="返修站点">返修站点</option>
                                                        </select><span style="color: red;">*</span><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">班组:</div>
                                                        <input id="Team" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">站点Asset:</div>
                                                        <input id="EquipmentId" style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; " />
                                                        <span style="color: red;">*</span><br />
                                                    </div>
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">站点描述:</div>
                                                        <input id="StationDesc" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">IP:</div>
                                                        <input id="IP" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><br />
                                                    </div>
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        
                                                        
                                                    </div>
                                                </div>

                                                <label id="msgbase" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="SaveBase(); return false;" value="下一步>>" />
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>
                        <div class="RadAjaxPanel" id="ddPLCTemplate" style="display: none;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>数据模板信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px;">
                                                    <input type="hidden" id="ID" value="" />
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">数据模板:</div>
                                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 220px;" id="PLCTemplateId">
                                                            <option value="" selected="selected">请选择</option>
                                                        </select><span style="color: red;">*</span><br />
                                                        
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">PLC数据块:</div>
                                                        <input id="PLCDB" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><span style="color: red;">*</span><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">检查回馈地址:</div>
                                                        <input id="CheckAddress" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><span style="color: red;">*</span><br />
                                                    </div>
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">握手触发器:</div>
                                                        <input id="PLCTrigger" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><span style="color: red;">*</span><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">默认行为代码:</div>
                                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 220px;" id="ActionCode">
                                                            <option value="" selected="selected">请选择</option>
                                                            <option value="UP">UP</option>
                                                            <option value="AP">AP</option>
                                                            <option value="CO">CO</option>
                                                        </select><span style="color: red;">*</span><br />
                                                         <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">回馈数据长度:</div>
                                                        <input id="ReturnLength" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><span style="color: red;">*</span><br />
                                                    </div>
                                                    <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">通讯类型:</div>
                                                        <input id="CommunicateType" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><span style="color: red;">*</span><br />
                                                        <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">通讯名称:</div>
                                                        <input id="CommunicateName" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 220px;" /><span style="color: red;">*</span><br />
                                                    </div>
                                                    <%--<div style="float: left; margin-top: 5px; margin-left: 15px;">
                                                        
                                                       
                                                    </div>--%>
                                                </div>
                                                <div style="margin-top:5px;margin-left:15px;">
                                                <label id="msgPLCTemplate" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="SavePLCTemplate(); return false;" value="下一步>>" />
                                                </div>
                                            </div>
                                            
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>

                        <div class="RadAjaxPanel" id="ddAP" style="display: none;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>AP信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px; height: 188px;">
                                                    <div style="height: 150px;">
                                                        <table id="dataAP" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                                            style="border: solid 1px #add9c0; height: 120px; overflow-y: auto;">
                                                            <thead>
                                                                <tr>
                                                                </tr>
                                                            </thead>
                                                        </table>
                                                    </div>
                                                    <div id="tbAP" style="height: auto">
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendAP()">新增</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeitAP()">删除</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="acceptAP()">保存</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="rejectAP()">取消</a>
                                                    </div>
                                                    <label id="msgAP" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                    <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="SaveAP(); return false;" value="下一步>>" />
                                                </div>
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>

                        <div class="RadAjaxPanel" id="ddUP" style="display: none;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>UP信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px; height: 188px;">
                                                    <div style="height: 150px;">
                                                        <table id="dataUP" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                                            style="border: solid 1px #add9c0; height: 120px; overflow-y: auto;">
                                                            <thead>
                                                                <tr>
                                                                </tr>
                                                            </thead>
                                                        </table>
                                                    </div>
                                                    <div id="tbUP" style="height: auto">
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendUP()">新增</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeitUP()">删除</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="acceptUP()">保存</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="rejectUP()">取消</a>
                                                    </div>
                                                    <label id="msgUP" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                    <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="SaveUP(); return false;" value="下一步>>" />
                                                </div>
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>
                        <div class="RadAjaxPanel" id="ddSheet" style="display: none;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>工艺信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px; height: 188px;">
                                                    <div style="height: 150px;">
                                                        <table id="dataSheet" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                                            style="border: solid 1px #add9c0; height: 120px; overflow-y: auto;">
                                                            <thead>
                                                                <tr>
                                                                </tr>
                                                            </thead>
                                                        </table>
                                                    </div>
                                                    <div id="tb" style="height: auto">
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">新增</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">取消</a>
                                                        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">获取修改</a>--%>
                                                    </div>
                                                    <label id="msgSheet" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                    <input type="button" id="btnSheet" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="SaveSheet(); return false;" value="下一步>>" />
                                                    <input type="button" id="btnReturn" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right; display: none;" onclick="returnBase(); return false;" value="<<返回站点基本信息" />
                                                    <input type="button" class="button white-gradient" id="upload" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="Upload(); return false;" value="上传作业指导书" />
                                                    <input type="file" id="file1" name="file" style="height:30px;margin-top: 5px; margin-right: 15px; float: right; display:none;" onchange="UploadProcessSheet(); return false;" />
                                                </div>
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>

                        <div class="RadAjaxPanel" id="ddProgress" style="display: none;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>过程质量信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px; height: 188px; overflow-y: auto;">
                                                    <div style="height: 150px;">
                                                        <table id="dataProgress" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                                            style="border: solid 1px #add9c0; height: 120px; overflow-y: auto;">
                                                            <thead>
                                                                <tr>
                                                                </tr>
                                                            </thead>
                                                        </table>
                                                    </div>
                                                    <div id="tbProgress" style="height: auto">
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendProgress()">新增</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeitProgress()">删除</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="acceptProgress()">保存</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="rejectProgress()">取消</a>
                                                        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">获取修改</a>--%>
                                                    </div>
                                                    <label id="msgProgress" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                    <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="SaveProgress(); return false;" value="下一步>>" />
                                                </div>

                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>

                        <div class="RadAjaxPanel" id="ddTraceability" style="display: none;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>零件追溯信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px; height: 188px; overflow-y: auto;">
                                                    <div style="height: 150px;">
                                                        <table id="dataTraceability" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                                            style="border: solid 1px #add9c0; height: 120px; overflow-y: auto;">
                                                            <thead>
                                                                <tr>
                                                                </tr>
                                                            </thead>
                                                        </table>
                                                    </div>
                                                    <div id="tbTraceability" style="height: auto">
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendTraceability()">新增</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeitTraceability()">删除</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="acceptTraceability()">保存</a>
                                                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="rejectTraceability()">取消</a>
                                                        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">获取修改</a>--%>
                                                    </div>
                                                    <label id="msgTraceability" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                    <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="returnBase(); return false;" value="<<返回站点基本信息" />
                                                </div>
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>


                    </dd>
                </dl>

            </div>

        </div>
        <div style="display: block; float: left; margin-left: 15px;">
        </div>
    </section>
    <style type="text/css">
        .qbox {
            width: 95px;
            background-color: rgb(255,255,0);
        }
    </style>
    <script src="station.js"></script>
    <script type="text/javascript">   

        $(document).ready(function () {
            //getLine();
            //getStore();
            //datagridfresh(1, 10, "", "", "");
            Search();
            getLine();
            getPlcTemplate();
            getEquipment();
        });
        ///初始化分页
    </script>
</asp:Content>
