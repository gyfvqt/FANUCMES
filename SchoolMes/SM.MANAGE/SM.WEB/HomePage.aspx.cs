using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using iTextSharp.text.pdf.draw;
using System.Diagnostics;
using System.Net;
using System.Net.Sockets;

namespace SM.WEB
{
    public partial class HomePage : BasicPage
    {        
        protected void Page_Load(object sender, EventArgs e)
        {
            var weekdayN = DateTime.Now.DayOfWeek;
            var IP = GetLocalIp();
        }
        private string GetClientIP()
        {
            string result = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (null == result || result == String.Empty)
            {
                result = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            if (null == result || result == String.Empty)
            {
                result = HttpContext.Current.Request.UserHostAddress;
            }
            return result;
        }
        public static string GetLocalIp()
        {
            IPAddress localIp = null;

            try
            {
                IPAddress[] ipArray;
                ipArray = Dns.GetHostAddresses(Dns.GetHostName());
                localIp = ipArray.First(ip => ip.AddressFamily == AddressFamily.InterNetwork);

            }
            catch (Exception ex)
            {
            }
            if (localIp == null)
            {
                localIp = IPAddress.Parse("127.0.0.1");
            }
            return localIp.ToString();
        }
        protected void Unnamed_Click(object sender, EventArgs e)
        {
            Document document = new Document(PageSize.A4, 30, 10, 36, 15);
            string filename = "Pick_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf";
            string fullfilename = "\\PickListPDF\\" + filename;
            PdfWriter.GetInstance(document, new FileStream(Server.MapPath(fullfilename), FileMode.Create));
            document.Open();
            document.AddAuthor("陈秦");
            document.AddCreator("陈秦");
            document.AddCreationDate();
            string space1 = " ".PadLeft(25, ' ');
            string suser = "创建人: 陈秦" ;
            string pickcode = "单号：PIC20190324";
            string space2 = " ".PadLeft(65 - suser.Length, ' ');

            BaseFont bfchinese = BaseFont.CreateFont(@"c:\windows\fonts\kaiu.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
            Font ChFont_Title = new Font(bfchinese, 18, Font.BOLD);
            Font ChFont_STitle = new Font(bfchinese, 9, Font.NORMAL);
            
            
            document.Add(new Paragraph(space1 + "物料拉动拣料单\r\n", ChFont_Title));
            document.Add(new Paragraph(pickcode + space2 + suser + "  创建日期: " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "\r\n", ChFont_STitle));
            LineSeparator line = new LineSeparator(2f, 100, BaseColor.BLACK, Element.ALIGN_CENTER, -5f);
            document.Add(line);

            document.Add(new Paragraph());
            // 报表之表格部分

            PdfPTable table = PDFTable1();
            table.SpacingBefore = 15;
            table.WidthPercentage = 100;
            table.HorizontalAlignment = Element.ALIGN_LEFT;
            document.Add(table);
           
            document.Close();
        }
        private PdfPTable PDFTable1()
        {                    

            var table1 = new PdfPTable(7);     //创建表格实例4列
            int[] a = { 2, 2, 5, 2, 3, 2, 2 };          //设置列宽比例
            table1.SetWidths(a);
            BaseFont bfchinese = BaseFont.CreateFont(@"c:\windows\fonts\kaiu.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
         
            Font ChFont_TTitle = new Font(bfchinese, 9, Font.BOLD);
            string[] arrHeader = { "物料落点编码", "物料编码", "物料描述", "叫料数量", "叫料时间", "路径", "仓位" };
            for (int i = 0; i < arrHeader.Length; i++)
            {
                PdfPCell cell = new PdfPCell(new Paragraph(arrHeader[i], ChFont_TTitle));
                cell.DisableBorderSide(13);
                table1.AddCell(cell);
            }
            Font ChFont_TBody = new Font(bfchinese, 9, Font.NORMAL);
            for (int i = 0; i < arrHeader.Length; i++)
            {
                PdfPCell cell = new PdfPCell(new Paragraph(arrHeader[i], ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);
            }
            for (int i = 0; i < arrHeader.Length; i++)
            {
                PdfPCell cell = new PdfPCell(new Paragraph(arrHeader[i], ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);
            }
            for (int i = 0; i < arrHeader.Length; i++)
            {
                PdfPCell cell = new PdfPCell(new Paragraph(arrHeader[i], ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);
            }

            return table1;
        }

    }
}