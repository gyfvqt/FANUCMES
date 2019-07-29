using DAL;
using System;
using System.Data;
using System.Web;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Diagnostics;
using iTextSharp.text.pdf.draw;

namespace SM.WEB.Controller
{
    /// <summary>
    /// AMTicketPrint 的摘要说明
    /// </summary>
    public class AMTicketPrint : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                //string DEPT = HttpContext.Current.Request.Params["dept"];
                string sql = "";
                DataSet dsuserinfo = new DataSet();
                if (context.Session["_dsuserinfo"] != null)
                {
                    dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                }

                //获取任务明细
                DataSet dscall = new DataSet();
                sql = string.Format(@"select a.*,b.LastName+b.FirstName as CreateName,c.LastName+c.FirstName as Executor,a.ID as XID,d.ID as SID,d.TicketDetailCode,CONVERT(varchar(10), d.ExecuteDate) as ExecuteDate,d.Stratus,d.UpdateTime as SUpdateTime,d.URL
                    from AMTicket(nolock) a 
                    left join UserInfo(nolock) b on a.Creator=b.ID 
                    left join UserInfo(nolock) c on a.UserId=c.ID 
                    join AMTicketSplit(nolock) d on a.ID=d.TicketId
                    where d.ID= {0}", ID);
                dscall = SQLHelper.GetDataSet(sql);
                string fullfilename = "";
                string CallId = "";

                if (dscall != null && dscall.Tables[0].Rows.Count > 0)
                {
                    if (dscall.Tables[0].Rows[0]["URL"].ToString() != "")
                    {
                        fullfilename = dscall.Tables[0].Rows[0]["URL"].ToString();
                    }
                    else
                    {
                        #region 创建PDF
                        Document document = new Document(PageSize.A4, 30, 10, 36, 15);
                        string filename = "Pick_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf";
                        fullfilename = "/TicketPDF/" + filename;
                        PdfWriter.GetInstance(document, new FileStream(context.Server.MapPath(fullfilename), FileMode.Create));
                        document.Open();
                        document.AddAuthor(dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString());
                        document.AddCreator(dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString());
                        document.AddCreationDate();
                        string space1 = " ".PadLeft(25, ' ');
                        string suser = "创建人: " + dscall.Tables[0].Rows[0]["CreateName"].ToString();
                        string pickcode = "单号：" + dscall.Tables[0].Rows[0]["TicketDetailCode"].ToString();
                        string space2 = " ".PadLeft(55 - suser.Length, ' ');
                        BaseFont bfchinese = BaseFont.CreateFont(@"c:\windows\fonts\kaiu.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                        Font ChFont_Title = new Font(bfchinese, 18, Font.BOLD);
                        Font ChFont_STitle = new Font(bfchinese, 9, Font.NORMAL);

                        document.Add(new Paragraph(space1 + "日常维护任务单\r\n", ChFont_Title));
                        document.Add(new Paragraph(pickcode + space2 + suser + "  创建日期: " + dscall.Tables[0].Rows[0]["CreateTime"].ToString() + "\r\n", ChFont_STitle));

                        LineSeparator line = new LineSeparator(2f, 100, BaseColor.BLACK, Element.ALIGN_CENTER, -5f);
                        document.Add(line);
                        string ticketname="维护任务名称：" + dscall.Tables[0].Rows[0]["TicketName"].ToString();
                        string space3= " ".PadLeft(15, ' ');
                        string ticketexcuteor="任务执行人："+ dscall.Tables[0].Rows[0]["Executor"].ToString();
                        document.Add(new Paragraph(ticketname + space3 + ticketexcuteor, ChFont_STitle));
                        document.Add(new Paragraph("维护日期："+ " ".PadLeft(4, ' ')+ dscall.Tables[0].Rows[0]["ExecuteDate"].ToString(), ChFont_STitle));
                        document.Add(line);
                        //维护设备清单
                        string sqlequipment = string.Format(@"select b.*,a.ID as AQID,a.TicketId,a.EquipmentId from AMEquipment(nolock) a 
                                               join EquipmentData(nolock) b on a.EquipmentId=b.ID where a.TicketId=N'{0}'", 
                                               dscall.Tables[0].Rows[0]["ID"].ToString());
                        DataSet dsequiment = SQLHelper.GetDataSet(sqlequipment);
                        PdfPTable table = PDFTable1(dsequiment);
                        table.SpacingBefore = 15;
                        table.WidthPercentage = 100;
                        table.HorizontalAlignment = Element.ALIGN_LEFT;
                        document.Add(table);

                        document.Close();


                        #endregion



                    }
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "打印日常维护任务单成功:" + dscall.Tables[0].Rows[0]["TicketName"].ToString());
                    }
                    //更新拣料单PDF存放路径以便重打
                    sql = String.Format(@"update PickList set PickPdfUrl=N'{0}' where ID=N'{1}'", fullfilename, CallId);
                    SQLHelper.ExcuteSQL(sql);
                }
                HttpContext.Current.Response.Write(fullfilename);
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("0");
            }
        }
        private PdfPTable PDFTable1(DataSet ds)
        {

            var table1 = new PdfPTable(5);     //创建表格实例4列
            int[] a = { 2, 2, 5, 2, 2 };          //设置列宽比例
            table1.SetWidths(a);
            BaseFont bfchinese = BaseFont.CreateFont(@"c:\windows\fonts\kaiu.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
            #region 表头
            Font ChFont_TTitle = new Font(bfchinese, 9, Font.BOLD);
            string[] arrHeader = { "设备ID", "设备名称", "设备描述", "班组", "机器编码" };
            for (int i = 0; i < arrHeader.Length; i++)
            {
                PdfPCell cell = new PdfPCell(new Paragraph(arrHeader[i], ChFont_TTitle));
                cell.DisableBorderSide(13);
                table1.AddCell(cell);
            }
            #endregion
            #region 数据输出
            Font ChFont_TBody = new Font(bfchinese, 9, Font.NORMAL);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                //设备ID
                PdfPCell cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["ID"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                //设备名称
                cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["EquipmentName"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                //设备描述
                cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["EquipmentDesc"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                //班组
                cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["Team"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                //机器编码
                cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["EquipmentCode"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                
            }

            #endregion
            return table1;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}