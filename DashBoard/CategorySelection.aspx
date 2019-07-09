<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CategorySelection.aspx.cs" Inherits="DashBoard_CategorySelection" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" />
    <script src="../Plugins/JS/Jquery.3.3.1.js"></script>
    <script src="../Plugins/JS/jquery-ui.min.js"></script>
    <script src="../Plugins/JS/moment.min.js"></script>
    <script src="../Plugins/JS/daterangepicker.js"></script>
    <link href="../Plugins/CSS/bootstrap.min.css" rel="stylesheet" />
    <link href="../Plugins/CSS/styles.css" rel="stylesheet" />
    <link href="../Plugins/CSS/daterangepicker.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="../Plugins/JS/bootstrap.min.js"></script>
    <script src="../Plugins/JS/Chart.min.js"></script>
 
    <title></title>
    <style>
      
    </style>
</head>
    <script>
        $(document).ready(function () {
            $("#btnSwitch").click(function () {
                window.location.href = "AunoaLandingPage.aspx";
            });

            var TypeId = localStorage.getItem('TypeId');
            if (TypeId == 3) {
                $("#divElectricity").hide()
            } else {
                $("#divElectricity").show()
            }
            if (TypeId == 8) {
                $("#divColdRoom").hide()
            }
            else if (TypeId == 10) {
                $("#divColdRoom").hide()
            }
            else if (TypeId == 11 || TypeId == 14 || TypeId == 15) {
                $("#divColdRoom").hide()
            
            }else {
                $("#divColdRoom").show()
            }
        });
      
    </script>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 p-0">
                <nav class="navbar navbar-light bg-light navbar-expand-lg p-1" style="background-color:white !important">
                    <a class="navbar-brand" href="">
                        <img src="../Plugins/images/bbq.png" width="80" height="auto" class="d-inline-block align-top" alt="" />
                    </a>
                   <%--  <div class="m-3 ">
                            <button class="btn btn-primary" id="btnSwitch">
                                <i class="fas fa-home"></i>
                            </button>
                        </div>--%>
                       

                    <ul class="navbar-nav flex-row ml-md-auto d-none d-md-flex">
                        <li class="m-3 text-center" style="width:200px; line-height:14px;"><span><label id="lblTime"></label></span><br /></li>
                        <%--<a class="navbar-brand" href="">
                            <img src="../Plugins/images/teams-Logo.png" width="250" height="auto" class="d-inline-block align-top" alt="" />
                        </a>--%>
                    </ul>
               </nav>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row mt-3">
           <%-- <div class="col-md-4 divCategorySelection" data-attr="Diesel" >
                <a href="#">
                    <div class="card" style="min-height:120px;">
                        <div class="card-body p-2">
                            <div class="row">
                                <div class="col-md-3 pt-2">
                                    <img src="../Plugins/images/Cat-DG.svg" class="img-fluid" />
                                </div>
                                <div class="col-md-9">
                                    <h3 class="pt-4 pb-3"><strong>Diesel Generator</strong></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </div>--%>
           <%-- <div class="col-md-4 divCategorySelection" data-attr="Chiller">
                <a href="#">
                    <div class="card" style="min-height:120px;">
                        <div class="card-body p-2">
                            <div class="row">
                                <div class="col-md-3 pt-4">
                                    <img src="../Plugins/images/Cat-Chiller.svg" class="img-fluid text-danger" />
                                </div>
                                <div class="col-md-9">
                                    <h3 class="pt-4 pb-3"><strong>Chiller</strong></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </div>--%>
            <div class="col-md-4 divCategorySelection" data-attr="AHU" >
                <div class="card" style="min-height:120px;">
                    <a href="HVAC.aspx">
                        <div class="card-body p-2">
                            <div class="row">
                                <div class="col-md-3 pt-4">
                                    <img src="../Plugins/images/Cat-AHU.svg" class="img-fluid" />
                                </div>
                                <div class="col-md-9">
                                    <h3 class="pt-4 pb-3"><strong>HVAC</strong></h3>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
      <%--  </div>
        <div class="row mt-3">--%>
          <%--  <div class="col-md-4 divCategorySelection" data-attr="ColdRoom" id="divColdRoom">
                <a href="HVAC.aspx">
                    <div class="card" style="min-height:120px;">
                        <div class="card-body p-2">
                            <div class="row">
                                <div class="col-md-3 pt-3">
                                    <img src="../Plugins/images/Cat-Cold-Room.svg" class="img-fluid" />
                                </div>
                                <div class="col-md-9">
                                    <h3 class="pt-4 pb-3"><strong>Cold Room</strong></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </div>--%>
            <div class="col-md-4 divCategorySelection" data-attr="Electricity" id="divElectricity" >
                <a href="Aunoa_Electricity.aspx">
                    <div class="card" style="min-height:120px;">
                        <div class="card-body p-2">
                            <div class="row">
                                <div class="col-md-3">
                                    <img src="../Plugins/images/Cat-Electricity.svg" class="img-fluid text-danger" />
                                </div>
                                <div class="col-md-9">
                                    <h3 class="pt-4 pb-3"><strong>Electricity</strong></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            
        </div>
    </div>
</body>
</html>
