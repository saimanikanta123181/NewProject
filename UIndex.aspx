<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UIndex.aspx.cs" Inherits="UIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TEAMSFM MANAGINTELLEGENCE</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
   <%-- <link rel="stylesheet" href="DashBoard/plugins/dashboard.css" type="text/css" />--%>

    <link rel="stylesheet" href="DashBoard/plugins/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css" />
    <link rel="stylesheet" href="DashBoard/plugins/AdminLTE.min.css" />
    <link rel="stylesheet" href="DashBoard/plugins/_all-skins.min.css" />
    <link rel="stylesheet" href="DashBoard/plugins/dashboard.css" type="text/css" />

    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>

    <script src="DashBoard/plugins/jQuery/jquery-2.2.3.min.js" type="text/javascript"></script>

    <script src="DashBoard/plugins/bootstrap.min.js" type="text/javascript"></script>
    <script src="DashBoard/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="DashBoard/plugins/fastclick/fastclick.js" type="text/javascript"></script>
    <script src="DashBoard/plugins/app.min.js" type="text/javascript"></script>
    <style>
        .navigation {
            padding: 0;
            margin: 0;
            border: 0;
            line-height: 1;
        }

            .navigation ul,
            .navigation ul li,
            .navigation ul ul {
                list-style: none;
                margin: 0;
                padding: 0;
            }

            .navigation ul {
                position: relative;
                z-index: 500;
                float: left;
            }

                .navigation ul li {
                    float: left;
                    min-height: 0.05em;
                    line-height: 1em;
                    vertical-align: middle;
                    position: relative;
                }

                    .navigation ul li.hover,
                    .navigation ul li:hover {
                        position: relative;
                        z-index: 510;
                        cursor: default;
                    }

                .navigation ul ul {
                    visibility: hidden;
                    position: absolute;
                    top: 100%;
                    left: 0px;
                    z-index: 520;
                    width: 100%;
                }

                    .navigation ul ul li {
                        float: none;
                    }

                    .navigation ul ul ul {
                        top: 0;
                        right: 0;
                    }

                .navigation ul li:hover > ul {
                    visibility: visible;
                }

                .navigation ul ul {
                    top: 0;
                    left: 99%;
                }

                .navigation ul li {
                    float: none;
                }

                .navigation ul ul {
                    margin-top: 0.05em;
                }

        .navigation {
            width: 13em;
            background: #333333;
            font-family: poppins!important;
            zoom: 1;
        }

            .navigation:before {
                content: '';
                display: block;
            }

            .navigation:after {
                content: '';
                display: table;
                clear: both;
            }

            .navigation a {
                display: block;
                padding: 1em 1.3em;
                color: #ffffff;
                text-decoration: none;
                text-transform: uppercase;
            }

            .navigation > ul {
                width: 13em;
            }

            .navigation ul ul {
                width: 13em;
            }

            .navigation > ul > li > a {
                border-right: 0.3em solid #34A65F;
                color: #ffffff;
            }

                .navigation > ul > li > a:hover {
                    color: #ffffff;
                }

            .navigation > ul > li a:hover,
            .navigation > ul > li:hover a {
                background: #34A65F;
            }

            .navigation li {
                position: relative;
            }

            .navigation ul li.has-sub > a:after {
                content: '»';
                position: absolute;
                right: 1em;
            }

            .navigation ul ul li.first {
                -webkit-border-radius: 0 3px 0 0;
                -moz-border-radius: 0 3px 0 0;
                border-radius: 0 3px 0 0;
            }

            .navigation ul ul li.last {
                -webkit-border-radius: 0 0 3px 0;
                -moz-border-radius: 0 0 3px 0;
                border-radius: 0 0 3px 0;
                border-bottom: 0;
            }

            .navigation ul ul {
                -webkit-border-radius: 0 3px 3px 0;
                -moz-border-radius: 0 3px 3px 0;
                border-radius: 0 3px 3px 0;
            }

            .navigation ul ul {
                border: 1px solid #34A65F;
            }

                .navigation ul ul a {
                    color: #ffffff;
                }

                    .navigation ul ul a:hover {
                        color: #ffffff;
                    }

                .navigation ul ul li {
                    border-bottom: 1px solid #0F8A5F;
                }

                    .navigation ul ul li:hover > a {
                        background: #4eb1ff;
                        color: #ffffff;
                    }

            .navigation.align-right > ul > li > a {
                border-left: 0.3em solid #34A65F;
                border-right: none;
            }

            .navigation.align-right {
                float: right;
            }

                .navigation.align-right li {
                    text-align: right;
                }

                .navigation.align-right ul li.has-sub > a:before {
                    content: '+';
                    position: absolute;
                    top: 50%;
                    left: 15px;
                    margin-top: -6px;
                }

                .navigation.align-right ul li.has-sub > a:after {
                    content: none;
                }

                .navigation.align-right ul ul {
                    visibility: hidden;
                    position: absolute;
                    top: 0;
                    left: -100%;
                    z-index: 598;
                    width: 100%;
                }

                    .navigation.align-right ul ul li.first {
                        -webkit-border-radius: 3px 0 0 0;
                        -moz-border-radius: 3px 0 0 0;
                        border-radius: 3px 0 0 0;
                    }

                    .navigation.align-right ul ul li.last {
                        -webkit-border-radius: 0 0 0 3px;
                        -moz-border-radius: 0 0 0 3px;
                        border-radius: 0 0 0 3px;
                    }

                .navigation.align-right ul ul {
                    -webkit-border-radius: 3px 0 0 3px;
                    -moz-border-radius: 3px 0 0 3px;
                    border-radius: 3px 0 0 3px;
                }

        .sidebar-menu, .sidebar-menu:hover {
            overflow: visible;
        }

        .sidebar {
            overflow: visible !important;
            height: 125rem !important;
        }

        .sidebar-menu > li {
            padding: 9px 5px 9px 11px !important;
        }

        .slimScrollDiv {
            overflow: visible !important;
            height: 125rem !important;
        }

        .treeview-menu.submenu {
         
            position: absolute;
            left: 103%;
            top: -1%;
            width: 145px;
        }

           .treeview-menu-collapse {
            display:none;
        }

        @media (min-width: 768px) {
            .sidebar-mini.sidebar-collapse .sidebar-menu > li > a > span {
                display: none !important;
            }

            .sidebar-mini.sidebar-collapse .sidebar-menu > li > a > i {
                display: none !important;
            }

            .sidebar-mini.sidebar-collapse .sidebar-menu > li > a {
                display: none !important;
            }

            #dashboard {
                border-left: 7px solid transparent;
            }
        }

        .treeview-menu i {
            font-size: 6px !important;
        }

        .treeview-menu submenu menu-open {
           width:115%;
        }

        .skin-blue .main-header .navbar .sidebar-toggle:hover {
        color:red;
        }
    </style>
    <%--<script type="text/javascript">
        $(document).ready(function ($) {
            var alterClass = function () {
                var ww = document.body.clientWidth;
                if (ww < 767) {
                    $('.treeview-menu').removeClass('submenu');
                } else if (ww >= 768) {
                    $('.treeview-menu').addClass('submenu');
                };
            };
            $(window).resize(function () {
                alterClass();
            });
            //Fire it when the page first loads:
            alterClass();
        });
    </script>--%>
    <script type="text/javascript" language="javascript">
        /*--------------------------------------------------------
        document Ready
        ---------------------------------------------------------*/
        var userid = '<%=Session["UserId"]%>';
       
        $(document).ready(function () {
            $(document).ajaxStart(function () {
                SessionCheck();
            });
            //$(document).click(function () {
            //    alert('hi');
            //    //$(this).contents().find("body").on('click', function (event) {
            //    //    $(".treeview-menu").fadeOut();
            //    //});
            //});
            var alterClass = function () {
                var ww = document.body.clientWidth;
                if (ww < 767) {
                    $('.treeview-menu').removeClass('submenu');
                } else if (ww >= 768) {
                    $('.treeview-menu').addClass('submenu');
                };
            };
            $(window).resize(function () {
                alterClass();
            });
            //Fire it when the page first loads:
            alterClass();
        });

        //$(function () {
        //    $('.slider').click(function () {
        //        $('#nav').slideToggle(0);

        //        var img = $(this).find('img');
        //        if ($(img).attr('id') == 'top') {
        //            $(img).attr('src', 'Icons/arrow_bottom.png');
        //            $(img).attr('id', 'bot');
        //        } else {
        //            $(img).attr('src', 'Icons/arrow_top.png');
        //            $(img).attr('id', 'top');
        //        }
        //    });

        //    $('.sub').click(function () {
        //        var cur = $(this).prev();
        //        $('#nav li ul').each(function () {
        //            if ($(this)[0] != $(cur)[0])
        //                $(this).slideUp(0);

        //        });
        //        $(cur).slideToggle(0);
        //    });

        //    $('.dropdown_1column').click(function () {
        //        $(this).hide();
        //    });

        //    $('#menu li').hover(function () {
        //        $('.dropdown_1column').show();
        //    });
        //});

        /*-----------------------------------------------------------------------------------------
        Screens Filling
        ---------------------------------------------------------------------------------------------*/

        function FillScreens(MId, SId, Url, SName) {
            var str = "";
            if (MId == "8" && SId == "805") {
                window.open(document.URL + "/" + Url, 'open_window', 'menubar, toolbar, location, directories, status, scrollbars, resizable,dependent, width=640, height=480, left=0, top=0');
                return false;
            }
            else if (MId == "8" && SId == "806")
                window.location.href = "Logout.aspx?se=0";
            else if (MId == "6")
                str = Url + "?Mid=" + SId + "&SName=" + SName;
            else if (MId == "1")
                str = Url + "?Sid=" + SId;
            else if (Url != '#')
                str = Url + "?Sid=" + SId;


            if (Url != '#')
                window.frames["IScreen"].document.location.href = str;

         

           

            $(".treeview-menu").fadeOut(300);
        }

        /*-----------------------------------------------------------------------------------------
        Loading
        ---------------------------------------------------------------------------------------------*/
        function ShowLoading() {
            $("#overlay").show();
            $("#divLoading").fadeIn(300);
        }
        function HideLoading() {
            $("#overlay").hide();
            $("#divLoading").fadeOut(300);
        }

        /*--------------------------------------------------------------
        Session Check
        ----------------------------------------------------------------*/
        function SessionCheck() {
            if (userid == '' || userid == null || userid == '0')
                parent.window.location.href = "../Logout.aspx?se=1";
        }

    </script>
