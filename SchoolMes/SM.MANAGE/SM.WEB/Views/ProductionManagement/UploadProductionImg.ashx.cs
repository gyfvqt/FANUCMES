using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Drawing;
using System.IO;
using System.Web.Script.Serialization;
using System.Drawing.Imaging;
using DAL;
using System.Configuration;

namespace SM.WEB.Views.ProductionManagement
{
    /// <summary>
    /// UploadProductionImg 的摘要说明
    /// </summary>
    public class UploadProductionImg : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/html";
            if (context.Request.Files.Count > 0)
            {
                HttpPostedFile file1 = context.Request.Files["myfile"];
                //string Sid = HttpContext.Current.Request.Params["sid"];
                string file = uploadImg(file1, "/ProductionImg/");  //这里引用的是上面封装的方法
                //string sql = string.Format(@"update StationInfo set ProcessSheet=N'{0}' where ID=N'{1}'", file, Sid);
                //SQLHelper.ExcuteSQL(sql);
                WriteJson(context.Response, "true", file);
            }
            else
            {
                WriteJson(context.Response, "error", "请选择要上传的文件");
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
                string pfold = ConfigurationManager.AppSettings["ProcessSheet"].ToString();
                img.Save(pfold + virpath + filename);
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
            if (imgtype != ".pdf")
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
            string pfold = ConfigurationManager.AppSettings["ProcessSheet"].ToString();
            file.SaveAs(pfold + virpath + filename);
            return virpath + filename;
        }
    }
}