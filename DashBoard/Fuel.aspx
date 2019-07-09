<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fuel.aspx.cs" Inherits="CMS.DashBoard_Fuel" %>

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
    <%--<script src="../Plugins/JS/Chart.min.js"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.js"></script>
    <title></title>
    <style>
        #DGUnitGenrationBarChart,#DieselConsumptionBarChart,#DGRunningBarChart {
            height: 210px !important;
            margin-top: -30px;
        }
 </style>
</head>
<script>
    var TimeId = 0; var TimeSet = "";
    var today = moment().format('DD/MM/YYYY HH:mm:ss');
    var TypeId = localStorage.getItem('TypeId');
    $(document).ready(function () {
        $("#txtLocation").html(localStorage.getItem('Location'));
        $("#txtDate").daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {
                format: 'DD/MM/YYYY'
            }
        });
        click();
        $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        setInterval(function () {
            $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        }, 1000);

        $("#txtDate").change(function () {

            if ($("#txtDate").val() == moment(new Date()).format("DD/MM/YYYY")) {
                TimeId = 1;
                TimeOut($("#txtDate").val() + ' ' + '23:59 PM');
            }
            else {
                TimeId = 2;
                TimeOut($("#txtDate").val() + ' ' + '23:59 PM');
            }
        });

        getDGUnitGenrationData(today);
        getDieselConsumptionData(today);
        GetDGRunningHrsData(today);
      
    });

    function click() {
        $("#btnToday").click(function (e) {
            $('#btnYesterday').removeClass('btn-primary').addClass('btn-outline-primary');
            $('#btnToday').removeClass('btn-outline-primary').addClass('btn-primary');
            TimeId = 1;
            $("#txtDate").val(moment().format('DD/MM/YYYY'));
            TimeOut(moment().format('DD/MM/YYYY HH:mm'));
        });
        $("#btnYesterday").click(function (e) {
            $('#btnToday').removeClass('btn-primary').addClass('btn-outline-primary');
            $('#btnYesterday').removeClass('btn-outline-primary').addClass('btn-primary');
            $today = new Date();
            $yesterday = new Date($today);
            var $dd = $yesterday.getDate() - 1;
            var $mm = $yesterday.getMonth() + 1; //January is 0!

            var $yyyy = $yesterday.getFullYear();
            if ($dd < 10) { $dd = '0' + $dd } if ($mm < 10) { $mm = '0' + $mm } var yesterday = $dd + '/' + $mm + '/' + $yyyy;
            TimeId = 2;
            $("#txtDate").val(yesterday);
            TimeOut(yesterday + ' ' + '23:59:00');
        });
    }
    function TimeOut(Date) {
        if (TimeId == 1) {
            getDGUnitGenrationData(Date);
            getDieselConsumptionData(Date);
            GetDGRunningHrsData(Date);
            TimeSet = setInterval(function () {
                getDGUnitGenrationData(Date);
                getDieselConsumptionData(Date);
                GetDGRunningHrsData(Date);
            }, 300000);
        }
        else if (TimeId == 2) {
            clearTimeout(TimeSet);
            getDGUnitGenrationData(Date);
            getDieselConsumptionData(Date);
            GetDGRunningHrsData(Date);
        }
    };

    function getDGUnitGenrationData(today) {
        var Hrs = [];
        var UnitGenrate = [];

        $.ajax({
            url: "Fuel.aspx/GetDGUnitGenrationData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Hrs.push(Temp[i].HRS);
                    UnitGenrate.push(Temp[i].UnitGenerate);
                }
                $("#DivDGUnitGenration").empty();
                var str = '<canvas id="DGUnitGenrationBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#DivDGUnitGenration").append(str);
                genrateFuelBarChart(Hrs, UnitGenrate, 'DGUnitGenrationBarChart', 'blue', 'Units in KWH', 'DG Unit Genration')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getDieselConsumptionData(today) {
        var Hrs = [];
        var FuelConsumption = [];
        $.ajax({
            url: "Fuel.aspx/GetDieselConsumptionData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Hrs.push(Temp[i].HRS);
                    FuelConsumption.push(Temp[i].FuelConsumption);
                }
                $("#DivDieselConsumption").empty();
                var str = '<canvas id="DieselConsumptionBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#DivDieselConsumption").append(str);
                genrateFuelBarChart(Hrs, FuelConsumption, 'DieselConsumptionBarChart', '#ef418c', 'Units in Ltr', 'Diesel Consumption')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function GetDGRunningHrsData(today) {
        var Status = [];
        var RunningHrs = [];

        $.ajax({
            url: "Fuel.aspx/GetDGRunningHrsData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    RunningHrs.push(Temp[i].RunningHour);
                }
                $("#DivDGRunning").empty();
                var str = '<canvas id="DGRunningBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#DivDGRunning").append(str);
                genrateFuelBarChart(Status, RunningHrs, 'DGRunningBarChart', '#aba038', 'Units in Min', 'DG Running Time')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }

    function genrateFuelBarChart(Status, RunningHrs, id, color, labelString,label) {
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                datasets: [{
                    label: label,
                    backgroundColor: color,
                    data: RunningHrs
                }],
                labels: Status
            },
            options: {
                legend: {
                    display: true,
                    position: 'top'
                },
                title: {
                    display: true,
                },
                scales: {
                    xAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'During 00 to 24 Hrs'
                        }
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: labelString
                        }
                    }]
                },
            },
        });
    }
 </script>
