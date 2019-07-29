<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DEHeader.aspx.cs" Inherits="SM.WEB.Station.DEHeader" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="win8/jquery.js"></script>
    <style type="text/css">
        .select {
            -webkit-background-clip: padding-box;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            -webkit-transition: -webkit-box-shadow 400ms;
            -moz-transition: -moz-box-shadow 400ms;
            -ms-transition: box-shadow 400ms;
            -o-transition: box-shadow 400ms;
            transition: box-shadow 400ms;
            -webkit-box-shadow: 0 0 0 1px rgba(51, 153, 255, 0), 0 0 0 rgba(51, 153, 255, 0);
            -moz-box-shadow: 0 0 0 1px rgba(51, 153, 255, 0), 0 0 0 rgba(51, 153, 255, 0);
            box-shadow: 0px 0px 0px 1px rgba(51,153,255,0), 0px 0px 0px rgba(51,153,255,0);
            width: 99%;
            height: 40px;
            font-size: 18px;
            /*font-weight: bold;*/
        }

        .span {
            width: 298px;
            height: 30px;
            font-size: 18px;
            font-weight: bold;
            line-height: 30px;
            text-align: center;
            /*border: 1px solid red;*/
            color: #fff;
        }

        .button {
            display: inline-block;
            *display: inline:;
            zoom: 1;
            vertical-align: baseline;
            *vertical-align: middle:;
            position: relative;
            text-align: center;
            font-weight: bold;
            text-transform: none;
            padding: 0 11px;
            font-size: 13px;
            line-height: 28px;
            height: 28px;
            *line-height: 26px:;
            *height: 26px:;
            -webkit-background-clip: padding-box;
            -webkit-box-sizing: content-box;
            -moz-box-sizing: content-box;
            box-sizing: content-box;
            min-width: 6px;
            border-width: 1px;
            border-style: solid;
            -webkit-background-clip: padding-box;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            -webkit-appearance: none;
            background-position: center center !important;
        }

        .button, .button-group > :first-child.button, .select-value, .legend {
            -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, .75), 0 1px 1px rgba(0, 0, 0, .15);
            -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, .75), 0 1px 1px rgba(0, 0, 0, .15);
            box-shadow: inset 0px 1px 0px rgba(255,255,255,0.75), 0px 1px 1px rgba(0,0,0,0.15);
        }

        .button, .select-value, .legend {
            -webkit-text-shadow: 0 1px 0 rgba(255, 255, 255, .75);
            -moz-text-shadow: 0 1px 0 rgba(255, 255, 255, .75);
            text-shadow: 0px 1px 0px rgba(255,255,255,0.75);
        }

            .button, .button:visited, .select-value, .select-arrow, .switch-button, .legend, .block-title, .details > summary, .accordion > dt, .table > thead > tr > th, .table > thead > tr > td, .table > tfoot > tr > th, .table > tfoot > tr > td, .agenda-header, .agenda-event, .tabs-back, .blocks-list > li, .panel-control, .wizard-step {
                color: #666;
                background: #d6dadf url(../img/old-browsers/colors/bg_button.png) repeat-x;
                -webkit-background-size: 100% 100%;
                -moz-background-size: 100% 100%;
                -o-background-size: 100% 100%;
                background-size: 100% 100%;
                background: -webkit-gradient(linear,left top,left bottom,from(#efeff4),to(#d6dadf));
                background: -webkit-linear-gradient(top,#efeff4,#d6dadf);
                background: -moz-linear-gradient(top,#efeff4,#d6dadf);
                background: -ms-linear-gradient(top,#efeff4,#d6dadf);
                background: -o-linear-gradient(top,#efeff4,#d6dadf);
                background: linear-gradient(top,#efeff4,#d6dadf);
                border-color: #ccc;
            }

        .button {
            cursor: pointer;
        }

        .button {
            cursor: pointer;
        }

        label, input[type=button], input[type=submit], button {
            cursor: pointer;
        }

        input:focus, .input:focus {
            outline: 0;
        }

        .button.full-width {
            width: 100%;
            margin: 0;
            height: auto;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        .button:focus {
            outline: 0;
            -webkit-box-shadow: inset 0 0 0 1px rgba(51, 153, 255, 1), 0 1px 1px rgba(255, 255, 255, .5), 0 0 5px rgba(51, 153, 255, .75);
            -moz-box-shadow: inset 0 0 0 1px rgba(51, 153, 255, 1), 0 1px 1px rgba(255, 255, 255, .5), 0 0 5px rgba(51, 153, 255, .75);
            box-shadow: inset 0px 0px 0px 1px rgba(51,153,255,1), 0px 1px 1px rgba(255,255,255,0.5), 0px 0px 5px rgba(51,153,255,0.75);
        }

        .button.huge, .huge .button {
            padding: 0 18px;
            font-size: 18px;
            line-height: 46px;
            height: 46px;
            *line-height: 44px:;
            *height: 44px:;
            min-width: 10px;
            margin-top: 0px;
            margin-bottom: 0px;
            -webkit-background-clip: padding-box;
            -webkit-border-radius: 6px;
            -moz-border-radius: 6px;
            border-radius: 6px;
        }

        .button.glossy, .glossy > .select-value, .glossy > .select-arrow {
            background: #dcdce0 url(../img/old-browsers/colors/bg_button_glossy.png) repeat-x;
            -webkit-background-size: 100% 100%;
            -moz-background-size: 100% 100%;
            -o-background-size: 100% 100%;
            background-size: 100% 100%;
            background: -webkit-gradient(linear,left top,left bottom,from(#f5f5f7),to(#dcdce0),color-stop(.5,#dededf),color-stop(.5,#d1d1d2));
            background: -webkit-linear-gradient(top,#f5f5f7,#dededf 50%,#d1d1d2 50%,#dcdce0);
            background: -moz-linear-gradient(top,#f5f5f7,#dededf 50%,#d1d1d2 50%,#dcdce0);
            background: -ms-linear-gradient(top,#f5f5f7,#dededf 50%,#d1d1d2 50%,#dcdce0);
            background: -o-linear-gradient(top,#f5f5f7,#dededf 50%,#d1d1d2 50%,#dcdce0);
            background: linear-gradient(top,#f5f5f7,#dededf 50%,#d1d1d2 50%,#dcdce0);
        }

        .title-bar {
            background: #31363a url(/win8/images/old-browsers/style/bg_profile.png) repeat-x;
            -webkit-background-size: 100% 100%;
            -moz-background-size: 100% 100%;
            -o-background-size: 100% 100%;
            background-size: 100% 100%;
            background: -webkit-gradient(linear,left top,left bottom,from(#383e42),to(#31363a));
            background: -webkit-linear-gradient(top,#383e42,#31363a);
            background: -moz-linear-gradient(top,#383e42,#31363a);
            background: -ms-linear-gradient(top,#383e42,#31363a);
            background: -o-linear-gradient(top,#383e42,#31363a);
            background: linear-gradient(top,#383e42,#31363a);
        }

        .linen {
            color: #fff;
            border-color: #929ba6;
            background: #a7b2be url(/win8/images/fabric.png);
            background: url(/win8/images/fabric.png),-webkit-gradient(linear,left top,left bottom,from(#5d656e),to(#a7b2be)) repeat-x,#a7b2be;
            background: url(/win8/images/fabric.png),-webkit-linear-gradient(top,#5d656e,#a7b2be) repeat-x,#a7b2be;
            background: url(/win8/images/fabric.png),-moz-linear-gradient(top,#5d656e,#a7b2be) repeat-x,#a7b2be;
            background: url(/win8/images/fabric.png),-ms-linear-gradient(top,#5d656e,#a7b2be) repeat-x,#a7b2be;
            background: url(/win8/images/fabric.png),-o-linear-gradient(top,#5d656e,#a7b2be) repeat-x,#a7b2be;
            background: url(/win8/images/fabric.png),linear-gradient(top,#5d656e,#a7b2be) repeat-x,#a7b2be;
        }

        .div {
            position: absolute;
            top: 50%;
            left: 50%;
            margin: -150px 0 0 -150px;
            width: 300px;
            height: 300px;
            /*border: 1px solid #008800;*/
        }

        .option {
            font-size: 18px;
        }
    </style>
</head>
<body class="linen">
    <form id="form1" runat="server">
        <div>
            <div class="div">
                <div style="height: 58px; width: 99%;">
                    <img src="logo.png" />
                </div>
                <div style="height: 100px;">
                    <span class="span">线体-设备监控仪表盘</span>
                    <select name="domain" class="select full-width margin-top" id="line">
                        <option value="" class="option">请选择线体</option>
                    </select>
                    <%--<span class="span">工位</span>
                    <select name="domain" class="select full-width margin-top" id="station">
                        <option value="" class="option">请选择工位</option>
                    </select>--%>
                </div>
                <input name="btnLogin" class="button glossy full-width huge margin-top" id="btnLogin" style="width: 100%;" onclick="CheckInput(); return false;" type="submit" value="登录" />
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                GetLine();
            });
            function GetLine() {
                $.post('/Controller/Dashboard/getEquipmentLine.ashx', function (data) {
                    var ohtml = '<option value="" class="option">请选择线体</option>';
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            ohtml += '<option value="' + data[i].ID + '" class="option">' + data[i].EquipmentName + '</option>';
                        }
                    }
                    $("#line").html(ohtml);
                }, "json");
            }
            function GetStation(obj) {
                var lineid = $(obj).val();
                $.post('/Controller/getStationByLineid.ashx', { lineid: lineid }, function (data) {
                    var ohtml = '<option value="" class="option">请选择工位</option>';
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            ohtml += '<option value="' + data[i].ID + '" class="option">' + data[i].StationName + '</option>';
                        }
                    }
                    $("#station").html(ohtml);
                }, "json");
            }
            function CheckInput() {
                var stationid = $("#line").val();
                if (stationid !== "") {
                    window.location.href = "DashboardE.aspx?id=" + stationid;
                }
                else {
                    alert("请先选线体")
                }
            }
        </script>
    </form>
</body>
</html>
