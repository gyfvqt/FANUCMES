
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
    $.post('/Controller/AMTicketSplitSearch.ashx', {
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
                        field: 'SID', title: '操作', width: 60, align: 'center',
                        formatter: function (value, row, index) {
                            return '<a href="#" onclick=\'javascript:Printx("' + row.SID
                                + '");\'>打印维护任务</a>';
                        }
                    },
                    {
                        field: 'TicketDetailCode', title: '维护任务编号', width: 100, align: 'center',
                        formatter: function (value, row, index) {
                            return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                + '","' + row.TicketDetailCode
                                + '","' + row.TicketName
                                + '","' + row.TicketDesc
                                + '","' + row.UserId
                                + '","' + row.TicketReturn
                                + '","' + row.SID
                                + '");\'>' + row.TicketDetailCode + '</a>';
                        }
                    },
                    { field: 'TicketName', width: 160, title: '维护任务名称', align: 'center' },
                    { field: 'Stratus', width: 100, title: '任务状态', align: 'center' },
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
                        field: 'SID', title: '操作', width: 60, align: 'center',
                        formatter: function (value, row, index) {
                            return '<a href="#" onclick=\'javascript:Printx("' + row.SID
                                + '");\'>打印维护任务</a>';
                        }
                    },
                    {
                        field: 'TicketDetailCode', title: '维护任务编号', width: 120, align: 'center',
                        formatter: function (value, row, index) {
                            return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                + '","' + row.TicketDetailCode
                                + '","' + row.TicketName
                                + '","' + row.TicketDesc
                                + '","' + row.UserId
                                + '","' + row.TicketReturn
                                + '","' + row.SID
                                + '");\'>' + row.TicketDetailCode + '</a>';
                        }
                    },
                    { field: 'TicketName', width: 160, title: '维护任务名称', align: 'center' },
                    { field: 'Stratus', width: 100, title: '任务状态', align: 'center' },
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

function Edit(ID, TicketNo, FaultName, FaultDesc, UserId, TicketReturn, SID) {   
    $("#datawin").datagrid("loading");
    $("#txtid").val(ID);
    $("#txtsid").val(SID);
    $("#TicketNo").val(TicketNo);
    $("#FaultName").val(FaultName);
    $("#FaultDesc").val(FaultDesc);
    $("#UserId").val(UserId);
    $("#FaultReturn").val(TicketReturn);
    //$("#listdd").hide();
    $("#listinputdd").show();   
    $("#ddAP").show();
    $("#ddUP").show();    
    getAPBySid(ID);
    getUPBySid(ID);  
    $("#datawin").datagrid("loaded");
}
function ClearAll(obj) {
    wsid = "";
    $("#txtid").val("");
    $("#TicketNo").val("");
    $("#FaultName").val("");
    $("#FaultDesc").val("");
    $("#UserId").val("");

    $('#datawin').datagrid('clearSelections');

    if (obj == 1) {
        $("#listdd").show();
        $("#listinputdd").hide();        
        $("#ddAP").hide();
        $("#ddUP").hide();
    }
    else if (obj == 0) {
        //$("#listdd").hide();
        $("#listinputdd").show();
    }
}

function getAPBySid(ID) {
    $("#dataAP").datagrid({
        url: "/Controller/AMEquipmentSearch.ashx?Id=" + ID,        
        fitColumns: true,
        rownumbers: true,
        singleSelect: true,
        loadMsg: '加载中......',
        height: 'auto',        
        emptyMsg: "<span>没有查询到数据</span>",
        showFooter: true,
        columns: [[

            {
                field: 'EquipmentCode', width: 100, title: '设备ID', align: 'center'
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


function getUPBySid(ID) {
    $("#dataUP").datagrid({
        url: "/Controller/AMProcessSheetSearch.ashx?Id=" + ID,        
        fitColumns: true,
        rownumbers: true,
        singleSelect: true,
        loadMsg: '加载中......',
        height: 'auto',
        emptyMsg: "<span>没有查询到数据</span>",
        showFooter: true,
        columns: [[
            
            {
                field: 'DOCName', width: 100, title: '附件名称', align: 'center',
                formatter: function (value, row, index) {
                    return '<a href="' + row.URL + '"  target="_blank">' + row.DOCName + '</a>';
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

function SaveCompleted(xtype) {
    var ID = $("#txtsid").val();    
    var TicketReturn = $("#FaultReturn").val();
    var ExecuteStatus = xtype == 0 ? "执行" : "完成";    

    $.post('/Controller/AMTicketExcute.ashx', {
        id: ID,
        ticketReturn: TicketReturn,
        executeStatus: ExecuteStatus
    }, function (data) {

        if (data == "0") {
            $("#msgbase").html("保存失败！");
        }
        else {
            $("#msgbase").html("保存成功！");
            Search(1, 10);
        }
    }, "text");
}

function Printx(ID) {
    $("#datawin").datagrid("loading");
    $.post('/Controller/AMTicketPrint.ashx', { id: ID }, function (data) {

        if (data == "0") {
            $("#msg").html("打印日常任务维护单失败！");
        }
        else {
            //$("#msg").html("打印日常任务维护成功！");
            //打开文件
            window.open(data);
            $("#datawin").datagrid("loaded");
            ClearAll(1);
        }
    }, "text");
}