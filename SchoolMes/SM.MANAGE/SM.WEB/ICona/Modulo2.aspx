<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Modulo2.aspx.cs" Inherits="Fca.Cups.WebApp.ICona.Modulo2" %>

<asp:Content ContentPlaceHolderID="PortalContent" runat="server">
    <link rel="stylesheet" href="/Content/theme/styles/progress-slider.css?v=1">

    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxProxy">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="GridTest">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTest" LoadingPanelID="RdLoading" />
                    <telerik:AjaxUpdatedControl ControlID="PnlEdit" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="BtnNext">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlQuestionDetail" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="BtnClose">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridTest" LoadingPanelID="RdLoading" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="BtnCancel">
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
                    OnNeedDataSource="GridTest_NeedDataSource" OnItemCommand="GridTest_ItemCommand">
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
                            <telerik:GridBoundColumn DataField="NCaseTest" ItemStyle-HorizontalAlign="Center" HeaderText="<%$ Resources:LocalString, Res_ICONA_NCase %>" HeaderStyle-Width="150">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn UniqueName="Succed" DataField="Succed" HeaderText="<%$ Resources:LocalString, Res_ICONA_Succed %>"
                                AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100"> 
                                <ItemTemplate>
                                    <telerik:RadBinaryImage CssClass="margin-right" ID="Image" runat="server"
                                        Width="32px"
                                        AutoAdjustImageControlSize="false"
                                        ResizeMode="Fit" ImageAlign="Middle" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </dd>

            <%--TEST SECTION--%>
            <dt id="testSection" class="not-closable" style="display: none">
                <asp:Label ID="Label4" runat="server" Text="<%$ Resources:LocalStrings, Res_ICONA_Test %>"></asp:Label></dt>
            <dd style="display: none">
                <div id="PnlEdit" runat="server" cssclass="with-small-padding" visible="false">

                    <asp:Panel ID="pnlDemo" runat="server" Visible="false">
                        <div id="ucEnvironmentPanel_pnlEnvironmentMessage" class="align-center">
                            <p class="message red-gradient simpler" style="font-weight: bold;">
                                <%= Fca.Cups.WebApp.Common.Localization.GetString("Res_ICONA_Demo") %>
                            </p>
                        </div>
                    </asp:Panel>

                    <asp:Panel CssClass="small-margin-bottom margin-top" ID="PnlQuestion" runat="server">
                        <div class="columns">
                                    <div class="twelve-columns wizard-steps" id="lblQuestion" runat="server" style="text-align:left;font-size:16px;height:auto;min-height:40px;padding-top:10px;padding-bottom:10px;padding-left:5px;width:97%"> 
                                </div>
                            </div>
                        <telerik:RadAjaxPanel runat="server" ID="pnlQuestionDetail">
                             
                            <div class="columns with-mid-padding">
                                <div class=" six-columns">
                                    <telerik:RadBinaryImage CssClass="margin-right" ID="ImageUploaded" runat="server"
                                        Width="100%"
                                        AutoAdjustImageControlSize="false" 
                                        ResizeMode="Fit" ImageAlign="Middle" />
                                </div>

                                <div class=" six-columns">
                                    <fieldset class="fieldset">
                                        <legend class="legend"><asp:Label ID="Label1" runat="server" Text="<%$ Resources:LocalStrings, Res_Answer %>"></asp:Label></legend>

                                        <asp:Repeater runat="server" ID="RptAnswer">
                                            <ItemTemplate>
                                                <div class="new-row with-mid-padding">

                                                    <input type="checkbox" id="ckCorrect" runat="server" name="checkbox-2" data-idanswer='<%# Eval("IdAnswer") %>' value="1" class="checkbox mid-margin-left">
                                                    <label for="checkbox-2" class="label"><%# Eval("DesAnswer") %></label>

                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                    </fieldset>
                                </div>



                            </div>
                            <div class="columns">

                                <div class="eleven-columns with-small-padding">

                                    <span id="outerProgress" runat="server" class="progress anthracite thin " style="width: 100%">
                                        <span id="innerProgress" runat="server" class="progress-bar" style="width: 0%"></span>
                                    </span>

                                </div>
                                <div class="one-columns with-small-padding ">
                                    <asp:Label ID="lblProg" runat="server" Text="1/3"></asp:Label>
                                </div>

                            </div>

                        </telerik:RadAjaxPanel>
                        <div class="columns with-mid-padding small-margin-bottom">
                            <div class="six-columns no-margin-bottom with-mid-padding">
                                <asp:Label ID="Label2" runat="server" CssClass="bold" Text="<%$ Resources:LocalStrings, Res_ICONA_MsgHelpUser %>"></asp:Label>
                            </div>
                            <div class="five-columns align-right no-margin-bottom with-mid-padding">
                                <asp:LinkButton ID="BtnCancel" runat="server" CssClass="button white-gradient" OnClick="BtnCancel_Click">
                                    <asp:Label ID="LblCancel" runat="server" Text="<%$ Resources:LocalStrings, Res_ICONA_Cancel %>"></asp:Label>
                                    <span class="button-icon right-side blue-gradient"><span class="icon-undo"></span></span>
                                </asp:LinkButton>
                                <asp:LinkButton ID="BtnNext" runat="server" CssClass="button white-gradient" OnClick="BtnNext_Click">
                                    <asp:Label ID="lblNext" runat="server" Text="<%$ Resources:LocalStrings, Res_Next %>"></asp:Label>
                                    <span class="button-icon right-side blue-gradient"><span class="icon-forward"></span></span>
                                </asp:LinkButton>
                            </div>
                        </div>

                    </asp:Panel>

                    <asp:Panel CssClass="with-mid-padding small-margin-bottom margin-top" ID="PnlResult" runat="server" Visible="false">

                        <asp:Panel ID="pnlCorrect" runat="server" CssClass="block-title">
                            <h2 class="align-center">
                                <label id="lblSuccedMsg" runat="server" />
                            </h2>
                            <h2 class="align-center"><%= Fca.Cups.WebApp.Common.Localization.GetString("Res_ICONA_Congratulations") %> </h2>
                            <div class="align-center">
                                <img src="ImgTest/success.png" />
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlError" runat="server" CssClass="block-title">
                            <h2 class="align-center">
                                <label id="lblErrorMsg" runat="server" />
                            </h2>
                            <h2 class="align-center"><%= Fca.Cups.WebApp.Common.Localization.GetString("Res_ICONA_TryAgain") %> </h2>
                            <div class="align-center imgContainer">
                                <img src="ImgTest/under_construction.png" height="128" />
                            </div>
                        </asp:Panel>

                        <div class="columns with-mid-padding small-margin-bottom">
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


    <telerik:RadScriptBlock runat="server">
        <script type="text/javascript">
            function CollapseGrid() {
                $(document.body).applySetup();
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


<asp:Content ContentPlaceHolderID="CustomJSPlaceHolder" runat="server">
</asp:Content>
