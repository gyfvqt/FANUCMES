<%@ Page Title="" Language="C#" MasterPageFile="~/PopUp.Master" AutoEventWireup="true" CodeBehind="StepModule1.aspx.cs" Inherits="Fca.Cups.WebApp.ICona.StepModule1" %>
<asp:Content ContentPlaceHolderID="PortalContent" runat="server">

    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxProxy">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="GridPart">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridPart" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="GridInterferingPart">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridInterferingPart" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="BtnCancel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlStepConfig" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="BtnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridPart" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID ="GridInterferingPart" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
         </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <asp:HiddenField ID="wrongExtension" runat="server" />
    <div ID="PnlStep" runat="server" CssClass="with-mid-padding">
        <telerik:RadAjaxPanel CssClass="with-mid-padding small-margin-bottom" ID="pnlStepConfig" runat="server">
            <div class="columns">
                <div class="six-columns columns">
                    <%-- Grid Plant --%>
                    <div class="twelve-columns">
                    <telerik:RadGrid runat="server" ID="GridPart"
                        OnInit="GridPart_Init" OnNeedDataSource="GridPart_NeedDataSource"
                        OnItemCommand="GridPart_ItemCommand" >
                        <MasterTableView ShowHeadersWhenNoRecords="true" CommandItemDisplay="Top" DataKeyNames="CodPart">
                            <CommandItemTemplate>
                                <div class="margin-bottom with-mid-padding">
                                    <div class="columns">
                                        <div class="two-columns twelve-columns-mobile">
                                            <div class="button-height inline-medium-label ">
                                                <label for="RadCmbPlant" class="label">
                                                    <div style="white-space: nowrap;">
                                                        <asp:Label ID="lblPart" runat="server" Text="<%$ Resources:LocalStrings, Res_Part %>"></asp:Label>
                                                    </div>
                                                </label>
                                                </div>
                                        </div>
                                        <div class="seven-columns twelve-columns-mobile align-center">
                                                <div class="button-height">
                                                    <telerik:RadComboBox ID="RadCmbPart" AutoPostBack="true" runat="server" ShowMoreResultsBox="true"
                                                            EnableLoadOnDemand="True" Width="100%" DataTextField="LocalizedText" DataValueField="CodPart" OnItemsRequested="RadCmbPart_ItemsRequested" />
                                                </div>
                                            </div>
                                        <div class="three-columns twelve-columns-mobile align-right">
                                            <asp:LinkButton ID="btnAdd" runat="server" CssClass="button white-gradient" CommandName="AddNewPart">
                                                <asp:Label ID="LblAdd" runat="server" Text="<%$ Resources:LocalStrings, Res_Add %>"></asp:Label>
                                                <span class="button-icon right-side blue-gradient"><span class="icon-plus-round"></span></span>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </CommandItemTemplate>
                            <Columns>
                                <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="70">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="BtnDelete" runat="server" CommandArgument='<%# Eval("CodPart") %>' CommandName="DeletePart" CssClass="button compact icon-trash red-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_Delete %>" data-tooltip-options='{"removeOnBlur" : true}' OnLoad="BtnDelete_Load"></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="DesPart" HeaderText="<%$ Resources:LocalString, Res_Part %>">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                        </div>
                    <div class="twelve-columns">
                     <telerik:RadGrid runat="server" ID="GridInterferingPart"
                        OnInit="GridInterferingPart_Init" OnNeedDataSource="GridInterferingPart_NeedDataSource"
                        OnItemCommand="GridInterferingPart_ItemCommand" >
                          <MasterTableView ShowHeadersWhenNoRecords="true" CommandItemDisplay="Top" DataKeyNames="CodPartInterfering">
                         <CommandItemTemplate>
                                <div class="margin-bottom with-mid-padding">
                                    <div class="columns">
                                        <div class="four-columns twelve-columns-mobile">
                                            <div class="button-height inline-medium-label ">
                                                <label for="RadCmbInterferingPart" class="label">
                                                    <div style="white-space: nowrap;">
                                                        <asp:Label ID="Label2" runat="server" Text="<%$ Resources:LocalStrings, Res_InterferingPart %>"></asp:Label>
                                                    </div>
                                                </label>
                                                </div>
                                        </div>
                                        <div class="five-columns twelve-columns-mobile align-left">
                                                <div class="button-height">
                                                    <telerik:RadComboBox ID="RadCmbInterferingPart" AutoPostBack="true" runat="server" ShowMoreResultsBox="true"
                                                            EnableLoadOnDemand="True" Width="100%" DataTextField="LocalizedText" DataValueField="CodPart" OnItemsRequested="RadCmbInterferingPart_ItemsRequested"/>
                                                </div>
                                            </div>
                                        <div class="three-columns twelve-columns-mobile align-right">
                                            <asp:LinkButton ID="btnAdd" runat="server" CssClass="button white-gradient" CommandName="AddNewPart">
                                                <asp:Label ID="LblAdd" runat="server" Text="<%$ Resources:LocalStrings, Res_Add %>"></asp:Label>
                                                <span class="button-icon right-side blue-gradient"><span class="icon-plus-round"></span></span>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </CommandItemTemplate>
                              <Columns>
                                <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="70">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="BtnDelete" runat="server" CommandArgument='<%# Eval("CodPartInterfering") %>' CommandName="DeletePart" CssClass="button compact icon-trash red-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_Delete %>" data-tooltip-options='{"removeOnBlur" : true}' OnLoad="BtnDelete_Load"></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="DesPart" HeaderText="<%$ Resources:LocalString, Res_InterferingPartPart %>">
                                </telerik:GridBoundColumn>
                            </Columns>
                              </MasterTableView>
                         </telerik:RadGrid>
                    </div>
                </div>
                <div class="six-columns columns">
                    <div class="four-columns small-margin-top">
                        <telerik:RadAsyncUpload ID="ImageUpload" runat="server" MaxFileInputsCount="1" Width="50px"
                            EnableInlinProgress="true" OnClientFilesUploaded="OnClientFilesUploaded"
                            HideFileInput="true" OnFileUploaded="ImageUpload_FileUploaded" OnClientValidationFailed="FileValidationFailed"
                            AllowedFileExtensions=".jpeg,.jpg,.png" Localization-Remove="<%$ Resources:LocalStrings, Res_Remove %>" 
                            localization-select="<%$ Resources:LocalStrings, Res_Select %>" />
                        <asp:Label ID="Label4" Text="*.jpeg,.jpg,.png" runat="server" Style="font-size: 12px;"></asp:Label>
                    </div>
                    <div class="eight-columns">
                        <!-- button load image -->
                        <asp:LinkButton ID="BtnLoadImage" CssClass="button white-gradient" runat="server" Style="visibility: hidden">
                            <asp:Label runat="server" Text="<%$ Resources:LocalStrings, Res_Load %>"></asp:Label>
                            <span class="button-icon right-side blue-gradient"><span class="icon-cloud-upload"></span></span>
                        </asp:LinkButton>

                        <div class="button-height inline-label full-width">
                            <label for="lblDesc" class="label">
                                <div style="white-space: nowrap;">
                                    <asp:Label runat="server" Text="<%$ Resources:LocalStrings, Res_Color %>"></asp:Label>
                                </div>
                            </label>
                            <telerik:RadColorPicker runat="server" ShowIcon="true" ID="RColorPicker" Skin="Metro" OnClientColorChange="colorChange" />
                        </div>
                    </div>
                    <div class="twelve-columns new-row">
                        <div runat="server" id="divPointer" class="imgContainer" onmousedown="SetPosition(this, event)" style="position: relative; overflow:hidden; /* padding-bottom: image's height divided by width multiply by 100 */">
                            <telerik:RadBinaryImage CssClass="margin-right" ID="ImageUploaded" runat="server"
                                Width="100%"
                                AutoAdjustImageControlSize="false"
                                ResizeMode="Fit" ImageAlign="Middle" />
                            <asp:Repeater ID="rptPointer" runat="server" ClientIDMode="AutoID" OnItemDataBound="rptPointer_ItemDataBound">
                                <ItemTemplate>
                                    <asp:Panel runat="server" ID="lnkPointer" CssClass="hotspot" Style="cursor:pointer;"></asp:Panel>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Repeater ID="rptArea" runat="server" ClientIDMode="AutoID" OnItemDataBound="rptArea_ItemDataBound">
                                <ItemTemplate>
                                    <asp:Panel runat="server" ID="lnkArea" CssClass="hotspot" Style="cursor:pointer;"></asp:Panel>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
                
                <asp:HiddenField ID="posX" runat="server" />
                <asp:HiddenField ID="posY" runat="server" />
                <asp:HiddenField ID="sequence" runat="server" />
                <asp:HiddenField ID="pointColor" runat="server" Value=""/> 
                

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

    <telerik:RadWindow ID="RdComponent" runat="server" Behaviors="None" Height="340px" Width="750px" Title="<%$ Resources:LocalStrings, Res_ClassificationDefect %>" 
        Modal="true">
        <ContentTemplate>
            <telerik:RadAjaxPanel ID="UpComponent" runat="server" LoadingPanelID="RdLoading" CssClass="with-mid-padding" >                        
                <div CssClass="columns with-mid-padding small-margin-bottom" runat="server">
                    <div class="columns">
                        <div class="twelve-columns twelve-columns-mobile">
                            <div class="button-height inline-label full-width">
                                <label for="RadCmbPart" class="label">
                                    <div style="white-space: nowrap;">
                                        <asp:Label ID="LblPart" runat="server" Text="<%$ Resources:LocalStrings, Res_Part %>"></asp:Label>
                                    </div>
                                </label>
                                <telerik:RadComboBox ID="CmbPart" AutoPostBack="true" runat="server" OnSelectedIndexChanged="CmbPart_SelectedIndexChanged" ShowMoreResultsBox="true"
                                    EnableLoadOnDemand="true" DataTextField="CodPart" DataValueField="DesPart" Width="100%">
                                    <WebServiceSettings Method="GetPartIconaModule1" Path="~/RadComboBoxDataService.svc"></WebServiceSettings>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rfPart" runat="server" ControlToValidate="CmbPart" Display="Dynamic" ForeColor="Red" CssClass="strong"
                                    ErrorMessage="<%$ Resources:LocalStrings, Res_ErrorMandatoryField %>" ValidationGroup="ConfirmPartPos">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="twelve-columns twelve-columns-mobile">
                            <div class="button-height inline-label full-width">
                                <label for="RadCmbPart" class="label">
                                    <div style="white-space: nowrap;">
                                        <asp:Label ID="Label5" runat="server" Text="<%$ Resources:LocalStrings, Res_Defect %>"></asp:Label>
                                    </div>
                                </label>
                                <telerik:RadComboBox ID="CmbDefect" AutoPostBack="false" runat="server"  ShowMoreResultsBox="true"
                                    EnableLoadOnDemand="True" Width="100%" DataTextField="DesDefect" DataValueField="CodDefect" OnClientItemsRequesting="onClientDefectRequesting">
                                    <WebServiceSettings Method="GetTesisDefectData" Path="~/RadComboBoxDataService.svc"></WebServiceSettings>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CmbDefect" Display="Dynamic" ForeColor="Red" CssClass="strong"
                                    ErrorMessage="<%$ Resources:LocalStrings, Res_ErrorMandatoryField %>" ValidationGroup="ConfirmPartPos">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div runat="server" id="lblintPartDiv"  class="three-columns twelve-columns-mobile">
                            <div class="button-height inline-medium-label">
                                <label for="CmbIntPart" class="label">
                                    <div style="white-space: nowrap;">
                                        <asp:Label ID="Label6" runat="server" Text="<%$ Resources:LocalStrings, Res_InterferingPart %>"></asp:Label>
                                    </div>
                                </label>
                                 </div>
                        </div>
                         <div runat="server" id="IntPartDiv" class="nine-columns twelve-columns-mobile">
                                <telerik:RadComboBox ID="CmbIntPart" AutoPostBack="false" runat="server" ShowMoreResultsBox="true"
                                    EnableLoadOnDemand="true" DataTextField="CodPartInterfering" DataValueField="DesPart" Width="100%">
                                    <WebServiceSettings Method="GetInterferingPartIconaModule1" Path="~/RadComboBoxDataService.svc"></WebServiceSettings>
                                </telerik:RadComboBox>
                           
                        </div>
                        <div class="twelve-columns">
                            <div class="button-height inline-label full-width">
                                <label for="chkTargetAvg" class="label">
                                    <div style="white-space: nowrap;">
                                        <asp:Label ID="Label14" runat="server" Text="<%$ Resources:LocalStrings, Res_RaggioValidita %>"></asp:Label>
                                    </div>
                                </label>
                                <telerik:RadNumericTextBox runat="server" ID="NumRaggio"  Width="120" MinValue="15" MaxValue="50" Value="15" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="columns with-mid-padding small-margin-bottom">
                    <div class="twelve-columns align-right no-margin-bottom">                        
                         <%--<asp:LinkButton ID="BtnCancelComponent" runat="server" CssClass="button white-gradient" OnClick="BtnCancelComponent_Click">
                            <asp:Label ID="Label2" runat="server" Text="<%$ Resources:LocalStrings, Res_Cancel %>"></asp:Label>
                            <span class="button-icon right-side blue-gradient"><span class="icon-undo"></span></span>
                        </asp:LinkButton>--%>
                        <asp:LinkButton ID="BtnRemoveComponent" runat="server" CssClass="button white-gradient" OnClick="BtnRemoveComponent_Click">
                            <asp:Label ID="Label3" runat="server" Text="<%$ Resources:LocalStrings, Res_RemovePoint %>"></asp:Label>
                            <span class="button-icon right-side red-gradien"><span class="icon-trash"></span></span>
                        </asp:LinkButton>
                        <asp:LinkButton ID="BtnSaveComponent" runat="server" CssClass="button white-gradient" OnClick="BtnSaveComponent_Click" ValidationGroup="ConfirmPartPos">
                            <asp:Label ID="Label1" runat="server" Text="<%$ Resources:LocalStrings, Res_Save %>"></asp:Label>
                            <span class="button-icon right-side blue-gradient"><span class="icon-tick"></span></span>
                        </asp:LinkButton>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </ContentTemplate>
    </telerik:RadWindow>

