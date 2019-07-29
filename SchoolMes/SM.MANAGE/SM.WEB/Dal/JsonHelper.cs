using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;

namespace GF2.MES.Report.Helper
{
    public class JsonHelper
    {
        /// <summary>
        /// 把DataTable数据转换为Json格式
        /// </summary>
        /// <param name="dt">传入DataTable数据</param>
        /// <returns></returns>
        public string DataTableToJson(DataTable dt, int pageTotal)
        {
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("{\"total\"");
            jsonBuilder.Append(":");
            jsonBuilder.Append(pageTotal);
            jsonBuilder.Append(",\"rows");
            jsonBuilder.Append("\":[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString());
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("],");
            jsonBuilder.Append("\"title");
            jsonBuilder.Append(dt.TableName);
            jsonBuilder.Append("\":[");
            //这是循环获取列名称
            for (int n = 0; n < dt.Columns.Count; n++)
            {
                jsonBuilder.Append("{");
                jsonBuilder.Append("\"field");
                jsonBuilder.Append("\":\"");
                jsonBuilder.Append(dt.Columns[n].ColumnName);
                jsonBuilder.Append("\",");
                jsonBuilder.Append("\"title");
                jsonBuilder.Append("\":\"");
                jsonBuilder.Append(dt.Columns[n].ColumnName);
                jsonBuilder.Append("\"");
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("},");

            jsonBuilder.Remove(jsonBuilder.Length - 2, 2);
            jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }
    }
}