using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.SessionState;

namespace SM.WEB
{
    public partial class PageM : System.Web.UI.MasterPage
    {
               
        public DataSet dsuserinfo = new DataSet();
        public DataSet dsFpermission = new DataSet();
        public DataSet dsSpermission = new DataSet();
        public string pagename = "";
        //public string menuHTML = "<li class='with-right-arrow'><span>< span class='list-count'>2</span>刀具管理</span><ul class='big-menu'><li><a href = '#' > 刀具主数据 </ a ></ li >< li >< a href='#'>换刀提醒设置</a></li></ul></li>";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Label lbl = (Label)this.ContentPlaceHolder1.FindControl("lblPage");
                pagename = lbl.Text;
                if (Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = Session["_dsuserinfo"] as DataSet;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
                if (Session["_dsFpermission"] != null)
                {
                    dsFpermission = Session["_dsFpermission"] as DataSet;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
                if (Session["_dsSpermission"] != null)
                {
                    dsSpermission = Session["_dsSpermission"] as DataSet;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}