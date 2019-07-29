using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.SessionState;
using System.Web.UI.WebControls;
using System.Management;
using DAL;

namespace SM.WEB
{
    public class BasicPage : System.Web.UI.Page
    {
        public static DataSet dsuserinfo = new DataSet();
        public static DataSet dsFpermission = new DataSet();
        public static DataSet dsSpermission = new DataSet();
        
        protected override void OnPreInit(EventArgs e)
        {
            try
            {
                #region 是否注册
                DataSet ds = SQLHelper.GetDataSet("select top 1 * from SysLicense(nolock)");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    if (Security.symmetry_Decode(ds.Tables[0].Rows[0]["ReleaseCode"].ToString(), "QWERTYUI") != GetCPUSerialNumber())
                    {
                        Response.Redirect("/NoRegist.aspx");
                    }                   
                }
                else
                {
                    Response.Redirect("/NoRegist.aspx");
                }
                #endregion

                #region 是否有权限
                if (Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = Session["_dsuserinfo"] as DataSet;
                }
                else
                {
                    Response.Redirect("/Login.aspx");
                }
                if (Session["_dsFpermission"] != null)
                {
                    dsFpermission = Session["_dsFpermission"] as DataSet;
                }
                else
                {
                    Response.Redirect("/Login.aspx");
                }
                if (Session["_dsSpermission"] != null)
                {
                    dsSpermission = Session["_dsSpermission"] as DataSet;
                }
                else
                {
                    Response.Redirect("/Login.aspx");
                }
                //Label lb = this.FindControl("lblPage") as Label;
                #endregion
            }
            catch (Exception ex)
            {

            }

        }
        protected static bool GetPermission(string Menu)
        {           
            bool flag = false;
            try
            {
                DataRow[] dr =dsSpermission.Tables[0].Select("MenuName='"+Menu+"'");
                if (dr.Length > 0)
                {
                    flag = true;
                }
            }
            catch (Exception ex)
            {

            }
            return flag;

        }
        public static string GetCPUSerialNumber()
        {
            string cpuSerialNumber = string.Empty;
            ManagementClass mc = new ManagementClass("Win32_Processor");
            ManagementObjectCollection moc = mc.GetInstances();
            foreach (ManagementObject mo in moc)
            {
                cpuSerialNumber = mo["ProcessorId"].ToString();
                break;
            }
            mc.Dispose();
            moc.Dispose();
            return cpuSerialNumber;
        }
    }
}