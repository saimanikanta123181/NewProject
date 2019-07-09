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
    public partial class DashBoard_Water : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #region get request count
        [WebMethod]
        public static string GetWaterYearlyData(string FromDate, string ToDate,int TypeId)
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
                Res = obj.GridFill("Water_Yearly_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Water.aspx.cs;Method:GetWaterYearlyData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetWaterMonthlyData(int Year,int TypeId)
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
                Res = obj.GridFill("Water_Monthly_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Water.aspx.cs;Method:GetWaterMonthlyData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetWaterDailyData(int Year, int Month,int TypeId)
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
                Res = obj.GridFill("Water_Daily_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Water.aspx.cs;Method:GetWaterDailyData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string getWaterHourlyData(string TodayDate,int TypeId)
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
                Res = obj.GridFill("Water_24Hour_Consumption", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:Water.aspx.cs;Method:getWaterHourlyData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
    }
}