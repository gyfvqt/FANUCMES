﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SM.WEB.Views.WMS
{
    public partial class Warehouse : BasicPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string menu = lblPage.Text.Trim();
            if (!BasicPage.GetPermission(menu))
            {
                Response.Redirect("/Login.aspx");
            }
        }
    }
}