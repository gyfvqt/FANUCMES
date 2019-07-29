<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SM.WEB.Login" %>

<!DOCTYPE HTML>
<!DOCTYPE html PUBLIC "" "">
<!--[if IEMobile 7]><html class="no-js iem7 oldie linen"><![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html class="no-js ie7 oldie linen" lang="en"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html class="no-js ie8 oldie linen" lang="en"><![endif]-->
<!--[if (IE 9)&!(IEMobile)]><html class="no-js ie9 linen" lang="en"><![endif]-->
<!--[if (gt IE 9)|(gt IEMobile 7)]><!-->
<html
class="no-js linen" lang="en">
<!--<![endif]-->
<head>
    <meta content="IE=11.0000"
        http-equiv="X-UA-Compatible">

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>MES-重庆西门雷森有限公司 
    </title>
    <meta name="description">
    <meta name="author">
    <meta name="HandheldFriendly" content="True">
    <meta name="MobileOptimized" content="320">
    <meta name="viewport" content="user-scalable=0, initial-scale=1.0, target-densitydpi=115">
    <!-- CSS styles -->
    <%--<link href="/StyleFiles/LoginPage.css" rel="stylesheet" />--%>
    <link href="/StyleFiles/common.css" rel="stylesheet">
    <link href="/StyleFiles/print.css" rel="stylesheet" media="print">
    <link href="/StyleFiles/480.css" rel="stylesheet" media="only all and (min-width: 480px)">
    <link href="/StyleFiles/768.css" rel="stylesheet" media="only all and (min-width: 768px)">
    <link href="/StyleFiles/992.css" rel="stylesheet" media="only all and (min-width: 992px)">
    <link href="/StyleFiles/1200.css" rel="stylesheet" media="only all and (min-width: 1200px)">
    <link href="/StyleFiles/2x.css" rel="stylesheet" media="only all and (-webkit-min-device-pixel-ratio: 1.5), only screen and (-o-min-device-pixel-ratio: 3/2), only screen and (min-devic">
    <link href="favicon.ico" rel="shortcut icon" type="image/x-icon">
    <link href="/StyleFiles/login.css" rel="stylesheet">
    <script src="/StyleFiles/jquery.js"></script>

    <script src="/StyleFiles/modernizr.js"></script>
    <!-- For Modern Browsers -->
    <link href="Content/img/favicons/favicon.png"
        rel="shortcut icon">
    <!-- For everything else -->
    <link href="Content/img/favicons/favicon.ico"
        rel="shortcut icon">
    <!-- iOS web-app metas -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <!-- iPhone ICON -->
    <link href="Content/img/favicons/apple-touch-icon.png" rel="apple-touch-icon"
        sizes="57x57">
    <!-- iPad ICON -->
    <link href="Content/img/favicons/apple-touch-icon-ipad.png"
        rel="apple-touch-icon" sizes="72x72">
    <!-- iPhone (Retina) ICON -->
    <link href="Content/img/favicons/apple-touch-icon-retina.png" rel="apple-touch-icon"
        sizes="114x114">
    <!-- iPad (Retina) ICON -->
    <link href="Content/img/favicons/apple-touch-icon-ipad-retina.png"
        rel="apple-touch-icon" sizes="144x144">
    <!-- iPhone SPLASHSCREEN (320x460) -->
    <link href="Content/img/splash/iphone.png" rel="apple-touch-startup-image"
        media="(device-width: 320px)">
    <!-- iPhone (Retina) SPLASHSCREEN (640x960) -->
    <link href="Content/img/splash/iphone-retina.png" rel="apple-touch-startup-image"
        media="(device-width: 320px) and (-webkit-device-pixel-ratio: 2)">
    <!-- iPhone 5 SPLASHSCREEN (640×1096) -->
    <link href="Content/img/splash/iphone5.png" rel="apple-touch-startup-image"
        media="(device-height: 568px) and (-webkit-device-pixel-ratio: 2)">
    <!-- iPad (portrait) SPLASHSCREEN (748x1024) -->
    <link href="Content/img/splash/ipad-portrait.png" rel="apple-touch-startup-image"
        media="(device-width: 768px) and (orientation: portrait)">
    <!-- iPad (landscape) SPLASHSCREEN (768x1004) -->
    <link href="Content/img/splash/ipad-landscape.png" rel="apple-touch-startup-image"
        media="(device-width: 768px) and (orientation: landscape)">
    <!-- iPad (Retina, portrait) SPLASHSCREEN (2048x1496) -->
    <link href="Content/img/splash/ipad-portrait-retina.png" rel="apple-touch-startup-image"
        media="(device-width: 1536px) and (orientation: portrait) and (-webkit-min-device-pixel-ratio: 2)">
    <!-- iPad (Retina, landscape) SPLASHSCREEN (1536x2008) -->
    <link href="Content/img/splash/ipad-landscape-retina.png"
        rel="apple-touch-startup-image" media="(device-width: 1536px)  and (orientation: landscape) and (-webkit-min-device-pixel-ratio: 2)">
    <!-- Microsoft clear type rendering -->
    <meta http-equiv="cleartype" content="on">
    <meta name="GENERATOR" content="MSHTML 11.00.9600.18978">
    <style type="text/css">
        input:-webkit-autofill, textarea:-webkit-autofill, select:-webkit-autofill {
            -webkit-text-fill-color: #fff !important;
            transition: background-color 5000s ease-in-out 0s;
        }
    </style>
</head>
<body>
    <div id="container">
        <hgroup class="large-margin-bottom" id="login-title">
            <h1 class="login-title-image">MES</h1>
            <%--<h5>© FANUC</h5>--%>
        </hgroup>
        <form id="form1" method="post" autocomplete="off">
            <div class="aspNetHidden">
                <input name="RadManager_TSM" id="RadManager_TSM" type="hidden">
                <input name="__EVENTTARGET" id="__EVENTTARGET" type="hidden">
                <input name="__EVENTARGUMENT" id="__EVENTARGUMENT" type="hidden">
                <input name="__VIEWSTATE" id="__VIEWSTATE" type="hidden" value="IypU19mPw9PBe/vIlnFOG4SkiEhrCn5qfa/OiB6CsDDvsjMOX28gg/zQ1T6YrWyuf+AFoZP4WRLGBhywz4VDaKfJhstum5/ISvrDIKXxyjo=">
            </div>
            <script type="text/javascript">
                //<![CDATA[
                var theForm = document.forms['form1'];
                if (!theForm) {
                    theForm = document.form1;
                }
                function __doPostBack(eventTarget, eventArgument) {
                    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
                        theForm.__EVENTTARGET.value = eventTarget;
                        theForm.__EVENTARGUMENT.value = eventArgument;
                        theForm.submit();
                    }
                }
