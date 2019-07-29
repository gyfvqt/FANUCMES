using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Helper;
using System.Data;

namespace SM.WEB.Station
{
    public partial class DashboardE : System.Web.UI.Page
    {
        public string lineid = "0";
        public string linename = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                lineid = Request.QueryString["id"]!=null? Request.QueryString["id"].ToString():"0";
                string sql = string.Format(@"select * from EquipmentData(nolock) where ID=N'{0}'", lineid);
                DataSet ds = SQLHelper.GetDataSet(sql);
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    linename = ds.Tables[0].Rows[0]["EquipmentName"].ToString();
                }
            }
            catch(Exception ex) {

            }
        }
    }
}