</head>
<body class="hold-transition skin-blue fixed sidebar-mini w3-light-grey">

    <form id="form1" runat="server">
        <!-- Site wrapper -->
        <div class="wrapper">
            <header class="main-header">
                <nav class="navbar navbar-static-top">
                    <!-- Sidebar toggle button-->
                 
                <%--    <img src="images/Teams logo.jpg" style="width: 321px;height:auto;float:left;" />--%>
                   
                    <img src="images/TEAMS%20LOGO.jpg" Style="width: 185px;height:auto;float:left;"/>
                       <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button" style="background-color:white;color:red;border-left:2px solid red;">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar" style="color:red;"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <ul id="navigation-right" >
                        <li style="line-height: 2;">
                           <a href="Logout.aspx?se=0" style="color:#ffffff; font-size:13px;">Logout <img src="images/menuicon/power-off.svg" alt="support-icon" width="20" /></a>
                            
                             <%--Support No: 020 67356400--%>
                        </li>
                        <li style="display:none;">
                            <img src="images/menuicon/Raise-Support-Ticket.svg" alt="menu-icon" width="15" />
                        </li>
                        <li style="display:none;">
                            <div>Jan 02, 2018</div>
                            11.45 AM</li>
                       <%-- <li style="padding: 0px 10px;">
                            <img src="images/menuicon/MyAccount.svg" alt="menu-icon" width="50" style="margin: 3px 15px 0px 0px;" />
                            <img src="images/menuicon/chevron.svg" alt="menu-icon" width="15" />
                        </li>--%>
                    </ul>
                    <!-- Top container -->
                    <%--<div class="w3-bar w3-top w3-black w3-large" style="z-index:4;height: 50px;">

                </div>--%>
                    <!-- /Top container -->
                </nav>


            </header>

            <aside class="main-sidebar">
                <section class="sidebar" style="background-color: white; border-right: thin solid lightgrey;color:orange;">
                    <%--<form action="#" method="get" class="sidebar-form">
                <div class="input-group">
                  <input type="text" name="q" id="myInput" onkeyup="myFunction()" class="form-control" placeholder="Search..." />
                      <span class="input-group-btn">
                        <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                        </button>
                      </span>
                </div>
              </form>--%>
                    <!-- /.search form -->
                    <ul class="sidebar-menu" id="myUL" onmouseout="" style="color:#333333;">
                        <% foreach (System.Data.DataRow mr in ds.Tables[0].Rows)
                            {%>
                        <li class="treeview" style="border-left: thick solid #ed533d !important;">

                            <a style="color:#333333;font-size:14px;"
                                title="<%= mr["ModuleName"] %>"><i class="<%= mr["ModuleImage"] %>"></i>

                             <img src="<%= mr["ModuleImage"] %>" alt="dashboard-icon" width="20px" />
                                <%= mr["ModuleName"] %>
                                <span class="pull-right-container"><i class="fa fa-angle-right pull-left"></i></span>
                            </a>
                            <ul class="treeview-menu" style="width: 100%;">
                                <%  System.Data.DataView dataView = ds.Tables[1].DefaultView;
                                    dataView.RowFilter = "ModuleId = '" + mr["ModuleId"] + "'";
                                    foreach (System.Data.DataRowView smr in dataView)
                                    {%>

                                <li onclick="FillScreens('<%= smr["ModuleId"] %>','<%= smr["ScreenId"] %>','<%= smr["AddUrl"] %>','<%= smr["ScreenName"] %>')">
                                    <i class="fa fa-circle" style="padding: 5px;"></i><%= smr["ScreenName"] %></li>

                                <%} %>
                            </ul>

                        </li>
                        <%--<asp:DataList  ID="MainDataList" runat="server" RepeatDirection="Vertical" Width="100%"
                            OnItemDataBound="MainDataList_ItemDataBound">
                            <ItemStyle HorizontalAlign="Left" />
                            <ItemTemplate>
                                <input type="hidden" id="HtxtMId" name="HtxtMId" value='<%# Eval("ModuleId")%>' runat="server" />


                                <li class="treeview"><a
                                    onclick="FillScreens('<%#Eval("ModuleId")%>',101,'<%#Eval("ModuleDesc")%>','<%#Eval("ModuleName")%>')"
                                    title="<%# Eval("ModuleName") %>"><i class="<%# Eval("ModuleImage") %>"></i><span class="menu--label" style="display: inline;">
                                        <%# Eval("ModuleName") %></span> </a>

                                    <asp:DataList ID="ChildDataList" runat="server" Width="100%" RepeatDirection="Vertical"
                                        RepeatColumns="1" EnableViewState="false">
                                        <ItemTemplate>
                                            <ul class="treeview-menu">
                                                <li class="treeview" onclick="FillScreens('<%#Eval("ModuleId")%>','<%#Eval( "ScreenId")%>','<%#Eval("AddUrl")%>','<%#Eval("ScreenName")%>')">
                                                    <i class="fa fa-circle-o"></i><%#Eval( "ScreenName")%></li>
                                            </ul>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </li>
                            </ItemTemplate>
                        </asp:DataList>--%>
                        <%} %>
                    </ul>


                    <%-- <ul class="sidebar-menu" id="myUL">
                        <!--Dashboard-->
                        <li class="treeview" id="dashboard">
                            <a target="iframe_a" href="pagess/dashboard.html">
                                <img src="images/menuicon/Dashboard_Icon.svg" alt="dashboard-icon" />
                                <span>Dashboard</span>
                            </a>
                        </li>
                        <!--Control Panel-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <span class="pull-right-container"><i class="fa fa-angle-right pull-left"></i></span>
                                <img src="images/menuicon/Menu_Icon_Grey.svg" alt="menu-icon" />
                                Control Panel
                            </a>
                            <ul class="treeview-menu" style="width: 70%;">
                                <li><a target="iframe_a" href="pagess/Security.aspx"><i class="fa fa-circle"></i>Security </a></li>
                                <li><a target="iframe_a" href="pagess/Security.aspx"><i class="fa fa-circle"></i>System Setting</a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>Auto Email</a></li>
                            </ul>
                        </li>

                        <!--Master Setting-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <span class="pull-right-container"><i class="fa fa-angle-right pull-left"></i></span>
                                <img src="images/menuicon/MyAccount_Icon_Grey.svg" alt="my-account-icon" />
                                Master Setting
                            </a>
                            <ul class="treeview-menu" style="width: 150%;">
                                <li><a target="iframe_a" href="pagess/Facility-Mapping.aspx"><i class="fa fa-circle"></i>Facility Mapping/ Site Master/ Location Master</a></li>
                                <li><a target="iframe_a" href="pagess/Service-Provider.aspx"><i class="fa fa-circle"></i>Service Provider/ Manufacturer Master</a></li>
                                <li><a target="iframe_a" href="pagess/Performance-Management-Master.aspx"><i class="fa fa-circle"></i>Performance Management Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>Manpower Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>Service Request Master</a></li>
                                <li><a target="iframe_a" href="pagess/Asset-Management-Master.aspx"><i class="fa fa-circle"></i>Asset Management Master</a></li>
                                <li><a target="iframe_a" href="pagess/Escalation-Matrix-Master.aspx"><i class="fa fa-circle"></i>Escalation Matrix Master</a></li>
                                <li><a target="iframe_a" href="pagess/common-area-billing-master.aspx"><i class="fa fa-circle"></i>Common Area Billing Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>Printing Services Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>Inventory Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>HSQE Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>Work Permit Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>Fit Out Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>Visitor Management Master</a></li>
                                <li><a target="iframe_a" href="pagess/Training-Master.aspx"><i class="fa fa-circle"></i>Training Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>Room Reservation Master</a></li>
                                <li><a target="iframe_a" href="pagess/Survey-Master.aspx"><i class="fa fa-circle"></i>Survey Master</a></li>
                                <li><a target="iframe_a" href="pagess/Audit-Master.aspx"><i class="fa fa-circle"></i>Audit Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>Space Master</a></li>
                                <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle"></i>Venue Booking Master</a></li>
                            </ul>
                        </li>

                        <!--Helpdesk-->
                        <li class="treeview">
                            <a target="iframe_a" href="pagess/Helpdesk.aspx">
                                <img src="images/menuicon/FacilityProfile_Icon_Grey.svg" alt="facility-profile-icon" />
                                <span>Helpdesk</span>
                            </a>
                        </li>

                        <!--Energy-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <span class="pull-right-container"><i class="fa fa-angle-right pull-left"></i></span>
                                <img src="images/menuicon/Energy.svg" alt="raise-support-ticket-icon" />
                                Energy
                            </a>
                            <ul class="treeview-menu" style="width: 70%;">
                                <li><a target="iframe_a" href="pagess/location.html"><i class="fa fa-circle"></i>Security </a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>System Setting</a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>Auto Email</a></li>
                            </ul>
                        </li>

                        <!--Inventory-->
                        <li class="treeview">
                            <a target="iframe_a" href="pagess/Inventory.aspx">
                                <img src="images/menuicon/Inventory.svg" alt="raise-support-ticket-icon" />
                                <span>Inventory</span>
                            </a>
                        </li>


                        <!--Asset Management-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <span class="pull-right-container"><i class="fa fa-angle-right pull-left"></i></span>
                                <img src="images/menuicon/Asset-Management.svg" alt="raise-support-ticket-icon" />
                                Asset Management
                            </a>
                            <ul class="treeview-menu" style="width: 70%;">
                                <li><a target="iframe_a" href="pagess/location.html"><i class="fa fa-circle"></i>Security </a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>System Setting</a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>Auto Email</a></li>
                            </ul>
                        </li>

                        <!--Performance Management-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <span class="pull-right-container"><i class="fa fa-angle-right pull-left"></i></span>
                                <img src="images/menuicon/Performance-Management.svg" alt="raise-support-ticket-icon" />
                                Performance Management
                            </a>
                            <ul class="treeview-menu" style="width: 70%;">
                                <li><a target="iframe_a" href="pagess/location.html"><i class="fa fa-circle"></i>Security </a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>System Setting</a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>Auto Email</a></li>
                            </ul>
                        </li>

                        <!--HSQE-->
                        <li class="treeview">
                            <a target="iframe_a" href="pagess/HealthSafety.aspx">
                                <img src="images/menuicon/HSQE.svg" alt="raise-support-ticket-icon" />
                                HSQE
                            </a>
                        </li>

                        <!--Performance Management-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <span class="pull-right-container"><i class="fa fa-angle-right pull-left"></i></span>
                                <img src="images/menuicon/Work-Permit.svg" alt="raise-support-ticket-icon" />
                                Work Permits
                            </a>
                            <ul class="treeview-menu" style="width: 115%;">
                                <li><a target="iframe_a" href="pagess/Work-Permit-cold.aspx"><i class="fa fa-circle"></i>Cold Work Permit </a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>Electrical Work Permit</a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>Work Permit Confined Space Entry</a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>Height Working Permit</a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>Hot Working Permit</a></li>
                                <li><a target="iframe_a" href="pagess/country.html"><i class="fa fa-circle"></i>Transmittal Form</a></li>

                            </ul>
                        </li>
                        <!--Manpower Management-->
                        <li class="treeview">
                            <a target="iframe_a" href="pagess/dashboard.html">
                                <img src="images/menuicon/Manpower-Management.svg" alt="Manpower-Management-icon" />
                                Manpower Management
                            </a>
                        </li>

                        <!--Training-->
                        <li class="treeview">
                            <a target="iframe_a" href="pagess/dashboard.html">
                                <img src="images/menuicon/Training.svg" alt="raise-support-ticket-icon" />
                                Training
                            </a>
                        </li>

                        <!--Survey-->
                        <li class="treeview">
                            <a target="iframe_a" href="pagess/Survey-Master.aspx">
                                <img src="images/menuicon/Survey.svg" alt="raise-support-ticket-icon" />
                                Survey
                            </a>
                        </li>

                        <!--Audit-->
                        <li class="treeview">
                            <a target="iframe_a" href="pagess/Audit-Master.aspx">
                                <img src="images/menuicon/Audit.svg" alt="raise-support-ticket-icon" />
                                Audit
                            </a>
                        </li>

                        <!--Management Reports-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <img src="images/menuicon/Management-Reports.svg" alt="raise-support-ticket-icon" />
                                Management Reports
                            </a>
                        </li>

                        <!--Notice Board-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <img src="images/menuicon/Notice-Board.svg" alt="raise-support-ticket-icon" />
                                Notice Board
                            </a>
                        </li>

                        <!--House Keeping-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <img src="images/menuicon/House-Keeping.svg" alt="raise-support-ticket-icon" />
                                House Keeping
                            </a>
                        </li>

                        <!--Venue Booking-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <img src="images/menuicon/Venue-Booking.svg" alt="raise-support-ticket-icon" />
                                Venue Booking
                            </a>
                        </li>

                        <!--Common Area Billing-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <img src="images/menuicon/Common-Area-Billing.svg" alt="raise-support-ticket-icon" />
                                Common Area Billing
                            </a>
                        </li>

                        <!--Fitout Management-->
                        <li class="treeview">
                            <a target="iframe_a" href="pagess/Fitout-Management.aspx">
                                <img src="images/menuicon/Fitout-Management.svg" alt="raise-support-ticket-icon" />
                                Fitout Management
                            </a>
                        </li>

                        <!--Printing Services-->
                        <li class="treeview">
                            <a target="iframe_a" href="pagess/Printing-Services.aspx">
                                <img src="images/menuicon/Printing-Services.svg" alt="raise-support-ticket-icon" />
                                Printing Services
                            </a>
                        </li>

                        <!--Visitor Management System-->
                        <li class="treeview">
                            <a target="iframe_a" href="pagess/VisitorManagement.aspx">
                                <img src="images/menuicon/Visitor-Management-System.svg" alt="visitor-management-icon" />
                                <span>Visitor Management System</span>
                            </a>
                        </li>

                        <!--Student Room Reservation-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <img src="images/menuicon/Student-Room-Reservation.svg" alt="raise-support-ticket-icon" />
                                Student Room Reservation
                            </a>
                        </li>

                        <!--Space Management-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <img src="images/menuicon/Space-Management.svg" alt="raise-support-ticket-icon" />
                                Space Management
                            </a>
                        </li>

                        <!--Facility Profile-->
                        <li class="treeview">
                            <a target="iframe_a" href="#">
                                <img src="images/menuicon/Facility-Profile.svg" alt="raise-support-ticket-icon" />
                                Facility Profile
                            </a>
                        </li>
                    </ul>--%>
                </section>
                <!-- /.sidebar -->
            </aside>


            <div class="content-wrapper" id="main-div">


                <section>
                    <input type="hidden" id="HtxtId" runat="server" />
                    <div class='embed-container'>
                    <iframe id="IScreen" name="IScreen" src="LandingPage.aspx" runat="server" width="100%" style="overflow-x: auto; padding-left: 15px;"
                        frameborder="0">
                    </iframe>
                        </div>
                </section>
                <img src="images/hmlogo.png" style="display:none;" id="Imagld" width="190" height="40" alt="AFM" />
            </div>




        </div>
        <!-- ./wrapper -->
        <footer class="main-footer" style="text-align: right;">
          <strong>Copyright &copy; 2017-2018 <a href="http://hubmatrix.net/">Hubmatrix Technologies</a>.</strong> All rights
            reserved.
        </footer>
    </form>

    <%--<script>
        function myFunction() {
            var input, filter, ul, li, a, i;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            ul = document.getElementById("myUL");
            li = ul.getElementsByTagName("li");
            for (i = 0; i < li.length; i++) {
                a = li[i].getElementsByTagName("a")[0];
                if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";

                }
            }
        }
    </script>--%>
</body>
</html>
