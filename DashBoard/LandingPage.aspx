<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LandingPage.aspx.cs" Inherits="CMS.DashBoard_LandingPage" %>

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
    var TimeId = 0; var TimeSet = "";
    $(document).ready(function () {

        $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        setInterval(function () {
            $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        }, 1000);
       

        $(".location").on('click', function () {
            var TypeId = $(this).attr("data-attr");
            var location = $(this).attr("data-location");
            localStorage.clear();
            localStorage.setItem('TypeId', TypeId);
            localStorage.setItem('Location', location);
            //window.location.href="LiveDashboard.aspx";
            window.location.href = "SiteDashboard.aspx";
        });
    });

 </script>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 p-0">
                <nav class="navbar navbar-light bg-light navbar-expand-lg p-1" style="background-color:white !important">
                    <a class="navbar-brand" href="">
                        <img src="../Plugins/images/Flechazo-Logo.png" width="170" height="auto" class="d-inline-block align-top" alt="" />
                    </a>
                   

                    <ul class="navbar-nav flex-row ml-md-auto d-none d-md-flex">
                        <li class="m-3 text-center" style="width:200px; line-height:14px;"><span><label id="lblTime"></label></span><br /></li>
                        <a class="navbar-brand" href="">
                            <img src="../Plugins/images/teams-Logo.png" width="250" height="auto" class="d-inline-block align-top" alt="" />
                        </a>
                    </ul>
               </nav>
            </div>
        </div>
    </div>
    <%--<div class="container-fluid">
        <div class="row mt-5 justify-content-center">
            <div class="col-md-8 bg-light  ">
                <h2 class="text-center mt-3 p-3"><strong>Select Hotel For Review</strong></h2>
                <div class="row ">
                    <div class="col-md-6">
                        <button type="button" class="btn btn-success btn-lg btn-block location" data-attr="1" data-location="Pune" />
                        <div class="media m-3">
                            <img src="../Plugins/images/shanivarwada.svg" width="60px" class="mr-3" alt="Hotel">
                            <div class="media-body">
                                <h2 class="mt-2 text-light">Pune</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <button type="button" class="btn btn-secondary btn-lg btn-block location" data-attr="2" data-location="Hyderabad" />
                        <div class="media m-3">
                            <img src="../Plugins/images/charminar.svg" width="45px" class="mr-3" alt="Hotel">
                            <div class="media-body">
                                <h2 class="mt-2 text-light">Hyderabad</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 pt-4">
                        <p class="text-center small">Powered By
                            <br />
                            Hubmatrix Technologies Pvt. Ltd</p>
                    </div>
                </div>
            </div>
        </div>
    </div>--%>

    <div class="container-fluid">
		<h4 class="mt-1 p-1"><strong>Select Hotel For Review</strong></h4>
		<div class="row justify-content-center">
			<div class="col-md-4 m-2 p-3 bg-light" style="min-height: 300px;">
				<h5 class="text-info"><strong>West Zone</strong></h5>
				<div class="media">
					&emsp;&emsp;&emsp;
						<div class="media-body">
							<button class="btn btn-success">Pune</button>
							<div class="media mt-3">
								<div class="media-body">
									<div class="row">
										<div class="col-md-2 pt-2">
											<i class="fas fa-arrow-right"></i>
										</div>
										<div class="col-md-10 pl-0 pt-2">
											<button class="btn btn-dark location" data-attr="1" data-location="Pune-Wakad">Wakad</button>
										</div>
									</div>
	
								</div>
							</div>
							
						</div>
						
					</div>
			</div>
			<div class="col-md-4 m-2 p-4 bg-light" style="min-height: 300px;">
				<h5 class="text-info"><strong>South Zone</strong></h5>
				<div class="media">
					&emsp;&emsp;&emsp;
					<div class="media-body">
						<button class="btn btn-success">Banglore</button>
						<div class="media mt-3">
							<div class="media-body">
								<div class="row">
									<div class="col-md-2 pt-2">
										<i class="fas fa-arrow-right"></i>
									</div>
									<div class="col-md-10 pl-0 pt-2">
										<button class="btn btn-dark location" data-attr="" data-location="WhiteField" disabled>WhiteField</button>
									</div>
								</div>
								<div class="row">
										<div class="col-md-2 pt-2">
											<i class="fas fa-arrow-right"></i>
										</div>
										<div class="col-md-10 pl-0 pt-3">
											<button class="btn btn-dark location" data-attr="" data-location="Marathalli" disabled>Marathalli</button>
										</div>
									</div>

							</div>
						</div>

						<div class="mt-3">
								<button class="btn btn-success">Hyderabad</button>
								<div class="media mt-3">
									<div class="media-body">
										<div class="row">
											<div class="col-md-2 pt-2">
												<i class="fas fa-arrow-right"></i>
											</div>
											<div class="col-md-10 pl-0 pt-2">
												<button class="btn btn-dark location" data-attr="" data-location="Gachibowli" disabled>Gachibowli</button>
											</div>
										</div>
										<div class="row">
												<div class="col-md-2 pt-2">
													<i class="fas fa-arrow-right"></i>
												</div>
												<div class="col-md-10 pl-0 pt-3">
													<button class="btn btn-dark location" data-attr="2" data-location="Hyderabad-Madhapur">Madhapur</button>
												</div>
											</div>
		
									</div>
								</div>
						</div>
						
					</div>
					
				</div>
			</div>
			<div class="col-md-12 pt-2">
				<p class="text-center small"><i>Powered By</i><br>Hubmatrix Technologies Pvt. Ltd.</p>
			</div>
		</div>
	</div>
</body>
</html>