//]]>
            </script>

            <script src="/StyleFiles/WebResource.js" type="text/javascript"></script>

            <script src="/StyleFiles/Telerik.Web.UI.WebResource.js" type="text/javascript"></script>

            <div class="aspNetHidden">
                <input name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" type="hidden" value="C2EE9ABB">
                <input name="__EVENTVALIDATION" id="__EVENTVALIDATION" type="hidden" value="JHwYZYJAVG2kxTmRbYrtqYX617IELR8C5aeB+P66dm2mJ/uegCUesgsG2yg7uN7lMlT9jUY7Wj8ySzmgHhNfrjYa4hAQklQoJkLw1xbHfkFZ836aZG9sMSBzI2RY+BFbe5vQ4izS5yOAm/EAsjss0KIZJASNPau0qlZWZ/FvLF6aRs5lgjW0+3mFi9+3L2xi">
            </div>
            <script type="text/javascript">
                //<![CDATA[
                Sys.WebForms.PageRequestManager._initialize('RadManager', 'form1', ['tradAjxManagerSU', 'radAjxManagerSU'], [], [], 90, '');
//]]>
            </script>
            <!-- 2014.2.724.45 -->
            <div id="radAjxManagerSU">
                <span id="radAjxManager"
                    style="display: none;"></span>
            </div>
            <ul class="inputs black-input large no-margin-bottom">
                <!-- The autocomplete="off" attributes is the only way to prevent webkit browsers from filling the inputs with yellow -->

                <li><%--<span class="icon-user no-margin-right"></span>--%>
                    <input name="login" class="input-unstyled" id="login" type="text" placeholder="用户名" value="" autocomplete="off"></li>
                <%--<hr />--%>
                <li><%--<span class="icon-lock no-margin-right"></span>--%>
                    <input name="pass" class="input-unstyled" id="pass" type="password" placeholder="密码" value="" autocomplete="off"></li>
            </ul>
            <%-- <select
                name="domain" class="select full-width margin-top" id="domain">
                <option value="2">ADAM</option>
                <option selected="selected" value="1">Local User</option>
            </select>--%>
            <input name="fake_login" style="display: none;" type="text">
            <input name="fake_password" style="display: none;" type="password">
            <input name="btnLogin" class="button glossy full-width huge margin-top" id="btnLogin" style="width: 100%;" onclick="CheckInput(); return false;" type="submit" value="登录">
            <%--<ul class="  large no-margin-bottom" style="line-height:30px;">
                <li style="-moz-box-shadow: inset 0 1px 0 rgba(0, 0, 0, 0);"><span style="color: rgb(255, 255, 255); text-align: left; margin-top: 5px;-moz-box-shadow: inset 0 1px 0 rgba(0, 0, 0, 0);-webkit-box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0);">请输入正确的用户名和密码！</span></li>
            </ul>--%>
        </form>
    </div>
    <script src="/StyleFiles/setup.js"></script>

    <script>      

        $(document).ready(function () {


            /*
             * JS login effect
             * This script will enable effects for the login page
             */
            // Elements
            var doc = $('html').addClass('js-login'),
                container = $('#container'),
                formLogin = $('#form1'),

                // If layout is centered
                centered;

            // Handle resizing (mostly for debugging)
            function handleLoginResize() {
                // Detect mode
                centered = (container.css('position') === 'absolute');

                // Set min-height for mobile layout
                if (!centered) {
                    container.css('margin-top', '');
                }
                else {
                    if (parseInt(container.css('margin-top'), 10) === 0) {
                        centerForm(false);
                    }
                }
            };

            // Register and first call
            $(window).bind('normalized-resize', handleLoginResize);
            handleLoginResize();

            /*
             * Center function
             * param boolean animate whether or not to animate the position change
             * param string|element|array any jQuery selector, DOM element or set of DOM elements which should be ignored
             * return void
             */
            function centerForm(animate, ignore) {
                // If layout is centered
                if (centered) {
                    var siblings = formLogin.siblings(),
                        finalSize = formLogin.outerHeight();

                    // Ignored elements
                    if (ignore) {
                        siblings = siblings.not(ignore);
                    }

                    // Get other elements height
                    siblings.each(function (i) {
                        finalSize += $(this).outerHeight(true);
                    });

                    // Setup
                    container[animate ? 'animate' : 'css']({ marginTop: -Math.round(finalSize / 2) + 'px' });
                }
            };

            // Initial vertical adjust
            centerForm(false);

            document.getElementById("login").focus();

        });

        var doc = $('html').addClass('js-login'),
            container = $('#container'),
            formLogin = $('#form1'),

            // If layout is centered
            centered;

        /**
        * Function to Check login input 
        */
        function CheckInput(sender, eventArgs) {

            // Values
            var login = $.trim($('#login').val()),
                pass = $.trim($('#pass').val()),
                formLogin = $('#form1');

            formLogin.clearMessages();

            if (login.length === 0) {
                // Display message
                //displayError('Please fill in your login');
                displayError('请输入登录信息');
                return false;
            }
            else if (pass.length === 0) {
                // Remove empty login message if displayed
                formLogin.clearMessages('请输入登录信息');

                // Display message
                //displayError('Please fill in your password');
                displayError('请输入密码');
                return false;
            }

            // Check inputs
            else {
                // Display message
                //displayError('Please fill in your login');
                formLogin.clearMessages();

                // Show progress
                //displayLoading('Checking credentials...');
                displayLoading('验证登录中 ...');
                var Userid = $("#login").val().trim();
                var Password = $("#pass").val().trim();
                $.post('/Controller/Login.ashx', { userid: Userid, password: Password }, function (data) {

                    if (data == "1") {
                        //ajaxLoadEnd();
                        document.location.href = "HomePage.aspx"
                    }
                    else {
                        displayError('请输入正确的用户名和密码');
                    }
                }, "json");
                //var ajaxManager = $find('radAjxManager');
                //ajaxManager.ajaxRequest('Login');
            }
        }

        /**
         * Function to display error messages
         * param string message the error to display
         */
        function displayError(message) {
            formLogin.clearMessages();
            // Show message
            var message = formLogin.message(message, {
                append: false,
                arrow: 'bottom',
                classes: ['red-gradient'],
                animate: false					// We'll do animation later, we need to know the message height first
            });

            // Vertical centering (where we need the message height)
            centerForm(true, 'fast');

            // Watch for closing and show with effect
            message.on('endfade', function (event) {
                // This will be called once the message has faded away and is removed
                centerForm(true, message.get(0));

            }).hide().slideDown('fast');
        }

        /**
         * Function to display loading messages
         * param string message the message to display
         */
        function displayLoading(message) {
            // Show message
            var message = formLogin.message('<strong>' + message + '</strong>', {
                append: false,
                arrow: 'bottom',
                classes: ['blue-gradient', 'align-center'],
                stripes: true,
                darkStripes: false,
                closable: false,
                animate: false					// We'll do animation later, we need to know the message height first
            });

            // Vertical centering (where we need the message height)
            centerForm(true, 'fast');

            // Watch for closing and show with effect
            message.on('endfade', function (event) {
                // This will be called once the message has faded away and is removed
                centerForm(true, message.get(0));

            }).hide().slideDown('fast');
        }

        /*
        * Center function
        * @param boolean animate whether or not to animate the position change
        * @param string|element|array any jQuery selector, DOM element or set of DOM elements which should be ignored
        * @return void
        */
        function centerForm(animate, ignore) {
            // If layout is centered
            if (centered) {
                var siblings = formLogin.siblings(),
                    finalSize = formLogin.outerHeight();

                // Ignored elements
                if (ignore) {
                    siblings = siblings.not(ignore);
                }

                // Get other elements height
                siblings.each(function (i) {
                    finalSize += $(this).outerHeight(true);
                });

                // Setup
                container[animate ? 'animate' : 'css']({ marginTop: -Math.round(finalSize / 2) + 'px' });
            }
        };

        function setup() {
            /*
             * AJAX login
             * This function will handle the login process through AJAX
             */
            formLogin.submit(function (event) {
                // Values
                var login = $.trim($('#login').val()),
                    pass = $.trim($('#pass').val());

                // Check inputs
                if (login.length === 0) {
                    // Display message
                    displayError('Please fill in your login');
                    return false;
                }
                else if (pass.length === 0) {
                    // Remove empty login message if displayed
                    formLogin.clearMessages('Please fill in your login');

                    // Display message
                    displayError('Please fill in your password');
                    return false;
                }
                else {
                    // Remove previous messages
                    formLogin.clearMessages();

                    // Show progress
                    displayLoading('Checking credentials...');
                }
            });

            // Register and first call
            $(window).on('normalized-resize', handleLoginResize);
            handleLoginResize();

            // Initial vertical adjust
            centerForm(false);

            // render server errors
            var errors = JSON.parse('');
            if (errors != null) {
                $(errors).each(function (index, err) {
                    displayError(err);
                });
            }
        }

    </script>
</body>
</html>
