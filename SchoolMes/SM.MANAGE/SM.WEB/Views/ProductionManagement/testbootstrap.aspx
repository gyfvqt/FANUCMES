<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="testbootstrap.aspx.cs" Inherits="SM.WEB.Views.ProductionManagement.testbootstrap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<link href="/jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" />
    <link href="/jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
    <script src="/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>--%>
    <link href="/bootstrapdist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/bootstrap-table-dist/bootstrap-table.min.css" rel="stylesheet" />
    <script src="/bootstrapdist/js/bootstrap.min.js"></script>
    <script src="/bootstrap-table-dist/bootstrap-table.min.js"></script>
    <script src="/bootstrap-table-dist/locale/bootstrap-table-zh-CN.min.js"></script>
    <%--<script src="/Scripts/fanuc.js"></script>--%>
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="站点管理（PLC）"></asp:Label>
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
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:生产数据管理\站点管理（PLC）</span>
        </div>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode" id="accordionCannedReport">
                    <dt class="closed" id="list-section"><span id="PortalContent_lblTest">查询条件</span></dt>
                    <dd id="listfilterdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block; height: 80px; overflow-y: auto;">
                                <div>
                                    <div style="font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">
                                        站点编码:
                                    <input id="txtStationCode" type="text" style="margin: 0 5px 5px 0; height: 20px; width: 120px; border: solid 1px #ccc;" />
                                    </div>
                                    <div style="font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">
                                        站点名称:
                                    <input id="txtStationName" type="text" style="margin: 0 5px 5px 0; height: 20px; width: 120px; border: solid 1px #ccc;" />
                                    </div>
                                    <div style="font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444;">
                                        站点描述:
                                    <input id="txtStationDesc" type="text" style="margin: 0 5px 5px 0; height: 20px; width: 120px; border: solid 1px #ccc;" />
                                    </div>
                                    <div style="font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">
                                        站点类型:
                                    <input id="txtStationType" type="text" style="margin: 0 5px 5px 0; height: 20px; width: 120px; border: solid 1px #ccc;" />
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
                                <div class="with-small-padding" style="height: auto; overflow-y: auto;">
                                    <table id="datawin" style="width: auto; min-height: 180px;"></table>
                                    <%--<div id="gridWellToolbar">
                                        <a href="#" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="AddWell()">添加</a>
                                        <a href="#" class="easyui-linkbutton" iconcls="icon-edit" plain="true" onclick="EditWell()">编辑 </a>
                                        <a href="#" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="DeleteWell()">删除 </a>
                                    </div>--%>
                                </div>

                            </div>

                        </div>
                    </dd>
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">新增(编辑)产品</span></dt>
                    <dd id="listinputdd" style="display: none;">
                        <div class="RadAjaxPanel" style="display: block;">
                            <div style="margin-top: 5px; margin-left: 5px;">
                                <input id="txtid" style="display: none;" />
                                <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">产品编码:</div>
                                    <input id="ProductionId" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">产品名称:</div>
                                    <input id="ProductionName" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">产品型号:</div>
                                    <input id="ProductionType" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />

                                </div>
                                <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">产品图号:</div>
                                    <input id="ProductionSheet" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">对应线体:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="LineId">
                                        <option value="" selected="selected">请选择</option>
                                    </select><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">建议批量:</div>
                                    <input id="Batch" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span>

                                </div>
                                <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">仓位信息:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="StoreId">
                                        <option value="" selected="selected">请选择</option>
                                    </select><span style="color: red;">*</span><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">产品图片:</div>
                                    <input id="ProductionImg" class="k-textbox" type="file" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" />
                                    <input type="hidden" value="" id="hidProductionImg" /><br />
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">是否生效:</div>
                                    <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="IsEnable">
                                        <option value="1" selected="selected">是</option>
                                        <option value="0">否</option>
                                    </select>
                                </div>
                            </div>
                            <br />
                            <div style="margin-top: 5px; margin-left: 5px;">
                                <div style="float: left; margin-top: 5px; margin-left: 15px;">
                                    <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">产品描述:</div>
                                    <textarea id="ProductionDesc" maxlength="100" class="k-textbox" style="margin: 0 5px 5px 0; width: 220px; height: 100px;"></textarea>
                                </div>
                            </div>
                        </div>
                    </dd>
                </dl>

            </div>

        </div>
        <div style="display: block; float: left; margin-left: 15px;">
            <input type="button" class="button white-gradient" id="New" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(0); return false;" value="新  增" />
            <input type="button" class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save(); return false;" value="保  存" />
            <input type="button" class="button white-gradient" id="delete" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Delete(); return false;" value="删  除" />
            <input type="button" class="button white-gradient" id="cancel" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="ClearAll(1); return false;" value="取  消">
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <style type="text/css">
        .qbox {
            width: 95px;
            background-color: rgb(255,255,0);
        }
    </style>
    <script type="text/javascript">     

        $(function () {
            //1.初始化Table
            var oTable = new TableInit();
            oTable.Init();
            //2.初始化Button的点击事件
            var oButtonInit = new ButtonInit();
            oButtonInit.Init();
        }); var TableInit = function () {
            var oTableInit = new Object();
            //初始化Table
            oTableInit.Init = function () {
                $('#datawin').bootstrapTable({
                    url: '/Controller/StationSearch.ashx',         //请求后台的URL（*）
                    method: 'get',                      //请求方式（*）
                    //toolbar: '#toolbar',                //工具按钮用哪个容器
                    striped: true,                      //是否显示行间隔色
                    cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                    pagination: true,                   //是否显示分页（*）
                    sortable: false,                     //是否启用排序
                    sortOrder: "asc",                   //排序方式
                    queryParams: oTableInit.queryParams,//传递参数（*）
                    sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                    pageNumber: 1,                       //初始化加载第一页，默认第一页
                    pageSize: 10,                       //每页的记录行数（*）
                    pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                    search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                    strictSearch: true,
                    showColumns: true,                  //是否显示所有的列
                    showRefresh: true,                  //是否显示刷新按钮
                    minimumCountColumns: 2,             //最少允许的列数
                    clickToSelect: true,                //是否启用点击选中行
                    height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                    uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                    showToggle: true,                    //是否显示详细视图和列表视图的切换按钮
                    cardView: false,                    //是否显示详细视图
                    detailView: false,                   //是否显示父子表
                    columns: [{
                        checkbox: true
                    }, {
                        field: 'StationCode',
                        title: '站点编码'
                    }, {
                        field: 'StationName',
                        title: '上级部门'
                    }, {
                        field: 'StationType',
                        title: '部门级别'
                    }, {
                        field: 'StationDesc',
                        title: '描述'
                    },]
                });
            };

            //得到查询的参数
            oTableInit.queryParams = function (params) {
                var StationCode = $('#txtStationCode').val();
                var StationName = $('#txtStationName').val();
                var StationDesc = $('#txtStationDesc').val();
                var StationType = $('#txtStationType').val();
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    pagesize: params.limit,   //页面大小
                    pageindex: params.offset,  //页码
                    //departmentname: $("#txt_search_departmentname").val(),
                    //statu: $("#txt_search_statu").val()
                    stationCode:escape(StationCode),
                    StationName:escape(StationName),
                    StationType: escape(StationType),
                    StationDesc: escape(StationDesc)
                    //pageindex: escape(page),
                    //pagesize:escape(pageSize)
                };
                return temp;
            };
            return oTableInit;
        }; var ButtonInit = function () {
            var oInit = new Object();
            var postdata = {};
            oInit.Init = function () {
                //初始化页面上面的按钮事件
            };
            return oInit;
        };
        //$(document).ready(function () {
        //    //getLine();
        //    //getStore();
        //    //datagridfresh(1, 10, "", "", "");
        //    Search();
        //});
        ///初始化分页
        function Search() {
            //设置分页控件 
            Query(1, 10);

        }


        function Query(pageNumber, pageSize) {
            var StationCode = $('#txtStationCode').val();
            var StationName = $('#txtStationName').val();
            var StationDesc = $('#txtStationDesc').val();
            var StationType = $('#txtStationType').val();

            //var opts = $('#datawin').datagrid('options');
            var page = pageNumber;//获取页码
            var pageSize = pageSize;//获取每页多少记录
            var handler = "/Controller/StationSearch.ashx?stationCode=" + escape(StationCode)
                + "&StationName=" + escape(StationName)
                + "&StationType=" + escape(StationType)
                + "&StationDesc=" + escape(StationDesc)
                + "&pageindex=" + escape(page)
                + "&pagesize=" + escape(pageSize);
            $('#datawin').datagrid({
                //toolbar: "#gridWellToolbar",
                pagination: true,
                rownumbers: true,
                singleselect: false,
                fitColumns: true,
                //height: 'min-height:200px',
                loadMsg: '正在处理,请稍等。。。',
                emptyMsg: "<span>没有查询到数据</span>",
                url: handler,
                columns: [[
                    //{ field: 'rownum', width: 30, title: 'No' },
                    {
                        field: 'ID', title: '操作', width: 30, align: 'center',
                        formatter: function (value, row, index) {
                            return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                        }
                    },
                    { field: 'StationCode', title: '站点编码', width: 100 },
                    { field: 'StationName', title: '站点名称', width: 100 },
                    { field: 'StationDesc', title: '站点描述', width: 100 },
                    { field: 'StationType', title: '站点类型', width: 100 },
                    {
                        field: 'IsEnable', title: '是否生效', width: 100,
                        styler: function (value, row, index) {

                            return "background:rgb(255,0,0);color:rgb(255,255,255);width:100%;text-align:center;";


                        }
                    }
                ]]
            });
            //$('#datawin').datagrid('options').url = handler; //设置表格数据的来源URL
            var p = $('#datawin').datagrid('getPager');
            $(p).pagination({
                pageSize: 10, //每页显示的记录条数，默认为10 
                pageList: [10, 20, 30], //可以设置每页记录条数的列表 
                onSelectPage: function (pageNumber, pageSize) {
                    Query(pageNumber, pageSize);//分页查询
                }
            });
            $('#datawin').datagrid('reload'); //重新加载表格

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
        function getStore() {
            $.post('/Controller/storeSearch.ashx', { pageindex: 1, pagesize: 100, warehouseId: "", storeName: "", warehouseType: "" }, function (data) {

                if (data.rows[0].tips != "没有数据") {
                    var ohtml = '<option value="" selected="selected">请选择</option>';
                    for (var i = 0; i < data.rows.length; i++) {
                        ohtml += '<option value="' + data.rows[i].ID + '">' + data.rows[i].StoreName + '</option>'
                    }
                    $("#StoreId").html(ohtml);
                }
            }, "json");
        }
        function Search1() {

            var ProductionId = $("#txtProductionId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ProductionName = $("#txtProductionName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var ProductionType = $("#txtProductionType").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            datagridfresh(1, 10, ProductionId, ProductionName, ProductionType);
        }

        function datagridfresh(pageNumber, pageSize, ProductionId, ProductionName, ProductionType) {
            $("#datawin").datagrid("loading");
            $.post('/Controller/productionSearch.ashx', { pageindex: pageNumber, pagesize: pageSize, productionId: ProductionId, productionName: ProductionName, productionType: ProductionType }, function (data) {
                if (data.rows[0].tips == "没有数据") {
                    $("#datawin").datagrid("loaded");
                    $("#datawin").datagrid({
                        //columns: [data.titleTable],   //动态取标题
                        emptyMsg: "<span>没有查询到数据，请调整一下查询条件！</span>",
                        columns: [[
                            { field: 'rownum', width: 30, title: 'No' },
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                }
                            },

                            {
                                field: 'ProductionId', title: '产品编码', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.ProductionId
                                        + '","' + row.ProductionName
                                        + '","' + row.ProductionType
                                        + '","' + row.ProductionSheet
                                        + '","' + row.LineId
                                        + '","' + row.Batch
                                        + '","' + row.StoreId
                                        + '","' + row.ProductionImg
                                        + '","' + row.ProductionDesc
                                        + '","' + row.IsEnable
                                        + '");\'>' + row.ProductionId + '</a>';
                                }
                            },
                            { field: 'ProductionName', width: 150, title: '产品名称', align: 'center' },
                            { field: 'ProductionType', width: 50, title: '产品型号', align: 'center' }


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
                        columns: [[
                            { field: 'rownum', width: 30, title: 'No' },
                            {
                                field: 'ID', title: '操作', width: 30, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<input type="checkbox" name="dgcheckbox"  id="' + row.ID + '">';
                                }
                            },

                            {
                                field: 'ProductionId', title: '产品编码', width: 120, align: 'center',
                                formatter: function (value, row, index) {
                                    return '<a href="#" onclick=\'javascript:Edit("' + row.ID
                                        + '","' + row.ProductionId
                                        + '","' + row.ProductionName
                                        + '","' + row.ProductionType
                                        + '","' + row.ProductionSheet
                                        + '","' + row.LineId
                                        + '","' + row.Batch
                                        + '","' + row.StoreId
                                        + '","' + row.ProductionImg
                                        + '","' + row.ProductionDesc
                                        + '","' + row.IsEnable
                                        + '");\'>' + row.ProductionId + '</a>';
                                }
                            },
                            { field: 'ProductionName', width: 150, title: '产品名称', align: 'center' },
                            { field: 'ProductionType', width: 50, title: '产品型号', align: 'center' }


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
                            var ProductionId = $("#txtProductionId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var ProductionName = $("#txtProductionName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            var ProductionType = $("#txtProductionType").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
                            datagridfresh(pageNumber, pageSize, ProductionId, ProductionName, ProductionType);
                        }
                    });
                }
            }, "json");
        }
        function Edit(ID, ProductionId, ProductionName, ProductionType, ProductionSheet,
            LineId, Batch, StoreId, ProductionImg, ProductionDesc, IsEnable) {
            $("#txtid").val(ID);
            $("#ProductionId").val(ProductionId);
            $("#ProductionName").val(ProductionName);
            $("#ProductionType").val(ProductionType);
            $("#ProductionSheet").val(ProductionSheet);
            $("#LineId").val(LineId);
            $("#Batch").val(Batch);
            $("#StoreId").val(StoreId);
            $("#hidProductionImg").val(ProductionImg);
            $("#ProductionDesc").val(ProductionDesc);
            $("#IsEnable").val(IsEnable);
            $("#ProductionId").attr("readonly", "readonly");
            $("#ProductionId").css("background", "rgb(194, 184, 184)");

            $("#listdd").hide();
            $("#listinputdd").show();
        }
        function ClearAll(obj) {
            $("#txtid").val("");
            $("#ProductionId").val("");
            $("#ProductionName").val("");
            $("#ProductionType").val("");
            $("#ProductionSheet").val("");
            $("#LineId").val("");
            $("#Batch").val("");
            $("#StoreId").val("");
            $("#hidProductionImg").val("");
            $("#ProductionDesc").val("");
            $("#IsEnable").val("1");

            $("#ProductionId").removeAttr("readonly");
            $("#ProductionId").css("background", "rgb(255, 255, 255)");
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
                if (confirm("确定删除数据？")) {
                    $.post('/Controller/productionDelete.ashx', { id: deleteid }, function (data) {

                        if (data == "0") {
                            $("#msg").html("*删除失败！");
                        }
                        else {
                            $("#msg").html("*删除成功！");
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



    </script>
</asp:Content>