<body>
    <div class="container-fluid">
       <div class="row">
            <div class="col-md-12 p-0">
                <nav class="navbar navbar-light bg-light navbar-expand-lg p-1" style="background-color:white !important">
                    <a class="navbar-brand" href="../DashBoard/Fuel.aspx">
                        <img src="../Plugins/images/Flechazo-Logo.png" width="130" height="auto" class="d-inline-block align-top" alt="" />
                    </a>
                   <ul class="navbar-nav flex-row ml-md-auto d-none d-md-flex">
                        <li class="m-3 pt-2">
                            <h6><strong><span id="txtLocation"></span></strong></h6>
                        </li>
                        <li class="m-3">
                            <button class="btn btn-primary"  id="btnToday">Today</button>
                        </li>
                        <li class="m-3">
                            <button class="btn btn-outline-primary" id="btnYesterday">Yesterday</button>
                        </li>
                      
                        <li class="m-3">
                            <div class="input-group">
                                <input type="text" id="txtDate" class="form-control" />
                                <div class="input-group-append">
                                    <button class="btn btn-outline-primary" type="button"><i class="fas fa-calendar-alt"></i></button>
                                </div>
                            </div>
                        </li>
                        <li class="m-3 text-right" style="width:200px; line-height:14px;"><span><label id="lblTime"></label></span><br /></li>
                        <a class="navbar-brand" href="../DashBoard/Fuel.aspx">
                            <img src="../Plugins/images/teams-Logo.png" width="200" height="auto" class="d-inline-block align-top pt-2" alt="" />
                        </a>
                    </ul>


                </nav>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row mt-2">
            <a href="../DashBoard/LandingPage.aspx" title="Home">
                <div class="col-md-1 pt-2">
                    <img src="../Plugins/images/home.svg" width="40px" />
                </div>
            </a>
            <a href="../DashBoard/SiteDashboard.aspx" title="Dashboard">
                <div class="col-md-1 pt-2">
                    <img src="../Plugins/images/Dashboard.svg" width="40px" />
                </div>
            </a>
            <div class="col-md bg-light card-electricity mr-3">
                <a href="Electricity.aspx" title="Electricity">
                    <div class="media pt-1 pb-1">
                        <img src="../Plugins/images/Electricity.svg" width="45px" class="mr-3" alt="Electricity" />
                        <div class="media-body">
                            <h5 class="mt-2">Electricity</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md bg-light card-hvac mr-3">
                <a href="HVAC.aspx" title="HVAC">
                    <div class="media pt-1 pb-1">
                        <img src="../Plugins/images/HVAC.svg" width="45px" class="mr-3" alt="HVAC" />
                        <div class="media-body">
                            <h5 class="mt-2">AC</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md bg-light card-fuel-active mr-3">
                <a href="Fuel.aspx" title="Fuel">
                    <div class="media pt-1 pb-1">
                        <img src="../Plugins/images/Fuel.svg" width="45px" class="mr-3" alt="Fuel" />
                        <div class="media-body">
                            <h5 class="mt-2">Fuel</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md bg-light card-gas mr-3">
                <a href="Gas.aspx" title="Gas">
                    <div class="media pt-1 pb-1">
                        <img src="../Plugins/images/fire-outline.svg" width="45px" class="mr-3" alt="Gas" />
                        <div class="media-body">
                            <h5 class="mt-2">Gas</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md bg-light card-water mr-3">
                <a href="Water.aspx" title="Water">
                    <div class="media pt-1 pb-1">
                        <img src="../Plugins/images/Water.svg" width="45px" class="mr-3" alt="Water" />
                        <div class="media-body">
                            <h5 class="mt-2">Water</h5>
                        </div>
                    </div>
                </a>
            </div>


        </div>

        <div class="row p-1">
          <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>DG Unit Genration In KWH</strong></h6>
                    <div id="DivDGUnitGenration">
                    </div>
                </div>
            </div>
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Diesel Consumption In Ltr</strong></h6>
                    <div id="DivDieselConsumption">
                    </div>
                </div>
            </div>
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Performance Chart</strong></h6>
                    <div id="DivPerformanceChart">
                    </div>
                </div>
            </div>
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>DG Running In Min</strong></h6>
                    <div id="DivDGRunning">
                    </div>
                </div>
            </div>
         </div>
    </div>
</body>
</html>

