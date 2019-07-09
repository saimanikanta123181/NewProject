using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.SessionState;
using System.Data;
using System.Configuration;
using System.Web.Services;
using System.Data.SqlClient;
using System.Text;
using System.Collections;
using CAL;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
     #region Variables Declaration
    ClsLoginInfo objloginfo = new ClsLoginInfo();
    ClsUsers objuser = new ClsUsers();
    #endregion

    #region Page Load
    protected void Page_Load(object sender, System.EventArgs e)
    {
        // Put user code to initialize the page here
        if (!IsPostBack)
        {

            HttpCookieCollection cookieCols = new HttpCookieCollection();
            cookieCols = Request.Cookies;
            if (!(cookieCols["CMS"] == null))
            {
                if (cookieCols["CMS"].Value != "")
                {
                    short UserId = short.Parse(cookieCols["CMS"].Value.ToString());
                    objuser = new ClsUsers(UserId);//callingconstructor
                    //txtuserid.Text = objuser.UserCode;
                    chksignin.Checked = true;
                }
                else
                {
                    chksignin.Checked = false;
                    //txtuserid.Text = "";
                }
            }
        }


    }
    #endregion

     #region Login Button Click
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string UserName = Request.Form["txtuserid"];
        string Password = Request.Form["txtPwd"];
        if(UserName == "demo" && Password == "demo")
        {
            Response.Redirect("DashBoard/LandingPage.aspx", false);
        }
        else
        {
           
        }
      }
    #endregion

}