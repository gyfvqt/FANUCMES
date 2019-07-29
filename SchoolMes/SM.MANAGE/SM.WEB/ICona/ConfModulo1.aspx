<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConfModulo1.aspx.cs" Inherits="Fca.Cups.WebApp.ICona.ConfModulo1" %>

<asp:Content ContentPlaceHolderID="PortalContent" runat="server">
    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxProxy">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="GridTest">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTest" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="PnlEdit" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="RadCmbLevel" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="RdPublish" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="RadCmbAuditType" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RdEditQuestion">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PnlEdit" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="GridStep" LoadingPanelID="RdLoading" />
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
                        <%-- <SortExpressions>
                           <telerik:GridSortExpression FieldName="LevelTest" SortOrder="Ascending" />
                        </SortExpressions>
                        <GroupByExpressions >
                          <telerik:GridGroupByExpression >
                            <GroupByFields>
                              <telerik:GridGroupByField FieldName="LevelTest" />
                            </GroupByFields>
                          </telerik:GridGroupByExpression>
                        </GroupByExpressions>--%>
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
                                        <asp:LinkButton ID="btnAdd" runat="server" CssClass="button white-gradient" CommandName="AddNewConfiguration">
                                            <asp:Label ID="LblAdd" runat="server" Text="<%$ Resources:LocalStrings, Res_Add %>"></asp:Label>
                                            <span class="button-icon right-side blue-gradient"><span class="icon-plus-round"></span></span>
                                        </asp:LinkButton>
                                    </div>
                                    <div class="six-columns twelve-columns-mobile new-row">
                                        <div class="button-height inline-medium-label ">
                                            <label for="RadCmbFilterLevel" class="label">
                                                <div style="white-space: nowrap;">
                                                    <asp:Label ID="Label3" runat="server" Text="<%$ Resources:LocalStrings, Res_LevelTest %>"></asp:Label>
                                                </div>
                                            </label>
                                            <telerik:RadComboBox ID="RadCmbFilterLevel" runat="server" AutoPostBack="true" 
                                        RenderMode="Lightweight" AllowCustomText="false" DataValueField="IdLevel" DataTextField="Description" OnSelectedIndexChanged="IndexFilterChange" OnItemDataBound="Filters_DataBound">
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
                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderStyle-Width="130px" Groupable="false">
                                <ItemTemplate>
                                    <asp:LinkButton ID="BtnConfigureTree" runat="server" CommandArgument='<%# Eval("IDConfiguration") %>' CommandName="EditConfiguration" CssClass="button compact icon-gear with-tooltip" title="<%$ Resources:LocalStrings, Res_Configure %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                    <asp:LinkButton ID="BtnDelete" runat="server" CommandArgument='<%# Eval("IDConfiguration") %>' CommandName="DeleteConfiguration" CssClass="button compact icon-trash red-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_Delete %>" data-tooltip-options='{"removeOnBlur" : true}' OnLoad="BtnDelete_Load"></asp:LinkButton>
                                    <asp:LinkButton ID="BtnPublish" runat="server" CommandArgument='<%# Eval("IDConfiguration") %>' CommandName="PublishConfiguration" CssClass="button compact icon-extract with-tooltip" title="<%$ Resources:LocalStrings, Res_Publish %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                    <asp:LinkButton ID="BtnTrialTest" runat="server" CommandArgument='<%# Eval("IDConfiguration") %>' CommandName="TrialTest" CssClass="button compact icon-paper-plane with-tooltip" title="<%$ Resources:LocalStrings, Res_TrialTest %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="LocalizedText" UniqueName="LocalizedText" HeaderText="<%$ Resources:LocalString, Res_ICONA_Title %>" HeaderStyle-Width="200">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn UniqueName="LevelTest" HeaderText="<%$ Resources:LocalStrings, Res_LevelTest %>" DataField="LevelTest" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" HeaderStyle-Width="100">
                                <ItemTemplate>
                                    <asp:Label ID="lblLevelTest" runat="server" Text="" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="AuditType" HeaderText="<%$ Resources:LocalStrings, Res_AuditType %>" DataField="IdAuditType" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" HeaderStyle-Width="160">
                                <ItemTemplate>
                                    <asp:Label ID="lblAuditType" runat="server" Text="" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridDateTimeColumn UniqueName="DateValidFrom" DataField="DateValidFrom" HeaderText="<%$ Resources:LocalString, Res_DateFrom %>"
                               DataFormatString="{0:d/M/yyyy}" DataType="System.Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridDateTimeColumn UniqueName="DateValidTo" DataField="DateValidTo" HeaderText="<%$ Resources:LocalString, Res_DateTo %>"
                                DataFormatString="{0:d/M/yyyy}" DataType="System.Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridTemplateColumn DataField="IsPublished" UniqueName="IsPublished" HeaderText="<%$ Resources:LocalString, Res_Published %>"
                                AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100">
                                <ItemTemplate>
                                    <span id="SuccedIcona" runat="server" class="icon-tick green icon-size2 with-padding"></span>
                                    <span id="WarningIcona" runat="server" class="icon-cross red icon-size2 with-padding"></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="IsEditable" UniqueName="IsEditable" HeaderText="<%$ Resources:LocalString, Res_Icona_Editable %>"
                                AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100">
                                <ItemTemplate>
                                    <span id="SuccedIcona_Editable" runat="server" class="icon-tick green icon-size2 with-padding"></span>
                                    <span id="WarningIcona_Editable" runat="server" class="icon-cross red icon-size2 with-padding"></span>
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
                                    <input id="lblDescQuiz" maxlength="100" runat="server" clientidmode="Static" style="width:400px;" class="full-width input" />
                                </div>
                            </div>
                            <div class="four-columns">
                                <div class="button-height button-height inline-label full-width ">
                                    <label for="RadCmbPlant" class="label">
                                        <div style="white-space: nowrap;">
                                            <asp:Label ID="lblPlant" runat="server" Text="<%$ Resources:LocalStrings, Res_LevelTest %>"></asp:Label>
                                        </div>
                                    </label>
                                    <telerik:RadComboBox ID="RadCmbLevel" runat="server" AutoPostBack="true" 
                                        RenderMode="Lightweight" AllowCustomText="false" DataValueField="IdLevel" DataTextField="Description">
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
                                        RenderMode="Lightweight" AllowCustomText="false" DataValueField="IdAuditType" DataTextField="Description" OnSelectedIndexChanged="RadCmbAuditType_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </div>
                            </div>
                        </div>
                        
                        <div class="button-height inline-label new-row">
                            <asp:Label ID="Label35" runat="server" CssClass="label" Text="<%$ Resources:LocalStrings, Res_ICONA_ListStep %>"/> 
                        </div>  
                        <%-- Grid Step --%>
                        <telerik:RadGrid runat="server" ID="GridStep"
                            OnInit="GridStep_Init" OnNeedDataSource="GridStep_NeedDataSource" OnItemCommand="GridStep_ItemCommand">
                            <MasterTableView ShowHeadersWhenNoRecords="true" CommandItemDisplay="Top" DataKeyNames="Order">
                                <CommandItemTemplate>
                                    <div class=" margin-bottom with-mid-padding">
                                        <div class="columns">
                                            <div class="twelve-columns twelve-columns-mobile align-right">
                                                <asp:LinkButton ID="btnAdd" runat="server" CssClass="button white-gradient" CommandName="AddNewStep">
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
                                            <asp:LinkButton ID="BtnConfigureStep" runat="server" CommandArgument='<%# Eval("Order") %>' CommandName="EditStep" CssClass="button compact icon-gear with-tooltip" title="<%$ Resources:LocalStrings, Res_Configure %>" data-tooltip-options='{"removeOnBlur" : true}'></asp:LinkButton>
                                            <asp:LinkButton ID="BtnDelete" runat="server" CommandArgument='<%# Eval("Order") %>' CommandName="DeleteStep" CssClass="button compact icon-trash red-gradient with-tooltip" title="<%$ Resources:LocalStrings, Res_Delete %>" data-tooltip-options='{"removeOnBlur" : true}' OnLoad="BtnDelete_Load1"></asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="Description" HeaderText="<%$ Resources:LocalString, Res_ICONA_Step %>">
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


    <telerik:RadAjaxPanel runat="server" LoadingPanelID="RdLoading" ID="RadPanel" OnAjaxRequest="RadPanel_AjaxRequest">
        <telerik:RadWindowManager ID="RadWindowManager1" ShowContentDuringLoad="false" VisibleStatusbar="false"
            ReloadOnShow="true" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow ID="RdEditQuestion" runat="server" Behaviors="None" Height="620px" Width="1150px" Title="<%$ Resources:LocalStrings, Res_ICON_Step %>" 
                    OnClientClose="OnClientClose_RdEditQuestion" Modal="true">                     
                </telerik:RadWindow>

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
                                    <asp:Label ID="Label1" runat="server" Text="<%$ Resources:LocalStrings, Res_Cancel %>"></asp:Label>
                                    <span class="button-icon right-side blue-gradient"><span class="icon-undo"></span></span>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSavePublish" runat="server" CssClass="button white-gradient" OnClick="btnSavePublish_Click">
                                    <asp:Label ID="Label2" runat="server" Text="<%$ Resources:LocalStrings, Res_Save %>"></asp:Label>
                                    <span class="button-icon right-side blue-gradient"><span class="icon-tick"></span></span>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </telerik:RadAjaxPanel>
                    </ContentTemplate>
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
                    $find("<%= RadPanel.ClientID%>").ajaxRequest("Close");

                $find("<%= GridStep.ClientID %>"
                        ).get_masterTableView().rebind();
            }

            function openWin(url) {
                var oWnd = radopen(url, "RdEditQuestion");
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
<asp:Content ContentPlaceHolderID="TemplatePlaceHolderJS" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="CustomJSPlaceHolder" runat="server">
</asp:Content>
