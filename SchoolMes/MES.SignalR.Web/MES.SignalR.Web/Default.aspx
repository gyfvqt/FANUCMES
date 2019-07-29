<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MES.SignalR.Web._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h1>流程演示</h1>
    <input type="hidden" id="displayname" />
    <h2 id="thisname"></h2>

    <select id="username" style="width: 100px;">
    </select>
    <br />
    <br />
    <input type="text" id="message" />
    <input id="send" type="button" value="发送" />
    <div>
        <h1 id="messgaeInfo"></h1>
    </div>

    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/jquery.signalR-2.4.0.min.js"></script>
    <script src="http://10.27.189.228:10086/signalr/hubs"></script>
    <script type="text/javascript">
        $(function () {
            $.connection.hub.url = 'http://10.27.189.228:10086/signalr';
            var work = $.connection.IMHub;

            $('#displayname').val(prompt('请输入昵称:', ''));
            $('#thisname').text('当前用户：' + $('#displayname').val());
            var fromUser = $('#displayname').val();

            //对应后端的SendMessage函数，消息接收函数
            work.client.receivePrivateMessage = function (user, message) {
                //alert(message);
                if (message != undefined) {
                    $('#messgaeInfo').append(message + '</br>');
                }
            };

            //后端SendLogin调用后，产生的loginUser回调
            work.client.onConnected = function (connnectId, userName, OnlineUsers) {
                reloadUser(OnlineUsers);
            };

            //hub连接开启
            $.connection.hub.start().done(function () {
                var username = $('#displayname').val();
                //发送上线信息
                work.server.register(username);

                //点击按钮，发送消息
                $('#send').click(function () {
                    var friend = $('#username').val();
                    //调用后端函数，发送指定消息
                    work.server.sendPrivateMessage(friend, $("#message").val());
                });
            });
        });

        //重新加载用户列表
        var reloadUser = function (userlist) {
            $("#username").empty();
            for (i = 0; i < userlist.length; i++) {
                $("#username").append("<option value=" + userlist[i].UserName + ">" + userlist[i].UserName + "</option>");
            }
        }
    </script>


</asp:Content>
