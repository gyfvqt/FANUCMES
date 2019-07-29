function Search() {
    var StationCode = $('#txtStationCode').val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var StationName = $('#txtStationName').val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var StationDesc = $('#txtStationDesc').val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var StationType = $('#txtStationType').val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    datagridfresh(1, 10, StationCode, StationName, StationDesc, StationType);
}
function datagridfresh(pageNumber, pageSize, StationCode, StationName, StationDesc, StationType) {
    $("#datawin").datagrid("loading");
    $.post('/Controller/StationSearch.ashx',
        {
            pageindex: pageNumber,
            pagesize: pageSize,
            stationCode: StationCode,
            stationName: StationName,
            stationType: StationType,
            stationDesc: StationDesc
        }, function (data) {
            if (data.rows[0].tips != "没有数据") {
                $("#datawin").datagrid("loaded");
                $("#datawin").datagrid({
                    //view: detailview,
                    //detailFormatter: function (index, row) {
                    //    return '<div style="padding:5px"><table class="ddv"></table></div>';
                    //},
                    //onExpandRow: function (index, row) {
                    //    getFItemDetail(index, row);
                    //},
                    rownumbers: true,
                    singleselect: false,
                    fitColumns: true,
                    emptyMsg: "<span>没有查询到数据，请调整一下查询条件！</span>",
                    columns: [[
                        {
                            field: 'ID', title: '操作', width: 15, align: 'center',
                            formatter: function (value, row, index) {
                                return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                            }
                        },
                        {
                            field: 'StationCode', title: '站点编码', width: 100,
                            formatter: function (value, row, index) {
                                return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                    + '","' + row.StationType
                                    + '");\'>' + row.StationCode + '</a>';
                            }
                        },
                        { field: 'StationName', title: '站点名称', width: 100 },
                        { field: 'StationDesc', title: '站点描述', width: 100 },
                        { field: 'StationType', title: '站点类型', width: 100 },
                        {
                            field: 'IsEnable', title: '是否生效', width: 100,
                            formatter: function (value, row, index) {
                                if (value == "0") return "失效";
                                else if (value == "1") return "生效";
                            }
                            //styler: function (value, row, index) {

                            //    return "background:rgb(255,0,0);color:rgb(255,255,255);width:100%;text-align:center;";


                            //}
                        }
                    ]],

                    onLoadSuccess: function () {
                        $("#datawin").datagrid("loaded");
                        //var row = $("#datawin").datagrid("getRows");
                        //for (var r = 0; r < row.length; r++) {
                        //    $("#datawin").datagrid("expandRow", r);
                        //}
                    }
                });
                $("#datawin").datagrid("loadData", data.rows);  //动态取数据                    
                $('#datapager').pagination({
                    total: data.total,
                    pageSize: pageSize,
                    onSelectPage: function (pageNumber, pageSize) {
                        var StationCode = $('#txtStationCode').val();
                        var StationName = $('#txtStationName').val();
                        var StationDesc = $('#txtStationDesc').val();
                        var StationType = $('#txtStationType').val();
                        datagridfresh(pageNumber, pageSize, StationCode, StationName, StationDesc, StationType);
                    }
                });
            }
            else {
                $("#datawin").datagrid("loaded");
                $("#datawin").datagrid({
                    //view: detailview,
                    //detailFormatter: function (index, row) {
                    //    return '<div style="padding:5px"><table class="ddv"></table></div>';
                    //},
                    //onExpandRow: function (index, row) {
                    //    getFItemDetail(index, row);
                    //},
                    rownumbers: true,
                    singleselect: false,
                    fitColumns: true,
                    emptyMsg: "<span>没有查询到数据，请调整一下查询条件！</span>",
                    columns: [[
                        {
                            field: 'ID', title: '操作', width: 15, align: 'center',
                            formatter: function (value, row, index) {
                                return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                            }
                        },
                        {
                            field: 'StationCode', title: '站点编码', width: 100,
                            formatter: function (value, row, index) {
                                return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                    + '");\'>' + row.StationCode + '</a>';
                            }
                        },
                        { field: 'StationName', title: '站点名称', width: 100 },
                        { field: 'StationDesc', title: '站点描述', width: 100 },
                        { field: 'StationType', title: '站点类型', width: 100 },
                        {
                            field: 'IsEnable', title: '是否生效', width: 100,
                            formatter: function (value, row, index) {
                                if (value == "0") return "失效";
                                else if (value == "1") return "生效";
                            }
                            //styler: function (value, row, index) {

                            //    return "background:rgb(255,0,0);color:rgb(255,255,255);width:100%;text-align:center;";


                            //}
                        }
                    ]],

                    onLoadSuccess: function () {
                        $("#datawin").datagrid("loaded");
                        //var row = $("#datawin").datagrid("getRows");
                        //for (var r = 0; r < row.length; r++) {
                        //    $("#datawin").datagrid("expandRow", r);
                        //}
                    }
                });
                $("#datawin").datagrid("loadData", []);  //动态取数据  
            }
        }, "json");
}


