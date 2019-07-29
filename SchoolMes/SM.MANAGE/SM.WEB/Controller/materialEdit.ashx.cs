using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GF2.MES.Report.Helper;
using DAL;
using System.Data;
using SM.WEB;

namespace SM.WEB.Controller
{
    /// <summary>
    /// materialEdit 的摘要说明
    /// </summary>
    public class materialEdit : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = "text/plain";
                string ID = HttpContext.Current.Request.Params["id"];
                string MaterialDataNo = HttpContext.Current.Request.Params["materialDataNo"];
                string MaterialDataName = HttpContext.Current.Request.Params["materialDataName"];
                string BoxType = HttpContext.Current.Request.Params["boxType"];
                string BoxTotalNo = HttpContext.Current.Request.Params["boxTotalNo"];
                string KG = HttpContext.Current.Request.Params["kg"];
                string Supplier = HttpContext.Current.Request.Params["supplier"];
                string M_W_S = HttpContext.Current.Request.Params["mws"];
                //string UserImagic = HttpContext.Current.Request.Params["userImagic"];

                if (ID.Trim() == "")
                {
                    string sqlmaxid = "Select max(ID) from MaterialData";
                    string maxid = SQLHelper.GetObject(sqlmaxid).ToString();
                    if (maxid == "" || maxid == "NULL")
                    {
                        maxid = "1";
                    }
                    else
                    {
                        maxid = (Convert.ToInt32(maxid) + 1).ToString();
                    }
                    maxid = maxid.PadLeft(5, '0');
                    string sqlrole = string.Format(@"insert into MaterialData(MaterialDataNo,
                                                    MaterialDataName,
                                                    BoxType,
                                                    BoxTotalNo,
                                                    KG,
                                                    Supplier) 
                                                    values(N'{0}',N'{1}',N'{2}',N'{3}',N'{4}',N'{5}') ;",
                        "FANUC_M" + maxid, MaterialDataName, BoxType, BoxTotalNo, KG, Supplier);
                    SQLHelper.ExcuteSQL(sqlrole);
                    //string getrole = @"select max(ID)  from MaterialData";
                    //string materialid = SQLHelper.GetObject(getrole).ToString();
                    string sqlwms = "";
                    if (M_W_S.Trim() != "")
                    {
                        string[] list = M_W_S.Split('|');
                        if (list.Length > 0)
                        {
                            for (int i = 0; i < list.Length; i++)
                            {
                                if (list[i].Trim() != "")
                                {
                                    string[] list2 = list[i].Split('_');
                                    sqlwms += string.Format(@"insert into Material_W_S(MaterialId,WarehouseId,StoreId,MTotal) values(N'{0}',N'{1}',N'{2}','0') ;", maxid, list2[0], list2[1]);
                                }
                            }
                            SQLHelper.ExcuteSQL(sqlwms);
                        }
                    }
                    
                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["UserId"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "新增物料成功:" + "FANUC_M" + maxid + "/" + MaterialDataName);
                    }
                }
                else
                {
                    string sqlrole = string.Format("update MaterialData set MaterialDataName=N'{0}',BoxType=N'{1}',BoxTotalNo=N'{2}',KG=N'{3}',Supplier=N'{4}' where ID={5};",
                         MaterialDataName, BoxType, BoxTotalNo, KG, Supplier, ID);
                    string deletepermissio = string.Format(@"delete from Material_W_S where MaterialId={0};", ID);
                    string sqlwms = "";
                    if (M_W_S.Trim() != "")
                    {
                        string[] list = M_W_S.Split('|');
                        if (list.Length > 0)
                        {
                            for (int i = 0; i < list.Length; i++)
                            {
                                if (list[i].Trim() != "")
                                {
                                    string[] list2 = list[i].Split('_');
                                    sqlwms += string.Format(@"insert into Material_W_S(MaterialId,WarehouseId,StoreId,MTotal) values(N'{0}',N'{1}',N'{2}','0') ;", ID, list2[0], list2[1]);
                                }
                            }

                        }
                    }
                    SQLHelper.ExcuteSQL(sqlrole+ deletepermissio + sqlwms);


                    if (context.Session["_dsuserinfo"] != null)
                    {
                        DataSet dsuserinfo = context.Session["_dsuserinfo"] as DataSet;
                        SystemLogs.InsertSystemLog(dsuserinfo.Tables[0].Rows[0]["ID"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["LastName"].ToString() + dsuserinfo.Tables[0].Rows[0]["FirstName"].ToString(),
                            dsuserinfo.Tables[0].Rows[0]["RoleName"].ToString(),
                            "编辑物料成功:" + MaterialDataNo + "/" + MaterialDataName);
                    }
                }
                HttpContext.Current.Response.Write("1");
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("0");
            }
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