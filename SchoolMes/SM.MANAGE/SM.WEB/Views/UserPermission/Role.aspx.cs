using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GF2.MES.Report.Helper;
using DAL;
using System.Data;
using SM.WEB;

namespace SM.WEB.Views.UserPermission
{
    public partial class Role : BasicPage
    {
        public DataSet dsmenus = new DataSet();  
        protected void Page_Load(object sender, EventArgs e)
        {
            string menu = lblPage.Text.Trim();
            if (!BasicPage.GetPermission(menu))
            {
                Response.Redirect("/Login.aspx");
            }
            try {
                string sql = @"select * from Menus";
                dsmenus = SQLHelper.GetDataSet(sql);
            }
            catch (Exception ex)
            {

            }
        }
    }
}