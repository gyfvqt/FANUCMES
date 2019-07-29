
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
    $.post('/Controller/AMTicketSearch.ashx', {
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
                        field: 'ID', title: '选择', width: 30, align: 'center',
                        formatter: function (value, row, index) {
                            return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                        }
                    },
                    {
                        field: 'XID', title: '', width: 60, align: 'center',
                        formatter: function (value, row, index) {
                            if (row.ExecuteStatus == "新建") {
                                return '<a href="#" onclick=\'javascript:SplitTicket("' + row.ID
                                    + '");\'>执行维护任务</a>';
                            }
                            else {
                                return "";
                            }
                        }
                    },
                    {
                        field: 'TicketNo', title: '维护任务编号', width: 100, align: 'center',
                        formatter: function (value, row, index) {
                            return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                + '","' + row.TicketNo
                                + '","' + row.TicketName
                                + '","' + row.TicketDesc                                
                                + '","' + row.UserId
                                + '","' + row.Creator                                
                                + '","Edit");\'>' + row.TicketNo + '</a>';
                        }
                    },
                    { field: 'TicketName', width: 160, title: '维护任务名称', align: 'center' },
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
                        field: 'ID', title: '选择', width: 30, align: 'center',
                        formatter: function (value, row, index) {
                            return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                        }
                    },
                    {
                        field: 'XID', title: '', width: 60, align: 'center',
                        formatter: function (value, row, index) {
                            if (row.ExecuteStatus == "新建") {
                                return '<a href="#" onclick=\'javascript:SplitTicket("' + row.ID
                                    + '");\'>执行维护任务</a>';
                            }
                            else {
                                return "";
                            }
                        }
                    },
                    {
                        field: 'TicketNo', title: '维护任务编号', width: 100, align: 'center',
                        formatter: function (value, row, index) {
                            return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                + '","' + row.TicketNo
                                + '","' + row.TicketName
                                + '","' + row.TicketDesc
                                + '","' + row.UserId
                                + '","' + row.Creator
                                + '","Edit");\'>' + row.TicketNo + '</a>';
                        }
                    },
                    { field: 'TicketName', width: 160, title: '维护任务名称', align: 'center' },
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

