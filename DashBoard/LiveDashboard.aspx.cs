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
    public partial class DashBoard_LiveDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #region get request count
        [WebMethod]
        public static string GetElectricityData(string date,int TypeId)
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
                Res = obj.GridFill("Electrical_Hourly_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:GetElectricityData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetWaterData(string date,int TypeId)
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
                Res = obj.GridFill("Water_Hourly_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:GetWaterData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetGasData(string date,int TypeId)
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
                Res = obj.GridFill("GAS_Hourly_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:GetGasData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetFuelData(string date,int TypeId)
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
                Res = obj.GridFill("Fuel_Hourly_Reading", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:GetFuelData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetHVACData(string date,int TypeId)
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
        #region get request count
        [WebMethod]
        public static string GetFuelBarData(string date,int TypeId)
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
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:GetFuelBarData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string GetConsumption(string date,int TypeId)
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
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:GetFuelBarData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

    }
}