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
    public partial class DashBoard_HVAC : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #region get request count
        [WebMethod]
        public static string GetHVACSupplyTempData(string date,int TypeId,int MeterId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[3];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDateTime(date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                pars[2] = new SqlParameter("@MeterSerialId", SqlDbType.BigInt);
                pars[2].Value = MeterId;
                Res = obj.GridFill("HVAC_Hourly_Supply_Air_Temp", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:HVAC.aspx.cs;Method:GetHVACSupplyTempData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetHVACReturnTempData(string date, int TypeId,int MeterId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[3];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDateTime(date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                pars[2] = new SqlParameter("@MeterSerialId", SqlDbType.BigInt);
                pars[2].Value = MeterId;
                Res = obj.GridFill("HVAC_Hourly_Return_Air_Temp", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:HVAC.aspx.cs;Method:GetHVACReturnTempData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetHVACCompRunTimeData(string date, int TypeId, int MeterId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[3];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDateTime(date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                pars[2] = new SqlParameter("@MeterSerialId", SqlDbType.BigInt);
                pars[2].Value = MeterId;
                Res = obj.GridFill("HVAC_Hourly_Comp_Run_Time", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:HVAC.aspx.cs;Method:GetHVACCompRunTimeData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetHVACUnitRunTimeData(string date, int TypeId, int MeterId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[3];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDateTime(date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                pars[2] = new SqlParameter("@MeterSerialId", SqlDbType.BigInt);
                pars[2].Value = MeterId;
                Res = obj.GridFill("HVAC_Hourly_Unit_Run_Time", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:HVAC.aspx.cs;Method:GetHVACUnitRunTimeData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion

        #region 
        [WebMethod]
        public static string GetHVACMeter(int TypeId)
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
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:HVAC.aspx.cs;Method:GetHVACMeter", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
        #region get request count
        [WebMethod]
        public static string GetHVACAnalysisData(string date, int TypeId, int MeterId)
        {
            ClsCommon obj = new ClsCommon();
            string Res = "";
            SqlParameter[] pars = new SqlParameter[3];

            try
            {
                pars[0] = new SqlParameter("@DATE", SqlDbType.DateTime);
                pars[0].Value = obj.ConvertDateTime(date);
                pars[1] = new SqlParameter("@TypeId", SqlDbType.BigInt);
                pars[1].Value = TypeId;
                pars[2] = new SqlParameter("@MeterSerialId", SqlDbType.BigInt);
                pars[2].Value = MeterId;
                Res = obj.GridFill("AC_Indoor_Outdoor_UnitRunning_Time", pars);
            }
            catch (Exception ex)
            {
                ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "Page:HVAC.aspx.cs;Method:GetHVACAnalysisData", 0);
                Res = "";
            }
            return Res;
        }
        #endregion
    }
}