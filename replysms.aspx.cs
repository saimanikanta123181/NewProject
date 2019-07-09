using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;

public partial class replysms : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string date = DateTime.Now.ToString("yyyy-MM-dd");
        string strUrl = "http://api.mVaayoo.com/mvaayooapi/MessageReply?user=alerts@hubmatrix.net:HUB@2016&senderID=56263404&sdtime=" + date + " 00:00:00&edtime=" + date + " 23:59:59";
        WebRequest request = HttpWebRequest.Create(strUrl);
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        Stream s = (Stream)response.GetResponseStream();
        StreamReader readStream = new StreamReader(s);
        string dataString = readStream.ReadToEnd();
     

        string mobile = Request["da"];
        string msgtxt = Request["msgtxt"];
        string dtime = Request["dtime"];

        Response.Write(mobile);
        Response.Write(msgtxt);
        Response.Write(dtime);
    }
}