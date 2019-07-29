using DAL;
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;


namespace SM.WEB.Views.Fault
{
    /// <summary>
    /// UpLoadSheet 的摘要说明
    /// </summary>
    public class UpLoadSheet : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/html";
                if (context.Request.Files.Count > 0)
                {
                    HttpPostedFile file1 = context.Request.Files["myfile"];
                    string Sid = HttpContext.Current.Request.Params["sid"];
                    string file = uploadFile(file1, "/ProcessSheet/");  //这里引用的是上面封装的方法
                    string[] arrStr = file1.FileName.Split('\\');
                    var filename = arrStr.Length > 0 ? arrStr[arrStr.Length - 1] : "";
                    string sql = string.Format(@"insert into AMProcessSheet(TicketId,DOCName,URL,UpLoadTime) values(N'{0}',N'{1}',N'{2}',getdate());", Sid, filename, file);
                    SQLHelper.ExcuteSQL(sql);
                    WriteJson(context.Response, "true", file);
                }
                else
                {
                    WriteJson(context.Response, "error", "请选择要上传的文件");
                }
            }
            catch (Exception ex)
            {

            }           

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        public static void WriteJson(HttpResponse response,
           string status1, string msg1, object data1 = null)
        {
            response.ContentType = "application/json";
            var obj = new { status = status1, msg = msg1, data = data1 };
            string json = new JavaScriptSerializer().Serialize(obj);
            response.Write(json);
        }

        /// <summary>
        /// 上传图片
        /// </summary>
        /// <param name="file">通过form表达提交的文件</param>
        /// <param name="virpath">文件要保存的虚拟路径</param>
        public static string uploadImg(HttpPostedFile file, string virpath)
        {
            if (file.ContentLength > 1024 * 1024 * 2)
            {
                throw new Exception("文件不能大于10M");
            }
            string imgtype = Path.GetExtension(file.FileName);
            if (imgtype != ".jpg" && imgtype != ".jpeg" && imgtype != ".png" && imgtype != ".bmp")  //图片类型进行限制
            {
                throw new Exception("请上传jpg或JPEG图片");
            }
            string[] arrStr = file.FileName.Split('\\');
            string filename = DateTime.Now.ToString("yyyyMMddHHmmss") + ".jpg";
            string outputpath = DateTime.Now.ToString("yyyyMMddHHmmss") + ".jpg";
            using (Image img = Bitmap.FromStream(file.InputStream))
            {
                string savepath = HttpContext.Current.Server.MapPath(virpath + filename);
                if (!Directory.Exists(HttpContext.Current.Server.MapPath(virpath)))
                {
                    Directory.CreateDirectory(HttpContext.Current.Server.MapPath(virpath));
                }
                img.Save(savepath);
                string sqlUpdate = @"";
                //GetPicThumbnail(HttpContext.Current.Server.MapPath(virpath) + filename, HttpContext.Current.Server.MapPath(virpath) + outputpath, 60);
                //File.Delete(HttpContext.Current.Server.MapPath(virpath) + filename);
            }
            return virpath + filename;
        }
        public static bool GetPicThumbnail(string sFile, string outPath, int flag)
        {
            System.Drawing.Image iSource = System.Drawing.Image.FromFile(sFile);
            ImageFormat tFormat = iSource.RawFormat;
            //以下代码为保存图片时，设置压缩质量  
            EncoderParameters ep = new EncoderParameters();
            long[] qy = new long[1];
            qy[0] = flag;//设置压缩的比例1-100  
            EncoderParameter eParam = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, qy);
            ep.Param[0] = eParam;
            try
            {
                ImageCodecInfo[] arrayICI = ImageCodecInfo.GetImageEncoders();
                ImageCodecInfo jpegICIinfo = null;
                for (int x = 0; x < arrayICI.Length; x++)
                {
                    if (arrayICI[x].FormatDescription.Equals("JPEG"))
                    {
                        jpegICIinfo = arrayICI[x];
                        break;
                    }
                }
                if (jpegICIinfo != null)
                {
                    iSource.Save(outPath, jpegICIinfo, ep);//dFile是压缩后的新路径  
                }
                else
                {
                    iSource.Save(outPath, tFormat);
                }
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                iSource.Dispose();
                iSource.Dispose();
            }
        }

        /// <summary>
        /// 上传文件
        /// </summary>
        /// <param name="file">通过form表达提交的文件</param>
        /// <param name="virpath">文件要保存的虚拟路径</param>
        public static string uploadFile(HttpPostedFile file, string virpath)
        {
            if (file.ContentLength > 1024 * 1024 * 6)
            {
                throw new Exception("文件不能大于6M");
            }
            string imgtype = Path.GetExtension(file.FileName);
            //imgtype对上传的文件进行限制
            //if (imgtype != ".doc" && imgtype != ".docx" && imgtype != ".pdf" && imgtype != ".xls" && imgtype != ".xlsx")
            if ( imgtype != ".pdf")
            {
                throw new Exception("只允许上传.pdf文件");
            }
            string[] arrStr = file.FileName.Split('\\');
            string filename = DateTime.Now.ToString("yyyyMMddHHmmss") + imgtype;

            string dirFullPath = HttpContext.Current.Server.MapPath(virpath);
            if (!Directory.Exists(dirFullPath))//如果文件夹不存在，则先创建文件夹
            {
                Directory.CreateDirectory(dirFullPath);
            }
            file.SaveAs(dirFullPath + filename);

            return virpath + filename;
        }
    }
}