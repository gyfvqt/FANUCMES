<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="PickList.aspx.cs" Inherits="SM.WEB.Views.MaterialCall.PickList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="/Scripts/fanuc.js"></script>
    <script src="/My97DatePicker/WdatePicker.js"></script>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="捡料单管理"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:物料拉动/捡料单管理</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span>查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 80px; overflow-y: auto;">                                
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">拣料单号:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="txtPickCode" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" />
                                    </div>
                                </div>
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">路径:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="txtDeliverWay" class="k-textbox" style="margin: 0 5px 5px 0; height: 26px; width: 150px;" />
                                    </div>
                                </div>
                                <div style="float: left; margin-top: 5px;">
                                    <span style="text-align: right; margin-top: 4px; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">创建人:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 26px; width: 150px; float: left;" id="UserName">
                                            <option value="" selected="selected">请选择</option>
                                        </select>
                                    </div>
                                </div>
                                <input type="button" class="button white-gradient" id="search" style="float: right; margin-right: 5px;" onclick="Search(1, 10); return false;" value="查  询" />
                                <div style="width:100%; float: left;">
                                    <span style="text-align: right; width: 90px; float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">拣料单生成时间    从:</span>
                                    <div style="float: left; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        <input id="CreateTimeB" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                        到 
                                                <input id="CreateTimeE" class="Wdate" style="border-color: #c5c5c5;" type="text" onclick="WdatePicker({ el: this, dateFmt: 'yyyy-MM-dd HH:mm:ss' })">
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </dd>
                    <dt id="list-filter"><span>物料落点列表</span></dt>
                    <dd id="listdd" style="display: block;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div>
                                <div class="with-small-padding" style="height: 258px; overflow-y: auto;">
                                    <div class="easyui-panel">
                                        <div id="datapager" class="easyui-pagination">
                                        </div>
                                    </div>
                                    <div style="height: 220px;">
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

                </dl>
            </div>
        </div>
        <div style="display: block; float: left; margin-left: 15px;">
            <%--<input type="button" class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="updateUsedTime(); return false;" value="打印拣料单" />--%>
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">    
        var stopFirstChangeEvent = true;
        var wsid = "";
        $(document).ready(function () {
            getUser();
            Search(1, 10);

        });
        function Search(pageNumber, pageSize) {
            var PickCode = $("#txtPickCode").val();
            var DeliverWay = $("#txtDeliverWay").val();
            var Creator = $("#UserName").val();
            
            var CreateTimeB = $("#CreateTimeB").val();
            var CreateTimeE = $("#CreateTimeE").val();
            datagridfresh(pageNumber, pageSize, PickCode, DeliverWay, Creator, CreateTimeB, CreateTimeE);
        }
        function getUser() {
            $.post('/Controller/userSearch.ashx', { pageindex:1,pagesize:1000,userId:"",email:"",phoneNumber:"" }, function (data) {
                var ohtml = "";
                for (var i = 0; i < data.rows.length; i++) {
                    ohtml += '<option value="' +  data.rows[i].FirstName+data.rows[i].FirstName + '">' + data.rows[i].FirstName+data.rows[i].FirstName + '</option>';
                }
                //$("#selectStationId").html('<option value="" selected="selected">请选择</option>' + ohtml);
                $("#UserName").html('<option value="" selected="selected">请选择</option>' + ohtml);
            }, "json");
        }

        function datagridfresh(pageNumber, pageSize, PickCode, DeliverWay, Creator, CreateTimeB, CreateTimeE) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/PickListSeach.ashx', {
                pageindex: pageNumber, pagesize: pageSize,
                pickCode: PickCode,
                creator: Creator,                
                deliverWay: DeliverWay,
                
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
                            //{
                            //    field: 'ID', title: '操作', width: 30, align: 'center',
                            //    formatter: function (value, row, index) {
                            //        if (row.CallStatus == "关闭") {
                            //            return "";
                            //        }
                            //        else {
                            //            return '<input type="checkbox" name="dgcheckbox"  id="' + row.CallId + '">';
                            //        }
                            //    }
                            //},
                            {
                                field: 'PickCode', title: '拣料单号', width: 80, align: 'center',
                                formatter: function (value, row, index) {
                                    if (row.PickPdfUrl != "" && row.PickPdfUrl != undefined) {
                                        return '<a href="#" onclick="javascript:window.open(\'' + row.PickPdfUrl + '\')">' + row.PickCode + '</a>';
                                    }
                                    else {
                                        return row.PickCode;
                                    }
                                }
                            },
                            {
                                field: 'CreateTime', title: '生成时间', width: 120, align: 'center'
                            },
                            { field: 'DeliverWay', width: 100, title: '路径', align: 'center' },
                            { field: 'Creator', width: 100, title: '创建人', align: 'center' }
                            
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
                            //{
                            //    field: 'ID', title: '操作', width: 30, align: 'center',
                            //    formatter: function (value, row, index) {
                            //        if (row.CallStatus == "关闭") {
                            //            return "";
                            //        }
                            //        else {
                            //            return '<input type="checkbox" name="dgcheckbox"  id="' + row.CallId + '">';
                            //        }
                            //    }
                            //},
                            {
                                field: 'PickCode', title: '拣料单号', width: 80, align: 'center',
                                formatter: function (value, row, index) {
                                    if (row.PickPdfUrl != "" && row.PickPdfUrl != undefined) {
                                        return '<a href="#" onclick="javascript:window.open(\'' + row.PickPdfUrl + '\')">' + row.PickCode + '</a>';
                                    }
                                    else {
                                        return row.PickCode;
                                    }
                                }
                            },
                            {
                                field: 'CreateTime', title: '生成时间', width: 120, align: 'center'
                            },
                            { field: 'DeliverWay', width: 100, title: '路径', align: 'center' },
                            { field: 'Creator', width: 100, title: '创建人', align: 'center' }
                            
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
        function ClearAll() {
            $("#msg").html("");
            Search(1, 10);
        }
        function updateUsedTime() {
            var deleteid = "";
            var DeliverWay = [];
            var checkDeliverWay = "";
            var deliverway = "";
            $("#msg").html("");
            $("input[name='dgcheckbox']").each(function (j, item) {
                if (item.checked) {
                    deleteid += "|" + item.id;
                    if (checkDeliverWay != "" && item.value != deliverway) {
                        checkDeliverWay += "0";
                    }
                    else {
                        checkDeliverWay += "1";
                        deliverway = item.value;
                    }
                }
            });
            if (checkDeliverWay.indexOf("0") > -1) {
                $("#msg").html("不允许不同配送路径的叫料需求进行打印拣料单！");
                return false;
            }
            if (deleteid.trim() != "") {

                $.post('/Controller/CallListToPickList.ashx', { id: deleteid }, function (data) {

                    if (data == "0") {
                        $("#msg").html("打印拣料单失败！");
                    }
                    else {
                        $("#msg").html("打印拣料单成功！");
                        //打开文件
                        window.open(data);

                        ClearAll(1);
                    }
                }, "text");
            }
            else {
                $("#msg").html("请先选择数据！");
            }
        }
    </script>
</asp:Content>
