<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="AMTicket.aspx.cs" Inherits="SM.WEB.Views.Fault.AMTicket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/Scripts/jquery.scrollTo.min.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <script src="AMTicket.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="日常维护管理"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:设备维护/日常维护管理</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span>查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 80px; overflow-y: auto;">
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">维护任务名称:</span>
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
                                
                                <div style="float: left; width: 100%;">
                                    <span style="text-align: right; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">创建时间    从:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="CreateTimeB" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                        到 
                                                <input id="CreateTimeE" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                    </div>
                                    <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(1, 10); return false;" value="查  询" />
                                </div>
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span>维护任务列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 258px; overflow-y: auto;">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 190px;">
                                        <table id="datawin" class="easyui-datagrid" data-options="border:false,singleSelect:true,fit:true,fitColumns:true"
                                            style="border: solid 1px #add9c0; overflow-y: auto;">
                                            <thead>
                                                <tr>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                     <input type="button" class="button white-gradient" id="New" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(0); return false;" value="新  增" />
                                <%--<input type="button" class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save(); return false;" value="保  存" />--%>
                                <input type="button" class="button white-gradient" id="delete" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Delete(); return false;" value="删  除" />
                                <input type="button" class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(1); return false;" value="取  消" />
                                <%--<input type="button" class="button white-gradient" id="rsave" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save(); return false;" value="执行通知单" />--%>
                                <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                </div>
                               
                            </div>

                        </div>
                    </dd>
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)维护任务</span><span onclick="ClearAll(1);return false;" style="float: right; margin-right: 15px;">返回</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>基本信息</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px;">
                                                    <input id="txtid" style="display: none;" />
                                                    <div style="width: 100%; float: left;">
                                                        <table class="fileter">
                                                            <tr>
                                                                <td style="width: 90px; height: 26px; text-align: right; vertical-align: middle;">维护任务编号:</td>
                                                                <td style="width: 170px;">
                                                                    <input id="TicketNo" class="k-textbox" readonly="readonly" maxlength="32" style="margin: 0 5px 5px 0; height: 26px; width: 150px; float: left; background: rgb(194, 184, 184);" />
                                                                    <span style="color: red;">*</span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 90px; height: 26px; text-align: right; vertical-align: middle;">维护任务名称:</td>
                                                                <td style="width: 170px;">
                                                                    <input id="FaultName" maxlength="32" class="k-textbox" style="border: 1px #ccc solid; width: 150px; margin: 0 5px 5px 0; width: 150px; height: 26px; float: left;" />
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
                                                                <td style="width: 90px; height: 26px; text-align: right; vertical-align: auto;">维护任务描述:</td>
                                                                <td style="width: 340px;" rowspan="2">
                                                                    <textarea id="FaultDesc" maxlength="100" class="k-textbox" style="margin: 0 5px 5px 0; height: 52px; width: 300px; float: left;"></textarea>
                                                                </td>
                                                            </tr>

                                                        </table>

                                                    </div>
                                                    <label id="msgbase" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                    <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="SaveBase(); return false;" value="下一步>>" />
                                                </div>
                                            </div>
                                        </dd>

                                    </dl>

                                </div>

                            </div>

                        </div>
                        <div class="RadAjaxPanel" id="ddPinlv" style="display: none;">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div class="with-mid-padding">
                                    <dl class="accordion toggle-mode">
                                        <dt class="closed"><span>任务周期设置</span></dt>
                                        <dd>
                                            <div class="RadAjaxPanel" style="display: block;">
                                                <div style="margin-top: 5px; margin-left: 5px; height: 100px;">
                                                    <div style="width: 100%;">
                                                        <div style="float: left; border-right: 2px #0fcff2 solid; width: 100px; height: 90px;">
                                                            <table cellspacing="5" cellpadding="5">
                                                                <tr>
                                                                    <td>
                                                                        <input type="radio" name="pinlv" id="rday" value="每天" onclick="Rday();" />每天</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <input type="radio" checked="checked" name="pinlv" id="rweek" value="每周" onclick="Rweek();" />每周</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <input type="radio" name="pinlv" id="rmonth" value="每月" onclick="Rmonth();" />每月</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <input type="radio" name="pinlv" id="ryear" value="每年" onclick="Ryear();" />每年</td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div id="divWeek" style="float: left; margin-left: 15px; border-right: 2px #0fcff2 solid; width: 250px; height: 90px;">
                                                            <table cellspacing="5">
                                                                <tr>
                                                                    <td>发生于每<input type="text" id="Xweek" style="width: 40px;" maxlength="2" />周</td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <input name="chkweek" type="checkbox" value="1" />周一&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        <input name="chkweek" type="checkbox" value="2" />周二&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        <input name="chkweek" type="checkbox" value="3" />周三&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        <input name="chkweek" type="checkbox" value="4" />周四</td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <input name="chkweek" type="checkbox" value="5" />周五&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        <input name="chkweek" type="checkbox" value="6" />周六&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        <input name="chkweek" type="checkbox" value="7" />周日
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div id="divYM" style="float: left; display: none; margin-left: 15px; border-right: 2px #0fcff2 solid; width: 250px; height: 90px;">
                                                            <table>
                                                                <tr>
                                                                    <td>发生于每月</td>
                                                                    <td>
                                                                        <input type="text" id="mday" style="width: 40px;" maxlength="2" />日</td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div id="divY" style="float: left; display: none; margin-left: 15px; border-right: 2px #0fcff2 solid; width: 250px; height: 90px;">
                                                            <table cellspacing="5">
                                                                <tr>
                                                                    <td>发生于<select  id="yearm">
                                                                                <option value="">Month</option>
                                                                                <option value="1">1</option>
                                                                                <option value="2">2</option>
                                                                                <option value="3">3</option>
                                                                                <option value="4">4</option>
                                                                                <option value="5">5</option>
                                                                                <option value="6">6</option>
                                                                                <option value="7">7</option>
                                                                                <option value="8">8</option>
                                                                                <option value="9">9</option>
                                                                                <option value="10">10</option>
                                                                                <option value="11">11</option>
                                                                                <option value="12">12</option>
                                                                            </select>月</td>
                                                                    <td>
                                                                        <select  id="ymday">
                                                                            <option value="">日期</option>
                                                                        </select>日</td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div id="divTime" style="float: left; margin-left: 15px;">
                                                            <table cellspacing="5" cellpadding="5">
                                                                <tr>
                                                                    <td style="height: 26px;">任务开始于<input id="Btime" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd' })"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 26px;">任务结束于<input id="Etime" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd' })"></td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <label id="msgPinlv" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
                                                    <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="SavePinlv(); return false;" value="下一步>>" />
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
                                        <dt class="closed"><span>维护设备列表</span></dt>
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
                                        <dt class="closed"><span>附加数据</span></dt>
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

                                                    <label id="msgUP" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>

                                                    <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="SaveUP(); return false;" value="下一步>>" />
                                                    <input type="button" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="DeleteAMSheet(); return false;" value="删除" />
                                                    <input type="button" class="button white-gradient" id="upload" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="Upload(); return false;" value="上传作业指导书" />
                                                    <input type="file" id="file1" name="file" style="height: 30px; margin-top: 5px; margin-right: 15px; float: right; display: none;" onchange="UploadProcessSheet(); return false;" />
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
                                        <dt class="closed"><span>日常任务提醒设置</span></dt>
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
                                                    <input type="button" id="btnReturn" class="button white-gradient" style="margin-top: 5px; margin-right: 15px; float: right;" onclick="ClearAll(1); return false;" value="<<返回站点基本信息" />

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
    <script type="text/javascript">
        var stopFirstChangeEvent = true;
        var wsid = "";
        var dayselect = "";
        $(document).ready(function () {
            Search(1, 10);
            getUser();
            initForm();

        });
    </script>
</asp:Content>
