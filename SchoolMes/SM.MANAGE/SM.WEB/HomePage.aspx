<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="SM.WEB.HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label runat="server" ID="lblPage" Visible="false" Text="HomePage"></asp:Label>
    <section id="main" role="main">
        <style>
            .background {
                max-width: 100%;
                height: auto;
                position: relative;
                display: block;
                margin: 0 auto;
                text-align: center;
            }

                .background img {
                    /*width: 100%;*/
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
                width: 400px;
            }

                table.gridtable th {
                    padding: 4px;
                    color: #fff;
                    background: #385fba url(/StyleFiles/img/old-browsers/colors/bg_big-menu.png) repeat-x;
                    border-color: #385fba;
                    border-width: 1px;
                    border-style: solid;
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
                    border-color: #ccc;
                    background-color: #ffffff;
                    color: black;
                }

                    table.gridtable td a {
                        font-size: 12px;
                        color: #0640fb;
                        text-decoration: none;
                        position: static;
                    }

            .demo {
                filter: alpha(Opacity=80);
                -moz-opacity: 0.5;
                opacity: 0.5;
            }

            .content {
                font-size: 12px;
                color: #FFFFFF;
                text-decoration: none;
                position: relative;
            }
        </style>
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:主页</span>
        </div>
        <!--背景DIV-->
        <div id="bgx" class="background" style="text-align: center;">
            <img style="z-index: -1; margin: 0 auto;" src="/StyleFiles/bg.png">
        </div>
        <!--内容div-->
        <div style="position: absolute; top: 40px; left: 30px;">
            <table class="gridtable " id="AM">                
            </table>
        </div>
        <div style="position: absolute; top: 40px; left: 460px;">
            <table class="gridtable " id="hfault">                
            </table>
        </div>
        <div style="position: absolute; top: 230px; left: 30px;">
            <table class="gridtable " id="HFN">                
            </table>
        </div>
        <div style="position: absolute; top: 230px; left: 460px;">
            <table class="gridtable " id="cuttor">                
            </table>
        </div>
        <div style="position: absolute; top: 10px; right: 10px;">
            <img src="StyleFiles/img/slogo168.png" />
        </div>
    </section>
    <script type="text/javascript">
        var UserId =<%=dsuserinfo.Tables[0].Rows[0]["ID"].ToString()%>;
        $(document).ready(function () {
            var h = window.innerHeight - 100;
            $("#bgx").height(h);
            getHFTNotice();
            getHCNotice();
            getHFNotice();
            getHAMNotice();
        });
        function FResize() {
            alert($("#main").width());
        }
        
        //(function($,h,c){var a=$([]),e=$.resize=$.extend($.resize,{}),i,k="setTimeout",j="resize",d=j+"-special-event",b="delay",f="throttleWindow";e[b]=250;e[f]=true;$.event.special[j]={setup:function(){if(!e[f]&&this[k]){return false}var l=$(this);a=a.add(l);$.data(this,d,{w:l.width(),h:l.height()});if(a.length===1){g()}},teardown:function(){if(!e[f]&&this[k]){return false}var l=$(this);a=a.not(l);l.removeData(d);if(!a.length){clearTimeout(i)}},add:function(l){if(!e[f]&&this[k]){return false}var n;function m(s,o,p){var q=$(this),r=$.data(this,d);r.w=o!==c?o:q.width();r.h=p!==c?p:q.height();n.apply(this,arguments)}if($.isFunction(l)){n=l;return m}else{n=l.handler;l.handler=m}}};function g(){i=h[k](function(){a.each(function(){var n=$(this),m=n.width(),l=n.height(),o=$.data(this,d);if(m!==o.w||l!==o.h){n.trigger(j,[o.w=m,o.h=l])}});g()},e[b])}})(jQuery,this);
        //换刀提醒
        function getHCNotice() {            
            var ohtml = '<tr><th colspan="3">换刀提醒</th></tr><tr><th>NO</th><th>提醒内容</th><th>提醒时间</th></tr>';
            $.post('/Controller/HomeCuttorNotice.ashx', { userId: UserId }, function (data) {
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"><a href="/Views/Cuttor/CuttorInfo.aspx">' + data[i].Message + '</a></td>';
                        ohtml += '<td>' + data[i].UpdateTime + '</td>';
                        ohtml += '</tr>';
                    }
                    for (var i = data.length; i < 6; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"></td>';
                        ohtml += '<td></td>';
                        ohtml += '</tr>';
                    }
                }
                else {
                    for (var i = 0; i < 6; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"></td>';
                        ohtml += '<td></td>';
                        ohtml += '</tr>';
                    }
                }
                $("#cuttor").html(ohtml);
            }, "json");
        }
        //故障通知
        function getHFNotice() {
            
            var ohtml = '<tr><th colspan="3">生产线故障提醒</th></tr><tr><th>NO</th><th>提醒内容</th><th>提醒时间</th></tr>';
            $.post('/Controller/HomeFaultInfo.ashx', { userId: UserId }, function (data) {
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"><a href="/Views/Report/ReportFault.aspx">' + data[i].FaultDesc + '</a></td>';
                        ohtml += '<td>' + data[i].FaultBeginTime + '</td>';
                        ohtml += '</tr>';
                    }
                    for (var i = data.length; i < 6; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"></td>';
                        ohtml += '<td></td>';
                        ohtml += '</tr>';
                    }
                }
                else {
                    for (var i = 0; i < 6; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"></td>';
                        ohtml += '<td></td>';
                        ohtml += '</tr>';
                    }
                }
                $("#hfault").html(ohtml);
            }, "json");
        }
        //故障通知单提醒
        function getHFTNotice() {            
            var ohtml = '<tr><th colspan="3">故障通知单提醒</th></tr><tr><th>NO</th><th>提醒内容</th><th>提醒时间</th></tr>';
            $.post('/Controller/HomeFaultNotice.ashx', { userId: UserId }, function (data) {
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"><a href="/Views/Fault/FaultNotice.aspx">' + data[i].FaultName + '</a></td>';
                        ohtml += '<td>' + data[i].CreateTime + '</td>';
                        ohtml += '</tr>';
                    }
                    for (var i = data.length; i < 6; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"></td>';
                        ohtml += '<td></td>';
                        ohtml += '</tr>';
                    }
                }
                else {
                    for (var i = 0; i < 6; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"></td>';
                        ohtml += '<td></td>';
                        ohtml += '</tr>';
                    }
                }
                $("#HFN").html(ohtml);
            }, "json");
        }
        //设备维护提醒
        function getHAMNotice() {            
            var ohtml = '<tr><th colspan="3">设备维护提醒</th></tr><tr><th>NO</th><th>提醒内容</th><th>提醒时间</th></tr>';
            $.post('/Controller/HomeAMNotice.ashx', { userId: UserId }, function (data) {
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"><a href="/Views/Fault/FaultNotice.aspx">' + data[i].TicketName + '</a></td>';
                        ohtml += '<td>' + data[i].ExecuteDate + '</td>';
                        ohtml += '</tr>';
                    }
                    for (var i = data.length; i < 6; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"></td>';
                        ohtml += '<td></td>';
                        ohtml += '</tr>';
                    }
                }
                else {
                    for (var i = 0; i < 6; i++) {
                        ohtml += '<tr class="demo">';
                        ohtml += '<td style="width: 20px;">' + (i + 1) + '</td>';
                        ohtml += '<td style="width: 240px;"></td>';
                        ohtml += '<td></td>';
                        ohtml += '</tr>';
                    }
                }
                $("#AM").html(ohtml);
            }, "json");
        }
    </script>
</asp:Content>
