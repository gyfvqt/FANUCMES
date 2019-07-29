<%@ Page Title="" Language="C#" MasterPageFile="~/PageM.Master" AutoEventWireup="true" CodeBehind="UserChange.aspx.cs" Inherits="SM.WEB.Views.UserPermission.UserChange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../../Scripts/ajaxfileupload.js"></script>
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
        <!--页面导航条-->
        <div style="height: 28px;">
            <span style="font-weight: bold; text-transform: uppercase; font-size: 16px; color: #444; float: left; margin-left: 12px; margin-top: 10px;">当前页面:系统管理\登录用户维护</span>
        </div>
        <asp:Label runat="server" ID="lblPage" Visible="false" Text="登录用户维护"></asp:Label>
        <div class="RadAjaxPanel" style="display: block;">
            <div class="with-mid-padding" id="PortalContent_PnlContainer">
                <dl class="accordion toggle-mode">
                    <dt class="closed" id="list-output"><span id="PortalContent_Label5">编辑登录用户</span></dt>
                    <dd id="listinputdd" style="display: block;">
                        <div class="with-small-padding">
                            <div class="RadAjaxPanel" style="display: block;">
                                <div style=" float:right; margin-top:5px;">
                                    <p>
                                        <input type="file" id="file1" name="file" style="height:30px;" />
                                        <input type="button" id="upload" value="上传" class="button white-gradient"   /></p>
                                    <p>
                                        <img id="img1" style="width:64px;height:64px;border: 1px solid #ccc;"  src="" /></p>
                                </div>
                                
                                <input id="txtid" style="display: none;" />
                                <input id="roleid" style="display: none;" />
                                <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; font-size: 14px; color: #444; width: 100px;">用户Id:</div>
                                <input id="txtEUserId" name="txtEUserId" maxlength="32" readonly="readonly" class="k-textbox" style="margin: 0 5px 5px 0; background: rgb(194, 184, 184); height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">姓:</div>
                                <input id="txtLastName" name="txtLastName" maxlength="8" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />
                                <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">名:</div>
                                <input id="txtFirstName" name="txtFirstName" maxlength="8" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><span style="color: red;">*</span><br />

                                <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">用户角色:</div>
                                <select style="margin: 0 5px 5px 0; border: 1px solid #ccc; height: 28px; width: 220px;" id="rwlb"></select><span style="color: red;">*</span><br />
                                <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">Email地址:</div>
                                <input id="txtEEmail" name="txtEEmail" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />
                                <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">手机号码:</div>
                                <input id="txtEPhoneNo" name="txtEPhoneNo" maxlength="16" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />

                                <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">密码:</div>
                                <input id="txtPassword" type="password" name="txtPassword" maxlength="32" class="k-textbox" style="margin: 0 5px 5px 0; height: 28px; width: 220px;" /><br />

                                <div style="padding-bottom: .3em; text-align: right; font-weight: bold; float: left; text-transform: uppercase; font-size: 14px; color: #444; width: 100px;">用户描述:</div>
                                <textarea id="txtUserdesc" maxlength="100" class="k-textbox" style="margin: 0 5px 5px 0; width: 220px; height: 100px;"></textarea>

                                
                            </div>
                        </div>
                    </dd>
                </dl>

            </div>

        </div>

        <div style="display: block; float: left; margin-left: 15px;">
            <button class="button white-gradient" id="save" style="margin-top: 5px; margin-left: 5px; float: left;" onclick="Save();return false;">保  存</button>
            <label id="msg" style="font: bold 14px; color: red; float: left; margin-left: 15px; margin-top: 12px; margin-right: 15px;"></label>
        </div>
    </section>
    <script type="text/javascript">
        $(document).ready(function () {
            getRole();
             $("#upload").click(function () {
                ajaxFileUpload();
            })
            $("#txtid").val("<%=dsuserinfo.Tables[0].Rows[0]["ID"].ToString()%>");
            $("#txtEUserId").val("<%=dsuserinfo.Tables[0].Rows[0]["UserId"].ToString()%>");
            $("#txtLastName").val("<%=dsuserinfo.Tables[0].Rows[0]["LastName"].ToString()%>");
            $("#txtFirstName").val("<%=dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString()%>");
            $("#txtEEmail").val("<%=dsuserinfo.Tables[0].Rows[0]["Email"].ToString()%>");
            $("#txtEPhoneNo").val("<%=dsuserinfo.Tables[0].Rows[0]["PhoneNumber"].ToString()%>");
            $("#txtUserdesc").val("<%=dsuserinfo.Tables[0].Rows[0]["UserDesc"].ToString()%>");
            $("#img1").attr("src", "<%=dsuserinfo.Tables[0].Rows[0]["UserImagic"].ToString()%>")
        });
        function getRole() {
            $.post('/Controller/getRoleCombobox.ashx', function (data) {

                if (data.rows[0].tips == "没有数据") {
                    $("#msg").html("*没有查询到数据，请调整一下查询条件！");
                }
                else {
                    //$("#rwlb").combobox("loadData", data.rows);
                    //$("#rwlb").combobox("select", data.rows[0].id);
                    var innerHtml = "";
                    for (var i = 0; i < data.rows.length; i++) {
                        innerHtml += '<option value="' + data.rows[i].id + '" >' + data.rows[i].text + '</option>';
                    }
                    $("#rwlb").html(innerHtml);
                    $("#rwlb").val("<%=dsuserinfo.Tables[0].Rows[0]["ID"].ToString()%>")
                }
            }, "json");
        }
        function Save() {
            var ID = $("#txtid").val();
            var UserId = $("#txtEUserId").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var LastName = $("#txtLastName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var FirstName = $("#txtFirstName").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var RoleId = $("#rwlb").val();
            var Email = $("#txtEEmail").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var PhoneNumber = $("#txtEPhoneNo").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var UserDesc = $("#txtUserdesc").val().replace('/\,/g', '，').replace('/\:/g', '：').replace('/\;/g', '；');
            var Password = $("#txtPassword").val();
            var UserImagic = $("#img1").attr("src") != "" ? $("#img1").attr("src") : "";
            $.post('/Controller/updateSelf.ashx', {
                id: ID,
                userid: UserId,
                lastName: LastName,
                firstName: FirstName,
                roleId: RoleId,
                email: Email,
                phoneNumber: PhoneNumber,
                userdesc: UserDesc,
                password: Password,
                userImagic: UserImagic
            }, function (data) {
                if (data == "0") {
                    $("#msg").html("*保存失败！");
                }
                else {
                    $("#msg").html("*保存成功！");
                    $.post('/Controller/getUserById.ashx', { id: ID }, function (data) {

                        if (data.rows[0].tips == "没有数据") {
                            $("#msg").html("*没有查询到数据！");
                        }
                        else {
                            $("#txtid").val(data.rows[0].ID);
                            $("#txtEUserId").val(data.rows[0].UserId);
                            $("#txtLastName").val(data.rows[0].LastName);
                            $("#txtFirstName").val(data.rows[0].FirstName);
                            $("#txtEEmail").val(data.rows[0].Email);
                            $("#txtEPhoneNo").val(data.rows[0].PhoneNumber);
                            $("#txtUserdesc").val(data.rows[0].UserDesc);
                            $("#rwlb").val(data.rows[0].RoleId);
                            if (data.rows[0].UserImagic != "") {
                                $("#img1").attr("src", data.rows[0].UserImagic);
                            }
                        }
                    }, "json");
                }
            }, "json");
        }
        function ajaxFileUpload() {            
            var formData = new FormData();
            formData.append("myfile", document.getElementById("file1").files[0]);
            
            $.ajax({
                url: "/Views/UserPermission/upload.ashx",
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
                        //alert("上传成功！");
                        $("#img1").attr("src", data.msg);
                        
                    }
                    if (data.status == "error") {
                        alert(data.msg);
                    }
                    //$("#imgWait").hide();
                },
                error: function (err) {
                    alert("上传失败！");
                    //$("#imgWait").hide();
                }
            });
        }
    </script>

    
    
</asp:Content>
