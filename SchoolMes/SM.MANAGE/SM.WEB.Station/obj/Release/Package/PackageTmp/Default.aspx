<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SM.WEB.Station._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>ASP.NET</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
        <p>
            <input type="text" id="birthday" style="width: 200px;" onblur="javascript:qalert(this);" />
            <input type="text" id="birthday1" style="width: 200px;" onblur="javascript:qalert1(this);" />
            <input type="text" id="birthday2" style="width: 200px;" onblur="javascript:qalert2(this);" />
            <input type="text" id="birthday3" style="width: 200px;" onblur="javascript:qalert3(this);" />
            <input type="text" id="birthday4" style="width: 200px;" onblur="javascript:qalert4(this);" />
        </p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Getting started</h2>
            <p>
                ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
            A design surface and hundreds of controls and components let you rapidly build sophisticated, powerful UI-driven sites with data access.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301948">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Get more libraries</h2>
            <p>
                NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Web Hosting</h2>
            <p>
                You can easily find a web hosting company that offers the right mix of features and price for your applications.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
            </p>
        </div>
    </div>
    <script type="text/javascript">
        var changeinputid;
        function keyDown(e) {
            //IE内核浏览器
            if (navigator.appName == 'Microsoft Internet Explorer') {
                var keycode = event.keyCode;
                var realkey = String.fromCharCode(event.keyCode);
            } else {//非IE内核浏览器
                var keycode = e.which;
                var realkey = String.fromCharCode(e.which);
            }
            // console.log('按键码:' + keycode +  '字符: ' + realkey);

            //监听Ctrl键
            if (keycode == 13) {
                $("input[type=text]").each(function (index, item) {
                    if ($(item).is(':focus')) {
                        if ($(item).val() != "") {
                            $(item).blur();
                        }
                        return false;
                    }
                });
                return false;
            }
            $("#birthday").change(function () {
                console.log($(this).val());
                $("#birthday").select();
            })

            //$("input[type=text]").each(function (index, item) {
            //    $(item).change(function () {
            //        changeinputid = index;
            //        //alert(item.id);
            //    })
            //});

        }
        document.onkeydown = keyDown;
        function qalert(obj) {
            if ($(obj).val() != "") {
                //alert("扫描了！不要刷新哈！如果刷洗，我日你妹！");
                $("#birthday1").focus();
                $(obj).val("");
            }
        }
        function qalert1(obj) {
            if ($(obj).val() != "") {
                //alert("扫描了！不要刷新哈！如果刷洗，我日你妹！");
                $("#birthday2").focus();
                $(obj).val("");
            }
        }
        function qalert2(obj) {
            if ($(obj).val() != "") {
                //alert("扫描了！不要刷新哈！如果刷洗，我日你妹！");
                $("#birthday3").focus();
                $(obj).val("");
            }
        }
        function qalert3(obj) {
            if ($(obj).val() != "") {
                //alert("扫描了！不要刷新哈！如果刷洗，我日你妹！");
                $("#birthday4").focus();
                $(obj).val("");
            }
        }
        function qalert4(obj) {
            if ($(obj).val() != "") {
                //alert("扫描了！不要刷新哈！如果刷洗，我日你妹！");
                $("#birthday").focus();
                $(obj).val("");
            }
        }
    </script>
</asp:Content>
