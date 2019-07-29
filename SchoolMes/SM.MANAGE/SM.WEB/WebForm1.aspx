<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SM.WEB.WebForm1" %>

<!DOCTYPE HTML>

<!DOCTYPE html PUBLIC "" "">
<!--[if IEMobile 7]><html class="no-js iem7 oldie"><![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html class="no-js ie7 oldie" lang="en"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html class="no-js ie8 oldie" lang="en"><![endif]-->
<!--[if (IE 9)&!(IEMobile)]><html class="no-js ie9" lang="en"><![endif]-->
<!--[if (gt IE 9)|(gt IEMobile 7)]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->
<head>
    <meta content="IE=11.0000"
        http-equiv="X-UA-Compatible">

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>重庆西门雷森有限公司</title>
    <meta name="HandheldFriendly" content="True">
    <meta name="MobileOptimized" content="320">
    <meta name="viewport" content="user-scalable=1, initial-scale=1.0, target-densitydpi=115">
    <!-- CSS styles -->
    <link href="/StyleFiles/common.css" rel="stylesheet">
    <link href="/StyleFiles/print.css" rel="stylesheet" media="print">
    <link href="/StyleFiles/480.css" rel="stylesheet" media="only all and (min-width: 480px)" />
    <link href="/StyleFiles/768.css" rel="stylesheet" media="only all and (min-width: 768px)" />
    <link href="/StyleFiles/992.css" rel="stylesheet" media="only all and (min-width: 992px)" />
    <link href="/StyleFiles/1200.css" rel="stylesheet" media="only all and (min-width: 1200px)" />
    <link href="/StyleFiles/2x.css" rel="stylesheet" media="only all and (-webkit-min-device-pixel-ratio: 1.5), only screen and (-o-min-device-pixel-ratio: 3/2), only screen and (min-devic" />
    <link href="/Content/img/favicons/favicon.ico" rel="shortcut icon"
        type="image/x-icon">
    <link href="/kendoui.core/styles/kendo.common.min.css" rel="stylesheet" />
    <link href="/kendoui.core/styles/kendo.default.min.css" rel="stylesheet" />
    <%--<link href="/kendoui.core/styles/kendo.mobile.all.min.css" rel="stylesheet" />--%>
    <script src="/StyleFiles/jquery.js"></script>
    <script src="/kendoui.core/js/kendo.core.min.js"></script>
    <script src="/StyleFiles/modernizr.js"></script>
    <link href="/StyleFiles/home.css" rel="stylesheet">
    <!-- For Modern Browsers -->
    <link href="/Content/img/favicons/favicon.png" rel="shortcut icon">
    <!-- For everything else -->
    <link href="/Content/img/favicons/favicon.ico" rel="shortcut icon">
    <!-- iPhone ICON -->
    <link href="/Content/img/favicons/apple-touch-icon.png" rel="apple-touch-icon"
        sizes="57x57">
    <!-- iPad ICON -->
    <link href="/Content/img/favicons/apple-touch-icon-ipad.png"
        rel="apple-touch-icon" sizes="72x72">
    <!-- iPhone (Retina) ICON -->
    <link href="/Content/img/favicons/apple-touch-icon-retina.png" rel="apple-touch-icon"
        sizes="114x114">
    <!-- iPad (Retina) ICON -->
    <link href="/Content/img/favicons/apple-touch-icon-ipad-retina.png"
        rel="apple-touch-icon" sizes="144x144">
    <!-- iPhone SPLASHSCREEN (320x460) -->
    <link href="/Content/img/splash/iphone.png" rel="apple-touch-startup-image"
        media="(device-width: 320px)">
    <!-- iPhone (Retina) SPLASHSCREEN (640x960) -->
    <link href="/Content/img/splash/iphone-retina.png" rel="apple-touch-startup-image"
        media="(device-width: 320px) and (-webkit-device-pixel-ratio: 2)">
    <!-- iPhone 5 SPLASHSCREEN (640×1096) -->
    <link href="/Content/img/splash/iphone5.png" rel="apple-touch-startup-image"
        media="(device-height: 568px) and (-webkit-device-pixel-ratio: 2)">
    <!-- iPad (portrait) SPLASHSCREEN (748x1024) -->
    <link href="/Content/img/splash/ipad-portrait.png" rel="apple-touch-startup-image"
        media="(device-width: 768px) and (orientation: portrait)">
    <!-- iPad (landscape) SPLASHSCREEN (768x1004) -->
    <link href="/Content/img/splash/ipad-landscape.png" rel="apple-touch-startup-image"
        media="(device-width: 768px) and (orientation: landscape)">
    <!-- iPad (Retina, portrait) SPLASHSCREEN (2048x1496) -->
    <link href="/Content/img/splash/ipad-portrait-retina.png" rel="apple-touch-startup-image"
        media="(device-width: 1536px) and (orientation: portrait) and (-webkit-min-device-pixel-ratio: 2)">
    <!-- iPad (Retina, landscape) SPLASHSCREEN (1536x2008) -->
    <link href="/Content/img/splash/ipad-landscape-retina.png"
        rel="apple-touch-startup-image" media="(device-width: 1536px)  and (orientation: landscape) and (-webkit-min-device-pixel-ratio: 2)">
    <!-- Microsoft clear type rendering -->
    <meta http-equiv="cleartype" content="on">
    <!-- IE9 Pinned Sites: http://msdn.microsoft.com/en-us/library/gg131029.aspx -->

    <meta name="application-name" content="Developr Admin Skin">
    <meta name="msapplication-tooltip" content="Cross-platform admin template.">
    <%--<META name="msapplication-starturl" content="http://www.display-inline.fr/demo/developr">--%>
    <!-- These custom tasks are examples, you need to edit them to show actual pages -->

    <%--<META name="msapplication-task" content="name=Agenda;action-uri=http://www.display-inline.fr/demo/developr/agenda.html;icon-uri=http://www.display-inline.fr/demo/developr/img/favicons/favicon.ico">--%>

    <%--<META name="msapplication-task" content="name=My profile;action-uri=http://www.display-inline.fr/demo/developr/profile.html;icon-uri=http://www.display-inline.fr/demo/developr/img/favicons/favicon.ico">--%>

    <style type="text/css">
        .RadAjax_Silk .raDiv {
            background-image: url('/Content/img/standard/loaders/loading32.gif') !important;
        }

        .RadAjax_Silk .raColor {
            background-color: #e6e6e6;
            color: #3b3b3b;
        }

        .RadAjax_Silk .raTransp {
            opacity: 0.8;
            -moz-opacity: 0.8;
            filter: alpha(opacity=80);
        }
    </style>

    <meta name="GENERATOR" content="MSHTML 11.00.9600.18978">
    <script src="/ichartjs-master/ichart.1.2.1.min.js"></script>

</head>
<body class="clearfix with-menu reversed">
    <form id="form1" action="./default" method="post">
        <div class="aspNetHidden">
            <input name="RadManager_TSM" id="RadManager_TSM" type="hidden">
            <input name="__EVENTTARGET" id="__EVENTTARGET" type="hidden">
            <input name="__EVENTARGUMENT" id="__EVENTARGUMENT" type="hidden">
            <input name="__VIEWSTATE" id="__VIEWSTATE" type="hidden" value="viOd6DG0VUlfl2iZ+mk2KknOPB5f7/qpJQDQDr4vuQOJgQ0q6VqmEYHPSHlqUyv2gy77Iywr8dRnhR79lPTKbCpT7AgdRKt2emHIIPzjSWGduIU24gxURFxrZFRuZf74iUZkvixVcIQk55NIlR1rQ9rFtQbqUO34Fy21pPtrnXdISJuUB/ipHw4Mtye5fNVxstHdQKnXFfQfkuOf+K9lE9DkL9Pi009FjDc9JxA3a6g3i8V17RVdu1jCRxrs68GkB6ygraxJFRSyWzaF6WSJSBI/PtTXVFPHm64nh8rFpuUottpkl/B1bempxfmqweDyqvyZAMwybiEHuMrp7EVXvYqc3UzsxrFNQIBGQF/Zm7QFF2EhieS0bek0N+/kRcl5RcTFQxOFfIBYRLbXqS4D+nvmRzZlc1/9aLohZRTZLYYFwa6bsE3/Ujwyv6LRSA5H5dB7EE6I/IKyAWrHpM9P8JYjYpHSvxJYBbO/gA8pQqCdcRYT/szSpmgMJzWTaeBQo39OdKvFZuM330mWWAyzFpnsQGXFCNTgtnjTDumtUDZMm7zX8lklj65EjdDHIWkvPUjg66lvzhFugkWLuQsnd5QtBHMscf2nVif4EoVyHW/JgbdCipBNBCMWj3wuPF8xLj4JbikqhWvM67EBqISFe6vk9BxcJHe5jrx9cWjx+tGJQehLOAvPSg/aqC1/Wxpugqz+OBmBEYjrRq+VuxRVWfmzydimSwcHiAHIj4sLOzl/78Xj6g1ymDJeciTdQwoJDrRaCcDceKiN0oaQebJnk0cRNuipqyZ7EYajYPiO5LHtPOEMJc9W/Uh0h/zxmLn3RPzZ6AdQQ1gpurvUmlxaSw==">
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
        <link class="Telerik_stylesheet" href="/StyleFiles/WebResource.css" rel="stylesheet"
            type="text/css">
        <link class="Telerik_stylesheet" href="/StyleFiles/WebResource(1).css"
            rel="stylesheet" type="text/css">
        <link class="Telerik_stylesheet" href="/StyleFiles/WebResource(2).css"
            rel="stylesheet" type="text/css">
        <link class="Telerik_stylesheet" href="/StyleFiles/WebResource(3).css"
            rel="stylesheet" type="text/css">
        <script src="/StyleFiles/Telerik.Web.UI.WebResource.js" type="text/javascript"></script>

        <div class="aspNetHidden">
            <input name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" type="hidden" value="CA0B0334">
            <input name="__PREVIOUSPAGE" id="__PREVIOUSPAGE" type="hidden" value="iBIIricVwlE8w4O8qWiENJUHPh0wrAxllprgfEwHfFVcLXGY6d_14_6XbYMCM6rUXOpxFiW8K9JeSq7cvxcxYw2">
            <input name="__EVENTVALIDATION" id="__EVENTVALIDATION" type="hidden" value="k3Q54Uo/pBbVcm/2aG6MmkzP67IsleXOUWlf4bpHxF5H9cBrOcKmCRT1xLVMq3f/QFNKbOVnvhYTq+CRGIgvlX3420cILYP+bPDcruvVzQtXyD4HaKf5/nTvCN6PHpelfq6l5rq2pFMmsVCvdEqihuezCePWc9TT0yuhdxlAh7RDQzEa8Kip42QqcXXhxA5qT9urAFY1wLG7WTF4l94ROw==">
        </div>
        <script type="text/javascript">
            //<![CDATA[
            //Sys.WebForms.PageRequestManager._initialize('ctl00$RadManager', 'form1', ['tctl00$radAjxManagerSU', 'radAjxManagerSU'], [], [], 360, 'ctl00');
            //]]>
        </script>
        <!-- 2014.2.724.45 -->
        <div id="radAjxManagerSU">
            <span id="ctl00_radAjxManager" style="display: none;"></span>
        </div>
        <div class="RadAjax RadAjax_Silk" id="RdLoading" style="display: none;">
            <div class="raDiv"></div>
            <div class="raColor raTransp"></div>
        </div>
        <!-- Prompt IE 6 users to install Chrome Frame -->
        <!--[if lt IE 7]><p class="message red-gradient simpler">Your browser is <em>ancient!</em> <a href="http://browsehappy.com/">Upgrade to a different browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to experience this site.</p><![endif]-->
        <!-- Title bar -->
        <header id="title-bar" role="banner">
            <div id="logocontainer">
                <div id="logo">
                    <div class="item1">&nbsp;</div>
                    <div class="item2">
                        <div class="align-center" id="ucEnvironmentPanel_pnlEnvironmentMessage">
                            <p class="message blue-gradient simpler">
                                <span id="ucEnvironmentPanel_lblEnvironment"
                                    style="font-weight: bold;">FANUC</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Button to open/hide menu -->
        <a id="open-menu" href="#"><span>菜单</span></a><!-- Button to open/hide shortcuts -->
        <!-- Main content -->
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
            </style>
            <div class="RadAjaxPanel" id="ctl00_ctl00_PortalContent_PnlContainerPanel" style="display: block;">
                <div class="with-mid-padding" id="PortalContent_PnlContainer">
                    <dl class="accordion toggle-mode" id="accordionCannedReport">
                        <dt class="closed" id="list-section" style="background: -ms-linear-gradient(rgb(39, 106, 143), rgb(56, 95, 186));" ><span id="PortalContent_lblTest">查询条件</span></dt>
                        <dd id="listsectiondd" style="display: block;">
                            <div class="with-small-padding">
                                <div class="RadAjaxPanel" id="ctl00_ctl00_PortalContent_RadAjaxPanelProfilePanel" style="display: block;">
                                    <div>
                                        <label for="txtline" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">线体编码:</label>
                                        <input id="txtline" name="txtline" class="k-textbox" style="margin: 0 5px 5px 0;" />
                                        <label for="txtlinename" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">线体名称:</label>
                                        <input id="txtlinename" name="txtlinename" class="k-textbox" style="margin: 0 5px 5px 0;" />
                                        <label for="txtlinetype" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">线体类型:</label>
                                        <input id="txtlinetype" name="txtlinetype" class="k-textbox" style="margin: 0 5px 5px 0;" />


                                        <%--<button class="k-button k-primary" id="get" style="margin-top: 2em; float: right; background-color:rgb(102,102,102);border-color:rgb(102,102,102);">查 询</button>--%>
                                        <button class="button white-gradient" id="get" style="margin-top: 2em; float: right;margin-right:5px;">查  询</button>
                                    </div>

                                    <br />
                                    <br />
                                </div>
                            </div>
                        </dd>
                        <dt id="list-filter"><span id="PortalContent_Label1">结果列表</span></dt>
                        <dd id="listfilterdd" style="display: block;">
                            <div class="RadAjaxPanel" id="ctl00_ctl00_PortalContent_RadAjaxPanelFilterPanel" style="display: block;">
                                <div id="ctl00_PortalContent_RadAjaxPanelFilter">
                                    <div class="with-small-padding" style="height:428px;">
                                        <div id="ichart3d"> </div>
                                    </div>

                                </div>
                            </div>
                        </dd>
                        <div class="new-row"></div>
                        <dt class="closed" id="list-output"><span id="PortalContent_Label5">编辑/新增</span></dt>
                        <dd id="listoutputdd" style="display: block;">
                            <div class="RadAjaxPanel" id="ctl00_ctl00_PortalContent_RadAjaxPanelOutputPanel" style="display: block;">
                                <div id="ctl00_PortalContent_RadAjaxPanelOutput" style="margin-top:5px;margin-left:5px;">                               
                                    <button class="button white-gradient" id="save" style="margin-top: 5px;margin-right:5px; float: right;">保  存</button><button class="button white-gradient" id="cancel" style="margin-top: 5px;margin-right:5px; float: right;">取  消</button>
                                    <label for="txtline" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">线体编码:</label>
                                    <input id="txtline" name="txtline" class="k-textbox" style="margin: 0 5px 5px 0; width:220px;" /><span style="color:red;">*</span><br />
                                    <label for="txtlinename" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">线体名称:</label>
                                    <input id="txtlinename" name="txtlinename" class="k-textbox" style="margin: 0 5px 5px 0; width:220px;" /><span style="color:red;">*</span><br />
                                    <label for="txtlinetype" style="padding-bottom: .3em; font-weight: bold; text-transform: uppercase; font-size: 14px; color: #444;">线体类型:</label>
                                    <input id="txtlinetype" name="txtlinetype" class="k-textbox" style="margin: 0 5px 5px 0; width:220px;" /><br />
                                    <br>
                                </div>
                            </div>
                        </dd>
                    </dl>

                </div>

            </div>
        </section>
        <!-- End main content -->
        <!-- Side tabs shortcuts -->
        <!-- End tabs shortcuts -->
        <!-- Sidebar/drop-down menu -->
        <section id="menu" role="complementary">
            <!-- This wrapper is used by several responsive layouts -->

            <div id="menu-content">
                <header><span id="ucUserInfo_lblRole">管理员</span></header>
                <div id="profile">
                    <img width="64" height="64" class="user-icon" alt="User name"
                        src="/StyleFiles/user.png">
                    <span class="name">
                        <span id="ucUserInfo_lblUser">路人甲<br />
                            <br />
                        </span>
                        <a href="#" style="font-size: 14px; color: #e6e6e6;">注销</a>
                    </span>
                </div>
                <%--<UL class="children-tooltip" id="access">
                    <LI>
                        <A title="主页" href='javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions("ctl00$ucUserMenu$ctl00", "", false, "", "Default.aspx", false, true))'>
                            <SPAN class="icon-home"></SPAN>
                        </A>
                    </LI>
                    <LI>
                        <A title="个人资料" id="btnprofile" onclick="return false;" href="javascript:__doPostBack('ctl00$ucUserMenu$btnprofile','')">
                            <SPAN class="icon-user"></SPAN>
                        </A>
                    </LI>
                    <LI>
                        <A title="手册"
                           href="javascript:__doPostBack('ctl00$ucUserMenu$ctl01','')"><SPAN class="icon-read"></SPAN></A>
                    </LI>
                    <LI>
                        <A title="注销" id="ucUserMenu_btnLogOff" href="javascript:__doPostBack('ctl00$ucUserMenu$btnLogOff','')">
                            <SPAN class="icon-logout"></SPAN>
                        </A>
                    </LI>
                </UL>--%>
                <div id="ctl00_ucUserMenu_UserProfile_Window" style="display: none;">
                    <div id="ctl00_ucUserMenu_UserProfile_Window_C"
                        style="display: none;">
                    </div>
                    <input name="ctl00_ucUserMenu_UserProfile_Window_ClientState" id="ctl00_ucUserMenu_UserProfile_Window_ClientState" type="hidden">
                </div>
                <input name="ctl00$ucUserMenu$PageToRefresh" id="PageToRefresh" type="hidden">
                <script type="text/javascript">
                    $('#btnprofile').click(function f() {
                        $find('ctl00_ucUserMenu_UserProfile_Window').show();
                        Sys.Application.remove_load(f);
                        Sys.Application.add_load(f);
                        $('#PageToRefresh').val(window.location.href);
                    });

                    function PopUpClose() {
                        window.location.href = $('#PageToRefresh').val();
                    }
                </script>
                <section class="navigable">
                    <ul class="big-menu">
                        <li class="title-menu" id="Li1">菜单</li>
                        <li class="with-right-arrow">
                            <span>
                                <span class="list-count">9</span>生产数据管理
                            </span>
                            <ul class="big-menu">
                                <li><a class="current navigable-current" id="_masterdata_masterdata" href="#">生产线管理</a></li>
                                <li><a id="_masterdata_masterdata1" href="#">产品管理</a></li>
                                <li><a id="_masterdata_masterdata2" href="#">站点管理（PC）</a></li>
                                <li><a id="_masterdata_masterdata3" href="#">站点管理（PLC）</a></li>
                                <li><a id="_masterdata_masterdata4" href="#">PLC模板</a></li>
                                <li><a id="_masterdata_masterdata5" href="#">BOM管理</a></li>
                                <li><a id="_masterdata_masterdata6" href="#">工作日历</a></li>
                                <li><a id="_masterdata_masterdata7" href="#">设备主数据</a></li>
                                <li><a id="_masterdata_masterdata8" href="#">设备故障提醒设置</a></li>
                            </ul>
                        </li>
                        <li class="with-right-arrow">
                            <span>
                                <span class="list-count">2</span>生产排产
                            </span>
                            <ul class="big-menu">
                                <li><a href="#">ERP集成接口</a></li>
                                <li><a href="#">生产计划及生产订单</a></li>
                            </ul>
                        </li>
                        <li class="with-right-arrow">
                            <span>
                                <span class="list-count">3</span>订单管理
                            </span>
                            <ul class="big-menu">
                                <li><a href="#">订单查询</a></li>
                                <li><a href="#">成品查询</a></li>
                                <li><a href="#">零件追溯查询</a></li>
                            </ul>
                        </li>
                        <li class="with-right-arrow">
                            <span>
                                <span class="list-count">4</span>物料拉动
                            </span>
                            <ul class="big-menu">
                                <li><a href="#">物料落点管理</a></li>
                                <li><a href="#">触发点管理</a></li>
                                <li><a href="#">叫料需求管理</a></li>
                                <li><a href="#">捡料单管理</a></li>
                            </ul>
                        </li>
                        <li class="with-right-arrow">
                            <span>
                                <span class="list-count">2</span>刀具管理
                            </span>
                            <ul class="big-menu">
                                <li><a href="#">刀具主数据</a></li>
                                <li><a href="#">换刀提醒设置</a></li>
                            </ul>
                        </li>
                        <li class="with-right-arrow">
                            <span>
                                <span class="list-count">11</span>设备维护
                            </span>
                            <ul class="big-menu">
                                <li><a href="#">故障通知单</a></li>
                                <li><a href="#">故障通知单–执行人查看并执行</a></li>
                                <li><a href="#">日常维护管理</a></li>
                                <li><a href="#">日常维护任务单</a></li>
                                <li><a href="#">日常维护任务单–查看或执行</a></li>
                                <li><a href="#">生产报表</a></li>
                                <li><a href="#">Cycletime</a></li>
                                <li><a href="#">站点状态报表</a></li>
                                <li><a href="#">故障和人工干预报表</a></li>
                                <li><a href="#">瓶颈分析</a></li>
                                <li><a href="#">TOP10 故障</a></li>
                            </ul>
                        </li>
                        <li class="with-right-arrow">
                            <span>
                                <span class="list-count">5</span>库存WMS
                            </span>
                            <ul class="big-menu">
                                <li><a href="#">仓储区域维护</a></li>
                                <li><a href="#">仓位维护</a></li>
                                <li><a href="#">物料主数据维护</a></li>
                                <li><a href="#">转储单管理</a></li>
                                <li><a href="#">物料库存查询</a></li>
                            </ul>
                        </li>
                        <li class="with-right-arrow">
                            <span>
                                <span class="list-count">1</span>ANDON
                            </span>
                            <ul class="big-menu">
                                <li><a href="#">ANDON配置</a></li>
                            </ul>
                        </li>
                        <li class="with-right-arrow">
                            <span>
                                <span class="list-count">3</span>系统管理
                            </span>
                            <ul class="big-menu">
                                <li><a href="#">角色管理</a></li>
                                <li><a href="#">用户管理</a></li>
                                <li><a href="#">系统日志</a></li>
                            </ul>
                        </li>
                    </ul>
                </section>
            </div>
            <!-- End content wrapper -->
            <!-- This is optional -->
            <footer id="menu-footer">
                <!-- Any content -->
            </footer>
        </section>
        <script src="/StyleFiles/setup.js"></script>

        <script type="text/javascript">
            /*
            * This script highligths the menu left
            */
            $("#_default").addClass("current navigable-current");
        </script>

        <script type="text/javascript">
            //$.template.init();

            //function TriggerPageLoaded() {
            //    Developr.pageLoaded();
            //}
        </script>

        <script type="text/javascript">
            //<![CDATA[
            //Sys.Application.add_init(function () {
            //    $create(Telerik.Web.UI.RadAjaxManager, { "_updatePanels": "", "ajaxSettings": [], "clientEvents": { OnRequestStart: "", OnResponseEnd: "TriggerPageLoaded()" }, "defaultLoadingPanelID": "", "enableAJAX": true, "enableHistory": false, "links": [], "styles": [], "uniqueID": "ctl00$radAjxManager", "updatePanelsRenderMode": 0 }, null, null, $get("ctl00_radAjxManager"));
            //});
            //Sys.Application.add_init(function () {
            //    $create(Telerik.Web.UI.RadAjaxLoadingPanel, { "initialDelayTime": 0, "isSticky": false, "minDisplayTime": 0, "skin": "Silk", "uniqueID": "ctl00$RdLoading", "zIndex": 999999 }, null, null, $get("RdLoading"));
            //});
            //Sys.Application.add_init(function () {
            //    $create(Telerik.Web.UI.RadWindow, { "_dockMode": false, "animation": 1, "behaviors": 4, "clientStateFieldID": "ctl00_ucUserMenu_UserProfile_Window_ClientState", "formID": "form1", "height": "400px", "iconUrl": "", "minimizeIconUrl": "", "modal": true, "name": "UserProfile_Window", "navigateUrl": "Security/Popups/UserProfile.aspx", "reloadOnShow": true, "skin": "Silk", "visibleStatusbar": false, "width": "400px" }, { "close": PopUpClose }, null, $get("ctl00_ucUserMenu_UserProfile_Window"));
            //});
//]]>
        </script>
        <script type="text/javascript">
            //$( "#accordion" ).accordion();

            $("#get").click(function () {
                debugger
                alert('Thank you! Your Choice is:\n\nFabric ID:  and Size: ');
                return false;
            });

            $(function(){   

				var data = [

				        	{name : 'WinXP',value : 68.34,color:'#3883bd'},

				        	{name : 'Win7',value : 26.83,color:'#3F5C71'},

				        	{name : 'Other',value : 4.83,color:'#a6bfd2'}

			        	];

				

				var chart = new iChart.Pie3D({

					render : 'ichart3d',

					title:{

						text:'中国地区2012年08月份操作系统分布情况',

						color:'#e0e5e8',

						height:40,

						border:{

							enable:true,

							width:[0,0,2,0],

							color:'#343b3e'

						}

					},

					padding:'2 10',

					footnote:{

						text:'StatCounter Global Stats,design by ichartjs',

						color:'#e0e5e8',

						height:30,

						border:{

							enable:true,

							width:[2,0,0,0],

							color:'#343b3e'

						}

					},

					width : 800,

					height : 400,

					data:data,

					shadow:true,

					shadow_color:'#15353a',

					shadow_blur:8,

					background_color : '#3b4346',

					gradient:true,

					color_factor:0.28,

					gradient_mode:'RadialGradientOutIn',

					showpercent:true,

					decimalsnum:2,

					legend:{

						enable:true,

						padding:30,

						color:'#e0e5e8',

						border:{

							width:[0,0,0,2],

							color:'#343b3e'

						},

						background_color : null,

					},

					sub_option:{

						offsetx:-40,

						border:{

							enable:false

						},

						label : {

							background_color:'#fefefe',

							sign:false,//设置禁用label的小图标

							line_height:10,

							padding:4,

							border:{

								enable:true,

								radius : 4,//圆角设置

								color:'#e0e5e8'

							},

							fontsize:11,

							fontweight:600,

							color : '#444444'

						}

					},

					border:{

						width:[0,20,0,20],

						color:'#1e2223'

					}

				});

				

				chart.bound(0);

			});


        </script>
    </form>
</body>
</html>

