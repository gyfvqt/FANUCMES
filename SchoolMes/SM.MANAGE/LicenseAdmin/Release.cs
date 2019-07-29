using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Helper;

namespace LicenseAdmin
{
    public partial class Release : Form
    {
        public Release()
        {
            InitializeComponent();
        }

        private void btnRegist_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtCpu.Text.Trim() != "")
                {
                    txtReleaseCode.Text = Security.symmetry_Encode(txtCpu.Text.Trim(), "QWERTYUI");
                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}
