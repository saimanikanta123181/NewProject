<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SiteDashboard.aspx.cs" Inherits="CMS.DashBoard_SiteDashboard" %>

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
    <script src="https://cdn.zingchart.com/zingchart.min.js"></script>
  <%--  <script> zingchart.MODULESDIR = "https://cdn.zingchart.com/modules/";
        ZC.LICENSE = ["569d52cefae586f634c54f86dc99e6a9", "ee6b7db5b51705a13dc2339db3edaf6d"];

    </script>--%>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.js"></script>
    <title></title>
    <style>
        #consumptionBarChart {
            height: 180px !important;
        }

        #spendBarChart {
            height: 180px !important;
        }
        .zc-svg
        {
                margin-top: 0px !important;
        }
        .zc-top
        {
            top:0px !important;
        }
    </style>
</head>
<script>
    var TimeId = 0; var TimeSet = "";
    var TypeId = localStorage.getItem('TypeId');
    $(document).ready(function () {
        $("#btnSwitch").click(function () {
            window.location.href = "LandingPage.aspx";
        });
        $("#txtLocation").html(localStorage.getItem('Location'));
        $("#txtDate").daterangepicker({
            singleDatePicker: true,
            showDropdowns: true,
            locale: {
                format: 'DD/MM/YYYY'
            }
        });
        //$(".test").click(function () {
        //    var i = 0;
        //});
        click();
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


        var today = moment().format('DD/MM/YYYY HH:mm ');
        GetConsumptionTableData(today);
        GetConsumption(today);
        getElectricityData(today);
        getSpendChartData(today);
        getHVACData(today);
        GetUnmonitoredData(today);
        TimeSet = setInterval(function () {

            var today = moment().format('DD/MM/YYYY HH:mm ');

            GetConsumptionTableData(today);
            GetConsumption(today);
            getElectricityData(today);
            getSpendChartData(today);
            getHVACData(today);
            GetUnmonitoredData(today);
        }, 300000);
        $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        setInterval(function () {
            $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        }, 1000);
        TimeOut(today);

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
            TimeOut(yesterday + ' ' + '23:59');
        });
    }
    function TimeOut(Date) {


        if (TimeId == 1) {
            GetConsumptionTableData(Date);
            GetConsumption(Date);
            getElectricityData(Date);
            getSpendChartData(Date);
            getHVACData(Date);
            GetUnmonitoredData(Date);
            TimeSet = setInterval(function () {
                GetConsumptionTableData(Date);
                GetConsumption(Date);
                getElectricityData(Date);
                getSpendChartData(Date);
                getHVACData(Date);
                GetUnmonitoredData(Date);
            }, 300000);
        }
        else if (TimeId == 2) {
            clearTimeout(TimeSet);
            GetConsumptionTableData(Date);
            GetConsumption(Date);
            getElectricityData(Date);
            getSpendChartData(Date);
            getHVACData(Date);
            GetUnmonitoredData(Date);
        }
    };
    function getElectricityData(today) {
        var Status = [];
        var CCount = [];
        var AvgReading = [];
        $.ajax({
            url: "SiteDashboard.aspx/GetElectricityData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push('EB');
                    CCount.push(Temp[i].Main);
                    Status.push('DG');
                    CCount.push(Temp[i].DG);
                    Status.push('Total');
                    CCount.push(Temp[i].Total);
                    $("#txtTotalCon").html(Temp[i].Total);
                }
             
                $("#ConsumptionBarChartDiv").empty();
                var str = '<canvas id="consumptionBarChart" height="300" width="400" style="color:black;"></canvas>';
                $("#ConsumptionBarChartDiv").append(str);
                genrateBarChart(Status, CCount, 'consumptionBarChart')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getSpendChartData(today) {
        var Status = [];
        var CCount = [];
        var AvgReading = [];
        $.ajax({
            url: "SiteDashboard.aspx/GetSpendChartData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var TotalSpend = 0;
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    if (Temp[i].MeterName == 'FA & Exhaust') {
                        Temp[i].MeterName = 'Exhaust';
                    } else if (Temp[i].MeterName == 'RO and Lighting') {
                        Temp[i].MeterName = 'Lighting';
                    }
                    Status.push(Temp[i].MeterName);
                    CCount.push(Temp[i].Consumption);
                    TotalSpend += Temp[i].Consumption;
                }
                $("#txtTotalSpend").html(TotalSpend.toFixed(2));
                $("#SpendBarChartDiv").empty();
                var str = '<canvas id="spendBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#SpendBarChartDiv").append(str);
                genrateBarChart(Status, CCount, 'spendBarChart')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }

    function genrateBarChart(Status, CCount, id) {
        var barColor;
        if (id == 'spendBarChart') {
            barColor = 'blue';
        } else {
            barColor = ["blue","#a50202","#fc6c00","#ff0c0c"];
        }
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                datasets: [{
                    label: "",
                    backgroundColor: barColor,
                    data: CCount,
                    lineTension: 0,
                }
                ],
                labels: Status
            },
           options: {
               legend: {
                    display: false,
                    position: 'top'
                },
                title: {
                    display: false,
                },
                scales: {
                    xAxes: [{
                        ticks: {
                            beginAtZero: true
                        },
                        display: true,
                        scaleLabel: {
                            display: false,
                        }
                    }],
                    yAxes: [{
                        ticks: {
                            beginAtZero:true
                        },
                        display: true,
                        scaleLabel: {
                            display: false,
                        }
                    }]
                },
                },
         
         });
    }
    function GetConsumptionTableData(today) {
        $.ajax({
            url: "SiteDashboard.aspx/GetConsumptionData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                $("#tblConsumption").empty();
                var str = '';
                var Temp = JSON.parse(data.d);
                var src = "", src1 = "";
                for (var i = 0; i < Temp.length; i++) {
                    str += '<tr><td>' + Temp[i].Category + '</td><td>' + Temp[i].ToDayCons + '</td><td>' + Temp[i].PrevDayCons + '</td><td>' + Temp[i].MonthCons + '</td></tr>';
                }
                $("#tblConsumption").append(str);
                lblupdTime.innerHTML = moment().format('h:mm:ss A');
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function GetUnmonitoredData(today) {
        $.ajax({
            url: "SiteDashboard.aspx/GetUnmonitoredEnergy",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                $("#tblEnergyMonitor").empty();
                var str = '';
                var Temp = JSON.parse(data.d);
                var src = "", src1 = "";
                for (var i = 0; i < Temp.length; i++) {
                    if (i != Temp.length - 1)
                    {
                        str += '<tr><td>' + Temp[i].Types + '</td><td>' + Temp[i].Values + ' KWH</td></tr>';
                    } else {
                        str += '<tr><td>' + Temp[i].Types + '</td><td>' + Temp[i].Values + '</td></tr>';
                    }
                  
                }
                $("#tblEnergyMonitor").append(str);
                lblupdTime.innerHTML = moment().format('h:mm:ss A');
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function GetConsumption(today) {
        $.ajax({
            url: "SiteDashboard.aspx/GetConsumption",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                $("#txtElectricity").html(Temp[0].DayCons_Electrical);
                $("#txtWater").html(Temp[0].DayCons_Water);
                 $("#txtGas").html(Temp[0].DayCons_Gas);
                 $("#txtFuel").html(Temp[0].DayCons_Fuel);
                 $("#txtDG").html(Temp[0].DayCons_DG);
             },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function RenderElectricityGuage(consumption, id) {
        var myConfig1 = {
            "type": "gauge",
            "series": [
              { "values": [consumption] }
            ]
        };

        zingchart.render({
            id: id,
            data: myConfig1,
            height: "100%",
            width: "100%"
        });

    }
    function RenderWaterGuage(consumption, id) {
        var myConfig1 = {
            "type": "gauge",
            "series": [
              { "values": [consumption] }
            ]
        };

        zingchart.render({
            id: id,
            data: myConfig1,
            height: "100%",
            width: "100%"
        });

    }
    function RenderDGGuage(consumption, id) {
        var myConfig1 = {
            "type": "gauge",
            "series": [
              { "values": [consumption] }
            ]
        };

        zingchart.render({
            id: id,
            data: myConfig1,
            height: "100%",
            width: "100%"
        });

    }
    function RenderFuelGuage(consumption, id) {
        var myConfig1 = {
            "type": "gauge",
            "series": [
              { "values": [consumption] }
            ]
        };

        zingchart.render({
            id: id,
            data: myConfig1,
            height: "100%",
            width: "100%"
        });

    }
    function RenderGasGuage(consumption, id) {
        var myConfig1 = {
            "type": "gauge",
            "series": [
                { "values": [consumption] }
            ]
        };

        zingchart.render({
            id: id,
            data: myConfig1,
            height: "100%",
            width: "100%"
        });

    }

    function getHVACData(today) {
        $.ajax({
            url: "SiteDashboard.aspx/GetHVACData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                $("#tblHVAC").empty();
                var str = '';
                var Temp = JSON.parse(data.d);
                var src = "", src1 = "";
                for (var i = 0; i < Temp.length; i++) {

                    if (Temp[i].Unit_Status_Reading == 1) {
                        src = "../Plugins/images/AC-working.gif"
                    }
                    else {
                        src = "../Plugins/images/AC-not-working.png"
                    }
                    if (Temp[i].Cooling_Status == 1 && Temp[i].Unit_Status_Reading != 0) {
                        src1 = "../Plugins/images/snowflake.gif"
                    }
                    else {
                        src1 = "../Plugins/images/snowflake_off.png";
                    }


                    str += '<tr><td align="center">' + Temp[i].LocationName + '</td><td align="center"><img src="' + src + '" height="auto" width="20px" background="none"/></td><td align="center"><img src="' + src1 + '" height="auto" width="20px"/></td><td align="center">' + Temp[i].Temp_Set_Reading + '</td><td align="center">' + Temp[i].Temp_Ret_Reading + '</td><td align="center">' + Temp[i].Temp_Sup_Reading + '</td><td align="center">' + (Temp[i].Delta_T_Reading == null ?'':Temp[i].Delta_T_Reading ) + '</td></tr>';
                }
                $("#tblHVAC").append(str)
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
</script>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 p-0">
                <nav class="navbar navbar-light bg-light navbar-expand-lg p-1" style="background-color: white !important">
                    <a class="navbar-brand" href="">
                        <img src="../Plugins/images/Flechazo-Logo.png" width="130" height="auto" class="d-inline-block align-top" alt="" />
                    </a>
                    <ul class="navbar-nav flex-row ml-md-auto d-none d-md-flex">

                        <li class="m-3 pt-2">
                            <h6><strong><span id="txtLocation"></span></strong></h6>
                        </li>
                        <li class="m-3">
                            <button class="btn btn-primary" id="btnSwitch">
                                <i class="fas fa-home"></i>
                                <%--<img src="../Plugins/images/home.svg" width="25px" />--%>
                            </button>
                        </li>
                        <li class="m-3">
                            <button class="btn btn-primary" id="btnToday">Today</button>
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
                        <li class="m-3 text-right" style="width: 200px; line-height: 14px;"><span>
                            <label id="lblTime"></label>
                        </span>
                            <br />
                            <small>Last Updated :
                                <label id="lblupdTime"></label>
                            </small></li>
                        <a class="navbar-brand" href="">
                            <img src="../Plugins/images/teams-Logo.png" width="200" height="auto" class="d-inline-block align-top pt-2" alt="" />
                        </a>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row pl-1 pb-0 pr-1 pt-1">
            <div class="col-md-2 pl-1 pb-0 pr-1 pt-1">
                <div class="bg-light card p-2 mb-2">
                        <p class="small mb-1">Site : Flechazo Restaurant</p>
                        <p class="small mb-1">Branch : Pune</p>
                        <p class="small mb-1">Region : West</p>
                    <%--<div class="row">
                        <p class="col-md-4 small mb-1">Site Name</p>
                        <p class="col-md-8 small mb-1">: Flechazo Restaurant</p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small mb-1">Branch</p>
                        <p class="col-md-8 small mb-1">: Pune</p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small mb-1">Region</p>
                        <p class="col-md-8 small mb-1">: West</p>
                    </div>--%>
                </div>
                <div class="bg-light card p-2 mb-1">
                        <p class="small mb-1">No Of PAX : 560</p>
                        <p class="small mb-1">Area In Sq.Ft : 345667</p>
                        <p class="small mb-1">OPs Hours : 12 AM - 12 PM</p>
                    <%--<div class="row">
                        <p class="col-md-4 small mb-1">No Of PAX</p>
                        <p class="col-md-8 small mb-1">: 560</p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small mb-1">Area In Sq.Ft</p>
                        <p class="col-md-8 small mb-1">: 345667</p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small mb-1">OPs Hours</p>
                        <p class="col-md-8 small mb-1">: 12 AM - 12 PM</p>
                    </div>--%>
                </div>
                <div class="bg-light card p-2 mb-1">
                    <div class="row">
                        <p class="col-md-12 small mb-1"><strong>In Store Quality</strong></p>
                        <p class="col-md-6 small mb-1">Temp : </p>
                        <p class="col-md-6 small mb-1">Oxygen : </p>
                    </div>
                    <div class="row">
                        <p class="col-md-6 small mb-1">Lux : </p>
                        <p class="col-md-6 small mb-1">Co2 : </p>
                        <p class="col-md-12 small mb-1">Humidity : </p>
                    </div>
                </div>
                <div class="bg-light card p-2 mb-1">
                    <div class="row">
                        <p class="col-md-12 small mb-1"><strong>Kitchen Air</strong></p>
                        <p class="col-md-6 small mb-1">Temp : </p>
                        <p class="col-md-6 small mb-1">Co2 : </p>
                        <p class="col-md-6 small mb-1">Oxygen : </p>
                    </div>
                </div>
                <div class="bg-light card p-2 pb-4">
                        <p class="small mb-1"><strong>Rest Room Air Quality</strong></p>
                        <p class="small mb-1">Ammonia : </p>
                        <%--<p class="col-md-4 small mb-1">&nbsp;</p>--%>
                </div>
            </div>
            <div class="col-md-7 pl-1 pb-0 pr-1 pt-1">
                <div class="row m-0">
                    <div class="col-md bg-light card pt-2 mb-1">
                        <a href="../DashBoard/Electricity.aspx">
                        <div class="row">
                            <div class="col-md-4 p-1">
                                <img src="../Plugins/images/Electricity.svg" class="img-fluid" alt="Electricity" />
                            </div>
                            <div class="col-md-8 pl-0 pr-2 text-right">
                                <p class="p-0 mb-0" style="font-size: 14px">
                                    Electricity<br />
                                    <span style="font-size: 15px; font-weight: bold;"><span id="txtElectricity"></span> KWH</span> 
                                </p>
                            </div>
                        </div>
                            </a>
                    </div>
                     <div class="col-md bg-light card pt-2 mb-1">
                         <a href="../DashBoard/Fuel.aspx">
                        <div class="row">
                            <div class="col-md-4 p-1">
                                <img src="../Plugins/images/Fuel.svg"   class="img-fluid" alt="Fuel" />
                            </div>
                            <div class="col-md-8 pl-0 pr-2 text-right">
                                <p class="p-0 mb-0" style="font-size: 14px">
                                    Fuel<br />
                                    <span style="font-size: 15px; font-weight: bold;" ><span id="txtFuel"></span> Ltr</span> 
                                </p>
                            </div>
                        </div>
                             </a>
                    </div>
                      <div class="col-md bg-light card pt-2 mb-1">
                         <a href="../DashBoard/Gas.aspx">
                        <div class="row">
                            <div class="col-md-4 p-1">
                                <img src="../Plugins/images/fire-outline.svg" width="35px" class="img-fluid" alt="Gas" />
                            </div>
                            <div class="col-md-8 pl-0 pr-2 text-right">
                                <p class="p-0 mb-0" style="font-size: 14px">
                                    Gas<br />
                                    <span style="font-size: 15px; font-weight: bold;"><span id="txtGas"></span> KG</span> 
                                </p>
                            </div>
                        </div>
                             </a>
                    </div>
                    <div class="col-md bg-light card pt-2 mb-1">
                         <a href="../DashBoard/Water.aspx">
                        <div class="row">
                            <div class="col-md-4 p-1">
                               <img src="../Plugins/images/Water.svg" class="img-fluid" alt="Water" />
                            </div>
                            <div class="col-md-8 pl-0 pr-2 text-right">
                                <p class="p-0 mb-0" style="font-size: 14px">
                                    Water<br />
                                    <span style="font-size: 15px; font-weight: bold;"><span id="txtWater"></span> Ltr</span> 
                                </p>
                            </div>
                        </div>
                             </a>
                    </div>
                  
                   
                    <div class="col-md bg-light card pt-2 mb-1">
                         <a href="../DashBoard/Fuel.aspx">
                        <div class="row">
                            <div class="col-md-4 p-1">
                                <img src="../Plugins/images/M_Dieselgenerator.svg"  class="img-fluid" alt="HVAC" />
                            </div>
                            <div class="col-md-8 pl-0 pr-2 text-right">
                                <p class="p-0 mb-0" style="font-size: 14px">
                                    DG<br />
                                    <span style="font-size: 15px; font-weight: bold;"><span id="txtDG"></span> KWH</span> 
                                </p>
                            </div>
                        </div>
                             </a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 pr-1">
                        <div class="bg-light card mb-1">
                        <p class="small text-left pl-2"><strong>Consumption</strong><strong style="float: right">Total : <span id="txtTotalCon"></span> KWH</strong></></p>
                        <div id="ConsumptionBarChartDiv">
                        </div>
                       </div>
                    </div>
                    <div class="col-md-8 pl-1">
                        <div class="bg-light card mb-1">
                            <p class="small text-left pl-2"><strong>Monitored Energy</strong><strong style="float: right">Total : <span id="txtTotalSpend"></span> KWH</strong></></p>
                            <div id="SpendBarChartDiv">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 ">
                        <div class="bg-light card p-2">
                            <p class="small text-left mb-0"><strong><a href="HVAC.aspx" class="text-primary">AC</a></strong></p>
                            <table class="table table-bordered table-sm mb-0" style="font-size: 10px !important">
                                <thead>
                                    <tr style="background: #e8e8e8 !important">
                                        <th style="text-align: center;">AC</th>
                                        <th style="text-align: center;">Unit Status</th>
                                        <th style="text-align: center;">Cooling Status</th>
                                        <th style="text-align: center;">Temp. Set.</th>
                                        <th style="text-align: center;">Temp. Ret</th>
                                        <th style="text-align: center;">Temp. Sup</th>
                                        <th style="text-align: center;">Delta T</th>
                                    </tr>
                                </thead>
                                <tbody id="tblHVAC"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 p-1">
                <div class="bg-light card p-2 mb-1">
                    <p class="small mb-0"><strong>Consumption Table</strong></p>
                    <table class="table table-bordered table-sm" style="font-size: 10px !important">
                        <thead>
                            <tr style="background: #e8e8e8 !important">
                                <th style="text-align: center;">Category</th>
                                <th style="text-align: center;">Today</th>
                                <th style="text-align: center;">Prev.Day</th>
                                <th style="text-align: center;">MTD</th>
                            </tr>
                        </thead>
                        <tbody id="tblConsumption"></tbody>
                    </table>
                          <%--<div class="col-md-4">
                        <div class="bg-light card p-2">
                            <p class="small text-center"><strong>Spend Vs Consumption</strong></></p>
                            <table class="table table-bordered table-sm" style="font-size: 10px !important; font-weight: bold">
                                <thead>
                                    <tr style="background: #e8e8e8 !important">
                                        <th style="text-align: center;">Type</th>
                                        <th style="text-align: center;">Value</th>
                                    </tr>
                                </thead>
                                <tbody id="tblEnergyMonitor"></tbody>
                            </table>

                        </div>
                    </div>--%>
               <p class="small mb-0"><strong>Monitored Energy Vs Consumption</strong></></p>
                            <table class="table table-bordered table-sm" style="font-size: 10px !important; font-weight: bold">
                                <thead>
                                    <tr style="background: #e8e8e8 !important">
                                        <th style="text-align: center;">Type</th>
                                        <th style="text-align: center;">Value</th>
                                    </tr>
                                </thead>
                                <tbody id="tblEnergyMonitor"></tbody>
                            </table>
                </div>
                <div class="bg-light card p-2 mt-1">
                    <p class="small mb-0"><strong>Alerts</strong> <i class="fas fa-bell text-danger"></i></p>
                    <div class="row">
                        <p class="col-md-4 small pt-0 pb-0 mb-0">Electricity</p>
                        <p class="col-md-6 pt-0 pb-0 mb-0" style="background-color: #dbffd9"></p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small pt-0 pb-0 mb-0">DG</p>
                        <p class="col-md-6 pt-0 pb-0 mb-0"><i class="fas fa-bell text-danger"></i>&nbsp;<i class="fas fa-bell text-danger"></i></p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small pt-0 pb-0 mb-0">Gas</p>
                        <p class="col-md-6 pt-0 pb-0 mb-0" style="background-color: #dbffd9"></p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small pt-0 pb-0 mb-0">Fuel</p>
                        <p class="col-md-6 pt-0 pb-0 mb-0"><i class="fas fa-bell text-danger"></i>&nbsp;<i class="fas fa-bell text-danger"></i></p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small pt-0 pb-0 mb-0">Water</p>
                        <p class="col-md-6 pt-0 pb-0 mb-0" style="background-color: #dbffd9"></p>
                    </div>
                    <%--<div class="row">
                        <p class="col-md-4 small">Request</p>
                        <p class="col-md-6 "><i class="fas fa-bell text-danger"></i>&nbsp;<i class="fas fa-bell text-danger"></i></p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small">HSQE</p>
                        <p class="col-md-6 " style="background-color: #dbffd9"></p>
                    </div>--%>
                </div>
            </div>

        </div>
        <div class="row pl-1 pb-1 pr-1 pt-0">
            <div class="col-md-3 p-1">
                <div class="bg-light card p-2 mb-1">
                    <div class="row">
                        <p class="col-md-12 small mb-0"><strong>Request</strong></p>
                        <p class="col-md-3 small mb-0">Pending</p>
                        <p class="col-md-3 small mb-0">: </p>
                        <p class="col-md-3 small mb-0 text-right">Done</p>
                        <p class="col-md-3 small mb-0">: </p>
                        <p class="col-md-12 small mb-0">&nbsp;</p>
                    </div>
                </div>

            </div>
            <div class="col-md-4 p-1">
                <div class="bg-light card p-2 mb-1">
                    <div class="row">
                        <p class="col-md-12 small mb-0"><strong>PPM</strong></p>
                        <p class="col-md-3 small mb-0">Pending</p>
                        <p class="col-md-3 small mb-0">: </p>
                        <p class="col-md-3 small mb-0 text-right">Done</p>
                        <p class="col-md-3 small mb-0">: </p>
                        <p class="col-md-3 small mb-0">&nbsp;</p>
                    </div>
                </div>
            </div>
            <div class="col-md-5 p-1">
                <div class="bg-light card p-2 mb-1">
                    <div class="row">
                        <p class="col-md-12 small mb-0"><strong>HSQE</strong></p>
                        <p class="col-md-3 small mb-0">Incedent</p>
                        <p class="col-md-3 small mb-0">: </p>
                        <p class="col-md-3 small mb-0 text-right">Near Incident</p>
                        <p class="col-md-3 small mb-0">: </p>
                        <p class="col-md-3 small mb-0">Unsafe Act</p>
                        <p class="col-md-3 small mb-0">: </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
