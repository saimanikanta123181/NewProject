using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class Logout : System.Web.UI.Page
{
    #region Region For PageLoad
    protected void Page_Load(object sender, EventArgs e)
    {
        //Dictionary<string, string> dic = ((Dictionary<string, string>)Application["Sessions"]);
        //if (dic.ContainsKey(Session["UserCode"].ToString().ToLower()))
        //    ((Dictionary<string, string>)Application["Sessions"]).Remove(Session["UserCode"].ToString().ToLower());
        Session["UserCode"] = null;
        Session["UserName"] = null;
        Session["CompName"] = null;
        Session["CompId"] = null;
        Session["FStartDate"] = null;
        Session["FEndDate"] = null;
        Session["AccessLevel"] = null;
        Session["FinYear"] = null;
        Session["Role"] = null;
        Session["LoginId"] = null;
        Session["Pwd"] = null;
        Session["UserId"] = null;
        Session.Abandon();

        if (Request.QueryString["se"].ToString() == "1")
            lblmsg.Text = "Your session has been expired and system redirected to logout page.!";
        else
            lblmsg.Text = "You have been successfully logged out";
        lblmsg.Visible = true;
    }
    #endregion
}