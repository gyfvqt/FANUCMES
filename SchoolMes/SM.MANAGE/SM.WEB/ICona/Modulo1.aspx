<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="Modulo1.aspx.cs" Inherits="Fca.Cups.WebApp.ICona.Modulo1" %>

<asp:Content ContentPlaceHolderID="PortalContent" runat="server">
    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxProxy">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="GridTestHide">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTestHide" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="PnlEdit" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="divPartInterfering" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="GridTestLow">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTestLow" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="PnlEdit" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="divPartInterfering" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="GridTestMedium">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTestMedium" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="PnlEdit" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="divPartInterfering" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            <telerik:AjaxSetting AjaxControlID="BtnNext">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlStepDetail" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="divPartInterfering" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="BtnPrev">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlStepDetail" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="divPartInterfering" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="BtnCancel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTestHide" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="GridTestMedium" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="GridTestLow" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="BtnClose">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTestHide" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="GridTestMedium" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="GridTestLow" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
                        
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div class="with-mid-padding">
        <dl id="accordion" class="accordion toggle-mode">
            <%--LIST SECTION--%>
            <dt id="list-section" class="closed">
                <asp:Label ID="LblList" runat="server" Text="<%$ Resources:LocalStrings, Res_ICONA_Test_List %>"></asp:Label></dt>
            <dd id="list-section-dd">
                <div ID="pnlTest" runat="server" CssClass="with-padding">
                    <div class="align-center margin-top">
                        <p class="green-gradient messages simpler"><asp:Label ID="Label3" runat="server" Text="<%$ Resources:LocalStrings, Res_ICONA_TestLow %>"></asp:Label></p>
                    </div>
                    <telerik:RadGrid runat="server" ID="GridTestLow" Width="100%" 
                        OnItemDataBound="GridTestLow_ItemDataBound" OnInit="GridTestLow_Init"
                        OnNeedDataSource="GridTestLow_NeedDataSource" OnItemCommand="GridTestLow_ItemCommand">
                        <MasterTableView>
                            <Columns>
                                <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="70">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="BtnContinue" runat="server" 
                                            CommandArgument='<%# Eval("IdTest") + "," + Eval("IdConfiguration")%>' CommandName="ContinueTest" 
                                            CssClass="button compact icon-play green-gradient with-tooltip"                                             
                                            data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Title" HeaderText="<%$ Resources:LocalString, Res_ICONA_Title %>" HeaderStyle-Width="400">
                                </telerik:GridBoundColumn>
                                <telerik:GridDateTimeColumn UniqueName="DateValidTo" DataField="DateValidTo" HeaderText="<%$ Resources:LocalString, Res_Icona_ExpireDate %>"
                                DataFormatString="{0:d/M/yyyy}" DataType="System.Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200">
                            </telerik:GridDateTimeColumn>                       
                                <telerik:GridBoundColumn DataField="NCaseTest" ItemStyle-HorizontalAlign="Center" HeaderText="<%$ Resources:LocalString, Res_ICONA_NCase %>" HeaderStyle-Width="100">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="Succed" DataField="Succed" HeaderText="<%$ Resources:LocalString, Res_ICONA_Succed %>" 
                                    AllowFiltering="false"  ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100">
                                     <ItemTemplate>
                                         <telerik:RadBinaryImage CssClass="margin-right" ID="Image" runat="server"
                                                Width="32px"
                                                AutoAdjustImageControlSize="false"
                                                ResizeMode="Fit" ImageAlign="Middle"/>
                                     </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                    <div class="align-center margin-top">
                        <p class="orange-gradient messages simpler"><asp:Label ID="Label2" runat="server" Text="<%$ Resources:LocalStrings, Res_ICONA_TestMedium %>"></asp:Label></p>
                    </div>
                    <telerik:RadGrid runat="server" ID="GridTestMedium" Width="100%" 
                        OnItemDataBound="GridTestMedium_ItemDataBound" OnInit="GridTestMedium_Init"
                        OnNeedDataSource="GridTestMedium_NeedDataSource" OnItemCommand="GridTestMedium_ItemCommand">
                        <MasterTableView>
                            <Columns>
                                <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="70">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="BtnContinue" runat="server" 
                                            CommandArgument='<%# Eval("IdTest") + "," + Eval("IdConfiguration")%>' CommandName="ContinueTest" 
                                            CssClass="button compact icon-play green-gradient with-tooltip" 
                                            data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Title" HeaderText="<%$ Resources:LocalString, Res_ICONA_Title %>" HeaderStyle-Width="400">
                                </telerik:GridBoundColumn>
                                <telerik:GridDateTimeColumn UniqueName="DateValidTo" DataField="DateValidTo" HeaderText="<%$ Resources:LocalString, Res_Icona_ExpireDate %>"
                                DataFormatString="{0:d/M/yyyy}" DataType="System.Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200">
                            </telerik:GridDateTimeColumn>                            
                                <telerik:GridBoundColumn DataField="NCaseTest" ItemStyle-HorizontalAlign="Center" HeaderText="<%$ Resources:LocalString, Res_ICONA_NCase %>" HeaderStyle-Width="100">
                                </telerik:GridBoundColumn>
                               <telerik:GridTemplateColumn UniqueName="Succed" DataField="Succed" HeaderText="<%$ Resources:LocalString, Res_ICONA_Succed %>" 
                                     AllowFiltering="false"  ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100">
                                     <ItemTemplate>
                                         <telerik:RadBinaryImage CssClass="margin-right" ID="Image" runat="server"
                                                Width="32px"
                                                AutoAdjustImageControlSize="false"
                                                ResizeMode="Fit" ImageAlign="Middle"/>
                                     </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                    <div class="align-center margin-top">
                        <p class="red-gradient messages simpler"><asp:Label ID="Label1" runat="server" Text="<%$ Resources:LocalStrings, Res_ICONA_TestHide %>"></asp:Label></p>
                    </div>
                    <telerik:RadGrid runat="server" ID="GridTestHide" Width="100%" 
                        OnItemDataBound="GridTestHide_ItemDataBound" OnInit="GridTestHide_Init"
                        OnNeedDataSource="GridTestHide_NeedDataSource" OnItemCommand="GridTestHide_ItemCommand">
                        <MasterTableView>
                            <Columns>
                                <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="70">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="BtnContinue" runat="server" 
                                            CommandArgument='<%# Eval("IdTest") + "," + Eval("IdConfiguration")%>' CommandName="ContinueTest" 
                                            CssClass="button compact icon-play green-gradient with-tooltip" 
                                            data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Title" HeaderText="<%$ Resources:LocalString, Res_ICONA_Title %>" HeaderStyle-Width="400">
                                </telerik:GridBoundColumn>
                                <telerik:GridDateTimeColumn UniqueName="DateValidTo" DataField="DateValidTo" HeaderText="<%$ Resources:LocalString, Res_Icona_ExpireDate %>"
                                DataFormatString="{0:d/M/yyyy}" DataType="System.Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200">
                            </telerik:GridDateTimeColumn>
                                <telerik:GridBoundColumn DataField="NCaseTest" ItemStyle-HorizontalAlign="Center" HeaderText="<%$ Resources:LocalString, Res_ICONA_NCase %>" HeaderStyle-Width="100">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="Succed" DataField="Succed" HeaderText="<%$ Resources:LocalString, Res_ICONA_Succed %>" 
                                    AllowFiltering="false"  ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100">
                                     <ItemTemplate>
                                         <telerik:RadBinaryImage CssClass="margin-right" ID="Image" runat="server"
                                                Width="32px"
                                                AutoAdjustImageControlSize="false"
                                                ResizeMode="Fit" ImageAlign="Middle"/>
                                     </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>

                </div>
            </dd>
            <%--TEST SECTION--%>
            <dt id="testSection" class="not-closable" style="display: none">
                <asp:Label ID="Label4" runat="server" Text="<%$ Resources:LocalStrings, Res_ICONA_Test %>"></asp:Label></dt>
            <dd style="display: none">
                <div ID="PnlEdit" runat="server" Visible="false">
                    <asp:HiddenField ID="posX" runat="server" />
                    <asp:HiddenField ID="posY" runat="server" />
                    <asp:HiddenField ID="imageX" runat="server" />
                    <asp:HiddenField ID="imageY" runat="server" />
                    <asp:HiddenField ID="pointColor" runat="server"/>  
                    <asp:HiddenField ID="sequence" runat="server" />
                    <asp:HiddenField ID="maxPt" runat="server" />
                    <asp:HiddenField ID="maxPtMessage" runat="server" />
                    
                    <ul class="wizard-steps">
                        <asp:Repeater ID="rptWizard" runat="server" ClientIDMode="AutoID" OnItemDataBound="rptWizard_ItemDataBound">
                            <ItemTemplate>
                                <li id="rpt_li" runat="server"></li>
                            </ItemTemplate>
                        </asp:Repeater>
                        <li id="rpt_li_end" runat="server"> <%= Fca.Cups.WebApp.Common.Localization.GetString("Res_ICONA_Succed") %>
                            <span class="wizard-step"><span class="icon-flag"></span>
                        </li>
                    </ul>                                                                                          
                   
                    <asp:Panel id="pnlDemo" runat="server" Visible="false">
                        <div id="ucEnvironmentPanel_pnlEnvironmentMessage" class="align-center">	
                            <p class="message red-gradient simpler" style="font-weight:bold;">
                               <%= Fca.Cups.WebApp.Common.Localization.GetString("Res_ICONA_Demo") %>
                            </p>
                        </div>
                    </asp:Panel>

                   <%-- <h6 class="red align-right small-margin-right">
                        <asp:Label ID="lblMaxPoint" runat="server" Visible="false" />
                    </h6> --%>

                    <asp:Panel CssClass="with-small-padding small-margin-bottom" ID="PnlStep" runat="server">
                        <telerik:RadAjaxPanel runat="server" ID="pnlStepDetail">
                            <div runat="server" id="divPointer" class="imgContainer" onmousedown="SetPosition(this, event)" style="position: relative; /* padding-bottom: image's height divided by width multiply by 100 */">
                                <telerik:RadBinaryImage CssClass="margin-right" ID="ImagePoint" runat="server"
                                    Width="100%"
                                    AutoAdjustImageControlSize="false"
                                    ResizeMode="Fit" ImageAlign="Middle"/>
                                <asp:Repeater ID="rptPointer" runat="server" ClientIDMode="AutoID" OnItemDataBound="rptPointer_ItemDataBound">
                                    <ItemTemplate>
                                        <asp:Panel runat="server" ID="lnkPointer" CssClass="hotspot" Style="cursor:pointer;"></asp:Panel>
                                    </ItemTemplate>
                            </asp:Repeater>
                            </div> 
                        </telerik:RadAjaxPanel>
                        <div class="columns with-mid-padding small-margin-bottom">
                            <div class="twelve-columns align-right no-margin-bottom">
                                <asp:LinkButton ID="BtnCancel" runat="server" CssClass="button white-gradient" OnClick="BtnCancel_Click">
                                    <asp:Label ID="LblCancel" runat="server" Text="<%$ Resources:LocalStrings, Res_ICONA_Cancel %>"></asp:Label>
                                    <span class="button-icon right-side blue-gradient"><span class="icon-undo"></span></span>
                                </asp:LinkButton>
                                <asp:LinkButton ID="BtnPrev" runat="server" CssClass="button white-gradient" OnClick="BtnPrev_Click">
                                    <asp:Label ID="Label9" runat="server" Text="<%$ Resources:LocalStrings, Res_Previous %>"></asp:Label>
                                    <span class="button-icon right-side blue-gradient"><span class="icon-backward"></span></span>
                                </asp:LinkButton>
                                <asp:LinkButton ID="BtnNext" runat="server" CssClass="button white-gradient" OnClick="BtnNext_Click">
                                    <asp:Label ID="Label6" runat="server" Text="<%$ Resources:LocalStrings, Res_Next %>"></asp:Label>
                                    <span class="button-icon right-side blue-gradient"><span class="icon-forward"></span></span>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel CssClass="with-small-padding small-margin-bottom" ID="PnlResult" runat="server" Visible="false">

                        <asp:Panel ID="pnlCorrect" runat="server" CssClass="block-title">
                            <h2 class="align-center"><label id="lblSuccedMsg" runat="server" /></h2>
                            <h2 class="align-center"> <%= Fca.Cups.WebApp.Common.Localization.GetString("Res_ICONA_Congratulations") %> </h2>
                            <div class="align-center">
                                <img src="ImgTest/target.png" />
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlError" runat="server" CssClass="block-title">
                            <h2 class="align-center"><label id="lblErrorMsg" runat="server" /></h2>
                            <h2 class="align-center"><label id="lblErroMsg_2" runat="server" /></h2>
                            <div class="columns padding-button">
                                
                                <div class="four-columns align-center">
                                    <img src="ImgTest/identified.png" height="128"/>
                                    <h1 id="lblIdentified" runat="server"></h1>
                                </div>
                                <div class="four-columns align-center">
                                    <img src="ImgTest/placed.png" height="128"/>
                                    <h1 id="lblPlaced" runat="server"></h1>
                                </div>
                                <div class="four-columns align-center">
                                    <img src="ImgTest/classified.png" height="128"/>
                                    <h1 id="lblClassified" runat="server"></h1>
                                </div>
                                <div class="margin-top">                               
                                    <div class="align-left imgContainer margin-top">
                                        <img src="ImgTest/identified.png" height="32"/> <%= Fca.Cups.WebApp.Common.Localization.GetString("Res_ICONA_Identified") %>
                                    </div>
                                    <div class="align-left imgContainer">
                                        <img src="ImgTest/placed.png" height="32"/> <%= Fca.Cups.WebApp.Common.Localization.GetString("Res_ICONA_Placed") %>
                                    </div>
                                    <div class="align-left imgContainer">
                                        <img src="ImgTest/classified.png" height="32"/>  <%= Fca.Cups.WebApp.Common.Localization.GetString("Res_ICONA_Classified") %>
                                    </div> 
                                </div>                     
                            </div>
                        </asp:Panel>

                        <div class="columns with-small-padding small-margin-bottom">
                            <div class="twelve-columns align-right no-margin-bottom">                                
                                <asp:LinkButton ID="BtnClose" runat="server" CssClass="button white-gradient" OnClick="BtnClose_Click">
                                    <asp:Label ID="Label8" runat="server" Text="<%$ Resources:LocalStrings, Res_Close %>"></asp:Label>
                                    <span class="button-icon right-side blue-gradient"><span class="icon-tick"></span></span>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </dd>

        </dl>
    </div>
    
    <telerik:RadWindow ID="RdComponent" runat="server" Behaviors="None" Height="300px" Width="750px" Title="<%$ Resources:LocalStrings, Res_ClassificationDefect %>" 
        Modal="true">
        <ContentTemplate>
            <telerik:RadAjaxPanel ID="UpComponent" runat="server" LoadingPanelID="RdLoading" CssClass="with-mid-padding" >                        
                <div CssClass="columns with-mid-padding small-margin-bottom" runat="server">
                    <div class="columns">
                        <asp:Panel runat="server" ID="divPart" class="twelve-columns twelve-columns-mobile">
                            <div class="button-height inline-label full-width">
                                <label for="RadCmbPart" class="label">
                                    <div style="white-space: nowrap;">
                                        <asp:Label ID="LblPart" runat="server" Text="<%$ Resources:LocalStrings, Res_Part %>"></asp:Label>
                                    </div>
                                </label>
                                <telerik:RadComboBox ID="CmbPart" AutoPostBack="true" runat="server" OnSelectedIndexChanged="CmbPart_SelectedIndexChanged" ShowMoreResultsBox="true"
                                    EnableLoadOnDemand="True" Width="100%" DataTextField="LocalizedText" DataValueField="CodPart" OnItemsRequested="CmbPart_ItemsRequested">
                                    <WebServiceSettings Method="GetPartIconaModule1_ExecutionTest" Path="~/RadComboBoxDataService.svc"></WebServiceSettings>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rfPart" runat="server" ControlToValidate="CmbPart" Display="Dynamic" ForeColor="Red" CssClass="strong"
                                    ErrorMessage="<%$ Resources:LocalStrings, Res_ErrorMandatoryField %>" ValidationGroup="ConfirmPartPos">
                                </asp:RequiredFieldValidator>
                            </div>
                        </asp:Panel>

                        <asp:Panel runat="server" ID="divDefect" class="twelve-columns twelve-columns-mobile">
                            <div class="button-height inline-label full-width">
                                <label for="RadCmbPart" class="label">
                                    <div style="white-space: nowrap;">
                                        <asp:Label ID="Label5" runat="server" Text="<%$ Resources:LocalStrings, Res_Anomalia %>"></asp:Label>
                                    </div>
                                </label>
                                <telerik:RadComboBox ID="CmbDefect" AutoPostBack="true" runat="server"  ShowMoreResultsBox="true"
                                    EnableLoadOnDemand="True" Width="100%" DataTextField="DesDefect" DataValueField="CodDefect" OnClientItemsRequesting="onClientDefectRequesting">
                                    <WebServiceSettings Method="GetTesisDefectData" Path="~/RadComboBoxDataService.svc"></WebServiceSettings>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CmbDefect" Display="Dynamic" ForeColor="Red" CssClass="strong"
                                    ErrorMessage="<%$ Resources:LocalStrings, Res_ErrorMandatoryField %>" ValidationGroup="ConfirmPartPos">
                                </asp:RequiredFieldValidator>
                            </div>
                        </asp:Panel>

                        <asp:Panel class="twelve-columns twelve-columns-mobile" id="divPartInterfering" runat="server">
                            <div class="button-height inline-label full-width">
                                <label for="RadCmbPart" class="label">
                                    <div style="white-space: nowrap;">
                                        <asp:Label ID="Label11" runat="server" Text="<%$ Resources:LocalStrings, Res_InterferingPart %>"></asp:Label>
                                    </div>
                                </label>
                                <telerik:RadComboBox ID="CmbPartInterfering" AutoPostBack="true" runat="server" ShowMoreResultsBox="true"
                                    EnableLoadOnDemand="True" Width="100%" DataTextField="LocalizedText" DataValueField="CodPart" OnItemsRequested="CmbPart_ItemsRequested">
                                    <WebServiceSettings Method="GetPartInterferingIconaModule1_ExecutionTest" Path="~/RadComboBoxDataService.svc"></WebServiceSettings>
                                </telerik:RadComboBox>
                            </div>
                        </asp:Panel>

                    </div>
                </div>
                <div class="columns with-mid-padding small-margin-bottom">
                    <div class="twelve-columns align-right no-margin-bottom">
                        <asp:LinkButton ID="BtnCancelComponent" runat="server" CssClass="button white-gradient" OnClick="BtnCancelComponent_Click">
                            <asp:Label ID="Label10" runat="server" Text="<%$ Resources:LocalStrings, Res_Cancel %>"></asp:Label>
                            <span class="button-icon right-side red-gradien"><span class="icon-undo"></span></span>
                        </asp:LinkButton>
                        <asp:LinkButton ID="BtnRemoveComponent" runat="server" CssClass="button white-gradient" OnClick="BtnRemoveComponent_Click">
                            <asp:Label ID="Label7" runat="server" Text="<%$ Resources:LocalStrings, Res_RemovePoint %>"></asp:Label>
                            <span class="button-icon right-side red-gradien"><span class="icon-trash"></span></span>
                        </asp:LinkButton>
                        <asp:LinkButton ID="BtnSaveComponent" runat="server" CssClass="button white-gradient" OnClick="BtnSaveComponent_Click" ValidationGroup="ConfirmPartPos">
                            <asp:Label ID="LblSave" runat="server" Text="<%$ Resources:LocalStrings, Res_Save %>"></asp:Label>
                            <span class="button-icon right-side blue-gradient"><span class="icon-tick"></span></span>
                        </asp:LinkButton>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </ContentTemplate>
    </telerik:RadWindow>

    <telerik:RadScriptBlock runat="server">
        <script type="text/javascript">
            function CollapseGrid() {
                Developr.Accordion.show('testSection');
                Developr.Accordion.close('list-section');
            }

            function ShowGrid() {
                Developr.Accordion.hide('testSection');
                Developr.Accordion.open('list-section');
            }
        </script>
    </telerik:RadScriptBlock>

