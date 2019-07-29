<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="Fca.Cups.WebApp.ICona.Report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeaderCSS" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PortalContent" runat="server">

<asp:Panel runat="server" ID="PnlContainer" class="with-mid-padding">
    <dl id="accordionCannedReport" class="accordion toggle-mode">
        <dt id="list-filter" ><asp:Label ID="Label1" runat="server" Text="<%$ Resources:LocalStrings, Res_Report %>"></asp:Label></dt>
        <dd id="listfilterdd"  style="display: block">
            <div class="with-small-padding margin-bottom">
                <telerik:RadAjaxPanel ID="RadAjaxPanelProfile" runat="server" LoadingPanelID="RdLoading">
                    <h4><asp:Label ID="Label2" runat="server" Text="<%$ Resources:LocalStrings, Res_PerformanceTestPublished %>"></asp:Label></h4>
                    <div class="columns">
                        <div class="nine-columns">
                            <div class="button-height inline-medium-label ">
                                <label for="RadCmbPlant" class="label">
                                    <div style="white-space: nowrap;">
                                        <asp:Label ID="lblPlant" runat="server" Text="<%$ Resources:LocalStrings, Res_Plant %>"></asp:Label>
                                    </div>
                                </label>
                                <telerik:RadComboBox ID="RadCmbPlant" runat="server" CheckBoxes="true" EnableCheckAllItemsCheckBox="false"
                                    RenderMode="Lightweight" Width="60%" AllowCustomText="false" DataValueField="CodPlant" DataTextField="LocalizedText">
                                </telerik:RadComboBox>
                            </div>

                            <div class="button-height inline-medium-label ">
                                <label for="RadCmbAuditType" class="label">
                                    <div style="white-space: nowrap;">
                                        <asp:Label ID="Label4" runat="server" Text="<%$ Resources:LocalStrings, Res_AuditType %>"></asp:Label>
                                    </div>
                                </label>
                                <telerik:RadComboBox ID="RadCmbAudit" runat="server" EnableCheckAllItemsCheckBox="false"
                                    RenderMode="Lightweight" Width="60%" AllowCustomText="false" DataValueField="IDAuditType" DataTextField="LocalizedText">
                                </telerik:RadComboBox>
                            </div>
                            
                        </div>
                        <div class="three-columns float-right">
                            <asp:LinkButton ID="btnExport" CssClass="button white-gradient" runat="server" OnClick="btnExport_Click">
                                <asp:Label ID="Label8" runat="server" Text="<%$ Resources:LocalStrings, Res_ExportToExcel %>"></asp:Label>
                                <span class="button-icon right-side blue-gradient"><span class="icon-extract"></span></span>
                            </asp:LinkButton>
                        </div>
                    </div>
                </telerik:RadAjaxPanel>
            </div>
        </dd>
    </dl>
</asp:Panel>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TemplatePlaceHolderJS" runat="server">
    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CustomJSPlaceHolder" runat="server">
</asp:Content>
