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
    public partial class DashBoard_Fuel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
       
        #region get request count
        [WebMethod]
        public static string GetDGUnitGenrationData(string date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[0].Value = TypeId;
                pars[1] = new SqlParameter("@Date", SqlDbType.DateTime);
                pars[1].Value = obj.ConvertDateTime(date);
               
                Res = obj.GridFill("Dashboard_DG_Unit_Generation", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Fuel.aspx.cs;Method:GetDGUnitGenrationData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetDieselConsumptionData(string date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[0].Value = TypeId;
                pars[1] = new SqlParameter("@Date", SqlDbType.DateTime);
                pars[1].Value = obj.ConvertDateTime(date);

                Res = obj.GridFill("Dashboard_DG_Fule_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Fuel.aspx.cs;Method:GetDieselConsumptionData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region 
        [WebMethod]
        public static string GetDGRunningHrsData(string date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDateTime(date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("DG_Hourly_RunningTime", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Fuel.aspx.cs;Method:GetDGRunningHrsData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
    }
}