<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConfModulo2.aspx.cs" Inherits="Fca.Cups.WebApp.ICona.ConfModulo2" %>

<asp:Content ContentPlaceHolderID="PortalContent" runat="server">
    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxProxy">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="GridTest">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTest" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="PnlEdit" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="RadCmbPlant" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="RdPublish" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="RadCmbTypeTest" />
                    <telerik:AjaxUpdatedControl ControlID="RadCmbAuditType" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="GridQuestion">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridQuestion" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="RadWindowManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlEdit" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="BtnDownloadTraslate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlEdit" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSavePublish">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTest" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="BtnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTest" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnCancelPublish">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTest" LoadingPanelID="RdLoading" />
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
                <telerik:RadGrid runat="server" ID="GridTest" Width="100%" 
                    OnItemDataBound="GridTest_ItemDataBound" OnInit="GridTest_Init"
                    OnNeedDataSource="GridTest_NeedDataSource" OnItemCommand="GridTest_ItemCommand" OnPreRender="GridTest_PreRender">
                    <MasterTableView ShowHeadersWhenNoRecords="true" CommandItemDisplay="Top" DataKeyNames="IDConfiguration">
                        <CommandItemTemplate>
                            <div class=" margin-bottom with-mid-padding">
                                <div class="columns">
                                    <div class="six-columns twelve-columns-mobile">
                                        <div class="button-height inline-medium-label ">
                                            <label for="RadCmbLanguage" class="label">
                                                <div style="white-space: nowrap;">
                                                    <asp:Label ID="LblLanguage" runat="server" Text="<%$ Resources:LocalStrings, Res_GridLanguage %>"></asp:Label>
                                                </div>
                                            </label>
                                            <telerik:RadComboBox ID="RadCmbLanguage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="RadCmbLanguage_SelectedIndexChanged" OnDataBound="RadCmbLanguage_DataBound"
                                                RenderMode="Lightweight" Width="60%" AllowCustomText="false" DataValueField="IDCulture" DataTextField="DesCultureName">
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>

                                    <div class="six-columns twelve-columns-mobile align-right">
                                        <asp:LinkButton ID="BtnDownloadTraslateToolBar"  runat="server"   OnClick="BtnDownloadTraslateTool_Click" CssClass="button compact icon-mailbox blue-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_DownloadTraslate %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                        <asp:LinkButton ID="BtnUploadTraslateToolBar" runat="server"   OnClick="BtnUploadTraslateTool_Click" CssClass="button compact icon-publish blue-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_UploadTraslate %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                        <asp:LinkButton ID="btnAdd" runat="server" CssClass="button white-gradient" CommandName="AddNewConfiguration">
                                            <asp:Label ID="LblAdd" runat="server" Text="<%$ Resources:LocalStrings, Res_Add %>"></asp:Label>
                                            <span class="button-icon right-side blue-gradient"><span class="icon-plus-round"></span></span>
                                        </asp:LinkButton>
                                    </div>
                                    <div class="six-columns twelve-columns-mobile new-row">
                                        <div class="button-height inline-medium-label ">
                                            <label for="RadCmbFilterType" class="label">
                                                <div style="white-space: nowrap;">
                                                    <asp:Label ID="Label3" runat="server" Text="<%$ Resources:LocalStrings, Res_TypeTest %>"></asp:Label>
                                                </div>
                                            </label>
                                            <telerik:RadComboBox ID="RadCmbFilterType" runat="server" AutoPostBack="true" 
                                        RenderMode="Lightweight" AllowCustomText="false" DataValueField="IdTypeTest" DataTextField="Description" OnSelectedIndexChanged="IndexFilterChange" OnItemDataBound="Filters_DataBound">
                                    </telerik:RadComboBox>
                                        </div>
                                    </div>
                                    <div class="six-columns twelve-columns-mobile">
                                        <div class="button-height inline-medium-label ">
                                            <label for="RadCmbFilterAuditType" class="label">
                                                <div style="white-space: nowrap;">
                                                    <asp:Label ID="Label4" runat="server" Text="<%$ Resources:LocalStrings, Res_AuditType %>"></asp:Label>
                                                </div>
                                            </label>
                                            <telerik:RadComboBox ID="RadCmbFilterAuditType" runat="server" AutoPostBack="true"
                                                RenderMode="Lightweight" AllowCustomText="false" DataValueField="IdAuditType" DataTextField="Description" OnSelectedIndexChanged="IndexFilterChange">
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>
                                    <div class="six-columns twelve-columns-mobile">
                                        <div class="button-height inline-medium-label ">
                                            <label for="RadCmbFilterPublished" class="label">
                                                <div style="white-space: nowrap;">
                                                    <asp:Label ID="Label5" runat="server" Text="<%$ Resources:LocalStrings, Res_Published %>"></asp:Label>
                                                </div>
                                            </label>
                                            <telerik:RadComboBox ID="RadCmbFilterPublished" runat="server" AutoPostBack="true"
                                                RenderMode="Lightweight" AllowCustomText="false" DataTextField="Text" DataValueField="Value" OnSelectedIndexChanged="IndexFilterChange" >
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>
                                    <div class="six-columns twelve-columns-mobile">
                                        <div class="button-height inline-medium-label ">
                                            <label for="RadCmbFilterEditable" class="label">
                                                <div style="white-space: nowrap;">
                                                    <asp:Label ID="Label6" runat="server" Text="<%$ Resources:LocalStrings,  Res_Icona_Editable %>"></asp:Label>
                                                </div>
                                            </label>
                                            <telerik:RadComboBox ID="RadCmbFilterEditable" runat="server" AutoPostBack="true"
                                                RenderMode="Lightweight" AllowCustomText="false" DataTextField="Text" DataValueField="Value" OnSelectedIndexChanged="IndexFilterChange" >
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </CommandItemTemplate>
                        <Columns>
                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="130px">
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="SelectItem_check" ClientIDMode="Static" value='<%# Eval("IDConfiguration") %>' AutoPostBack="true"  OnCheckedChanged="GridTest_SelectRowGrid"/>
                                    <asp:LinkButton ID="BtnConfigureTree" runat="server" CommandArgument='<%# Eval("IDConfiguration") %>' CommandName="EditConfiguration" CssClass="button compact icon-gear with-tooltip" title="<%$ Resources:LocalStrings, Res_Configure %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                    <asp:LinkButton ID="BtnDelete" runat="server" OnLoad="BtnDel_Load1" CommandArgument='<%# Eval("IDConfiguration") %>' CommandName="DeleteConfiguration" CssClass="button compact icon-trash red-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_Delete %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                    <asp:LinkButton ID="BtnPublish" runat="server" CommandArgument='<%# Eval("IDConfiguration") %>' CommandName="PublishConfiguration" CssClass="button compact icon-extract with-tooltip" title="<%$ Resources:LocalStrings, Res_Publish %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                    <asp:LinkButton ID="BtnTrialTest" runat="server" CommandArgument='<%# Eval("IDConfiguration") %>' CommandName="TrialTest" CssClass="button compact icon-paper-plane with-tooltip" title="<%$ Resources:LocalStrings, Res_TrialTest %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="Title" HeaderText="<%$ Resources:LocalString, Res_ICONA_Title %>" HeaderStyle-Width="135">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn UniqueName="LevelTest" HeaderText="<%$ Resources:LocalStrings, Res_TypeTest %>" DataField="IdTypeTest" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" HeaderStyle-Width="160">
                                <ItemTemplate>
                                    <asp:Label ID="lblTypeTest" runat="server" Text="" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="AuditType" HeaderText="<%$ Resources:LocalStrings, Res_AuditType %>" DataField="IdAuditType" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" HeaderStyle-Width="160">
                                <ItemTemplate>
                                    <asp:Label ID="lblAuditType" runat="server" Text="" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="DesPlant" HeaderText="<%$ Resources:LocalString, Res_ICONA_Plant %>" HeaderStyle-Width="200">
                            </telerik:GridBoundColumn>  
                            <telerik:GridBoundColumn UniqueName="DateValidFrom" DataField="DateValidFrom" HeaderText="<%$ Resources:LocalString, Res_DateFrom %>"
                               ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d/M/yyyy}" DataType="System.Date" HeaderStyle-Width="145">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="DateValidTo" DataField="DateValidTo" HeaderText="<%$ Resources:LocalString, Res_DateTo %>"
                                ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d/M/yyyy}" DataType="System.Date" HeaderStyle-Width="145">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="IsPublished" UniqueName="IsPublished" HeaderText="<%$ Resources:LocalString, Res_Published %>"
                                 AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="75">
                                <ItemTemplate>
                                    <span id="SuccedIcona" runat="server" class="icon-tick green icon-size2 with-padding"></span>
                                    <span id="WarningIcona" runat="server" class="icon-cross red icon-size2 with-padding"></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>  
                            <telerik:GridTemplateColumn DataField="IsEditable" UniqueName="IsEditable" HeaderText="<%$ Resources:LocalString, Res_Icona_Editable %>"
                                AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="75">
                                <ItemTemplate>
                                    <span id="SuccedIcona_Editable" runat="server" class="icon-tick green icon-size2 with-padding"></span>
                                    <span id="WarningIcona_editable" runat="server" class="icon-cross red icon-size2 with-padding"></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </dd>
            <%--Edit Test SECTION--%>
            <dt id="testSection" class="not-closable" style="display: none">
                <asp:Label ID="LblInsertEdit" runat="server" Text="<%$ Resources:LocalStrings, Res_ICONA_Test %>" />
            </dt>
            <dd style="display: none">
                <telerik:RadAjaxPanel ID="PnlEdit" runat="server" CssClass="with-mid-padding" Visible="false">
                    <asp:Panel CssClass="columns with-mid-padding small-margin-bottom" ID="pnlEditConfig" runat="server">
                        <div class="columns">
                            <div class="eight-columns">
                                <div class="button-height inline-label full-width">
                                    <label for="lblDesc" class="label">
                                        <div style="white-space: nowrap;">
                                            <asp:Label for="lblDesc" runat="server" Text="<%$ Resources:LocalStrings, Res_DesQuiz %>" />
                                        </div>
                                    </label>
                                    <input id="lblDescQuiz" maxlength="1000" runat="server" clientidmode="Static" style="width:400px;" class="full-width input" />
                                </div>
                            </div>                            
                            <div class="four-columns align-right">
                                <div class="button-height button-height inline-label full-width ">
                                    <asp:LinkButton ID="BtnDownloadTraslate"  runat="server" OnLoad="BtnTransl_Load" OnClick="BtnDownloadTraslate_Click" CssClass="button compact icon-mailbox blue-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_DownloadTraslate %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                    <asp:LinkButton ID="BtnUploadTraslate" runat="server" OnLoad="BtnTransl_Load" OnClick="BtnUploadTraslate_Click" CssClass="button compact icon-publish blue-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_UploadTraslate %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                </div>
                            </div>
                            <div class="four-columns new-row">
                                <div class="button-height button-height inline-label full-width ">
                                    <label for="RadCmbPlant" class="label">
                                        <div style="white-space: nowrap;">
                                            <asp:Label ID="lblTypeTest" runat="server" Text="<%$ Resources:LocalStrings, Res_TypeTest %>"></asp:Label>
                                        </div>
                                    </label>
                                    <telerik:RadComboBox ID="RadCmbTypeTest" runat="server" AutoPostBack="true"  style="width:400px;"
                                        RenderMode="Lightweight" AllowCustomText="false" DataValueField="IdTypeTest" DataTextField="Description">
                                    </telerik:RadComboBox>
                                </div>
                            </div>
                            <div class="four-columns new-row">
                                <div class="button-height button-height inline-label full-width ">
                                    <label for="RadCmbAuditType" class="label">
                                        <div style="white-space: nowrap;">
                                            <asp:Label ID="lblIdAuditType" runat="server" Text="<%$ Resources:LocalStrings, Res_Audit_Types %>"></asp:Label>
                                        </div>
                                    </label>
                                    <telerik:RadComboBox ID="RadCmbAuditType" runat="server" AutoPostBack="true"  style="width:400px;"
                                        RenderMode="Lightweight" AllowCustomText="false" DataValueField="IdAuditType" DataTextField="Description">
                                    </telerik:RadComboBox>
                                </div>
                            </div>
                        </div>
                        <div class="button-height inline-label new-row">
                            <asp:Label ID="Label1" runat="server" CssClass="label" Text="<%$ Resources:LocalStrings, Res_ICONA_Visibility %>"/> 
                        </div> 
                        <%-- Grid Plant --%>
                        <telerik:RadGrid runat="server" ID="GridPlant" 
                            OnInit="GridPlant_Init" OnNeedDataSource="GridPlant_NeedDataSource"
                            OnItemCommand="GridPlant_ItemCommand"  OnPreRender="GridPlant_PreRender">
                            <MasterTableView ShowHeadersWhenNoRecords="true" CommandItemDisplay="Top" DataKeyNames="CodPlant">
                                <CommandItemTemplate>
                                    <div class="margin-bottom with-mid-padding">
                                        <div class="columns">
                                            <div class="six-columns twelve-columns-mobile">
                                                <div class="button-height inline-medium-label ">
                                                    <label for="RadCmbPlant" class="label">
                                                        <div style="white-space: nowrap;">
                                                            <asp:Label ID="lblPlant" runat="server" Text="<%$ Resources:LocalStrings, Res_Plant %>"></asp:Label>
                                                        </div>
                                                    </label>
                                                    <telerik:RadComboBox ID="RadCmbPlant" runat="server" AutoPostBack="false" 
                                                        RenderMode="Lightweight" Width="60%" AllowCustomText="false" DataValueField="CodPlant" DataTextField="LocalizedText">
                                                    </telerik:RadComboBox>
                                                </div>
                                            </div>
                                            <div class="six-columns twelve-columns-mobile align-right">
                                                <asp:LinkButton ID="btnAdd" runat="server" CssClass="button white-gradient" CommandName="AddNewPlant">
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
                                            <asp:LinkButton ID="BtnDelete" OnLoad="BtnDel_Load" runat="server" CommandArgument='<%# Eval("CodPlant") %>' CommandName="DeletePlant" CssClass="button compact icon-trash red-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_Delete %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="LocalizedText" HeaderText="<%$ Resources:LocalString, Res_Plant %>">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>




                        <div class="button-height inline-label new-row">
                            <asp:Label ID="Label35" runat="server" CssClass="label" Text="<%$ Resources:LocalStrings, Res_ICONA_ListQuestion %>"/> 
                        </div>  

                        <%-- Grid Question --%>
                        <telerik:RadGrid runat="server" ID="GridQuestion"
                            OnItemDataBound="GridQuestion_ItemDataBound" OnInit="GridQuestion_Init"
                            OnItemCommand="GridQuestion_ItemCommand" OnNeedDataSource="GridQuestion_NeedDataSource">
                            <MasterTableView ShowHeadersWhenNoRecords="true" CommandItemDisplay="Top" DataKeyNames="IDQuestion">
                                <CommandItemTemplate>
                                    <div class=" margin-bottom with-mid-padding">
                                        <div class="columns">
                                            <div class="twelve-columns twelve-columns-mobile align-right">
                                                <asp:LinkButton ID="btnAdd" runat="server" CssClass="button white-gradient" CommandName="AddNewQuestion">
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
                                            <asp:LinkButton ID="BtnConfigureQuestion" runat="server" CommandArgument='<%# Eval("IDQuestion") %>' CommandName="EditQuestion" CssClass="button compact icon-gear with-tooltip" title="<%$ Resources:LocalStrings, Res_Configure %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                            <asp:LinkButton ID="BtnDelete" runat="server" OnLoad="BtnDel_Load" CommandArgument='<%# Eval("IDQuestion") %>' CommandName="DeleteQuestion" CssClass="button compact icon-trash red-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_Delete %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="Question" HeaderText="<%$ Resources:LocalString, Res_ICONA_Question %>">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>

                    </asp:Panel>

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
                </telerik:RadAjaxPanel>
            </dd>

        </dl>
    </div>
    <telerik:RadWindow ID="RdPublish" runat="server" Behaviors="None" Height="180px" Width="950px" Title="<%$ Resources:LocalStrings, Res_Publish %>" Modal="true"> 
                    <ContentTemplate>
                    <telerik:RadAjaxPanel ID="UpComponent" runat="server" LoadingPanelID="RdLoading" CssClass="with-padding top-padding" >       
                        <div CssClass="columns with-mid-padding small-margin-bottom" runat="server">
                            <div class="columns">
                                <div class="four-columns">
                                    <div class="button-height inline-small-label">
                                        <asp:Label runat="server" CssClass="label"  Text="<%$ Resources:LocalStrings, Res_From %>"></asp:Label>
                                        <telerik:RadDatePicker ID="RadDatePickerFrom" runat="server">
                                            <Calendar
		                                        ID="CalendarDatePickerFrom"
		                                        UseRowHeadersAsSelectors="false"
		                                        UseColumnHeadersAsSelectors="false"
		                                        ViewSelectorText="x"
		                                        runat="server">
			                                        <SpecialDays>
				                                        <telerik:RadCalendarDay
					                                        Repeatable="Today"
					                                        ItemStyle-CssClass="green-bg" />
			                                        </SpecialDays>
	                                        </Calendar>
                                        </telerik:RadDatePicker>
                                    </div>
                                </div>
                                <div class="four-columns">
                                    <div class="button-height inline-small-label">
                                        <asp:Label runat="server" CssClass="label"  Text="<%$ Resources:LocalStrings, Res_To %>"></asp:Label>
                                        <telerik:RadDatePicker ID="RadDatePickerTo" runat="server">
                                            <Calendar
		                                        ID="CalendarDatePickerTo"
		                                        UseRowHeadersAsSelectors="false"
		                                        UseColumnHeadersAsSelectors="false"
		                                        ViewSelectorText="x"
		                                        runat="server">
			                                        <SpecialDays>
				                                        <telerik:RadCalendarDay
					                                        Repeatable="Today"
					                                        ItemStyle-CssClass="green-bg" />
			                                        </SpecialDays>
	                                        </Calendar>
                                        </telerik:RadDatePicker>
                                    </div>
                                </div>
                                <div class="four-columns">
                                    <asp:CheckBox ID="ckbIsPublish" runat="server" Text="<%$ Resources:LocalStrings, Res_IsPublish %>" />
                                </div>
                            </div>
                        </div>
                        <div class="columns with-mid-padding small-margin-bottom">
                            <div class="twelve-columns align-right no-margin-bottom">
                                <asp:LinkButton ID="btnCancelPublish" runat="server" CssClass="button white-gradient" OnClick="btnCancelPublish_Click">
                                    <asp:Label ID="Label2" runat="server" Text="<%$ Resources:LocalStrings, Res_Cancel %>"></asp:Label>
                                    <span class="button-icon right-side blue-gradient"><span class="icon-undo"></span></span>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSavePublish" runat="server" CssClass="button white-gradient" OnClick="btnSavePublish_Click">
                                    <asp:Label ID="Label3" runat="server" Text="<%$ Resources:LocalStrings, Res_Save %>"></asp:Label>
                                    <span class="button-icon right-side blue-gradient"><span class="icon-tick"></span></span>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </telerik:RadAjaxPanel>
                    </ContentTemplate>
                </telerik:RadWindow>
    <telerik:RadAjaxPanel runat="server" LoadingPanelID="RdLoading" ID="RadPanel" OnAjaxRequest="RadPanel_AjaxRequest">
        <telerik:RadWindowManager ID="RadWindowManager1" ShowContentDuringLoad="false" VisibleStatusbar="false"
            ReloadOnShow="true" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow ID="RdEditQuestion" runat="server" Behaviors="None" Height="620px" Width="1150px" Title="<%$ Resources:LocalStrings, Res_ICON_Question %>" 
                    OnClientClose="OnClientClose_RdEditQuestion" Modal="true"> 
                    
                </telerik:RadWindow>
                <telerik:RadWindow ID="RdUpTransl" runat="server" Behaviors="None" Height="350px" Width="500px" Title="<%$ Resources:LocalStrings, Res_ICON_Transl %>" 
                    OnClientClose="OnClientClose_RdUpTransl" Modal="true"> 
                    
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </telerik:RadAjaxPanel>

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

            function OnClientClose_RdEditQuestion(sender, args) {
                if (sender != undefined)
                    $find("<%= GridQuestion.ClientID %>").get_masterTableView().rebind();
            }
            function OnClientClose_RdUpTransl(sender, args) {
                if (sender != undefined)
                    $find("<%= GridTest.ClientID %>").get_masterTableView().rebind()
            }

            function openWin(url) {
                var oWnd = radopen(url, "RdEditQuestion");
            }
            function openWinTransl(url)
            {
                var oWndT = radopen(url, "RdUpTransl")
            }
            function openWinPublish() {
                var radwindow = $find('<%=RdPublish.ClientID %>');
                radwindow.show();
            }

            function closePopUpPublish() {
                var radwindow = $find('<%=RdPublish.ClientID %>');
                radwindow.close();
            }
        </script>
    </telerik:RadScriptBlock>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TemplatePlaceHolderJS" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CustomJSPlaceHolder" runat="server">
</asp:Content>
