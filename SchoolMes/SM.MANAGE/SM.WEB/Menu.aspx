<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="SM.WEB.Menu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="kendoui.core/styles/kendo.common.min.css" rel="stylesheet" />
    <link href="kendoui.core/styles/kendo.default.min.css" rel="stylesheet" />
    <link href="kendoui.core/styles/kendo.default.mobile.min.css" rel="stylesheet" />
    <script src="kendoui.core/js/jquery.min.js"></script>
    <script src="kendoui.core/js/kendo.ui.core.min.js"></script> 

</head>
<body>
    <form id="form1" runat="server">
        <div id="example">
        <div id="megaStore">
            <ul id="menu">
                <li>
                    Products
                    <ul>
                        <li>
                            Furniture
                            <ul>
                                <li>Tables & Chairs</li>
                                <li>Sofas</li>
                                <li>Occasional Furniture</li>
                                <li>Children's Furniture</li>
                                <li>Beds</li>
                            </ul>


                        </li>
                        <li>
                            Decor
                            <ul>
                                <li>Bed Linen</li>
                                <li>Throws</li>
                                <li>Curtains & Blinds</li>
                                <li>Rugs</li>
                                <li>Carpets</li>
                            </ul>
                        </li>
                        <li>
                            Storage
                            <ul>
                                <li>Wall Shelving</li>
                                <li>Kids Storage</li>
                                <li>Baskets</li>
                                <li>Multimedia Storage</li>
                                <li>Floor Shelving</li>
                                <li>Toilet Roll Holders</li>
                                <li>Storage Jars</li>
                                <li>Drawers</li>
                                <li>Boxes</li>
                            </ul>

                        </li>
                        <li>
                            Lights
                            <ul>
                                <li>Ceiling</li>
                                <li>Table</li>
                                <li>Floor</li>
                                <li>Shades</li>
                                <li>Wall Lights</li>
                                <li>Spotlights</li>
                                <li>Push Light</li>
                                <li>String Lights</li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li>
                    Stores
                    <ul>
                        <li>
                            <div id="template" style="padding: 10px;">
                                <h2>Around the Globe</h2>
                                <ol>
                                    <li>United States</li>
                                    <li>Europe</li>
                                    <li>Canada</li>
                                    <li>Australia</li>
                                </ol>
                                <img src="/StyleFiles/content/web/menu/map.png" alt="Stores Around the Globe" />
                                <button class="k-button">See full list</button>
                            </div>
                        </li>
                    </ul>
                </li>
                <li>
                    Blog
                </li>
                <li>
                    Company
                </li>
                <li>
                    Events
                </li>
                <li disabled="disabled">
                    News
                </li>
            </ul>
        </div>
        <style>
            #megaStore {
                max-width: 600px;
                margin: 30px auto;
                padding-top: 120px;
                /*background: url('/StyleFiles/content/web/menu/header.jpg') no-repeat center 0;*/
            }
            #menu h2 {
                font-size: 1em;
                text-transform: uppercase;
                padding: 5px 10px;
            }
            #template img {
                margin: 5px 20px 0 0;
                float: left;
            }
            #template {
                width: 380px;
            }
            #template ol {
                float: left;
                margin: 0 0 0 30px;
                padding: 10px 10px 0 10px;
            }
            #template:after {
                content: ".";
                display: block;
                height: 0;
                clear: both;
                visibility: hidden;
            }
            #template .k-button {
                float: left;
                clear: left;
                margin: 5px 0 5px 12px;
            }
        </style>
        <script>
            $(document).ready(function() {
                $("#menu").kendoMenu();
            });
        </script>
    </div>
    </form>
</body>
</html>
