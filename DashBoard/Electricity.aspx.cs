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
    public partial class DashBoard_Electricity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #region get request count
        [WebMethod]
        public static string GetElectricityYearlyData(string FromDate, string ToDate,int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[3];

            try
            {
                pars[0] = new SqlParameter("@FromDATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(FromDate); ;
                pars[1] = new SqlParameter("@ToDate", SqlDbType.DateTime);
                pars[1].Value = obj.ConvertDate(ToDate);
                pars[2] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[2].Value = TypeId; 

                Res = obj.GridFill("Electrical_Yearly_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:GetElectricityYearlyData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string GetElectricityMonthlyData(int Year,int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@YearId", SqlDbType.BigInt);
                pars[0].Value = Year;
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId; 
                Res = obj.GridFill("Electrical_Monthly_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:GetElectricityMonthlyData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string GetElectricityDailyData(int Year,int Month,int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[3];

            try
            {
                pars[0] = new SqlParameter("@YearId", SqlDbType.BigInt);
                pars[0].Value = Year;
                pars[1] = new SqlParameter("@MonthId", SqlDbType.BigInt);
                pars[1].Value = Month;
                pars[2] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[2].Value = TypeId; 
                Res = obj.GridFill("Electrical_Daily_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:GetElectricityDailyData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityHourlyData(string TodayDate,int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(TodayDate);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId; 
                Res = obj.GridFill("Electrical_24Hour_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:LiveDashboard.aspx.cs;Method:getElectricityHourlyData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion 

        //for modal content
        #region get request count
        [WebMethod]
        public static string getElectricityMeterConData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_DayWise_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityMeterConData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityPuneMainMeterData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_Hourly_MainMeter_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityPuneMainMeterData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityPuneHVACMeterData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_Hourly_HVACMeter_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityPuneHVACMeterData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityPuneFANExhaustMeterData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_Hourly_FAExhaustMeter_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityPuneFANExhaustMeterData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityPuneRawPowerMeterData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_Hourly_RawPowerMeter_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityPuneRawPowerMeterData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityPuneLightingMeterData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_Hourly_ROLightingMeter_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityPuneLightingMeterData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityHyderabadPieChartData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_DayWise_Consumption_PieChart", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityHyderabadPieChartData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityHyderabadMainMeterData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_Hourly_MainMeter_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityHyderabadMainMeterData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityHyderabadHVACMeterData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_Hourly_HVACMeter_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityHyderabadHVACMeterData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityHyderabadKitchenMeterData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_Hourly_KitchenMeter_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityHyderabadKitchenMeterData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region get request count
        [WebMethod]
        public static string getElectricityHyderabadKitchenEquipMeterData(string Date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDate(Date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                Res = obj.GridFill("Electrical_Hourly_KitchenEquipMeter_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityHyderabadKitchenEquipMeterData", 0);
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

        #region Get Consumption 
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
                Res = obj.GridFill("UnmonitorEnergy_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:SiteDashboard.aspx.cs;Method:GetConsumptionData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region 
        [WebMethod]
        public static string getElectricityWeekDayData(string date, int TypeId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];

            try
            {
                pars[0] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[0].Value = TypeId;
                pars[1] = new SqlParameter("@Date", SqlDbType.DateTime);
                pars[1].Value = obj.ConvertDate(date);
              
                Res = obj.GridFill("Dashboard_WeekDaywise_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:getElectricityWeekDayData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region 
        [WebMethod]
        public static string GetElectricityPFData(string date, int TypeId)
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
                Res = obj.GridFill("Electricity_PF_Reading", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Electricity.aspx.cs;Method:GetElectricityPFData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
     
    }
}