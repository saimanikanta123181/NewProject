 using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using CAL;

namespace CMS
{
    public partial class ComboFill : System.Web.UI.Page
    {

        #region For Pageload
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #endregion

        #region For Filling Regions
        [WebMethod]
        public static ComboDetails[] FillRegions(long UserId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@UserId", SqlDbType.BigInt);
            pars[0].Value = UserId;
            DataSet ds = objc.ComboFill("[SA_Regions_CmbFill]", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["RegionId"].ToString());
                br.Name = dtrow["RegionName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Branches Based On Regions
        [WebMethod]
        public static ComboDetails[] FillBranchesBasedOnRegions(string RegionIds, long UserId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();

            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@RegionId", SqlDbType.VarChar, 500);
            pars[0].Value = RegionIds;
            pars[1] = new SqlParameter("@UserId", SqlDbType.BigInt);
            pars[1].Value = UserId;
            DataSet ds = objc.ComboFill("Branches_CmbFillBasedonReg", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["BranchId"].ToString());
                br.Name = dtrow["BranchName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Sites Based On Branches
        [WebMethod]
        public static ComboDetails[] FillSitesBasedOnBranches(string BranchIds, long UserId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@HigherBranchIds", SqlDbType.VarChar, 1000);
            pars[0].Value = BranchIds;
            pars[1] = new SqlParameter("@UserId", SqlDbType.BigInt);
            pars[1].Value = UserId;
            DataSet ds = objc.ComboFill("Branches_CmbFillFPBasedonBranchIds", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["BranchId"].ToString());
                br.Name = dtrow["BranchName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Sites
        [WebMethod]
        public static ComboDetails[] FillBranches(long Userid)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@UserId", SqlDbType.BigInt);
            pars[0].Value = Userid;

            DataSet ds = objc.ComboFill("Branches_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["BranchId"].ToString());
                br.Name = dtrow["BranchName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Roles
        [WebMethod]
        public static ComboDetails[] FillRoles()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("SCT_Roles_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["RoleId"].ToString());
                br.Name = dtrow["RoleName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling User Types
        [WebMethod]
        public static ComboDetails[] FillUserTypes()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_UserTypesCmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["UTypeId"].ToString());
                br.Name = dtrow["UType"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Blocks
        [WebMethod]
        public static ComboDetails[] FillBlocks(long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;

            DataSet ds = objc.ComboFill("Blocks_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["BlockId"].ToString());
                br.Name = dtrow["BlockName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Blocks As Per Asset
        [WebMethod]
        public static ComboDetails[] AssetFillBlocks(long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;

            DataSet ds = objc.ComboFill("Asset_Blocks_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["BlockId"].ToString());
                br.Name = dtrow["BlockName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Blocks As Per Multi Site Id
        [WebMethod]
        public static ComboDetails[] AssetFillBlocksMulti(string SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.NVarChar);
            pars[0].Value = SiteId;

            DataSet ds = objc.ComboFill("Asset_MultiBlocks_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["BlockId"].ToString());
                br.Name = dtrow["BlockName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Blocks As Per House Keeping
        [WebMethod]
        public static ComboDetails[] FillHKBlock(long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            DataSet ds = objc.ComboFill("HK_Blocks_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["BlockId"].ToString());
                br.Name = dtrow["BlockName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Floors Based On Blocks
        [WebMethod]
        public static ComboDetails[] FillFloors(long BlockId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@BlockId", SqlDbType.BigInt);
            pars[0].Value = BlockId;

            DataSet ds = objc.ComboFill("Floors_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["FloorId"].ToString());
                br.Name = dtrow["FloorName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
        
        #region For Filling Asset Floors Based On Blocks
        [WebMethod]
        public static ComboDetails[] AssetFillFloors(long BlockId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@BlockId", SqlDbType.BigInt);
            pars[0].Value = BlockId;

            DataSet ds = objc.ComboFill("Asset_Floors_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["FloorId"].ToString());
                br.Name = dtrow["FloorName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Asset Floors Based On Blocks
        [WebMethod]
        public static ComboDetails[] AssetFillFloorsMulti(string BlockId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@BlockId", SqlDbType.NVarChar);
            pars[0].Value = BlockId;
            DataSet ds = objc.ComboFill("Asset_MultiFloors_CmbFill", pars);
            if (ds != null)
            {
                foreach (DataRow dtrow in ds.Tables[0].Rows)
                {
                    ComboDetails br = new ComboDetails();
                    br.Id = Convert.ToInt32(dtrow["FloorId"].ToString());
                    br.Name = dtrow["FloorName"].ToString();
                    details.Add(br);
                }
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling House Keeping Floors Based On Blocks
        [WebMethod]
        public static ComboDetails[] HKFillFloors(long BlockId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@BlockId", SqlDbType.BigInt);
            pars[0].Value = BlockId;

            DataSet ds = objc.ComboFill("HK_Floors_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["FloorId"].ToString());
                br.Name = dtrow["FloorName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Zones Based On Floors
        [WebMethod]
        public static ComboDetails[] FillZones(long FloorId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@FloorId", SqlDbType.BigInt);
            pars[0].Value = FloorId;

            DataSet ds = objc.ComboFill("Zones_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ZoneId"].ToString());
                br.Name = dtrow["ZoneName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Zones Based On Floors
        [WebMethod]
        public static ComboDetails[] AssetFillZones(long FloorId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@FloorId", SqlDbType.BigInt);
            pars[0].Value = FloorId;

            DataSet ds = objc.ComboFill("Asset_Zones_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ZoneId"].ToString());
                br.Name = dtrow["ZoneName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Zones Based On House Keeping Floors 
        [WebMethod]
        public static ComboDetails[] HKFillZones(long FloorId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@FloorId", SqlDbType.BigInt);
            pars[0].Value = FloorId;

            DataSet ds = objc.ComboFill("HK_Zones_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ZoneId"].ToString());
                br.Name = dtrow["ZoneName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Groups Based on HigherId
        [WebMethod]
        public static ComboDetails[] FillGroups(long HigherId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@HigherId", SqlDbType.BigInt);
            pars[0].Value = HigherId;
            //pars[1] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            //pars[1].Value = SiteId;

            DataSet ds = objc.ComboFill("EquipmentGroup_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipGroupId"].ToString());
                br.Name = dtrow["Groupname"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Groups Based on HigherId
        [WebMethod]
        public static ComboDetails[] FillInvGroups(long HigherId, long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@HigherId", SqlDbType.BigInt);
            pars[0].Value = HigherId;
            pars[1] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[1].Value = SiteId;

            DataSet ds = objc.ComboFill("InvGroup_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipGroupId"].ToString());
                br.Name = dtrow["Groupname"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Groups Based on HigherId
        [WebMethod]
        public static ComboDetails[] FillGroupsMulti(string HigherId, long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@HigherId", SqlDbType.NVarChar);
            pars[0].Value = HigherId;
            pars[1] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[1].Value = SiteId;

            DataSet ds = objc.ComboFill("EquipmentGroup_MultiCmbFill", pars);
            if (ds != null)
            {
                foreach (DataRow dtrow in ds.Tables[0].Rows)
                {
                    ComboDetails br = new ComboDetails();
                    br.Id = Convert.ToInt32(dtrow["EquipGroupId"].ToString());
                    br.Name = dtrow["Groupname"].ToString();
                    details.Add(br);
                }
            }
        
            return details.ToArray();
        }
        #endregion

        
        #region For Filling Groups Based on HigherId
        [WebMethod]
        public static ComboDetails[] HKFillGroups(long HigherId, long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@HigherId", SqlDbType.BigInt);
            pars[0].Value = HigherId;
            pars[1] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[1].Value = SiteId;

            DataSet ds = objc.ComboFill("HK_Group_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipGroupId"].ToString());
                br.Name = dtrow["Groupname"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
        

        #region For Filling Warranty Types
        [WebMethod]
        public static ComboDetails[] FillWarrantyTypes()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_WarrantyTypes_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["WarrantyTypeId"].ToString());
                br.Name = dtrow["WarrantyTypes"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Equipment Status
        [WebMethod]
        public static ComboDetails[] FillEquipmentStatus()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_EquipmentStatus_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipmentStatusId"].ToString());
                br.Name = dtrow["EquipmentStatus"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        
            
        #region For Filling House Keeping Status
        [WebMethod]
        public static ComboDetails[] FillHKStatus()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("HK_Status_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipmentStatusId"].ToString());
                br.Name = dtrow["EquipmentStatus"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion



        #region For Filling Manufacturers
        [WebMethod]
        public static ComboDetails[] FillManufacturers()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("Manufacturers_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["MFId"].ToString());
                br.Name = dtrow["MFName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region for Filling Service Providers
        [WebMethod]
        public static ComboDetails[] FillServiceProviders(long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            DataSet ds = objc.ComboFill("ServiceProviders_CmbFill", pars);
          
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["SPId"].ToString());
                br.Name = dtrow["SPName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Call Types
        [WebMethod]
        public static ComboDetails[] FillCallTypes()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_CallTypes_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["CallTypeId"].ToString());
                br.Name = dtrow["CallType"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
        #region For Filling Asset
        [WebMethod]
        public static ComboDetails[] Asset_CmbFill(int SiteId, int BlockId, int GroupId, int SubGroupId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[4];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@BlockId", SqlDbType.BigInt);
            pars[1].Value = BlockId;
            pars[2] = new SqlParameter("@EquipGroupId", SqlDbType.BigInt);
            pars[2].Value = GroupId;
            pars[3] = new SqlParameter("@EquipSubGroupId", SqlDbType.BigInt);
            pars[3].Value = SubGroupId;
            DataSet ds = objc.ComboFill("Asset_CmbFill", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipmentId"].ToString());
                br.Name = dtrow["TempEquipName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Employees
        [WebMethod]
        public static ComboDetails[] FillEmployees(long SiteId,long DeptId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@DeptId", SqlDbType.BigInt);
            pars[1].Value = DeptId;

            DataSet ds = objc.ComboFill("Employees_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EmpId"].ToString());
                br.Name = dtrow["EmpName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion


        

        #region For Filling Iteam Stock
        [WebMethod]
        public static ComboDetails[] FillItemStock(long SiteId, short Type)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@Type", SqlDbType.TinyInt);
            pars[1].Value = Type;

            DataSet ds = objc.ComboFill("Inv_Item_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ItemId"].ToString());
                br.Name = dtrow["Item"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling UOM
        [WebMethod]
        public static ComboDetails[] FillUOM()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("UOM_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["UOMId"].ToString());
                br.Name = dtrow["UOMName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Months
        [WebMethod]
        public static ComboDetails[] FillMonths()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_Months_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["Mon_Index"].ToString());
                br.Name = dtrow["Mon_Name"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Years
        [WebMethod]
        public static ComboDetails[] FillYears()
        {
            List<ComboDetails> details = new List<ComboDetails>();

            int currentYear = DateTime.Now.Year;
            for (int i = 2013; i <= currentYear; i++)
            {
                ComboDetails br = new ComboDetails();
                br.Id = i;
                br.Name = i.ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region Region for Classes
        public class ComboDetails
        {
            public int Id { get; set; }
            public string Name { get; set; }
        }
        #endregion

        #region Region for Classes
        public class ComboDetails2
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Designation { get; set; }

        }
        #endregion

        #region FillUsers
        [WebMethod]
        public static ComboDetails[] FillUsers(long SiteId, short Type)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@Type", SqlDbType.TinyInt);
            pars[1].Value = Type;
            DataSet ds = objc.ComboFill("SCT_Users_CmbFill", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["UserId"].ToString());
                br.Name = dtrow["UserName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region Fill Issue Types
        [WebMethod]
        public static ComboDetails[] FillIssueTypes(int DeptId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@DeptId", SqlDbType.Int);
            pars[0].Value = DeptId;
            DataSet ds = objc.ComboFill("CMSIBT_Complaints_IssueTypesBasedOnDept", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["IssuetypeId"].ToString());
                br.Name = dtrow["Description"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillTFMBranches
        [WebMethod]
        public static ComboDetails[] FillTFMBranches(long UserId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@UserId", SqlDbType.BigInt);
            pars[0].Value = Convert.ToInt64(UserId);


            DataSet ds = objc.ComboFill("TFMSIBT_Complaints_Branches_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["BranchId"].ToString());
                br.Name = dtrow["BranchName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region Fill TFM Departments
        [WebMethod]
        public static ComboDetails[] FillDepartments(int BId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@BId", SqlDbType.Int);
            pars[0].Value = BId;
            DataSet ds = objc.ComboFill("TFMSIBT_Complaints_Depts_CmbFill", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["DeptId"].ToString());
                br.Name = dtrow["DeptName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillEmployees For TFM
        [WebMethod]
        public static ComboDetails[] FillEmployees_CMS(long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@FPBranchId", SqlDbType.BigInt);
            pars[0].Value = SiteId;

            DataSet ds = objc.ComboFill("CMSIBT_Complaints_FillEmployee", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EmpId"].ToString());
                br.Name = dtrow["EmpName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Checking User Permissions
        [WebMethod]
        public static string CheckPerm(long UserId, long ScreenId)
        {
            string Res = "";
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@UserId", SqlDbType.BigInt);
            pars[0].Value = UserId;
            pars[1] = new SqlParameter("@ScreenId", SqlDbType.BigInt);
            pars[1].Value = ScreenId;
            ClsCommon ObjCo = new ClsCommon();
            Res = ObjCo.GridFill("SCT_CheckUserPermissions", pars);
            return Res;
        }
        #endregion

        #region For Filling Complaint No
        [WebMethod]
        public static ComboDetails[] FillCompNo(short TypeId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@TypeId", SqlDbType.TinyInt);
            pars[0].Value = TypeId;

            DataSet ds = objc.ComboFill("Complaints_FillBasedOnType", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ComplaintId"].ToString());
                br.Name = dtrow["No"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Categories
        [WebMethod]
        public static ComboDetails[] FillCat()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("Categories_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["CategoryId"].ToString());
                br.Name = dtrow["Name"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Inv Items
        [WebMethod]
        public static ComboDetails[] FillInvItems()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("Inv_Items_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ItemId"].ToString());
                br.Name = dtrow["Code"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillEnergy_Categories
        [WebMethod]
        public static ComboDetails[] FillEnergy_Categories()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];
            DataSet ds = objc.ComboFill("MeterReadings_Categories", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["CategoryId"].ToString());
                br.Name = dtrow["Description"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillEnergy_MeterTypes
        [WebMethod]
        public static ComboDetails[] FillEnergy_MeterTypes()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];
            DataSet ds = objc.ComboFill("MeterReadings_MeterTypes", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["MeterTypeId"].ToString());
                br.Name = dtrow["Description"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillEnergy_UOM
        [WebMethod]
        public static ComboDetails[] FillEnergy_UOM()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];
            DataSet ds = objc.ComboFill("MeterReadings_UOM", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["UOMId"].ToString());
                br.Name = dtrow["Description"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillEnergy_Equipments
        [WebMethod]
        public static ComboDetails[] FillEnergy_Equipments(long BranchId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@BranchId", SqlDbType.BigInt);
            pars[0].Value = Convert.ToInt64(BranchId);
            DataSet ds = objc.ComboFill("MeterReadings_Equipments", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipmentId"].ToString());
                br.Name = dtrow["EquipName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Event Types
        [WebMethod]
        public static ComboDetails[] FillETypes()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("HS_EventTypes_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EventId"].ToString());
                br.Name = dtrow["EventName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Incident Types
        [WebMethod]
        public static ComboDetails[] FillIncTypes()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("HS_IncidentTypes_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["IncidentId"].ToString());
                br.Name = dtrow["IncidentName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Activity Types
        [WebMethod]
        public static ComboDetails[] FillActivityTypes()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("HS_ActivityTypes_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ActivityTypeId"].ToString());
                br.Name = dtrow["Activity"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Injury Types
        [WebMethod]
        public static ComboDetails[] FillInjuryTypes()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("HS_InjuryTypes_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["InjuryTypeId"].ToString());
                br.Name = dtrow["InjuryType"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Parts Affected
        [WebMethod]
        public static ComboDetails[] FillPartAffected()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("HS_PartAffected_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["PartId"].ToString());
                br.Name = dtrow["PartAffected"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillEnergy_Meters
        [WebMethod]
        public static ComboDetails[] FillEnergy_Meters(string BranchId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@BranchId", SqlDbType.BigInt);
            pars[0].Value = Convert.ToInt64(BranchId);
            DataSet ds = objc.ComboFill("MeterReadings_Meters", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["MeterId"].ToString());
                br.Name = dtrow["MeterName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillFactors()
        [WebMethod]
        public static ComboDetails[] FillFactors(string SelRCIds)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();

            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SelRCIds", SqlDbType.VarChar, 1000);
            pars[0].Value = SelRCIds;
            DataSet ds = objc.ComboFill("HS_RCFators_RetBasedOnSelIds", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["FactorId"].ToString());
                br.Name = dtrow["FactorDesc"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Groups
        [WebMethod]
        public static ComboDetails[] FillGroupTypes()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];


            DataSet ds = objc.ComboFill("LUT_GroupTypes_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["GroupType"].ToString());
                br.Name = dtrow["GTName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Complaint Status
        [WebMethod]
        public static ComboDetails[] FillCompStatus()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_ComplaintStatus_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ComplaintStatusId"].ToString());
                br.Name = dtrow["ComplaintStatus"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region Fill Issue Types
        [WebMethod]
        public static ComboDetails[] FillIssueTypes_TFM(int DeptId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@DeptId", SqlDbType.Int);
            pars[0].Value = DeptId;
            DataSet ds = objc.ComboFill("TFMSIBT_Complaints_IssueTypesBasedOnDept", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["IssuetypeId"].ToString());
                br.Name = dtrow["Description"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling TPM Categories
        [WebMethod]
        public static ComboDetails[] FillTPMCategories()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_TPMCategories_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["TPMCategoryId"].ToString());
                br.Name = dtrow["TPMCatName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling TPM Complaint Types
        [WebMethod]
        public static ComboDetails[] FillTPMCompTypes(int CategoryId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@CategoryId", SqlDbType.Int);
            pars[0].Value = CategoryId;

            DataSet ds = objc.ComboFill("LUT_TPMCompTypes_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["CompTypeId"].ToString());
                br.Name = dtrow["CompType"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling TPM ROOMS
        [WebMethod]
        public static ComboDetails[] FillTPMRooms(int BlockId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@BlockId", SqlDbType.Int);
            pars[0].Value = BlockId;

            DataSet ds = objc.ComboFill("GuestRooms_Fill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                //modified by mayruri on 05-06-2018
                br.Id = Convert.ToInt32(dtrow["GuestRoomId"].ToString());
                br.Name = dtrow["GuestRoomNo"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Complaint Status
        [WebMethod]
        public static ComboDetails[] FillCompStatus_TFM()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_ComplaintStatus_TFMCmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ComplaintStatusId"].ToString());
                br.Name = dtrow["ComplaintStatus"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region FillGroups
        //[WebMethod]
        //public static ComboDetails[] FillMeterGroups(int SiteId)
        //{
        //    List<ComboDetails> details = new List<ComboDetails>();
        //    ClsCommon objc = new ClsCommon();
        //    SqlParameter[] pars = new SqlParameter[1];
        //    pars[0] = new SqlParameter("@SiteId", SqlDbType.Int);
        //    pars[0].Value = SiteId;
        //    DataSet ds = objc.ComboFill("MeterReadings_Groups", pars);
        //    foreach (DataRow dtrow in ds.Tables[0].Rows)
        //    {
        //        ComboDetails br = new ComboDetails();
        //        br.Id = Convert.ToInt32(dtrow["GroupId"].ToString());
        //        br.Name = dtrow["GroupName"].ToString();
        //        details.Add(br);
        //    }
        //    return details.ToArray();
        //}
        #endregion

        //Naganath
        #region  FillMeterGroups()
        [WebMethod]
        public static ComboDetails[] FillMeterGroups(int CategoryId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();

            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@CategoryId", SqlDbType.Int);
            pars[0].Value = CategoryId;

            DataSet ds = objc.ComboFill("Meter_Groups_ComboFill", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["GroupId"].ToString());
                br.Name = dtrow["GroupName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillEnergy_CategoriesTypes
        [WebMethod]
        public static ComboDetails[] FillEnergy_CategoriesTypes()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];
            DataSet ds = objc.ComboFill("[MeterReadings_CategoriesTypes]", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["CategoryId"].ToString());
                br.Name = dtrow["Description"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillLoads()
        [WebMethod]
        public static ComboDetails[] FillLoads()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();

            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("Loads_ComboFill", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["LoadId"].ToString());
                br.Name = dtrow["LoadName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

	    #region For Filling UOM
        [WebMethod]
        public static ComboDetails[] FillUOM_New()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("UOM_CmbFill_New", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["UOMId"].ToString());
                br.Name = dtrow["UOMName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		
		#region  FillMeterLoads()
        [WebMethod]
        public static ComboDetails[] FillMeterLoads()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();

            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("Meter_Loads_ComboFill", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["LoadId"].ToString());
                br.Name = dtrow["LoadName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling WIPComplaint Status
        [WebMethod]
        public static ComboDetails[] FillWIPCompStatus()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_WIPComplaintStatus_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ComplaintStatusId"].ToString());
                br.Name = dtrow["ComplaintStatus"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
        
        #region For Filling Complaint Status
        [WebMethod]
        public static ComboDetails[] FillWIPCompStatus_TFM()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_WIPComplaintStatus_TFMCmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ComplaintStatusId"].ToString());
                br.Name = dtrow["ComplaintStatus"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		
		#region  FillEnergy_Categorywise
        [WebMethod]
        public static ComboDetails[] FillEnergy_Meters_Categorywise(string Category)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@Category", SqlDbType.BigInt);
            pars[0].Value = Convert.ToInt64(Category);
            DataSet ds = objc.ComboFill("MeterReadings_Meters_Categorywise", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["MeterId"].ToString());
                br.Name = dtrow["MeterName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

	    #region  FillTankerMeter
        [WebMethod]
        public static ComboDetails[] FillTankerMeter()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];
            DataSet ds = objc.ComboFill("[GetTankerMeter]", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["MeterId"].ToString());
                br.Name = dtrow["MeterName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillManpowerDepartments
        [WebMethod]
        public static ComboDetails[] FillManpowerDepartments()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];
            DataSet ds = objc.ComboFill("Get_Manpower_Departments", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["DeptId"].ToString());
                br.Name = dtrow["DeptName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Equipment Name
        [WebMethod]
        public static ComboDetails[] FillEquipmentName()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("EquipName_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipmentId"].ToString());
                br.Name = dtrow["EquipName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		
        #region For Filling Months
        [WebMethod]
        public static ComboDetails[] FillAllMonths()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("MMR_Months_CmbFill", pars);
            
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["Mon_Index"].ToString());
                br.Name = dtrow["Mon_Name"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling AMC payment type
        [WebMethod]
        public static ComboDetails[] FillPType()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("AMCPType_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["PTypeId"].ToString());
                br.Name = dtrow["Value"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
       
        #region For Filling Equipments
        [WebMethod]
        public static ComboDetails[] FillEquipments()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("Equipment_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipId"].ToString());
                br.Name = dtrow["EquipName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
	
        #region For Filling Majorwork Status
        [WebMethod]
        public static ComboDetails[] FillCompStatus_MajorWork()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("LUT_ComplaintStatus_MajorWorkCmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ComplaintStatusId"].ToString());
                br.Name = dtrow["ComplaintStatus"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        //Jyoti
        #region For Filling Groups Based on HigherId
        [WebMethod]
        public static ComboDetails[] FillInventoryGroups(long HigherId, long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@HigherId", SqlDbType.BigInt);
            pars[0].Value = HigherId;
            pars[1] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[1].Value = SiteId;

            DataSet ds = objc.ComboFill("InventoryGroup_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipGroupId"].ToString());
                br.Name = dtrow["Groupname"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Schedule
        [WebMethod]
        public static ComboDetails[] FillPPMSchedule()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("FillPPMSchedule", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ScheduleId"].ToString());
                br.Name = dtrow["Schedule"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Years
        [WebMethod]
        public static ComboDetails[] FillPPMYears()
        {
            List<ComboDetails> details = new List<ComboDetails>();

            int currentYear = DateTime.Now.Year + 1;
            for (int i = 2013; i <= currentYear; i++)
            {
                ComboDetails br = new ComboDetails();
                br.Id = i;
                br.Name = i.ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion


        #region  FillManpowerDepartments added by mayuri on 22-05-2018 for add users
        [WebMethod]
        public static ComboDetails[] GetManpowerDepartments()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@Status", SqlDbType.Int);
            pars[0].Value = 1;
            DataSet ds = objc.ComboFill("Manpower_Dept_FillGrid", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["DeptId"].ToString());
                br.Name = dtrow["DeptName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Area Group [added by mayuri on 09-06-2018]
        [WebMethod]
        public static ComboDetails[] FillCUPN()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("Hospital_CUPN_ComboFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["Id"].ToString());
                br.Name = dtrow["Code"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Zone Group for hospital location[added by mayuri on 09-06-2018]
        [WebMethod]
        public static ComboDetails[] FillZonesGroup(int SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.Int);
            pars[0].Value = SiteId;
            DataSet ds = objc.ComboFill("Hospital_ZonesGroup_ComboFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["GroupId"].ToString());
                br.Name = dtrow["GroupName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Area Group [added by mayuri on 09-06-2018]
        [WebMethod]
        public static ComboDetails[] FillAreaGroup()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("Hospital_Areas_ComboFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["AreaId"].ToString());
                br.Name = dtrow["AreaName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        //FillCallerSource
        #region [added by mayuri on 10-06-2018]
        [WebMethod]
        public static ComboDetails[] FillCallerSource()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("FillCallerSource_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["CallerId"].ToString());
                br.Name = dtrow["CSources"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For TFM Filling Employees[added by mayuri on 11/06/2018]
        [WebMethod]
        public static ComboDetails[] TFMFillEmployees(long SiteId, long RId,long BlockId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[3];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@RId", SqlDbType.BigInt);
            pars[1].Value = RId;
            pars[2] = new SqlParameter("@BlockId", SqlDbType.BigInt);
            pars[2].Value = BlockId;

            DataSet ds = objc.ComboFill("App_Hospital_TFMEmployees_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EmpId"].ToString());
                br.Name = dtrow["EmpName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Zone Group[added by mayuri on 11-06-2018]
        [WebMethod]
        public static ComboDetails[] FillZonesGroupFloorWise(long FloorId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@FloorId", SqlDbType.BigInt);
            pars[0].Value = FloorId;
            DataSet ds = objc.ComboFill("Get_ZonesGroup_FloorWise_ComboFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["GroupId"].ToString());
                br.Name = dtrow["GroupName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling Zones Based On Floors[added by mayuri on 11-06-2018]
        [WebMethod]
        public static ComboDetails[] FillZonesUsingZoneGroup(long FloorId, long GroupId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@FloorId", SqlDbType.BigInt);
            pars[0].Value = FloorId;
            pars[1] = new SqlParameter("@GroupId", SqlDbType.BigInt);
            pars[1].Value = GroupId;

            DataSet ds = objc.ComboFill("ZonesUsingZoneGroup_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ZoneId"].ToString());
                br.Name = dtrow["ZoneName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion


        #region For TFM Filling Employees [added by mayuri on 11-06-2018]
        [WebMethod]
        public static ComboDetails[] FillEquipmentwithCode()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("EquipmentName_Equipcode_Combofill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipmentId"].ToString());
                br.Name = dtrow["EquipName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		
		#region For Fill LPG Cylinder drp added by mayuri on 20-06-2018
        [WebMethod]
        public static ComboDetails[] GetLPGCylinder()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];
         
            DataSet ds = objc.ComboFill("GetLPGCylinder", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["LPGCylinderId"].ToString());
                br.Name = dtrow["CylinderWeight"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion


        #region For Fill meter sub categories added by mayuri on 20-06-2018
        [WebMethod]
        public static ComboDetails[] GetMeterSubCategory()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("GetMeterSubCategory", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["SubCategoryId"].ToString());
                br.Name = dtrow["Description"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		
		
        #region For Filling Groups Based on HigherId
        [WebMethod]
        public static ComboDetails[] FillSubGroupsMulti(string HigherId, long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@HigherId", SqlDbType.NVarChar,200);
            pars[0].Value = HigherId;
            pars[1] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[1].Value = SiteId;

            DataSet ds = objc.ComboFill("EquipmentSubGroupName_ComboFill", pars);
            if (ds != null)
            {
                foreach (DataRow dtrow in ds.Tables[0].Rows)
                {
                    ComboDetails br = new ComboDetails();
                    br.Id = Convert.ToInt32(dtrow["EquipGroupId"].ToString());
                    br.Name = dtrow["Groupname"].ToString();
                    details.Add(br);
                }
            }

            return details.ToArray();
        }
        #endregion
		
		#region For Filling Iteam Stock
        [WebMethod]
        public static ComboDetails[] FillItem(long SiteId,int EquipmentId,int SbGroupId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[3];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@EquipmentId", SqlDbType.BigInt);
            pars[1].Value = EquipmentId;
            pars[2] = new SqlParameter("@SbGroupId", SqlDbType.BigInt);
            pars[2].Value = SbGroupId;

            DataSet ds = objc.ComboFill("Inv_ItemsMaster_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ItemId"].ToString());
                br.Name = dtrow["ItemName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		
		#region For Filling Unit
        [WebMethod]
        public static ComboDetails[] FillUnits(long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;

            DataSet ds = objc.ComboFill("Unit_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["UnitId"].ToString());
                br.Name = dtrow["UnitName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		
		 #region For Filling Equipment Zones Based On Floors
        [WebMethod]
        public static ComboDetails[] FillMainMeter(int HigherId, int CategoryTypeId,int SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[3];
            pars[0] = new SqlParameter("@higherId", SqlDbType.BigInt);
            pars[0].Value = HigherId;
            pars[1] = new SqlParameter("@CategoryTypeId", SqlDbType.BigInt);
            pars[1].Value = CategoryTypeId;
            pars[2] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[2].Value = SiteId;

            DataSet ds = objc.ComboFill("MainMeter_ComboFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["MeterId"].ToString());
                br.Name = dtrow["MeterName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Fill energy category UOM adde dby mayuri on 13-06-2018
        [WebMethod]
        public static ComboDetails[] GetEnergyCategoryUOM(long CategoryId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@CategoryId", SqlDbType.BigInt);
            pars[0].Value = CategoryId;
            DataSet ds = objc.ComboFill("GetEneryCategoryUOM", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["UOMId"].ToString());
                br.Name = dtrow["Description"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region
        [WebMethod]
        public static ComboDetails[] FillMainSubMeter(int HigherId, int CategoryTypeId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@higherId", SqlDbType.BigInt);
            pars[0].Value = HigherId;
            pars[1] = new SqlParameter("@CategoryTypeId", SqlDbType.BigInt);
            pars[1].Value = CategoryTypeId;


            DataSet ds = objc.ComboFill("MainSubMeter_ComboFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["MeterId"].ToString());
                br.Name = dtrow["MeterName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		#region  Fill site meters added by mayuri on 06/08/2018
        [WebMethod]
        public static ComboDetails[] FillSiteMeters(int SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            DataSet ds = objc.ComboFill("[GetSiteMeters]", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["MeterId"].ToString());
                br.Name = dtrow["MeterName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		
		#region For Filling Vendor
        [WebMethod]
        public static ComboDetails[] FillVendor(long SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;

            DataSet ds = objc.ComboFill("Vendor_ComboFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["VId"].ToString());
                br.Name = dtrow["VName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		#region For Filling Users
        [WebMethod]
        public static ComboDetails[] FillUsersCombo(int SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@BranchId", SqlDbType.Int);
            pars[0].Value = SiteId;

            DataSet ds = objc.ComboFill("User_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["UserId"].ToString());
                br.Name = dtrow["FirstName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		
		  #region For Filling items group
        [WebMethod]
        public static ComboDetails[] GetItemGroups(int SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.Int);
            pars[0].Value = SiteId;
          
            DataSet ds = objc.ComboFill("Get_ItemGroups", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipGroupId"].ToString());
                br.Name = dtrow["GroupName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region 
        [WebMethod]
        public static ComboDetails[] GetGroupWiseItems(int SiteId, int GroupId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.Int);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@EquipmentId", SqlDbType.Int);
            pars[1].Value = GroupId;
            DataSet ds = objc.ComboFill("Get_GroupWiseItems", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["ItemId"].ToString());
                br.Name = dtrow["ItemName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
		
		 #region For Filling Employees
        [WebMethod]
        public static ComboDetails2[] FillEmployees2(long SiteId)
        {
            List<ComboDetails2> details = new List<ComboDetails2>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;

            DataSet ds = objc.ComboFill("Employees_CmbFill", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails2 br = new ComboDetails2();
                br.Id = Convert.ToInt32(dtrow["EmpId"].ToString());
                br.Name = dtrow["EmpName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion


#region For FileSizeData added by mayuri on 12/09/2018 for file uploading
        [WebMethod]
        public static ComboDetailsForFileUploading[] FileSizeData()
        {
            List<ComboDetailsForFileUploading> details = new List<ComboDetailsForFileUploading>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];

            DataSet ds = objc.ComboFill("Get_Filesizedata", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetailsForFileUploading br = new ComboDetailsForFileUploading();
                br.Id = Convert.ToInt32(dtrow["FileId"].ToString().Trim());
                br.Name = dtrow["FileName"].ToString().Trim();
                br.Size = dtrow["FileSize"].ToString().Trim();
                br.Ext = dtrow["FileExtension"].ToString().Trim();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region Region for Classes
        public class ComboDetailsForFileUploading
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Size { get; set; }
            public string Ext { get; set; }

        }
        #endregion
		#region For Filling soft services frequency
        [WebMethod]
        public static ComboDetails[] GetSoftServicesFrequency()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];
            DataSet ds = objc.ComboFill("GetSoftServices_Frequency", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["FrequencyId"].ToString());
                br.Name = dtrow["Frequency"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
        #region For Filling soft services frequency
        [WebMethod]
        public static ComboDetails[] GetWeekDays()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];
            DataSet ds = objc.ComboFill("GetWeekDays", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["Id"].ToString());
                br.Name = dtrow["DayName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
        //#region For Filling Asset
        //[WebMethod]
        //public static ComboDetails[] Asset_CmbFill(int SiteId,int EquipGroupId,int EquipSubGroupId,int BlockId)
        //{
        //    List<ComboDetails> details = new List<ComboDetails>();
        //    ClsCommon objc = new ClsCommon();
        //    SqlParameter[] pars = new SqlParameter[4];
        //    pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
        //    pars[0].Value = SiteId;
        //    pars[1] = new SqlParameter("@EquipGroupId", SqlDbType.BigInt);
        //    pars[1].Value = EquipGroupId;
        //    pars[2] = new SqlParameter("@EquipSubGroupId", SqlDbType.BigInt);
        //    pars[2].Value = EquipSubGroupId;
        //    pars[3] = new SqlParameter("@BlockId", SqlDbType.BigInt);
        //    pars[3].Value = BlockId;
        //    DataSet ds = objc.ComboFill("Asset_CmbFill", pars);
        //    foreach (DataRow dtrow in ds.Tables[0].Rows)
        //    {
        //        ComboDetails br = new ComboDetails();
        //        br.Id = Convert.ToInt32(dtrow["EquipmentId"].ToString());
        //        br.Name = dtrow["TempEquipName"].ToString();
        //        details.Add(br);
        //    }
        //    return details.ToArray();
        //}
        //#endregion
		  #region For Filling get Technicain
        [WebMethod]
        public static ComboDetails[] FillTechnicianName(long DeptId, long BlockId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@DeptId", SqlDbType.BigInt);
            pars[0].Value = DeptId;
            pars[1] = new SqlParameter("@BlockId", SqlDbType.BigInt);
            pars[1].Value = BlockId;
            DataSet ds = objc.ComboFill("TechnicianName", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["UserId"].ToString());
                br.Name = dtrow["Name"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion 
        #region For FillAssigneeName
        [WebMethod]
        public static ComboDetails[] FillAssigneeName(int SiteId, int TypeId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.Int);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@TypeId", SqlDbType.Int);
            pars[1].Value = TypeId;
            DataSet ds = objc.ComboFill("GetAssigneeName", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["Id"].ToString());
                br.Name = dtrow["Name"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
        #region For Filling technicians
        [WebMethod]
        public static ComboDetails[] FillEngineeringTechnician(int SiteId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.Int);
            pars[0].Value = SiteId;
            DataSet ds = objc.ComboFill("GetEngineerTechnicianName", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["Id"].ToString());
                br.Name = dtrow["Name"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region For Filling PPM Statuss
        [WebMethod]
        public static ComboDetails[] FillPPMStatus()
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[0];
            DataSet ds = objc.ComboFill("GetPPMStatus", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["Id"].ToString());
                br.Name = dtrow["Name"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region added by mayuri on 11/12/2018
        [WebMethod]
        public static ComboDetails[] GetUsersForEscalation(long SiteId,long BlockId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@BlockId", SqlDbType.BigInt);
            pars[1].Value = BlockId;

            DataSet ds = objc.ComboFill("Users_Escalation", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EmpId"].ToString());
                br.Name = dtrow["EmpName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region  FillEnergy_Meters
        [WebMethod]
        public static ComboDetails[] FillEnergy_MetersWithCategory(string BranchId, string CategoryId,string BlockId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[3];
            pars[0] = new SqlParameter("@BranchId", SqlDbType.BigInt);
            pars[0].Value = Convert.ToInt64(BranchId);
            pars[1] = new SqlParameter("@CategoryId", SqlDbType.BigInt);
            pars[1].Value = Convert.ToInt64(CategoryId);
            pars[2] = new SqlParameter("@BlockId", SqlDbType.BigInt);
            pars[2].Value = Convert.ToInt64(BlockId);
            DataSet ds = objc.ComboFill("MeterReadings_MeterswithCategory", pars);
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["MeterId"].ToString());
                br.Name = dtrow["MeterName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion


        #region 
        [WebMethod]
        public static ComboDetails[] FillEmployeesForAssign(long SiteId,long DeptId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[2];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@DeptId", SqlDbType.BigInt);
            pars[1].Value = DeptId;
            DataSet ds = objc.ComboFill("GetEmployeesForAssign", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EmpId"].ToString());
                br.Name = dtrow["EmpName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region 
        [WebMethod]
        public static ComboDetails[] GetEquipmentList(long SiteId, long BlockId, long FloorId, long ZoneId, long GroupId, long SubGroupId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[6];
            pars[0] = new SqlParameter("@SiteId", SqlDbType.BigInt);
            pars[0].Value = SiteId;
            pars[1] = new SqlParameter("@BlockId", SqlDbType.BigInt);
            pars[1].Value = BlockId;
            pars[2] = new SqlParameter("@FloorId", SqlDbType.BigInt);
            pars[2].Value = FloorId;
            pars[3] = new SqlParameter("@ZoneId", SqlDbType.BigInt);
            pars[3].Value = ZoneId;
            pars[4] = new SqlParameter("@GroupId", SqlDbType.BigInt);
            pars[4].Value = GroupId;
            pars[5] = new SqlParameter("@SubGroupId", SqlDbType.BigInt);
            pars[5].Value = SubGroupId;
            DataSet ds = objc.ComboFill("GetEquipmentList", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipmentId"].ToString());
                br.Name = dtrow["EquipName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion

        #region
        [WebMethod]
        public static ComboDetails[] FillEquipmentSubGroup_ForDialyChecklist(long FloorId)
        {
            List<ComboDetails> details = new List<ComboDetails>();
            ClsCommon objc = new ClsCommon();
            SqlParameter[] pars = new SqlParameter[1];
            pars[0] = new SqlParameter("@FloorId", SqlDbType.BigInt);
            pars[0].Value = FloorId;

            DataSet ds = objc.ComboFill("FillEquipmentSubGroup_ForDialyChecklistCalender", pars);

            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                ComboDetails br = new ComboDetails();
                br.Id = Convert.ToInt32(dtrow["EquipGroupId"].ToString());
                br.Name = dtrow["GroupName"].ToString();
                details.Add(br);
            }
            return details.ToArray();
        }
        #endregion
    }

}