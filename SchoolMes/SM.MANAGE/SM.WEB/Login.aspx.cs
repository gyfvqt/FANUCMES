using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SM.WEB
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var md5123456 = Security.md5_Encode("123456");
            try
            {
                Session["_dsuserinfo"] = null;
                Session["_dsFpermission"] = null;
                Session["_dsSpermission"] = null;
            }
            catch (Exception ex)
            { }
        }
    }
}