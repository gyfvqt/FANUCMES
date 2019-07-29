<%@ Page Title="" Language="C#" MasterPageFile="~/PopUp.Master" AutoEventWireup="true" CodeBehind="UploadTranslation.aspx.cs" Inherits="Fca.Cups.WebApp.ICona.WebForm1" %>
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

    <div ID="PnlUploadTransl" runat="server" CssClass="with-mid-padding">
        <asp:HiddenField ID="wrongExtension" runat="server" />
        <telerik:RadAjaxPanel CssClass="columns with-mid-padding small-margin-bottom" ID="pnlEditConfig" runat="server">
            
            <div class="columns">
                <div class="twelve-columns columns">
                    <div class="six-columns small-margin-top">
                        <telerik:RadAsyncUpload ID="TranslUpload" runat="server" MaxFileInputsCount="1" Width="50px"
                            EnableInlinProgress="true" OnClientFilesUploaded="OnClientFilesUploaded"
                            HideFileInput="true" OnFileUploaded="TranslUpload_FileUploaded"
                            AllowedFileExtensions=".xlsx"
                            localization-select="<%$ Resources:LocalStrings, Res_Select %>" OnClientValidationFailed="FileValidationFailed">
                          </telerik:RadAsyncUpload>
                        <asp:Label ID="Label4" Text="*.xlsx" runat="server" Style="font-size: 12px;"></asp:Label>
                    </div>
                    <div class="six-columns align-right">
                        <!-- button load image -->
                        <asp:LinkButton ID="BtnLoadTransl" CssClass="button white-gradient" runat="server" Style="visibility: hidden">                            
                        </asp:LinkButton>
                        <!-- button remove -->
                        <%--<asp:LinkButton ID="BtnRemoveImage" CssClass="button white-gradient" runat="server"
                            OnClick="BtnRemoveImage_Click">
                            <asp:Label runat="server" Text="<%$ Resources:LocalStrings, Res_Remove %>"></asp:Label>
                            <span class="button-icon right-side blue-gradient"><span class="icon-cross-round"></span></span>
                        </asp:LinkButton>--%>
                    </div>
                </div>
                
                    
                        <div class="twelve-columns">
                            <asp:Repeater runat="server" ID="rptOutput" OnItemDataBound="rptOutput_ItemDataBound">
                                <ItemTemplate>
                                    <div class="twelve-columns">
                                        <asp:Label runat="server" ID="LblOutput" Text=<%# Eval("message") %>></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                   
                
            </div>   
        </telerik:RadAjaxPanel>
        <div class="columns with-mid-padding small-margin-bottom">
            <div class="twelve-columns align-right no-margin-bottom">
                <asp:LinkButton ID="BtnClose" runat="server" CssClass="button white-gradient" OnClick="BtnClose_Click" >
                    <asp:Label ID="LblClose" runat="server" Text="<%$ Resources:LocalStrings, Res_Close %>"></asp:Label>
                    <span class="button-icon right-side blue-gradient"><span class="icon-undo"></span></span>
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
            $get('<%= BtnLoadTransl.ClientID %>').click();
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

