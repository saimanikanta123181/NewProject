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
    public partial class DashBoard_Demo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region 
        [WebMethod]
        public static string GetConsumptionData(string date, int TypeId)
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
                Res = obj.GridFill("Dashboard_IOT_Day_PrevDay_Month_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:SiteDashboard.aspx.cs;Method:GetConsumptionData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string GetConsumption(string date, int TypeId)
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
                Res = obj.GridFill("Dashboard_IOT_Day_Month_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:SiteDashboard.aspx.cs;Method:GetConsumption", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetElectricityData(string date, int TypeId)
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
                Res = obj.GridFill("Dashboard_IOT_Electricity_MAIN_DG_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:SiteDashboard.aspx.cs;Method:GetElectricityData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetSpendChartData(string date, int TypeId)
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
                Res = obj.GridFill("Electrical_DayWise_Consumption_PieChart", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:SiteDashboard.aspx.cs;Method:GetSpendChartData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string GetHVACData(string date, int TypeId)
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
                Res = obj.GridFill("HVAC_Hourly_Reading", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:GetHVACData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
    }
}