function Edit(ID, TicketNo, FaultName, FaultDesc,  UserId, Creator, xtype) {
    $("#txtid").val(ID);
    $("#TicketNo").val(TicketNo);    
    $("#FaultName").val(FaultName);
    $("#FaultDesc").val(FaultDesc);
    $("#UserId").val(UserId);
    $("#msg").html();
    $("#msgbase").html();
    $("#msgPinlv").html();
    $("#msgAP").html();
    $("#msgUP").html();
    $("#msgSheet").html();
    if (xtype == "Edit") {        
        $("#FaultName").removeAttr("readonly");
        $("#FaultName").css("background", "rgb(255, 255, 255)");
        $("#FaultDesc").removeAttr("readonly");
        $("#FaultDesc").css("background", "rgb(255, 255, 255)");
        $("#UserId").removeAttr("disabled");
        $("#UserId").css("background", "rgb(255, 255, 255)");
        
    }
    else if (xtype == "Execute") {
        
        $("#FaultName").attr("readonly", "readonly");
        $("#FaultName").css("background", "rgb(194, 184, 184)");
        $("#FaultDesc").attr("readonly", "readonly");
        $("#FaultDesc").css("background", "rgb(194, 184, 184)");
        $("#UserId").attr("disabled", "disabled");
        $("#UserId").css("background", "rgb(194, 184, 184)");        
    }
    //$("#listdd").hide();
    $("#listinputdd").show();
    $("#ddPinlv").show();
    $("#ddSheet").show();
    $("#ddAP").show();
    $("#ddUP").show();
    getPinlv(ID);
    getAPBySid(ID);
    getUPBySid(ID);
    getPrcesssheetbyid(ID);
    
}
function ClearAll(obj) {
    wsid = "";
    $("#txtid").val("");
    $("#TicketNo").val("");    
    $("#FaultName").val("");
    $("#FaultDesc").val("");
    $("#UserId").val("");
    
    $("#FaultName").removeAttr("readonly");
    $("#FaultName").css("background", "rgb(255, 255, 255)");
    $("#FaultDesc").removeAttr("readonly");
    $("#FaultDesc").css("background", "rgb(255, 255, 255)");
    $("#UserId").removeAttr("disabled");
    $("#UserId").css("background", "rgb(255, 255, 255)");
    $("#divReturnLine").hide();
    $("#divReturn").hide();
    $("#msg").html();
    $("#msgbase").html();
    $("#msgPinlv").html();
    $("#msgAP").html();
    $("#msgUP").html();
    $("#msgSheet").html();

    $('#datawin').datagrid('clearSelections');

    if (obj == 1) {
        $("#listdd").show();
        $("#listinputdd").hide();        
        $("#ddSheet").hide();        
        $("#ddAP").hide();
        $("#ddUP").hide();
    }
    else if (obj == 0) {
        //$("#listdd").hide();
        $("#listinputdd").show();
    }
}
function SaveBase() {
    if ( $("#FaultName").val() == "" || $("#UserId").val().trim() == "") {
        $("#msgBase").html("带*的项目必须输入！");
        return false;
    }


    var ID = $("#txtid").val();
    var TicketNo = $("#TicketNo").val();    
    var FaultName = $("#FaultName").val();
    var FaultDesc = $("#FaultDesc").val();    
    var UserId = $("#UserId").val();

    $.post('/Controller/AMTicketEdit.ashx', {
        id: ID,
        faultName: FaultName,
        faultDesc: FaultDesc,
        faultReturn: "",        
        userId: UserId
    }, function (data) {

        if (data == "0") {            
            $("#msgbase").html("保存失败！");
        }
        else {
            $("#msgbase").html("保存成功！");
            Search(1, 10);
            $("#ddPinlv").show();
            $("#txtid").val(data);
            $.scrollTo('#msgPinlv', 500);
            getPinlv(data);
        }
    }, "text");
}
function Rday() {
    $("#divWeek").hide();
    $("#divYM").hide();
    $("#divY").hide();
}
function Rweek() {
    $("#divWeek").show();
    $("#divYM").hide();
    $("#divY").hide();
}
function Rmonth() {
    $("#divWeek").hide();
    $("#divYM").show();
    $("#divY").hide();
}
function Ryear() {
    $("#divWeek").hide();
    $("#divYM").hide();
    $("#divY").show();
}
function getPinlv(ID) {
    $.post('/Controller/AMConfigurationsSearch.ashx', { id: ID }, function (data) {
        if (data.length > 0) {
            switch (data[0].PeriodType) {
                case "每天":
                    Rday();
                    $("#rday").attr("checked", "checked");
                    break;
                case "每周":
                    Rweek();
                    $("#rweek").attr("checked", "checked");
                    $("#Xweek").val(data[0].Xweek);
                    var weeks = data[0].WeekDate.split('|');
                    
                    $("input[name='chkweek']").each(function (j, item) {
                        //if ($(item).is(':checked')) {
                        //    WeekDate += "|" + item.value;
                        //}
                        
                        if ($.inArray(item.value, weeks) > -1) {
                            $(item).attr("checked", "checked");
                        }
                    });
                    break;
                case "每月":
                    Rmonth();
                    $("#rmonth").attr("checked", "checked");
                    $("#mday").val(data[0].Day);
                    break;
                case "每年":
                    Ryear();
                    $("#ryear").attr("checked", "checked");
                    dayselect = data[0].Day;
                    $("#yearm").val(data[0].Month);
                    populateDaysx(data[0].Month);
                    $("#ymday").val(data[0].Day);
                    break;
            }
            $("#Btime").val(data[0].BeginDate);
            $("#Etime").val(data[0].EndDate);
        }
    }, "json");
}
function SavePinlv() {
    var ID = $("#txtid").val();
    var PeriodType = $('input:radio[name="pinlv"]:checked').val();
    var Xweek = "";
    var WeekDate = "";
    var Month = "";
    var Day = "";
    var BeginDate = $("#Btime").val();
    var EndDate = $("#Etime").val();
    var reg = /^\d+$/;
    switch (PeriodType) {
        case "每天":            
            break;
        case "每周":    
            Xweek=$("#Xweek").val();            
            $("input[name='chkweek']").each(function (j, item) {
                if ($(item).is(':checked')) {
                    WeekDate += "|" + item.value;
                }              
            });
            break;
        case "每月":
            
            if (!reg.test($("#mday").val())) {
                $("#msgPinlv").html("日期必须是数字！");
                return false;
            }
            if (parseInt($("#mday").val()) < 1 || parseInt($("#mday").val()) > 31) {
                $("#msgPinlv").html("日期范围为1-31日！");
                return false;
            }
            Day=$("#mday").val();
            break;
        case "每年":            
            Month=$("#yearm").val();
            Day = $("#ymday").val();           
            
            break;
    }
    $.post('/Controller/AMConfigurationEdit.ashx',  {
        ticketId: ID,
        periodType: PeriodType,
        xweek: Xweek,
        weekDate: WeekDate,
        month: Month,
        day: Day,
        beginDate: BeginDate,
        endDate: EndDate
    }, function (data) {
        if (data == "0") {
            $("#msgPinlv").html("设置维护任务周期失败！");
        }
        else {
            $("#ddAP").show();
            $.scrollTo('#msgAP', 500);            
            getAPBySid($("#txtid").val());

        }

    }, "json");
}