</asp:Content>
<asp:Content ContentPlaceHolderID="TemplatePlaceHolderJS" runat="server">
    <script type="text/javascript">
        var isEdit = false;

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

        function openPopUp() {
            if (isEdit)
                return;
            var combo = $find('<%= CmbPart.ClientID %>');
            combo.clearSelection();
            combo.set_emptyMessage("");

            var comboDef = $find('<%= CmbDefect.ClientID %>');
            comboDef.clearSelection();
            comboDef.set_emptyMessage("");
            var comboIntPart = $find('<%= CmbIntPart.ClientID%>');
            if (comboIntPart !== null)
            {
                comboIntPart.clearSelection();
                comboIntPart.set_emptyMessage("");
            }
            
           
            

            var NumRaggio = $find('<%= NumRaggio.ClientID %>');
            NumRaggio.set_value('0');

            var radwindow = $find('<%=RdComponent.ClientID %>');
            radwindow.show();
        }

        function editPopUp(sender) {            
            event.stopPropagation;
            event.preventDefault;
            isEdit = true;
            var part = $(sender).attr('data-part');
            var defect = $(sender).attr('data-defect');
            var despart = $(sender).attr('data-despart');
            var desdefect = $(sender).attr('data-desdefect');
            var validityPerc = $(sender).attr('data-validityPerc');
            var intpart = $(sender).attr('data-intpart');
            var desintpart = $(sender).attr('data-desintpart');
            $('#<%= sequence.ClientID %>').val($(sender).attr('data-sequence'));

            var combo = $find('<%= CmbPart.ClientID %>');
            var comboDef = $find('<%= CmbDefect.ClientID %>');
            var comboIntPart = $find('<%= CmbIntPart.ClientID%>');
            var NumRaggio = $find('<%= NumRaggio.ClientID %>');

            combo.set_value(part);
            comboDef.set_value(defect);
            

            combo.set_text(despart);
            comboDef.set_text(desdefect);
            

            if (comboIntPart != null)
            {
                comboIntPart.set_value(intpart);
                comboIntPart.set_text(desintpart);
            }

            NumRaggio.set_value(validityPerc);

            var radwindow = $find('<%=RdComponent.ClientID %>');
            radwindow.show();
        }

        function closePopUp() {
            isEdit = false;
            var radwindow = $find('<%=RdComponent.ClientID %>');
            radwindow.close();
        }

        function SetPosition(s, a) {
            if (isEdit)
                return;

            var width = $(s).innerWidth(),
                height = $(s).innerHeight();

            var adjustX = a.offsetX * 2 / 100,
                adjustY = a.offsetY * 2 / 100

            var relX = a.offsetX - adjustX,
                relY = a.offsetY - adjustY;

            var xNum = relX * 100 / width;
            var yNum = relY * 100 / height;

            var c = { X: xNum + "%", Y: yNum + "%" };
            var g = $.now();
            var f = "selector_" + g;
            var d = "hotspot_" + g;
            var b = $('<div id="' + d + '" class="hotspot"></div>');

            var sequences = new Array();
            $('.hotspot').each(function(i, obj) {
                sequences.push(parseInt($(obj).attr('data-sequence')));
            });

            var newSeq = Math.max.apply(Math,sequences) + 1;

            b.css({ position: "absolute", top: c.Y, left: c.X });
            b.css({ background: $('#<%= pointColor.ClientID %>').val(), "width": "2.567%", "height": "3.467%", "border-radius": "20px" });
            b.css("z-index", "103");
            b.attr('data-sequence', newSeq);

            $('#<%= posX.ClientID %>').val(xNum);
            $('#<%= posY.ClientID %>').val(yNum);
            $('#<%= sequence.ClientID %>').val('');

            openPopUp();

            b.appendTo(s);
            
            b.mousedown(function () {
                editPopUp(this);
                return false
            });

        }

        $('.hotspot').mousedown(function () {
            editPopUp(this);
            return false
        });

        function deleteHotspot(a) {
            $(a).remove();
            $('#<%= posX.ClientID %>').val(null);
            $('#<%= posY.ClientID %>').val(null);
        }

        function colorChange(sender, eventArgs)
        {
            var color = sender.get_selectedColor();
            $('.hotspot').each(function (i, obj) {
                $(obj).css("background", color);
            });
            $('#<%= pointColor.ClientID %>').val(color);
        }

        function onClientDefectRequesting(sender, e) {
            var context = e.get_context();
            context["IDCulture"] = '<%= Fca.Cups.WebApp.Common.SessionController.CurrentIdentity.IdCulture %>';
            var comboPart = $find('<%= CmbPart.ClientID %>');
            context["CodPart"] = comboPart.get_text().split('-')[0].replace(' ', '');
            context["Text"] = '';
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
<asp:Content ContentPlaceHolderID="CustomJSPlaceHolder" runat="server">
</asp:Content>
