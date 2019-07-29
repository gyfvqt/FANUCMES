using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Spire.Xls;
using Spire.License;
using System.Data;
using System.IO;

namespace GF2.MES.Report.Helper
{
    public class SpireXLSHelper
    {
        public static string ExportToExcel(DataSet ds,string path)
        {
            string xlsfile = "";
            try
            {
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    Workbook book = new Workbook();
                    book.Version = ExcelVersion.Version2010;
                    Worksheet sheet = book.Worksheets[0];
                    var random = new Random();
                    //1.设置表头                    
                    for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
                    {
                        sheet.Range[1, i + 1].Text = ds.Tables[0].Columns[i].ColumnName;
                    }


                    //2.构造表数据
                    for (var i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
                        {
                            sheet.Range[2 + i, j + 1].Text = ds.Tables[0].Rows[i][j].ToString();
                        }
                    }
                    //3.生成xls
                    var strFullName = path+ DateTime.Now.ToString("yyyyMMdd");
                    
                    if (!Directory.Exists(strFullName+ DateTime.Now.ToString("yyyyMMdd")))
                    {
                        Directory.CreateDirectory(strFullName );
                    }
                    if (Directory.Exists(strFullName + DateTime.Now.AddDays(-1).ToString("yyyyMMdd")))
                    {
                        Directory.Delete(path + DateTime.Now.AddDays(-1).ToString("yyyyMMdd"),true);
                    }
                    string filename = strFullName + @"\ExportXLS" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx";
                    book.SaveToFile(filename, ExcelVersion.Version2010);

                    xlsfile = filename;
                }                
            }
            catch
            {
 
            }
            return xlsfile;
        }
    }
}