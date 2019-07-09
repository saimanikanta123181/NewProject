using CAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace CMS
{
    public partial class DashBoard_AHU : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #region
        [WebMethod]
        public static string GetAHUMeter(int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[1];

            try
            {
                pars[0] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[0].Value = TypeId;
                Res = obj.GridFill("Ac_MeterName_Get", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:AHU.aspx.cs;Method:GetAHUMeter", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region
        [WebMethod]
        public static string GetAHUData(string date)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[1];

            try
            {
                pars[0] = new SqlParameter("@Date", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDateTime(date);
                Res = obj.GridFill("AHU_Reading", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:AHU.aspx.cs;Method:GetAHUData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
    }
}