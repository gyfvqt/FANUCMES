<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="WorkCalendar.aspx.cs" Inherits="SM.WEB.Views.ProductionManagement.WorkCalendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="工作日历"></asp:Label>
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

            table.gridtable {
                font-family: verdana,arial,sans-serif;
                font-size: 11px;
                color: #333333;
                border-width: 1px;
                border-color: #666666;
                border-collapse: collapse;
            }

                table.gridtable th {
                    padding: 4px;
                    color: #fff;
                    background: #385fba url(/StyleFiles/img/old-browsers/colors/bg_big-menu.png) repeat-x;
                    border-color: #385fba;
                    -webkit-background-size: 100% 100%;
                    -moz-background-size: 100% 100%;
                    -o-background-size: 100% 100%;
                    background-size: 100% 100%;
                    background: -webkit-gradient(linear,left top,left bottom,from(#276a8f),to(#385fba));
                    background: -webkit-linear-gradient(top,#276a8f,#385fba);
                    background: -moz-linear-gradient(top,#276a8f,#385fba);
                    background: -ms-linear-gradient(top,#276a8f,#385fba);
                    background: -o-linear-gradient(top,#276a8f,#385fba);
                    background: linear-gradient(top,#276a8f,#385fba);
                }

                table.gridtable td {
                    border-width: 1px;
                    padding: 2px;
                    border-style: solid;
                    border-color: #666666;
                    background-color: #ffffff;
                }

            .qbox {
                width: 98%;
                background-color: rgb(255,255,0);
            }
        </style>
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:系统管理\工作日历</span>
        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="width: 400px; min-height: 480px; overflow-y: auto;">
                    <dt class="closed">
                        <span>生产日历编辑</span>

                    </dt>
                    <dd style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" id="rolelist" style="display: block;">
                                <div style="width: 100%;">
                                    <div style="width: 100%; padding: 10px;">
                                        <table style="margin-left: 25px; padding: 10px;">
                                            <tr>
                                                <td style="width: 60px; height: 20px; text-align: center; vertical-align: middle;">年份</td>
                                                <td style="height: 20px;">
                                                    <input id="dyear" class="Wdate" style="border-color: #c5c5c5; width: 80px; height: 20px;" type="text" onclick="WdatePicker({ el: this, onpicked: setCalendar, dateFmt: 'yyyy' })" />

                                                </td>
                                                <td style="width: 60px; height: 20px; text-align: center; vertical-align: middle;">月份</td>
                                                <td style="height: 20px;">
                                                    <input id="dmonth" class="Wdate" style="border-color: #c5c5c5; width: 80px; height: 20px;" type="text" onclick="WdatePicker({ el: this, onpicked: setCalendar, dateFmt: 'MM' })" />

                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div style="width: 100%;">
                                        <div id="cc" style="width: 380px; height: 180px;"></div>
                                    </div>
                                    <div style="width: 100%; padding: 10px;">
                                        <input class="button white-gradient" type="button" style="margin-top: 5px; margin-left: 5px; float: left; width: 150px;" onclick="SetWorkDate(); return false;" value="保存设置工作日" />
                                        <label id="msgWorkDate" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px;"></label>
                                    </div>
                                    <%--<input type="button" value="获取" onclick="Init(); return false;"/>--%>
                                    <div style="width: 100%; padding: 5px; border-bottom: 1px #ccc solid; margin-top: 20px;"></div>
                                    <div style="width: 100%; padding: 10px;">
                                        <select style="margin: 0 5px 5px 5px; border: 1px solid #ccc; height: 26px; width: 175px;" id="selectweek">
                                            <option value="calendar-monday" selected="selected">星期一</option>
                                            <option value="calendar-tuesday">星期二</option>
                                            <option value="calendar-wednesday">星期三</option>
                                            <option value="calendar-thursday">星期四</option>
                                            <option value="calendar-friday">星期五</option>
                                            <option value="calendar-saturday">星期六</option>
                                            <option value="calendar-sunday">星期日</option>
                                        </select>
                                    </div>
                                    <div style="width: 100%; padding: 5px;">
                                        <input class="button white-gradient" type="button" style="margin-top: 5px; margin-left: 5px; float: left; width: 150px;" onclick="SetWorkDateW(1); return false;" value="设置工作日" />
                                        <input class="button white-gradient" type="button" style="margin-top: 5px; margin-left: 5px; float: left; width: 150px;" onclick="SetWorkDateW(0); return false;" value="设置非工作日" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </dd>
                </dl>
            </div>

        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left; margin-left: 420px;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="min-width: 440px; width: auto">
                    <dt class="closed"><span>生产班次设置</span></dt>
                    <dd style="display: block;">
                        <div class="with-small-padding" style="display: block; overflow-y: auto; height: auto;">
                            <div class="RadAjaxPanel">
                                <div style="margin-top: 5px; margin-left: 5px;">
                                    <table class="gridtable">                                        
                                        <tr>
                                            <th>班次ID</th>
                                            <th>班次名称</th>
                                            <th>开始时间</th>
                                            <th>结束时间</th>
                                        </tr>
                                        <tr>
                                            <td>01</td>
                                            <td>第一班</td>
                                            <td>
                                                <input type="text" name="wmscount" class="qbox" id="txtBegin01" />
                                            </td>
                                            <td>
                                                <input type="text" name="wmscount" class="qbox" id="txtEnd01" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>02</td>
                                            <td>第二班</td>
                                            <td>
                                                <input type="text" name="wmscount" class="qbox" id="txtBegin02" />
                                            </td>
                                            <td>
                                                <input type="text" name="wmscount" class="qbox" id="txtEnd02" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>03</td>
                                            <td>第三班</td>
                                            <td>
                                                <input type="text" name="wmscount" class="qbox" id="txtBegin03" />
                                            </td>
                                            <td>
                                                <input type="text" name="wmscount" class="qbox" id="txtEnd03" />
                                            </td>
                                        </tr>

                                    </table>
                                </div>
                            </div>
                            <div style="min-width: 100%; width: auto; float: left;">
                                <input class="button white-gradient" type="button" style="margin-top: 5px; width: 60px; margin-right: 5px; float: right;" onclick="SaveShift(); return false;" value="保  存" />
                                <label id="msgShift" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px;"></label>
                            </div>
                        </div>

                    </dd>
                </dl>
            </div>

        </div>
        <div class="RadAjaxPanel" style="display: block; position: absolute; float: left; margin-top: 250px; margin-left: 420px;">
            <div class="with-mid-padding">
                <dl class="accordion toggle-mode" style="min-width: 440px; width: auto">
                    <dt class="closed"><span>小休设置</span></dt>
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
                                    <div id="tb" style="height: auto;display:none;">
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
        var data = [];
        $(document).ready(function () {
            //Search();
            var arrayList = ["aa", "bb", "cc", "dd"];
            var flag = $.inArray("dd", arrayList);
            Init();
            getShift();
            getRest();
        });
        function SetWorkDate() {
            var dateInit = "";
            $(".calendar-selected").each(function (index, item) {
                var ymd = item.abbr.split(',')
                var y = ymd[0];
                var m = parseInt(ymd[1]) < 10 ? "0" + parseInt(ymd[1]) : ymd[1];
                var d = parseInt(ymd[2]) < 10 ? "0" + parseInt(ymd[2]) : ymd[2];
                dateInit += "|" + (y + "-" + m + "-" + d);
            });
            $.post('/Controller/WorkCalendarSet.ashx', {
                ymdList: dateInit, ym: $("#dyear").val() + "-" + $("#dmonth").val()
            }, function (data) {
                if (data == "0") {
                    $("#msgWorkDate").html("设置工作日失败！");
                }
                else if (data == "1") {
                    $("#msgWorkDate").html("设置工作日成功！");
                }

            }, "json");
        }

        function SetWorkDateW(type) {
            var w = $("#selectweek").val();
            $("." + w).each(function (index, item) {
                if (type == 1) {
                    if (!$(item).hasClass("calendar-selected")) {
                        $(item).addClass("calendar-selected");
                    }
                }
                else if (type == 0) {
                    if ($(item).hasClass("calendar-selected")) {
                        $(item).removeClass("calendar-selected");
                    }
                }
            });
            SetWorkDate();
        }
        function Init() {
            var d = new Date();
            $("#dyear").val(d.getFullYear());
            $("#dmonth").val((d.getMonth() + 1) < 10 ? "0" + (d.getMonth() + 1) : (d.getMonth() + 1));
            $('#cc').calendar({
                year: $("#dyear").val(),
                month: $("#dmonth").val(),
                firstDay: 1
            });
            setTimeout(function () {
                $.post('/Controller/WorkCalendarSearch.ashx', {
                    ym: $("#dyear").val() + "-" + $("#dmonth").val()
                }, function (data) {
                    var dateInit = [];
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            dateInit.push(data[i].WorkDate);
                        }
                    }
                    $(".calendar-day").each(function (index, item) {
                        //$(item).addClass("calendar-selected");
                        //item.innerText
                        var ymd = item.abbr.split(',')
                        var y = ymd[0];
                        var m = parseInt(ymd[1]) < 10 ? "0" + parseInt(ymd[1]) : ymd[1];
                        var d = parseInt(ymd[2]) < 10 ? "0" + parseInt(ymd[2]) : ymd[2];
                        var flag = $.inArray(y + "-" + m + "-" + d, dateInit);
                        if (flag != -1) {
                            $(item).addClass("calendar-selected");

                        }
                    });
                }, "json");
            }, 100
            );
        }
        function setCalendar() {
            $('#cc').calendar({
                year: $("#dyear").val(),
                month: $("#dmonth").val(),
                firstDay: 1
            });
            setTimeout(function () {
                $.post('/Controller/WorkCalendarSearch.ashx', {
                    ym: $("#dyear").val() + "-" + $("#dmonth").val()
                }, function (data) {
                    var dateInit = [];
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            dateInit.push(data[i].WorkDate);
                        }
                    }
                    $(".calendar-day").each(function (index, item) {
                        //$(item).addClass("calendar-selected");
                        //item.innerText
                        var ymd = item.abbr.split(',')
                        var y = ymd[0];
                        var m = parseInt(ymd[1]) < 10 ? "0" + parseInt(ymd[1]) : ymd[1];
                        var d = parseInt(ymd[2]) < 10 ? "0" + parseInt(ymd[2]) : ymd[2];
                        var flag = $.inArray(y + "-" + m + "-" + d, dateInit);
                        if (flag != -1) {
                            $(item).addClass("calendar-selected");

                        }
                    });
                }, "json");
            }, 100
            );
        }
        function getShift() {
            $.post('/Controller/WorkShiftSearch.ashx', function (data) {
                    var dateInit = [];
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            dateInit.push(data[i].WorkDate);
                            $("#txtBegin" + data[i].ID).val(data[i].BeginTime);
                            $("#txtEnd" + data[i].ID).val(data[i].EndTime);
                        }
                    }                    
                }, "json");
        }
        function SaveShift() {
            var shift = "";
            for (var i = 1; i < 4; i++) {
                shift+="|0"+i+"_"+$("#txtBegin0"+i).val()+"_"+$("#txtEnd0"+i).val()
            }
            $.post('/Controller/WorkShiftEdit.ashx', {
                ymdList: shift
            }, function (data) {
                if (data == "0") {
                    $("#msgShift").html("设置班次失败！");
                }
                else if (data == "1") {
                    $("#msgShift").html("设置班次成功！");
                }

            }, "json");
        }

        function getRest() {           
            $("#dataSheet").datagrid({
                url: "/Controller/RestSearch.ashx",
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
                        field: 'ShiftCode', width: 50, title: '班次', align: 'center', editor: {
                            type: 'validatebox',
                            options: {
                                required: true,
                                validType: ['text', 'length[0,32]']
                            }
                        }
                    },
                    {
                        field: 'ShiftName', width: 60, align: 'center', title: '名称', editor: {
                            type: 'validatebox',
                            options: {
                                required: true,
                                validType: ['text', 'length[0,32]']
                            }
                        }
                    },
                    {
                        field: 'BeginTime', width: 80, title: '开始时间', align: 'center', editor: {
                            type: 'validatebox',
                            options: {
                                required: true,
                                validType: ['text', 'length[0,32]']
                            }
                        }
                    },
                    {
                        field: 'EndTime', width: 80, align: 'center', title: '结束时间', editor: {
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
                //var ed = $('#dataSheet').datagrid('getEditor', { index: editIndex, field: 'FaultType' });
                //var FaultType = $(ed.target).combobox('getText');
                //$('#dataSheet').datagrid('getRows')[editIndex]['FaultType'] = FaultType;
                $('#dataSheet').datagrid('endEdit', editIndex);
                if (optype == "C") {
                    editIndex = undefined;
                    return true;
                }
                else if (optype == "E") {
                    if ($('#dataSheet').datagrid('getRows')[editIndex]['ShiftCode'].length > 32) {
                        $("#msgSheet").html("班次长度超过了32字符！");
                        editIndex = undefined;
                        return false;
                    }
                    if ($('#dataSheet').datagrid('getRows')[editIndex]['ShiftName'].length > 32) {
                        $("#msgSheet").html("名称长度超过了32字符！");
                        editIndex = undefined;
                        return false;
                    }
                    if ($('#dataSheet').datagrid('getRows')[editIndex]['BeginTime'].length > 32) {
                        $("#msgSheet").html("开始时间长度超过了32字符！");
                        editIndex = undefined;
                        return false;
                    }
                    if ($('#dataSheet').datagrid('getRows')[editIndex]['EndTime'].length > 32) {
                        $("#msgSheet").html("结束时间长度超过了32字符！");
                        editIndex = undefined;
                        return false;
                    }
                    
                    var row = $('#dataSheet').datagrid('getRows')[editIndex];
                    var ID = row.ID == undefined ? "" : row.ID;                    
                    var ShiftCode = row.ShiftCode.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                    var ShiftName = row.ShiftName.replace('/\,/g', '，').replace('/\;/g', '；');
                    var BeginTime = row.BeginTime;
                    var EndTime = row.EndTime;
                    
                    if (ShiftCode.trim() == "" || ShiftName.trim() == "" || BeginTime.trim() == "" || EndTime.trim() == "") {
                        $("#msgSheet").html("各项目必须输入完成！");
                        return false;
                    }

                    $.post('/Controller/RestEdit.ashx', {
                        id: ID,
                        shiftCode: ShiftCode,
                        shiftName: ShiftName,
                        beginTime: BeginTime,
                        endTime: EndTime
                    }, function (data) {

                        if (data == "0") {
                            $("#msgSheet").html("小休信息保存失败！");
                            editIndex = undefined;
                            return false;
                        }
                        else {
                            $("#msgSheet").html("小休信息保存成功！");
                            getRest();
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
            var ShiftName = row.ShiftName.replace('/\,/g', '，').replace('/\;/g', '；');

            $.post('/Controller/RestDeletebyId.ashx', {
                id: ID,
                shiftName: ShiftName
            }, function (data) {
                if (data == "0") {
                    $("#msgSheet").html("删除小休失败！");
                }
                else {
                    $("#msgSheet").html("删除小休成功！");
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
    </script>
</asp:Content>
