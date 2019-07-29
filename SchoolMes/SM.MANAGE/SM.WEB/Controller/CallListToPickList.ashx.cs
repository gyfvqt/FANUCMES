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
    /// CallListToPickList 的摘要说明
    /// </summary>
    public class CallListToPickList : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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

                



                //获取所有的叫料单
                DataSet dscall = new DataSet();
                sql = string.Format(@"select a.*,b.MaterialCallCode,
                    b.MaterialId,
                    b.StoreId,
                    b.CallType,
                    b.DeductionCountor,
                    b.DeliverType,
                    b.SaveNumber,
                    b.DelayTime,
                    b.DeliverWay,
                    b.StationId,
                    b.WHCount,c.MaterialDataNo,c.MaterialDataName,d.StoreNo,d.StoreName
                    from CallList(nolock) a join MaterialCallPoint(nolock) b on a.MaterialCallPointId=b.ID 
                    join MaterialData(nolock) c on c.ID=b.MaterialId 
                    join Store(nolock) d on d.ID=b.StoreId
                    where a.ID in({0})", ID.Replace('|', ',').TrimStart(','));
                dscall = SQLHelper.GetDataSet(sql);
                string fullfilename = "";
                string CallId = "";
                 
                if (dscall != null && dscall.Tables[0].Rows.Count > 0)
                {
                    //生成拣料单
                    sql = string.Format(@"insert into PickList(DeliverWay,CreateTime,Creator) values(N'{0}',getdate(),N'{1}');select SCOPE_IDENTITY();",
                        dscall.Tables[0].Rows[0]["DeliverWay"].ToString(), dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString()
                        );
                    object o = SQLHelper.GetObject(sql);
                    var code = "";
                    if (o != null)
                    {
                        code="FANUC-C-P-" + o.ToString().PadLeft(5, '0');
                        string sqlx = @"update PickList set PickCode='FANUC-C-P-" + o.ToString().PadLeft(5, '0') + "' where ID=" + o.ToString();
                        SQLHelper.ExcuteSQL(sqlx);
                        CallId = o.ToString();
                    }
                    
                    sql = "";
                    for (int i = 0; i < dscall.Tables[0].Rows.Count; i++)
                    {
                        //生成拣料单明细
                        sql += string.Format(@"insert into PickDetailList(PickId,CallId) values(N'{0}',N'{1}');", CallId, dscall.Tables[0].Rows[i]["ID"].ToString());
                        //更新零件落点线边库存
                        sql += string.Format(@"update MaterialCallPoint set WHCount+={0} where ID = {1};", dscall.Tables[0].Rows[i]["CallCount"].ToString(), dscall.Tables[0].Rows[i]["MaterialCallPointId"].ToString());
                    }

                    

                    //更新叫料单状态为 关闭
                    sql += string.Format(@"update CallList set CallStatus=N'关闭',UpdateTime=getdate() where ID in ({0});", ID.Replace('|', ',').TrimStart(','));

                    
                    
                    if (sql != "") SQLHelper.ExcuteSQL(sql);

                    #region 创建PDF
                    Document document = new Document(PageSize.A4, 30, 10, 36, 15);
                    string filename = "Pick_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf";
                    fullfilename = "/PickListPDF/" + filename;
                    PdfWriter.GetInstance(document, new FileStream(context.Server.MapPath(fullfilename), FileMode.Create));
                    document.Open();
                    document.AddAuthor(dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString());
                    document.AddCreator(dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString());
                    document.AddCreationDate();
                    string space1 = " ".PadLeft(25, ' ');
                    string suser = "创建人: " + dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString();
                    string pickcode = "单号：" + code;
                    string space2 = " ".PadLeft(55 - suser.Length, ' ');
                    BaseFont bfchinese = BaseFont.CreateFont(@"c:\windows\fonts\kaiu.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                    Font ChFont_Title = new Font(bfchinese, 18, Font.BOLD);
                    Font ChFont_STitle = new Font(bfchinese, 9, Font.NORMAL);

                    document.Add(new Paragraph(space1 + "物料拉动拣料单\r\n", ChFont_Title));
                    document.Add(new Paragraph(pickcode + space2 + suser + "  创建日期: " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "\r\n", ChFont_STitle));

                    LineSeparator line = new LineSeparator(2f, 100, BaseColor.BLACK, Element.ALIGN_CENTER, -5f);
                    document.Add(line);

                    PdfPTable table = PDFTable1(dscall);
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
                        "打印拣料单成功:" + ID);
                }
                //更新拣料单PDF存放路径以便重打
                sql = String.Format(@"update PickList set PickPdfUrl=N'{0}' where ID=N'{1}'", fullfilename, CallId);
                SQLHelper.ExcuteSQL(sql);
                HttpContext.Current.Response.Write(fullfilename);
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("0");
            }
        }
        private PdfPTable PDFTable1(DataSet ds)
        {

            var table1 = new PdfPTable(7);     //创建表格实例4列
            int[] a = { 2, 2, 5, 2, 3, 2, 2 };          //设置列宽比例
            table1.SetWidths(a);
            BaseFont bfchinese = BaseFont.CreateFont(@"c:\windows\fonts\kaiu.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
            #region 表头
            Font ChFont_TTitle = new Font(bfchinese, 9, Font.BOLD);
            string[] arrHeader = { "物料落点编码", "物料编码", "物料描述", "叫料数量", "叫料时间", "路径", "仓位" };
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
                //物料落点编码
                PdfPCell cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["MaterialCallCode"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                //物料编码
                cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["MaterialDataNo"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                //物料描述
                cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["MaterialDataName"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                //叫料数量
                cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["CallCount"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                //叫料时间
                cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["CallTime"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                //路径
                cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["DeliverWay"].ToString(), ChFont_TBody));
                cell.DisableBorderSide(15);
                table1.AddCell(cell);

                //仓位
                cell = new PdfPCell(new Paragraph(ds.Tables[0].Rows[i]["StoreName"].ToString(), ChFont_TBody));
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