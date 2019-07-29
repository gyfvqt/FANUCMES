<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="chart_area.aspx.cs" Inherits="SM.WEB.chart.chart_area" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="/kendoui.core/styles/kendo.common.min.css" rel="stylesheet" />
    <link href="/kendoui.core/styles/kendo.default.min.css" rel="stylesheet" />
    <link href="/kendoui.core/styles/kendo.default.mobile.min.css" rel="stylesheet" />
    <script src="/kendoui.core/js/jquery.min.js"></script>
    <script src="/kendoui.core/js/kendo.ui.core.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="example">
            <div id="grid"></div>
            <script>
                $(document).ready(function () {
                    $("#grid").kendoGrid({
                        dataSource: {
                            type: "odata",
                            transport: {
                                read: "https://demos.telerik.com/kendo-ui/service/Northwind.svc/Customers"
                            },
                            pageSize: 20
                        },
                        height: 550,
                        groupable: true,
                        sortable: true,
                        pageable: {
                            refresh: true,
                            pageSizes: true,
                            buttonCount: 5
                        },
                        columns: [{
                            template: "<div class='customer-photo'" +
                            "style='background-image: url(/StyleFiles/content/web/Customers/#:data.CustomerID#.jpg);'></div>" +
                            "<div class='customer-name'>#: ContactName #</div>",
                            field: "ContactName",
                            title: "Contact Name",
                            width: 240
                        }, {
                            field: "ContactTitle",
                            title: "Contact Title"
                        }, {
                            field: "CompanyName",
                            title: "Company Name"
                        }, {
                            field: "Country",
                            width: 150
                        }]
                    });
                });
            </script>
        </div>

        <style type="text/css">
            .customer-photo {
                display: inline-block;
                width: 32px;
                height: 32px;
                border-radius: 50%;
                background-size: 32px 35px;
                background-position: center center;
                vertical-align: middle;
                line-height: 32px;
                box-shadow: inset 0 0 1px #999, inset 0 0 10px rgba(0,0,0,.2);
                margin-left: 5px;
            }

            .customer-name {
                display: inline-block;
                vertical-align: middle;
                line-height: 32px;
                padding-left: 3px;
            }
        </style>
    </form>
</body>
</html>