</asp:Content>

<asp:Content ContentPlaceHolderID="TemplatePlaceHolderJS" runat="server">
    <script type="text/javascript">
        var isEdit = false;

        function closePopUp() {
            isEdit = false;
            var radwindow = $find('<%=RdComponent.ClientID %>');
            radwindow.close();
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

            var comboPartInterfering = $find('<%= CmbPartInterfering.ClientID %>');

            if (comboPartInterfering != null) {
                comboPartInterfering.clearSelection();
                comboPartInterfering.set_emptyMessage("");
            }
            
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

            var partInterfering = $(sender).attr('data-partInterfering');
            var desPartInterfering = $(sender).attr('data-desPartInterfering');
            debugger;
            $('#<%= sequence.ClientID %>').val($(sender).attr('data-sequence'));
                        
            $('#<%= imageX.ClientID %>').val($('#<%= ImagePoint.ClientID %>').width());
            $('#<%= imageY.ClientID %>').val($('#<%= ImagePoint.ClientID %>').height());

            var combo = $find('<%= CmbPart.ClientID %>');
            var comboDef = $find('<%= CmbDefect.ClientID %>');

            combo.set_value(part);
            comboDef.set_value(defect);

            combo.set_text(despart);
            comboDef.set_text(desdefect);

            var comboPartInterfering = $find('<%= CmbPartInterfering.ClientID %>');
            if (comboPartInterfering != null) {
                comboPartInterfering.set_value(partInterfering);
                comboPartInterfering.set_text(desPartInterfering);
            }
            
            var radwindow = $find('<%=RdComponent.ClientID %>');
            radwindow.show();
        }


        function SetPosition(s, a) {
            if (isEdit)
                return;

            if ($('.hotspot').length >= $('#<%= maxPt.ClientID %>').val())
            {
                $.modal.alert($('#<%= maxPtMessage.ClientID %>').val());
                return;
            }

            var width = $(s).innerWidth(),
                height = $(s).innerHeight();

            //Nell'esempio sottrae 16px a relX e relY,
            //per renderlo responsive sottraggo il 2%
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
            $('.hotspot').each(function (i, obj) {
                sequences.push(parseInt($(obj).attr('data-sequence')));
            });

            var newSeq = Math.max.apply(Math, sequences) + 1;

            b.css({ position: "absolute", top: c.Y, left: c.X });
            b.css({ background: $('#<%= pointColor.ClientID %>').val(), "width": "2.567%", "height": "3.467%", "border-radius": "20px" });
            b.css("z-index", "103");
            b.attr('data-sequence', newSeq);

            $('#<%= posX.ClientID %>').val(xNum);
            $('#<%= posY.ClientID %>').val(yNum);
            $('#<%= sequence.ClientID %>').val('');
            
            $('#<%= imageX.ClientID %>').val($('#<%= ImagePoint.ClientID %>').width());
            $('#<%= imageY.ClientID %>').val($('#<%= ImagePoint.ClientID %>').height());

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
        
        function onClientDefectRequesting(sender, e) {
            var context = e.get_context();
            context["IDCulture"] = '<%= Fca.Cups.WebApp.Common.SessionController.CurrentIdentity.IdCulture %>';
            var comboPart = $find('<%= CmbPart.ClientID %>');
            context["CodPart"] = comboPart.get_text().split('-')[0].replace(' ', '');
            context["Text"] = '';
        }
    </script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CustomJSPlaceHolder" runat="server">
</asp:Content>