function getLine() {
    $.post('/Controller/LineSearch.ashx', { pageindex: 1, pagesize: 100, lineId: "", lineName: "", lineType: "" }, function (data) {

        if (data.rows[0].tips != "没有数据") {
            var ohtml = '<option value="" selected="selected">请选择</option>';
            for (var i = 0; i < data.rows.length; i++) {
                ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].LineName + '</option>'
            }
            $("#LineId").html(ohtml);
        }
    }, "json");
}

function getPlcTemplate() {
    $.post('/Controller/PLCTemplateInfoSearch.ashx', { Id: "" }, function (data) {
        //if (data.rows[0].tips != "没有数据") {
            var ohtml = '<option value="" selected="selected">请选择</option>';
            for (var i = 0; i < data.length; i++) {
                ohtml += '<option value="' + data[i].ID + '">' + data[i].PLCTemplateName + '</option>';
            }
            $("#PLCTemplateId").html(ohtml);
        //}
    }, "json");
}
function selectChangeIsfirst(obj) {
    if ($(obj).val() == "标准站点") {
        $("#isfirst").removeAttr("disabled");
    }
    else {
        $("#isfirst").attr("disabled", "disabled");
        $("#isfirst").attr("checked", false);
    }
}
function getStationByid(ID) {
    $.post('/Controller/StationById.ashx', { id: ID }, function (data) {
        if (data.rows[0].tips != "没有数据") {
            $("#LineId").val(data.rows[0].LineId);
            $("#StationType").val(data.rows[0].StationType);
            $("#StationCode").val(data.rows[0].StationCode);
            $("#StationName").val(data.rows[0].StationName);
            $("#StationPosition").val(data.rows[0].StationPosition);
            $("#Team").val(data.rows[0].Team);
            $("#StationDesc").val(data.rows[0].StationDesc);
            $("#IP").val(data.rows[0].IP);
            //if (data.rows[0].StationType=="PLC" && data.rows[0].StationPosition == "标准站点") {
            //    $("#isfirst").removeAttr("disabled");
            //}
            $("#EquipmentId").combotree('setValue', data.rows[0].StationAsset);
            $("#isfirst").val(data.rows[0].IsFirstStation);

            if (data.rows[0].ProcessSheet != "") {
                $("#upload").val("◎上传作业指导书");
            }
            else {
                $("#upload").val("上传作业指导书");
            }

            $("#LineId").attr("disabled", "disabled");
            $("#LineId").css("background", "rgb(194, 184, 184)");
            $("#StationType").attr("disabled", "disabled");
            $("#StationType").css("background", "rgb(194, 184, 184)");
            if (data.rows[0].StationType == "PC") {
                $("#IP").attr("readonly", "readonly");
                $("#IP").css("background", "rgb(194, 184, 184)");
            }
            else {
                $("#IP").removeAttr("readonly");
                $("#IP").css("background", "rgb(255, 255, 255)");
            }
        }
    }, "json");
}
function SaveBase() {
    var ID = $("#txtid").val();
    var LineId = $("#LineId").val();
    var StationType = $("#StationType").val();
    var StationCode = $("#StationCode").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var StationName = $("#StationName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var StationPosition = $("#StationPosition").val();
    var Team = $("#Team").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var StationDesc = $("#StationDesc").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var IP = $("#IP").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var StationAsset = $("#EquipmentId").combotree('getValue');
    var IsFirst = $("#isfirst").val();

    if ($("#LineId").val().trim() == "" || $("#StationType").val().trim() == "" || $("#StationName").val().trim() == "" || $("#StationPosition").val().trim() == "") {
        $("#msgbase").html("带*的项目必须输入！");
        return false;
    }
    //var reg = /^\d+$/;
    //if (!reg.test($("#Batch").val())) {
    //    $("#msgbase").html("建议批次应为数字！");
    //    return false;
    //}
    $.post('/Controller/StationBaseEdit.ashx', {
        id: ID,
        stationPosition: StationPosition,
        stationType: StationType,
        stationCode: StationCode,
        stationName: StationName,
        lineId: LineId,
        team: Team,
        stationDesc: StationDesc,
        ip: IP,
        isfirst: IsFirst,
        stationAsset: StationAsset
    }, function (data) {
        if (data == "-1") {
            //ajaxLoadEnd();
            //alert("保存失败！");
            $("#msgbase").html("已经存在一个站点关联产品序列号和生产订单！");
        }
        else if (data == "0") {
            //ajaxLoadEnd();
            //alert("保存失败！");
            $("#msgbase").html("保存失败！");
        }
        else {
            $("#msgbase").html("保存成功！");
            $("#txtid").val(data);

            if ($("#StationType").val() == "PC") {
                $("#ddSheet").show();
                $("#btnSheet").show();
                $("#btnReturn").hide();
                $.scrollTo('#msgSheet', 500);
                getPrcesssheetbyid($("#txtid").val());
            }
            if ($("#StationType").val() == "PLC") {
                $("#ddPLCTemplate").show();
                $.scrollTo('#msgPLCTemplate', 500);
                getPLCTemplateByid($("#txtid").val());
            }
            Search();
            //ClearAll(1);
        }
    }, "json");

}

function getPrcesssheetbyid(ID) {
    var stype = [{ "value": "装配", "text": "装配" }, { "value": "拧紧", "text": "拧紧" }, { "value": "追溯", "text": "追溯" }];//json格式

    $("#dataSheet").datagrid({
        url: "/Controller/StationProcessByid.ashx?Id=" + ID,
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
            //{
            //    field: 'ProcessId', width: 30, title: '操作', align: 'center',
            //    formatter: function (value, row, index) {
            //        return '<a href="#" class="easyui-linkbutton" iconcls="icon-add" plain="true" style="font-weight: bold;  text-transform: uppercase; font-size: 18px; color: #00ff00;" title="新增" onclick="append()"> + </a>' +
            //            //' <a href="#" class="easyui-linkbutton" iconcls="icon-edit" plain="true" title="编辑"  onclick="EditWell("' + row.ProcessId + '")"> </a>' +
            //            '<a href="#" class="easyui-linkbutton" iconcls="icon-remove" plain="true" style="font-weight: bold;  text-transform: uppercase; font-size: 14px; color: #ff0000;" title="删除"  onclick="removeit()")">X</a>';
            //    }
            //},

            {
                field: 'ProcessName', width: 100, title: '工艺名称', align: 'center', editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                        validType: ['text', 'length[0,32]']
                    }
                }
            },
            {
                field: 'ProcessDesc', width: 150, align: 'center', title: '工艺描述', editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                        validType: ['text', 'length[0,100]']
                    }
                }
            },
            {
                field: 'ProcessType', width: 100, align: 'center', title: '工艺类型', editor: {
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
        var ed = $('#dataSheet').datagrid('getEditor', { index: editIndex, field: 'ProcessType' });
        var ProcessType = $(ed.target).combobox('getText');
        $('#dataSheet').datagrid('getRows')[editIndex]['ProcessType'] = ProcessType;
        $('#dataSheet').datagrid('endEdit', editIndex);
        if (optype == "C") {
            editIndex = undefined;
            return true;
        }
        else if (optype == "E") {
            if ($('#dataSheet').datagrid('getRows')[editIndex]['ProcessName'].length > 32) {
                $("#msgSheet").html("工艺名称长度超过了32字符！");
                return false;
            }
            if ($('#dataSheet').datagrid('getRows')[editIndex]['ProcessDesc'].length > 100) {
                $("#msgSheet").html("工艺描述长度超过了100字符！");
                return false;
            }
            var row = $('#dataSheet').datagrid('getRows')[editIndex];
            var ID = row.ProcessId == undefined ? "" : row.ProcessId;
            var PCStationId = $("#txtid").val();
            var ProcessName = row.ProcessName.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ProcessDesc = row.ProcessDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            ProcessType = row.ProcessType;

            if (ProcessName.trim() == "") {
                $("#msgSheet").html("工艺名称必须输入！");
                return false;
            }

            $.post('/Controller/StationProcessEdit.ashx', {
                id: ID,
                pcStationId: PCStationId,
                processName: ProcessName,
                processDesc: ProcessDesc,
                processType: ProcessType
            }, function (data) {

                if (data == "0") {
                    $("#msgSheet").html("工艺信息保存失败！");
                    return false;
                }
                else {
                    $("#msgSheet").html("工艺信息保存成功！");
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

    var ID = row.ProcessId == undefined ? "" : row.ProcessId;
    var ProcessName = row.ProcessName.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

    $.post('/Controller/StationPrecessDeletebyid.ashx', {
        id: ID,
        processName: ProcessName
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
function SaveSheet() {
    if ($("#StationType").val() == "PC") {
        $("#ddProgress").show();
        getProgressbySid($("#txtid").val());
        $.scrollTo('#msgProgress', 500);
    }
    if ($("#StationType").val() == "PLC") {
        $("#ddPLCTemplate").show();
        getPrcesssheetbyid($("#txtid").val());
    }
}

function getProgressbySid(ID) {
    $("#dataProgress").datagrid({
        url: "/Controller/StationPCProcessBySid.ashx?Id=" + ID,
        toolbar: "#tbProgress",
        fitColumns: true,
        rownumbers: true,
        singleSelect: true,
        loadMsg: '加载中......',
        height: 'auto',
        onClickRow: onClickRowProgress,
        emptyMsg: "<span>没有查询到数据</span>",
        showFooter: true,
        columns: [[
            //{
            //    field: 'ProcessId', width: 30, title: '操作', align: 'center',
            //    formatter: function (value, row, index) {
            //        return '<a href="#" class="easyui-linkbutton" iconcls="icon-add" plain="true" style="font-weight: bold;  text-transform: uppercase; font-size: 18px; color: #00ff00;" title="新增" onclick="append()"> + </a>' +
            //            //' <a href="#" class="easyui-linkbutton" iconcls="icon-edit" plain="true" title="编辑"  onclick="EditWell("' + row.ProcessId + '")"> </a>' +
            //            '<a href="#" class="easyui-linkbutton" iconcls="icon-remove" plain="true" style="font-weight: bold;  text-transform: uppercase; font-size: 14px; color: #ff0000;" title="删除"  onclick="removeit()")">X</a>';
            //    }
            //},

            {
                field: 'QualityDesc', width: 100, title: '过程质量描述', align: 'center', editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                        validType: ['text', 'length[0,32]']
                    }
                }
            },
            {
                field: 'QualityStandard', width: 150, align: 'center', title: '检验标准', editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                        validType: ['text', 'length[0,100]']
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
}
var editIndexProgress = undefined;
function endEditingProgress(optype) {
    if (editIndexProgress == undefined) { return true }
    if ($('#dataProgress').datagrid('validateRow', editIndexProgress)) {
        //var ed = $('#dataSheet').datagrid('getEditor', { index: editIndexProgress, field: 'ProcessType' });
        //var ProcessType = $(ed.target).combobox('getText');
        //$('#dataSheet').datagrid('getRows')[editIndex]['ProcessType'] = ProcessType;
        $('#dataProgress').datagrid('endEdit', editIndexProgress);
        if (optype == "C") {
            editIndexProgress = undefined;
            return true;
        }
        else if (optype == "E") {
            if ($('#dataProgress').datagrid('getRows')[editIndexProgress]['QualityDesc'].length > 32) {
                $("#msgProgress").html("过程质量描述长度超过了32字符！");
                return false;
            }
            if ($('#dataProgress').datagrid('getRows')[editIndexProgress]['QualityStandard'].length > 100) {
                $("#msgProgress").html("检验标准长度超过了100字符！");
                return false;
            }
            var row = $('#dataProgress').datagrid('getRows')[editIndexProgress];
            var ID = row.QualityId == undefined ? "" : row.QualityId;
            var PCStationId = $("#txtid").val();
            var QualityDesc = row.QualityDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var QualityStandard = row.QualityStandard.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            //var ProcessType = row.ProcessType;

            if (QualityDesc.trim() == "") {
                $("#msgProgress").html("过程质量描述必须输入！");
                return false;
            }

            $.post('/Controller/StationPCProcessEdit.ashx', {
                id: ID,
                pcStationId: PCStationId,
                qualityDesc: QualityDesc,
                qualityStandard: QualityStandard
            }, function (data) {

                if (data == "0") {
                    $("#msgProgress").html("保存失败！");
                    return false;
                }
                else {
                    $("#msgProgress").html("保存成功！");
                    //$('#dataSheet').datagrid('getRows')[editIndex]['ProcessId'] = ID;
                    //$('#dataSheet').datagrid('getRows')[editIndex]['PCStationId'] = PCStationId;
                    getProgressbySid($("#txtid").val());
                    editIndexProgress = undefined;
                    return true;
                }
            }, "text");
        }

    } else {
        return false;
    }
}
function onClickRowProgress(index) {
    if (editIndexProgress != index) {
        if (endEditingProgress("C")) {
            $('#dataProgress').datagrid('selectRow', index)
                .datagrid('beginEdit', index);
            editIndexProgress = index;
        } else {
            $('#dataProgress').datagrid('selectRow', editIndexProgress);
        }
    }
}
function appendProgress() {
    if (endEditingProgress("C")) {
        $('#dataProgress').datagrid('appendRow', { status: 'P' });
        editIndexProgress = $('#dataSheet').datagrid('getRows').length - 1;
        $('#dataProgress').datagrid('selectRow', editIndexProgress)
            .datagrid('beginEdit', editIndexProgress);
    }
}
function removeitProgress() {
    if (editIndexProgress == undefined) { return }
    var row = $('#dataProgress').datagrid('getRows')[editIndexProgress];

    var ID = row.QualityId == undefined ? "" : row.QualityId;
    var QualityDesc = row.QualityDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

    $.post('/Controller/StationPCProcessDeleteByid.ashx', {
        id: ID,
        qualityDesc: QualityDesc
    }, function (data) {
        if (data == "0") {
            $("#msgProgress").html("删除失败！");
        }
        else {
            $("#msgProgress").html("删除成功！");
            $('#dataProgress').datagrid('cancelEdit', editIndexProgress)
                .datagrid('deleteRow', editIndexProgress);
            editIndexProgress = undefined;
        }
    }, "text");

}
function acceptProgress() {
    if (endEditingProgress("E")) {
        $('#dataProgress').datagrid('acceptChanges');
    }
}
function rejectProgress() {
    $('#dataProgress').datagrid('rejectChanges');
    editIndexProgress = undefined;
}
function getChangesProgress() {
    var rows = $('#dataProgress').datagrid('getChanges');
    alert(rows.length + ' rows are changed!');
}
function SaveProgress() {
    if ($("#StationType").val() == "PC") {
        $("#ddTraceability").show();
        getTraceabilitySid($("#txtid").val());
        $.scrollTo('#msgTraceability', 500);
    }
    if ($("#StationType").val() == "PLC") {
        $("#ddPLCTemplate").show();
        getPrcesssheetbyid($("#txtid").val());
        $.scrollTo('#msgPLCTemplate', 500);
    }
}

function getTraceabilitySid(ID) {
    $("#dataTraceability").datagrid({
        url: "/Controller/StationTraceabilityBySid.ashx?Id=" + ID,
        toolbar: "#tbTraceability",
        fitColumns: true,
        rownumbers: true,
        singleSelect: true,
        loadMsg: '加载中......',
        height: 'auto',
        onClickRow: onClickRowTraceability,
        emptyMsg: "<span>没有查询到数据</span>",
        showFooter: true,
        columns: [[
            {
                field: 'TraceabilityDesc', width: 100, title: '零件名称', align: 'center', editor: {
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
}
var editIndexTraceability = undefined;
function endEditingTraceability(optype) {
    if (editIndexTraceability == undefined) { return true }
    if ($('#dataTraceability').datagrid('validateRow', editIndexTraceability)) {
        //var ed = $('#dataSheet').datagrid('getEditor', { index: editIndexTraceability, field: 'ProcessType' });
        //var ProcessType = $(ed.target).combobox('getText');
        //$('#dataSheet').datagrid('getRows')[editIndex]['ProcessType'] = ProcessType;
        $('#dataTraceability').datagrid('endEdit', editIndexTraceability);
        if (optype == "C") {
            editIndexTraceability = undefined;
            return true;
        }
        else if (optype == "E") {
            if ($('#dataTraceability').datagrid('getRows')[editIndexTraceability]['TraceabilityDesc'].length > 32) {
                $("#msgTraceability").html("过程质量描述长度超过了32字符！");
                return false;
            }

            var row = $('#dataTraceability').datagrid('getRows')[editIndexTraceability];
            var ID = row.TraceabilityId == undefined ? "" : row.TraceabilityId;
            var PCStationId = $("#txtid").val();
            var TraceabilityDesc = row.TraceabilityDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            //var QualityStandard = row.QualityStandard.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            //var ProcessType = row.ProcessType;

            if (TraceabilityDesc.trim() == "") {
                $("#msgTraceability").html("追溯零件信息必须输入！");
                return false;
            }

            $.post('/Controller/StationTraceabilityEdit.ashx', {
                id: ID,
                pcStationId: PCStationId,
                traceabilityDesc: TraceabilityDesc
            }, function (data) {

                if (data == "0") {
                    $("#msgTraceability").html("保存失败！");
                    return false;
                }
                else {
                    $("#msgTraceability").html("保存成功！");
                    //$('#dataSheet').datagrid('getRows')[editIndex]['ProcessId'] = ID;
                    //$('#dataSheet').datagrid('getRows')[editIndex]['PCStationId'] = PCStationId;
                    getTraceabilitySid($("#txtid").val());
                    editIndexTraceability = undefined;
                    return true;
                }
            }, "text");
        }

    } else {
        return false;
    }
}
function onClickRowTraceability(index) {
    if (editIndexTraceability != index) {
        if (endEditingTraceability("C")) {
            $('#dataTraceability').datagrid('selectRow', index)
                .datagrid('beginEdit', index);
            editIndexTraceability = index;
        } else {
            $('#dataTraceability').datagrid('selectRow', editIndexTraceability);
        }
    }
}
function appendTraceability() {
    if (endEditingTraceability("C")) {
        $('#dataTraceability').datagrid('appendRow', { status: 'P' });
        editIndexTraceability = $('#dataSheet').datagrid('getRows').length - 1;
        $('#dataTraceability').datagrid('selectRow', editIndexTraceability)
            .datagrid('beginEdit', editIndexTraceability);
    }
}
function removeitTraceability() {
    if (editIndexTraceability == undefined) { return }
    var row = $('#dataTraceability').datagrid('getRows')[editIndexTraceability];

    var ID = row.TraceabilityId == undefined ? "" : row.TraceabilityId;
    var TraceabilityDesc = row.TraceabilityDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

    $.post('/Controller/StationTraceabilityDeleteByid.ashx', {
        id: ID,
        traceabilityDesc: TraceabilityDesc
    }, function (data) {
        if (data == "0") {
            $("#msgTraceability").html("删除失败！");
        }
        else {
            $("#msgTraceability").html("删除成功！");
            $('#dataTraceability').datagrid('cancelEdit', editIndexTraceability)
                .datagrid('deleteRow', editIndexTraceability);
            editIndexTraceability = undefined;
        }
    }, "text");

}
function acceptTraceability() {
    if (endEditingTraceability("E")) {
        $('#dataTraceability').datagrid('acceptChanges');
    }
}
function rejectTraceability() {
    $('#dataTraceability').datagrid('rejectChanges');
    editIndexTraceability = undefined;
}
function getChangesTraceability() {
    var rows = $('#dataTraceability').datagrid('getChanges');
    alert(rows.length + ' rows are changed!');
}

function getPLCTemplateByid(ID) {
    $.post('/Controller/PLCTemplateOperationInfoSearchBySid.ashx', { id: ID }, function (data) {
        if (data != null && data.length>0) {
            $("#ID").val(data[0].ID);
            $("#PLCTemplateId").val(data[0].PLCTemplateId);
            $("#PLCDB").val(data[0].PLCDB);
            $("#PLCTrigger").val(data[0].PLCTrigger);
            $("#ActionCode").val(data[0].ActionCode);
            $("#CommunicateType").val(data[0].CommunicateType);
            $("#CommunicateName").val(data[0].CommunicateName);
            $("#CheckAddress").val(data[0].CheckAddress);
            $("#ReturnLength").val(data[0].ReturnLength);

        }
    }, "json");
}
function SavePLCTemplate() {
    $("#ddAP").show();
    var sID = $("#txtid").val();
    var ID = $("#ID").val();
    var PLCTemplateId = $("#PLCTemplateId").val();
    var PLCDB = $("#PLCDB").val();
    var PLCTrigger = $("#PLCTrigger").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var ActionCode = $("#ActionCode").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var CommunicateType = $("#CommunicateType").val();
    var CommunicateName = $("#CommunicateName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var CheckAddress = $("#CheckAddress").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var ReturnLength = $("#ReturnLength").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

    if ($("#PLCTemplateId").val().trim() == "" ||
        $("#PLCDB").val().trim() == "" ||
        $("#PLCTrigger").val().trim() == "" ||
        $("#ActionCode").val().trim() == "" ||
        $("#CommunicateType").val().trim() == "" ||
        $("#CommunicateName").val().trim() == "" ||
        $("#CheckAddress").val().trim() == "" ||
        $("#ReturnLength").val().trim() == "") {
        $("#msgPLCTemplate").html("带*的项目必须输入！");
        return false;
    }
    //var reg = /^\d+$/;
    //if (!reg.test($("#Batch").val())) {
    //    $("#msgbase").html("建议批次应为数字！");
    //    return false;
    //}
    $.post('/Controller/PLCTemplateOperationInfoEdit.ashx', {
        id: ID,
        plcStationId: sID,
        plcTemplateId: PLCTemplateId,
        plcDB: PLCDB,
        plcTrigger: PLCTrigger,
        communicateType: CommunicateType,
        checkAddress: CheckAddress,
        actionCode: ActionCode,
        communicateName: CommunicateName,
        returnLength: ReturnLength
    }, function (data) {

        if (data == "0") {            
            $("#msgPLCTemplate").html("模板信息保存失败！");
        }
        else {
            $.scrollTo('#msgAP', 500);
            $("#ID").val(data);         
            getAPBySid($("#txtid").val());
              
        }
    }, "json");
    
}

function getAPBySid(ID) {
    $("#dataAP").datagrid({
        url: "/Controller/PLCAPInfoSearch.ashx?Id=" + ID,
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
                field: 'PLCAPDBAddress', width: 100, title: 'PLC地址', align: 'center', editor: {
                    type: 'validatebox',
                    options: {
                        required: true
                    }
                }
            },
            //{
            //    field: 'APDataLength', width: 100, align: 'center', title: '数据长度', editor: {
            //        type: 'validatebox',
            //        options: {
            //            required: true                        
            //        }
            //    }
            //},
            {
                field: 'APDataDesc', width: 100, align: 'center', title: '数据描述', editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                        validType: ['text', 'length[0,100]']
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
var editIndexAP = undefined;
function endEditingAP(optype) {
    if (editIndexAP == undefined) { return true }
    if ($('#dataAP').datagrid('validateRow', editIndexAP)) {
        //var ed = $('#dataAP').datagrid('getEditor', { index: editIndexAP, field: 'ProcessType' });
        //var ProcessType = $(ed.target).combobox('getText');
        //$('#dataAP').datagrid('getRows')[editIndexAP]['ProcessType'] = ProcessType;
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
            var ID = row.PLCAPId == undefined ? "" : row.PLCAPId;
            var PLCStationId = $("#txtid").val();
            var PLCAPDBAddress = row.PLCAPDBAddress;
            //var APDataLength = row.APDataLength;
            var APDataDesc = row.APDataDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

            //if (APDataDesc.trim() == "") {
            //    $("#msgAP").html("A名称必须输入！");
            //    return false;
            //}

            $.post('/Controller/PLCAPInfoEdit.ashx', {
                id: ID,
                plcStationId: PLCStationId,
                plcAPDBAddress: PLCAPDBAddress,
                //apDataLength: APDataLength,
                apDataDesc: APDataDesc
            }, function (data) {

                if (data == "0") {
                    $("#msgAP").html("保存失败！");
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

    var ID = row.PLCAPId == undefined ? "" : row.PLCAPId;
    var APDataDesc = row.APDataDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

    $.post('/Controller/PLCAPInfoDeleteByid.ashx', {
        id: ID,
        apDataDesc: APDataDesc
    }, function (data) {
        if (data == "0") {
            $("#msgAP").html("删除AP信息失败！");
        }
        else {
            $("#msgAP").html("删除AP信息成功！");
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
        url: "/Controller/PLCUPInfoSearch.ashx?Id=" + ID,
        toolbar: "#tbUP",
        fitColumns: true,
        rownumbers: true,
        singleSelect: true,
        loadMsg: '加载中......',
        height: 'auto',
        onClickRow: onClickRowUP,
        emptyMsg: "<span>没有查询到数据</span>",
        showFooter: true,
        columns: [[

            {
                field: 'PLCUPDBAddress', width: 100, title: 'PLC地址', align: 'center', editor: {
                    type: 'validatebox',
                    options: {
                        required: true
                    }
                }
            },
            //{
            //    field: 'UPDataLength', width: 100, align: 'center', title: '数据长度', editor: {
            //        type: 'validatebox',
            //        options: {
            //            required: true
            //        }
            //    }
            //},
            {
                field: 'UPDataDesc', width: 100, align: 'center', title: '数据描述', editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                        validType: ['text', 'length[0,100]']
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
var editIndexUP = undefined;
function endEditingUP(optype) {
    if (editIndexUP == undefined) { return true }
    if ($('#dataUP').datagrid('validateRow', editIndexUP)) {
        //var ed = $('#dataUP').datagrid('getEditor', { index: editIndexUP, field: 'ProcessType' });
        //var ProcessType = $(ed.target).combobox('getText');
        //$('#dataUP').datagrid('getRows')[editIndexUP]['ProcessType'] = ProcessType;
        $('#dataUP').datagrid('endEdit', editIndexUP);
        if (optype == "C") {
            editIndexUP = undefined;
            return true;
        }
        else if (optype == "E") {
            //if ($('#dataUP').datagrid('getRows')[editIndexUP]['ProcessDesc'].length > 100) {
            //    $("#msgUP").html("工艺描述长度超过了100字符！");
            //    return false;
            //}
            var row = $('#dataUP').datagrid('getRows')[editIndexUP];
            var ID = row.PLCUPId == undefined ? "" : row.PLCUPId;
            var PLCStationId = $("#txtid").val();
            var PLCUPDBAddress = row.PLCUPDBAddress;
            //var UPDataLength = row.UPDataLength;
            var UPDataDesc = row.UPDataDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

            //if (ProcessName.trim() == "") {
            //    $("#msgUP").html("工艺名称必须输入！");
            //    return false;
            //}

            $.post('/Controller/PLCUPInfoEdit.ashx', {
                id: ID,
                plcStationId: PLCStationId,
                plcUPDBAddress: PLCUPDBAddress,
                //upDataLength: UPDataLength,
                upDataDesc: UPDataDesc
            }, function (data) {

                if (data == "0") {
                    $("#msgUP").html("保存UP信息失败！");
                    return false;
                }
                else {
                    $("#msgUP").html("保存UP信息成功！");
                    //$('#dataUP').datagrid('getRows')[editIndexUP]['ProcessId'] = ID;
                    //$('#dataUP').datagrid('getRows')[editIndexUP]['PCStationId'] = PCStationId;
                    getUPBySid($("#txtid").val());
                    editIndexUP = undefined;
                    return true;
                }
            }, "text");
        }

    } else {
        return false;
    }
}
function onClickRowUP(index) {
    if (editIndexUP != index) {
        if (endEditingUP("C")) {
            $('#dataUP').datagrid('selectRow', index)
                .datagrid('beginEdit', index);
            editIndexUP = index;
        } else {
            $('#dataUP').datagrid('selectRow', editIndexUP);
        }
    }
}
function appendUP() {
    if (endEditingUP("C")) {
        $('#dataUP').datagrid('appendRow', { status: 'P' });
        editIndexUP = $('#dataUP').datagrid('getRows').length - 1;
        $('#dataUP').datagrid('selectRow', editIndexUP)
            .datagrid('beginEdit', editIndexUP);
    }
}
function removeitUP() {
    if (editIndexUP == undefined) { return }
    var row = $('#dataUP').datagrid('getRows')[editIndexUP];

    var ID = row.PLCUPId == undefined ? "" : row.PLCUPId;
    var UPDataDesc = row.UPDataDesc.replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');

    $.post('/Controller/PLCUPInfoDeleteByid.ashx', {
        id: ID,
        UPDataDesc: UPDataDesc
    }, function (data) {
        if (data == "0") {
            $("#msgUP").html("删除UP信息失败！");
        }
        else {
            $("#msgUP").html("删除UP信息成功！");
            $('#dataUP').datagrid('cancelEdit', editIndexUP)
                .datagrid('deleteRow', editIndexUP);
            editIndexUP = undefined;
        }
    }, "text");

}
function acceptUP() {
    if (endEditingUP("E")) {
        $('#dataUP').datagrid('acceptChanges');
    }
}
function rejectUP() {
    $('#dataUP').datagrid('rejectChanges');
    editIndexUP = undefined;
}
function getChangesUP() {
    var rows = $('#dataUP').datagrid('getChanges');
    alert(rows.length + ' rows are changed!');
}
function SaveUP() {
    $("#ddSheet").show();
    $("#btnReturn").show();
    $("#btnSheet").hide();
    $.scrollTo('#msgSheet', 500);
    getPrcesssheetbyid($("#txtid").val());
}

function returnBase() {
    $.scrollTo("#list-filter", 500);
}

function Edit(ID, StationType) {
    $("#txtid").val(ID);
    $("#listdd").hide();
    $("#listinputdd").show();
    getStationByid(ID);
    getPrcesssheetbyid(ID);
    if (StationType == "PC") {        
        $("#ddSheet").show();
        $("#ddProgress").show();
        $("#ddTraceability").show();
        $("#ddAP").hide();
        $("#ddUP").hide();
        $("#ddPLCTemplate").hide();
        getPrcesssheetbyid(ID);
        getProgressbySid(ID);
        getTraceabilitySid(ID);
        $("#btnReturn").hide();
        $("#btnSheet").show();
    }
    else if (StationType == "PLC") {
        $("#ddSheet").show();
        $("#ddProgress").hide();
        $("#ddTraceability").hide();
        $("#ddAP").show();
        $("#ddUP").show();
        $("#ddPLCTemplate").show();
        getPLCTemplateByid(ID);
        getAPBySid(ID);
        getUPBySid(ID);
        getPrcesssheetbyid(ID);
        $("#btnReturn").show();
        $("#btnSheet").hide();
    }
    //getPrcesssheetbyid(ID);
}
function ClearAll(obj) {
    $("#txtid").val("");
    $("#LineId").val("");
    $("#StationType").val("");
    $("#StationCode").val("");
    $("#StationName").val("");
    $("#StationPosition").val("");
    $("#Team").val("");
    $("#StationDesc").val("");
    $("#IP").val("");
    $("#LineId").removeAttr("disabled");
    $("#LineId").css("background", "rgb(255, 255, 255)");
    $("#StationType").removeAttr("disabled");
    $("#StationType").css("background", "rgb(255, 255, 255)");

    $("#IP").removeAttr("readonly");
    $("#IP").css("background", "rgb(255, 255, 255)");
    $("#isfirst").val("0");
    //$("#isfirst").attr("disabled", "disabled");

    if (obj == 1) {
        $("#ddPLCTemplate").hide();
        $("#ddSheet").hide();
        $("#ddProgress").hide();
        $("#ddTraceability").hide();
        $("#ddAP").hide();
        $("#ddUP").hide();

        $("#listdd").show();
        Search();
        $("#listinputdd").hide();
    }
    else if (obj == 0) {
        $("#listdd").hide();
        $("#listinputdd").show();
    }
    $('#datawin').datagrid('clearSelections');
}
function Save() {
    if ($("#ProductionId").val().trim() == "" || $("#ProductionName").val().trim() == "" || $("#ProductionType").val().trim() == "" || $("#Batch").val().trim() == "") {
        $("#msg").html("带*的项目必须输入！");
        return false;
    }
    var reg = /^\d+$/;
    if (!reg.test($("#Batch").val())) {
        $("#msg").html("建议批次应为数字！");
        return false;
    }
    var ID = $("#txtid").val();
    var ProductionId = $("#ProductionId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var ProductionName = $("#ProductionName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var ProductionType = $("#ProductionType").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var ProductionSheet = $("#ProductionSheet").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var LineId = $("#LineId").val();
    var Batch = $("#Batch").val();
    var StoreId = $("#StoreId").val();
    var ProductionImg = $("#hidProductionImg").val();
    var ProductionDesc = $("#ProductionDesc").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
    var IsEnable = $("#IsEnable").val();


    $.post('/Controller/productionEdit.ashx', {
        id: ID,
        productionId: ProductionId,
        productionName: ProductionName,
        productionType: ProductionType,
        productionSheet: ProductionSheet,
        lineId: LineId,
        batch: Batch,
        storeId: StoreId,
        productionImg: ProductionImg,
        productionDesc: ProductionDesc,
        isEnable: IsEnable
    }, function (data) {

        if (data == "0") {
            //ajaxLoadEnd();
            //alert("保存失败！");
            $("#msg").html("*保存失败！");
        }
        else {
            $("#msg").html("*保存成功！");
            Search();
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
        if (confirm("确定删除站点数据？")) {
            $.post('/Controller/StationDelete.ashx', { id: deleteid }, function (data) {

                if (data == "0") {
                    $("#msg").html("删除站点失败！");
                }
                else {
                    $("#msg").html("删除站点成功！");
                    Search();
                    ClearAll(1);
                }
            }, "json");
        }

    }
    else {
        $("#msg").html("*请先选择删除数据！");
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
        url: "/Views/ProductionManagement/UploadProcessSheet.ashx",
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
               
                $("#msgSheet").html("上传作业指导书成功！");
                $("#upload").val("◎上传作业指导书");
                var file = document.getElementById('file1');
                file.outerHTML = file.outerHTML;
            }
            if (data.status == "error") {
                $("#msgSheet").html(data.msg);        
            }
            
        },
        error: function (err) {
            $("#msgSheet").html("上传失败！");            
        }
    });
}


function SetEnable() {
    var deleteid = "";
    $("input[name='dgcheckbox']").each(function (j, item) {
        if (item.checked) {
            deleteid += "|" + item.id;
        }
    });
    if (deleteid.trim() != "") {
        if (confirm("确定设置站点状态数据？")) {
            $.post('/Controller/StationEnable.ashx', { id: deleteid }, function (data) {

                if (data == "0") {
                    $("#msg").html("设置站点状态失败！");
                }
                else {
                    $("#msg").html("设置站点状态成功！");
                    Search();
                    ClearAll(1);
                }
            }, "json");
        }

    }
    else {
        $("#msg").html("*请先选择设置站点数据！");
    }
}

function getEquipment() {
    $("#EquipmentId").combotree({
        url: "/Controller/EquipmentDataTrees.ashx",
        required: true,
        editable: false
        //,
        //onSelect: function (rec) {
        //    $("#EquipmentDesc").val(rec.EquipmentDesc);
        //    $("#Team").val(rec.Team);
        //    $("#EquipmentCode").val(rec.EquipmentCode);
        //}
        //,
        //onChange:function (rec) {
        //    $("#EquipmentDesc").val(rec.EquipmentDesc);
        //    $("#Team").val(rec.Team);
        //    $("#EquipmentCode").val(rec.EquipmentCode);
        //}
    });
}