<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PopUp.Master" CodeBehind="QuestionModule2.aspx.cs"  Inherits="Fca.Cups.WebApp.ICona.QuestionModule2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PortalContent" runat="server">
    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxProxy">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlEditConfig" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <asp:HiddenField ID="wrongExtension" runat="server" />
    <div ID="PnlQuestion" runat="server" CssClass="with-mid-padding">
        <telerik:RadAjaxPanel CssClass="columns with-mid-padding small-margin-bottom" ID="pnlEditConfig" runat="server">
            <div class="button-height inline-label full-width">
                <label for="lblDesc" class="label">
                    <div style="white-space: nowrap;">
                        <asp:Label for="lblDesc" runat="server" Text="<%$ Resources:LocalStrings, Res_Question %>" />
                    </div>
                </label>
                <input id="lblDescQuestion" maxlength="1000" runat="server" clientidmode="Static" style="width:550px;" class="full-width input" />
<%--                <telerik:RadTextBox ID="lblqtest" TextMode="MultiLine" Wrap="false" Columns ="50" Rows="3" runat="server"></telerik:RadTextBox>--%>
            </div>
            <div class="columns">
                <div class="six-columns">
                    <div class="four-columns small-margin-top">
                        <telerik:RadAsyncUpload ID="ImageUpload" runat="server" MaxFileInputsCount="1" Width="50px"
                            EnableInlinProgress="true" OnClientFilesUploaded="OnClientFilesUploaded"
                            HideFileInput="true" OnFileUploaded="ImageUpload_FileUploaded" OnClientValidationFailed="FileValidationFailed"
                            AllowedFileExtensions=".jpeg,.jpg,.png" Localization-Remove="<%$ Resources:LocalStrings, Res_Remove %>" 
                            localization-select="<%$ Resources:LocalStrings, Res_Select %>"  />
                        <asp:Label ID="Label4" Text="*.jpeg,.jpg,.png" runat="server" Style="font-size: 12px;"></asp:Label>
                    </div>
                    <div class="eight-columns align-right">
                        <!-- button load image -->
                        <asp:LinkButton ID="BtnLoadImage" CssClass="button white-gradient" runat="server" Style="visibility: hidden">
                            <asp:Label runat="server" Text="<%$ Resources:LocalStrings, Res_Load %>"></asp:Label>
                            <span class="button-icon right-side blue-gradient"><span class="icon-cloud-upload"></span></span>
                        </asp:LinkButton>
                        <!-- button remove -->
                        <%--<asp:LinkButton ID="BtnRemoveImage" CssClass="button white-gradient" runat="server"
                            OnClick="BtnRemoveImage_Click">
                            <asp:Label runat="server" Text="<%$ Resources:LocalStrings, Res_Remove %>"></asp:Label>
                            <span class="button-icon right-side blue-gradient"><span class="icon-cross-round"></span></span>
                        </asp:LinkButton>--%>
                    </div>
                    <div class="twelve-columns new-row">
                        <telerik:RadBinaryImage CssClass="margin-right" ID="ImageUploaded" runat="server"
                            Width="100%"
                            AutoAdjustImageControlSize="false"
                            ResizeMode="Fit" ImageAlign="Middle" />
                    </div>
                </div>
                <div class="six-columns columns">
                    <div class="eight-columns">
                        <div class="button-height inline-label full-width">
                            <label for="lblDesc" class="label">
                                <div style="white-space: nowrap;">
                                    <asp:Label for="lblDesc" runat="server" Text="<%$ Resources:LocalStrings, Res_Answer %>" />
                                </div>
                            </label>
                            <input id="lblDesAnswer" maxlength="1000" runat="server" clientidmode="Static" class="full-width input" />
                        </div>
                    </div>
                    <div class="four-columns align-right">
                        <asp:LinkButton ID="btnAdd" runat="server" CssClass="button white-gradient" OnClick="btnAdd_Click">
                            <asp:Label ID="LblAdd" runat="server" Text="<%$ Resources:LocalStrings, Res_Add %>"></asp:Label>
                            <span class="button-icon right-side blue-gradient"><span class="icon-plus-round"></span></span>
                        </asp:LinkButton>
                    </div>
                    <div class="twelve-columns">
                        <div class="columns">
                            <asp:Repeater runat="server" ID="RptAnswer">
                                <HeaderTemplate>
                                    <div class="eight-columns">
                                        <asp:Label runat="server" ID="LblTitleAnswer" CssClass="label" Text="Risposta"></asp:Label>
                                    </div>
                                    <div class="three-columns align-center">
                                        <asp:Label runat="server" ID="Label1" CssClass="label" Text="Corretta"></asp:Label>
                                    </div>
                                    <div class="one-columns">
                                        
                                    </div>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <div class="eight-columns">
                                        <asp:TextBox runat="server" ID="LblAnswer" maxlength="1000" OnBlur="javascript:OnTextBoxBlur(this)" class="full-width input" data-idanswer =<%#Eval("IdAnswer") %>  Text='<%# Eval("DesAnswer") %>'></asp:TextBox>
                                    </div>
                                    <div class="three-columns  align-center">
                                        <asp:CheckBox ID="ckbCorrect" runat="server" OnChange="javascript:OnClientCheckedChange(this);" data-idanswer =<%#Eval("IdAnswer") %> Checked='<%# Eval("IsCorrect") %>'/>
                                    </div>
                                    <div class="one-columns">
                                        <asp:LinkButton ID="BtnDelete" OnLoad="BtnDel_Load" runat="server" CommandArgument='<%# Eval("IdAnswer") %>' CssClass="button compact icon-trash red-gradient with-tooltip"
                                            OnClick="BtnDelete_Click" title="<%$ Resources:LocalStrings, Res_Delete %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                        

                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>   
        </telerik:RadAjaxPanel>
        <div class="columns with-mid-padding small-margin-bottom">
            <div class="twelve-columns align-right no-margin-bottom">
                <asp:LinkButton ID="BtnCancel" runat="server" CssClass="button white-gradient" OnClick="BtnCancel_Click">
                    <asp:Label ID="LblCancel" runat="server" Text="<%$ Resources:LocalStrings, Res_Cancel %>"></asp:Label>
                    <span class="button-icon right-side blue-gradient"><span class="icon-undo"></span></span>
                </asp:LinkButton>
                <asp:LinkButton ID="BtnSave" runat="server" CssClass="button white-gradient" OnClick="BtnSave_Click">
                    <asp:Label ID="LblSave" runat="server" Text="<%$ Resources:LocalStrings, Res_Save %>"></asp:Label>
                    <span class="button-icon right-side blue-gradient"><span class="icon-tick"></span></span>
                </asp:LinkButton>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TemplatePlaceHolderJS" runat="server">
    <script type="text/javascript">
        function Close() {
            GetRadWindow().close(); // Close the window 
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog 
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well) 

            return oWindow;
        }

        function OnClientFilesUploaded(sender, args) {
            $get('<%= BtnLoadImage.ClientID %>').click();
        }
        function OnClientCheckedChange(e)
        {
            var IdA = { IdAnswer: $(e).attr('data-idanswer') };
            
            $.ajax({
                type: "POST",
                url: "/RadComboBoxDataService.svc/IconaConfModule2CheckedAnswerChange",
                data: JSON.stringify(IdA),
                contentType: "application/json; charset=utf-8",
                //dataType: "json",
                //cache: "false",
                success: function (msg) {
                    
                    
                }
            });
        }
        function OnTextBoxBlur(e) {
            
            var arguments = { IdAnswer: $(e).attr('data-idanswer'), DesAnswer: e.value };
            
            $.ajax({
                type: "POST",
                url: "/RadComboBoxDataService.svc/IconaConfModule2TextAnswerChange",
                data: JSON.stringify(arguments),
                contentType: "application/json; charset=utf-8",
                //dataType: "json",
                //cache: "false",
                success: function (msg) {
                    

                }
            });
        }
        function FileValidationFailed(sender, args) {
            var fileExtention = args.get_fileName().substring(args.get_fileName().lastIndexOf('.') + 1, args.get_fileName().length);
            if (args.get_fileName().lastIndexOf('.') != -1) {//this checks if the extension is correct
                if (sender.get_allowedFileExtensions().indexOf(fileExtention) == -1) {
                    $.modal.alert($('#<%= wrongExtension.ClientID %>').val());
                    return;
                }
            }
        }
    </script>
 </asp:Content>
