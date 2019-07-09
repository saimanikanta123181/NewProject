<%@ Page Language="C#" AutoEventWireup="true" Inherits="Login" CodeFile="Login.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>-:: TEAMS ::- Login ::-</title>
    <link rel="icon" href="images/tile.png" type="image/x-icon" />
   <%-- <link href="Styles/modalPopLite.css" rel="stylesheet" type="text/css" />--%>
  <%--  <link href="Styles/cms.css" rel="stylesheet" type="text/css" />--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" />
  <%--  <link href="Plugins/CSS/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="Plugins/CSS/bootstrap.min.css" rel="stylesheet" />
    <%--<link href="Styles/login-style.css" rel="stylesheet" type="text/css" />--%>
    <link href="Plugins/CSS/login-style.css" rel="stylesheet" />
  <%--  <link href="Plugins/CSS/styles.css" rel="stylesheet" />--%>
    <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet" />

    <style type="text/css">
        .email-input {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
            border-radius: 25px;
        }
    </style>
</head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript"></script>
<%--<script src="js/jquery-1.7.1.min.js" type="text/javascript"></script>--%>
    <script src="Plugins/JS/Jquery.3.3.1.js" type="text/javascript"></script>
<%--<script src="js/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>--%>
    <script src="Plugins/JS/jquery-ui-1.10.3.custom.min.js"  type="text/javascript"></script>
<%--<script src="js/jquery.validate.js" type="text/javascript"></script>--%>
<%--<script src="js/modalPopLite.min.js" type="text/javascript"></script>--%>
    <script src="Plugins/JS/modalPopLite.min.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" type="text/javascript"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" type="text/javascript"></script>

    <script src='https://www.google.com/recaptcha/api.js' type="text/javascript"></script>

<script type="text/javascript" language="javascript">
  
</script>
<body>
    <form id="form1" runat="server">

        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-7" style="padding-left:0px;">
                    <img src="Plugins/images/login-screen-image.svg" class="d-block img-fluid" alt="blue-login-image" />
                </div>
                <div class="col-sm-5 text-center">
                    <%--<img src="images/logo/clugston-logo.svg" class="img-fluid my-5 mr-3" alt="clugston" width="150" />--%>
                        <img src="Plugins/images/TEAMS LOGO.jpg" class="img-fluid my-5 ml-3" alt="TEAMSFM" width="200" />
<%--                    <img src="images/TEAMS LOGO.jpg" class="mx-auto d-block img-fluid my-5" alt="teams-logo" width="200" />--%>
                    <div class="mx-auto" align="center">Member Sign in</div>

                    <div class="container mt-5">
                        <div class="row">
                            <div class="col-md-7 mx-auto">
                                <div class="form-group" style="margin-bottom:3.5rem;">
                                    <asp:TextBox ID="txtuserid" runat="server" placeholder="Username"
                                            CssClass="form-control form-control-placeholder" ToolTip="Please enter your username"></asp:TextBox>                                   
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="txtPwd" runat="server" Placeholder="Password"
                                            CssClass="form-control form-control-placeholder" ToolTip="Please enter your password" TextMode="Password"></asp:TextBox>
                                </div>
                                <div style="padding:40px 0px 0px 0px;">
                                     <span class="psw"><a href="#" data-toggle="modal" data-target="#myModal">Forgot password?</a></span>

                                    <!-- The Modal -->
                                    <div class="modal fade" id="myModal">
                                        <div class="modal-dialog modal-md">
                                            <div class="modal-content animate">
                                                <!-- Modal Header -->
                                                <div class="modal-header">
                                                    <h4 class="modal-title" align="center">Forgot your Password ?</h4>
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                </div>

                                                <!-- Modal body -->
                                                <div class="modal-body">
                                                    <form action="/action_page.php">
                                                    <div class="imgcontainer">                       
                                                       <img src="Plugins/images/forgotpswd.png" alt="forgotpassword" width="280" />
                                                    </div>
                                                        <div>
                                                            <label for="lblMessage" id="Label1" class="lblmsg" title="sample" runat="server"></label>
                                                        </div>
                                                        <div class="container mt-4" align="center">
                                                            <label>Fill in required details.</label>
                                                            <input id="txtUName" name="txtUName" type="text" placeholder="Enter Username" class="email-input" />
                                                            <input id="txtEmailId" name="txtEmailId" placeholder="Enter Email" class="email-input" type="text" />
                                                        </div>

                                                        <div class="container mb-2" align="center">
                                                            <input type="button" name="btnSend" onclick="SendPwd()" value="Send" id="btnSend" class="btn" />
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div style="padding:20px 0px 0px 0px;">
                                    <label class="container1">
                                        Remember me
                                        <%--<asp:CheckBox ID="chksignin" CssClass="text-main-login" runat="server" Text="Remember me"
                                           ToolTip="Remember me"></asp:CheckBox>--%>
                                        <input id="chksignin" type="checkbox" checked="checked" runat="server" />
                                        <span class="checkmark"></span>
                                    </label>
                                </div> 
                            </div>
                        </div>
                    </div>
                    <div class="container my-4" align="center">
                        <div class="g-recaptcha mx-auto d-block" data-sitekey="6LfnRz8UAAAAAP-fIRse_nBgrKafa0urjGOLhfKl"></div>
                    </div>
                    <div class="my-5" align="center">
                        <asp:Button ID="btnLogin" CssClass="btn" Text="Sign in" runat="server" OnClick="btnLogin_Click"/>
                    </div>
                    <div class="container my-5">
                        <p class="footer-text" align="center">
                            &copy; 2017, All rights reserved. | Version 2.0.0 | Best view in Firefox, Chrome, Safari etc.
                            <br />
                            Support: +91 8880008800, <a href="mailto:info@hubmatrix.net" target="_top">info@hubmatrix.net</a> | Sales &amp; Marketing: +91 7767933119, <a href="mailto:sales@hubmatrix.net" target="_top">sales@hubmatrix.net</a>

                            <!--<a href="mailto:someone@example.com?Subject=Hello%20again" target="_top">Send Mail</a>-->
                        </p>
                        
                        <img src="Plugins/images/hubmatrix.png" class="mx-auto d-block img-fluid mt-5" alt="teams-logo" width="200" />
                     </div>
                </div>
            </div>
        </div>
  </form>
</body>
</html>
