using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Management;
using Helper;

namespace LicenseTool
{
    public partial class Regist : Form
    {
        public Regist()
        {
            InitializeComponent();
            this.txtCpu.Text = GetCPUSerialNumber();
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

        private void btnGetCpu_Click(object sender, EventArgs e)
        {
            this.txtCpu.Text = GetCPUSerialNumber();
        }

        private void btnRegist_Click(object sender, EventArgs e)
        {
            try
            {
                if (Security.symmetry_Decode(txtReleaseCode.Text.Trim(), "QWERTYUI") == GetCPUSerialNumber())
                {
                    var o = SQLHelper.GetObject("select count(1) as o from SysLicense(nolock)").ToString();
                    if (int.Parse(o) <= 0)
                    {
                        SQLHelper.ExcuteSQL(string.Format(@"insert into SysLicense(ReleaseCode) values(N'{0}')", txtReleaseCode.Text.Trim()));
                        lblMsg.Text = "注册成功！";
                    }
                    else
                    {
                        SQLHelper.ExcuteSQL(string.Format(@"update SysLicense set ReleaseCode=N'{0}',UpdateTime=GETDATE()", txtReleaseCode.Text.Trim()));
                        lblMsg.Text = "注册成功！";
                    }
                }
                else
                {
                    lblMsg.Text = "注册失败！错误的注册码，请联系管理员重新申请！";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "注册失败！错误的注册码，请联系管理员！"+ex.Message;
            }
        }
    }
}
