using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Web.UI.HtmlControls;
using CAL;
using System.Data;

public partial class UIndex : System.Web.UI.Page
{
    
         #region Region for Member Variables
    private short m_RoleId;
    private short m_ModuleId;
    private long m_UserId;
    protected string IPAddress = "";
    protected int m_ScreenId = 0;
    ClsHeader ObjHd = new ClsHeader();
    public DataSet ds;
    #endregion

    #region Region for Properties
    public short RoleId
    {
        get { return m_RoleId; }
        set { m_RoleId = value; }
    }
    public short ModuleId
    {
        get { return m_ModuleId; }
        set { m_ModuleId = value; }
    }

    public long UserId
    {
        get { return m_UserId; }
        set { m_UserId = value; }
    }

    public int ScreenId
    {
        get { return m_ScreenId; }
        set { m_ScreenId = value; }
    }
    #endregion

    #region Region for PageLoad
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack && Session["UserId"] != null)
        {
            RoleId = Convert.ToInt16(Session["Role"].ToString());
            UserId = Convert.ToInt64(Session["UserId"].ToString());
            FillHeaderOptions();
        }
        else
            Response.Redirect("Login.aspx", false);
    }
    #endregion

    #region Filling Header Options
    public void FillHeaderOptions()
    {
        try
        {

            ObjHd.RoleId = RoleId;
            ObjHd.UserId = UserId;
            ds = ObjHd.GetModules(Convert.ToBoolean(Session["Admin"]));

            if (ds.Tables[0].Rows.Count > 0)
            {
                //MainDataList.DataSource = ds.Tables[0];
                //MainDataList.DataBind();
            }

        }
        catch (Exception ex)
        {
            ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "UctrlHeader.ascx:FillHeaderOptions()", 0);
        }

    }
    #endregion

    #region Region For Main Datalist Item Data Bound
    protected void MainDataList_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                HtxtId = (HtmlInputHidden)(e.Item.FindControl("HtxtMId"));

                DataList dl = ((DataList)e.Item.FindControl("ChildDataList"));

                ds.Tables[1].DefaultView.RowFilter = "ModuleId=" + HtxtId.Value;
                dl.DataSource = ds.Tables[1].DefaultView;
                dl.DataBind();

            }
        }
        catch (Exception ex)
        {
            ErrorHandler.ErrorsEntry(ex.GetBaseException().ToString(), "ValidationView.aspx.cs:MainGrid_ItemDataBound", 0);
        }
    }
    #endregion

}