function getAPBySid(ID) {
    $("#dataAP").datagrid({
        url: "/Controller/AMEquipmentSearch.ashx?Id=" + ID,
        toolbar: "#tbAP",
        fitColumns: true,
        rownumbers: true,
        singleSelect: true,
        loadMsg: '加载中......',
        height: 'auto',
        onClickRow: onClickRowAP,
        emptyMsg: "<span>没有查询到数据</span>",
        showFooter: true,
        columns: [[

            {
                field: 'EquipmentCode', width: 100, title: '设备ID', align: 'center', editor: {
                    type: 'combotree',
                    options: {
                        url: "/Controller/EquipmentDataTrees.ashx",
                        //valueField: "value",
                        //textField: "text",
                        editable: false,
                        panelHeight: 100,
                        required: true
                    }
                }
            },
            {
                field: 'EquipmentName', width: 100, align: 'center', title: '设备名称'
            },
            {
                field: 'EquipmentDesc', width: 120, align: 'center', title: '设备描述'
            }
            ,
            {
                field: 'Team', width: 100, align: 'center', title: '班组'
            }

            //,
            //{
            //    field: 'EquipmentCode', width: 100, align: 'center', title: '机器编码'
            //}
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
var editIndexAP = undefined;
function endEditingAP(optype) {
    if (editIndexAP == undefined) { return true }
    if ($('#dataAP').datagrid('validateRow', editIndexAP)) {
        var ed = $('#dataAP').datagrid('getEditor', { index: editIndexAP, field: 'EquipmentCode' });
        var EquipmentCode = $(ed.target).combotree('getText');
        var EquipmentId = $(ed.target).combotree('getValue');
        $('#dataAP').datagrid('getRows')[editIndexAP]['EquipmentCode'] = EquipmentCode;
        $('#dataAP').datagrid('endEdit', editIndexAP);
        if (optype == "C") {
            editIndexAP = undefined;
            return true;
        }
        else if (optype == "E") {
            //if ($('#dataAP').datagrid('getRows')[editIndexAP]['ProcessDesc'].length > 100) {
            //    $("#msgAP").html("工艺描述长度超过了100字符！");
            //    return false;
            //}
            var row = $('#dataAP').datagrid('getRows')[editIndexAP];
            var ID = row.AQID == undefined ? "" : row.AQID;
            var TicketId = $("#txtid").val();
            
            $.post('/Controller/AMEquipmentEdit.ashx', {
                id: ID,
                ticketId: TicketId,                
                equipmentId: EquipmentId
            }, function (data) {

                if (data == "0") {
                    $("#msgAP").html("保存失败！");
                    editIndexAP = undefined;
                    return false;
                }
                else {
                    $("#msgAP").html("保存成功！");
                    //$('#dataAP').datagrid('getRows')[editIndexAP]['ProcessId'] = ID;
                    //$('#dataAP').datagrid('getRows')[editIndexAP]['PCStationId'] = PCStationId;
                    getAPBySid($("#txtid").val());
                    editIndexAP = undefined;
                    return true;
                }
            }, "text");
        }

    } else {
        return false;
    }
}
function onClickRowAP(index) {
    if (editIndexAP != index) {
        if (endEditingAP("C")) {
            $('#dataAP').datagrid('selectRow', index)
                .datagrid('beginEdit', index);
            editIndexAP = index;
        } else {
            $('#dataAP').datagrid('selectRow', editIndexAP);
        }
    }
}
function appendAP() {
    if (endEditingAP("C")) {
        $('#dataAP').datagrid('appendRow', { status: 'P' });
        editIndexAP = $('#dataAP').datagrid('getRows').length - 1;
        $('#dataAP').datagrid('selectRow', editIndexAP)
            .datagrid('beginEdit', editIndexAP);
    }
}
function removeitAP() {
    if (editIndexAP == undefined) { return }
    var row = $('#dataAP').datagrid('getRows')[editIndexAP];

    var ID = row.AQID == undefined ? "" : row.AQID;
    var EquipmentName = row.EquipmentName.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

    $.post('/Controller/AMEquipmentDelete.ashx', {
        id: ID,
        equipmentName: EquipmentName
    }, function (data) {
        if (data == "0") {
            $("#msgAP").html("删除维护设备失败！");
            editIndexAP = undefined;
        }
        else {
            $("#msgAP").html("删除维护设备成功！");
            $('#dataAP').datagrid('cancelEdit', editIndexAP)
                .datagrid('deleteRow', editIndexAP);
            editIndexAP = undefined;
        }
    }, "text");

}
function acceptAP() {
    if (endEditingAP("E")) {
        $('#dataAP').datagrid('acceptChanges');
    }
}
function rejectAP() {
    $('#dataAP').datagrid('rejectChanges');
    editIndexAP = undefined;
}
function getChangesAP() {
    var rows = $('#dataAP').datagrid('getChanges');
    alert(rows.length + ' rows are changed!');
}
function SaveAP() {
    $("#ddUP").show();
    $.scrollTo('#msgUP', 500);
    getUPBySid($("#txtid").val());
}

function getUPBySid(ID) {
    $("#dataUP").datagrid({
        url: "/Controller/AMProcessSheetSearch.ashx?Id=" + ID,
        toolbar: "#tbUP",
        fitColumns: true,
        rownumbers: true,
        singleSelect: true,
        loadMsg: '加载中......',
        height: 'auto',
        
        emptyMsg: "<span>没有查询到数据</span>",
        showFooter: true,
        columns: [[
            {
                field: 'ID', title: '操作', width: 15, align: 'center',
                formatter: function (value, row, index) {
                    return '<input type="checkbox" name="upcheckbox"  id="' + row.ID + '">';
                }
            },
            {
                field: 'DOCName', width: 100, title: '附件名称', align: 'center', 
                formatter: function (value, row, index) {
                    return '<a href="' + row.URL+'"  target="_blank">' + row.DOCName + '</a>';
                }
            },
            {
                field: 'UpLoadTime', width: 100, align: 'center', title: '上传时间'
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
function DeleteAMSheet() {
    var deleteid = "";
    $("input[name='upcheckbox']").each(function (j, item) {
        if (item.checked) {
            deleteid += "|" + item.id;
        }
    });
    if (deleteid.trim() != "") {
        if (confirm("确定删除AM指导书数据？")) {
            $.post('/Controller/AMProcessSheetDelete.ashx', { id: deleteid }, function (data) {

                if (data == "0") {
                    $("#msgUP").html("删除AM指导书失败！");
                }
                else {
                    $("#msgUP").html("删除AM指导书成功！");
                    getUPBySid($("#txtid").val());
                }
            }, "json");
        }

    }
    else {
        $("#msgUP").html("*请先选择删除数据！");
    }
}
function Upload() {
    $("#file1").click();
}
function UploadProcessSheet() {
    var formData = new FormData();
    formData.append("myfile", document.getElementById("file1").files[0]);
    formData.append("sid", $("#txtid").val());

    $.ajax({
        url: "/Views/Fault/UpLoadSheet.ashx",
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
                $("#msgUP").html("上传AM指导书成功！");
                getUPBySid($("#txtid").val());
                var file = document.getElementById('file1');
                file.outerHTML = file.outerHTML;
            }
            if (data.status == "error") {
                $("#msgUP").html(data.msg);
            }

        },
        error: function (err) {
            $("#msgUP").html("上传AM指导书失败！");
        }
    });
}

function SaveUP() {
    $("#ddSheet").show();    
    $.scrollTo('#msgSheet', 500);
    getPrcesssheetbyid($("#txtid").val());
}

function getPrcesssheetbyid(ID) {    
    $("#dataSheet").datagrid({
        url: "/Controller/AMCommentAlarmSearch.ashx?Id=" + ID,
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
                field: 'AlarmContent', width: 100, title: '提醒内容', align: 'center', editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                        validType: ['text', 'length[0,32]']
                    }
                }
            },
            {
                field: 'Xdate', width: 50, align: 'center', title: '提前几天通知', editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                        validType: ['text', 'length[0,2]']
                    }
                }
            },
            {
                field: 'AlarmTime', width: 100, align: 'center', title: '提醒时间', editor: {
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
        //var ed = $('#dataSheet').datagrid('getEditor', { index: editIndex, field: 'ProcessType' });
        //var ProcessType = $(ed.target).combobox('getText');
        //$('#dataSheet').datagrid('getRows')[editIndex]['ProcessType'] = ProcessType;
        $('#dataSheet').datagrid('endEdit', editIndex);
        if (optype == "C") {
            editIndex = undefined;
            return true;
        }
        else if (optype == "E") {
            if ($('#dataSheet').datagrid('getRows')[editIndex]['AlarmContent'].trim() == "" ||
                $('#dataSheet').datagrid('getRows')[editIndex]['Xdate'] == "" ||
                $('#dataSheet').datagrid('getRows')[editIndex]['AlarmTime'] == "") {
                $("#msgSheet").html("所有项目不能为空！");
                editIndex = undefined;
                return false;
            }
            if ($('#dataSheet').datagrid('getRows')[editIndex]['AlarmContent'].length > 32) {
                $("#msgSheet").html("提醒内容超过了32字符！");
                editIndex = undefined;
                return false;
            }
            var reg = /^\d+$/;
            if (!reg.test($('#dataSheet').datagrid('getRows')[editIndex]['Xdate'])) {
                $("#msgSheet").html("提前天数应为数字！");
                editIndex = undefined;
                return false;
            }
            if (parseInt($('#dataSheet').datagrid('getRows')[editIndex]['Xdate']) < 0 || parseInt($('#dataSheet').datagrid('getRows')[editIndex]['Xdate']) > 5) {
                $("#msgSheet").html("提前天数应为1-5天内！");
                editIndex = undefined;
                return false;
            }
            if ($('#dataSheet').datagrid('getRows')[editIndex]['AlarmTime'].length>32) {
                $("#msgSheet").html("提醒时间超过了32字符！");
                editIndex = undefined;
                return false;
            }
            var row = $('#dataSheet').datagrid('getRows')[editIndex];
            var ID = row.ID == undefined ? "" : row.ID;            
            var TicketId = $("#txtid").val();
            var AlarmContent = row.AlarmContent;
            var Xdate = row.Xdate;
            var AlarmTime = row.AlarmTime;

            

            $.post('/Controller/AMCommentAlarmEdit.ashx', {
                id: ID,
                ticketId: TicketId,
                alarmContent: AlarmContent,
                xdate: Xdate,
                alarmTime: AlarmTime
            }, function (data) {

                if (data == "0") {
                    $("#msgSheet").html("日常维护任务提醒设置失败！");
                    return false;
                }
                else {
                    $("#msgSheet").html("日常维护任务提醒设置成功！");
                    //$('#dataSheet').datagrid('getRows')[editIndex]['ProcessId'] = ID;
                    //$('#dataSheet').datagrid('getRows')[editIndex]['PCStationId'] = PCStationId;
                    getPrcesssheetbyid($("#txtid").val());
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
    var AlarmContent = row.AlarmContent;

    $.post('/Controller/AMCommentAlarmDelete.ashx', {
        id: ID,
        alarmContent: AlarmContent
    }, function (data) {
        if (data == "0") {
            $("#msgSheet").html("删除失败！");
            editIndex = undefined;
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
function returnBase() {
    $.scrollTo("#list-filter", 500);
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
            $.post('/Controller/AMTicketDelete.ashx', { id: deleteid }, function (data) {

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

function SplitTicket(ID) {
    if (confirm("确定执行维护任务吗？")) {
        $.post('/Controller/AMTicketSplit.ashx', { id: ID }, function (data) {

            if (data == "0") {
                $("#msg").html("开始执行失败！");
            }
            else {
                $("#msg").html("开始执行成功！");
                Search(1, 10);
                ClearAll(1);
            }
        }, "json");
    }
}


function initForm() {
    document.getElementById("yearm").selectedIndex = 0;
    document.getElementById("yearm").onchange = populateDays;
}
function populateDays() {
    var monthDays = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    var monthStr = this.options[this.selectedIndex].value;
    if (monthStr != "") {
        var theMonth = parseInt(monthStr)-1;
        document.getElementById("ymday").options.length = 0;
        for (var i = 0; i < monthDays[theMonth]; i++) {
            document.getElementById("ymday").options[i] = new Option(i + 1);
        }
        $("#ymday").val(dayselect);
        dayselect = "";
    }
}
function populateDaysx(x) {
    var monthDays = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    //var monthStr = this.options[this.selectedIndex].value;
    if (x != "") {
        var theMonth = parseInt(x) - 1;
        document.getElementById("ymday").options.length = 0;
        for (var i = 0; i < monthDays[theMonth]; i++) {
            document.getElementById("ymday").options[i] = new Option(i + 1);
        }
        $("#ymday").val(dayselect);
        dayselect = "";
    }
}
