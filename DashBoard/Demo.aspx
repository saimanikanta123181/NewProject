<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Demo.aspx.cs" Inherits="CMS.DashBoard_Demo" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" />
            <script src="https://cdn.fusioncharts.com/fusioncharts/latest/fusioncharts.js"></script>
    <script src=" https://cdn.fusioncharts.com/fusioncharts/latest/themes/fusioncharts.theme.ocean.js"></script>
    <script src="   https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src=" https://unpkg.com/jquery-fusioncharts@1.1.0/dist/fusioncharts.jqueryplugin.js"></script>

<%--    <script src="../Plugins/JS/Jquery.3.3.1.js"></script>--%>
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
       #chartobject-6{
           height:120px !important;
       }
       #raphael-paper-400{
             height:120px !important;
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
        RenderGuageChart(today);
        getElectricityData(today);
        getSpendChartData(today);
        getHVACData(today);
        TimeSet = setInterval(function () {

            var today = moment().format('DD/MM/YYYY HH:mm ');

            GetConsumptionTableData(today);
            RenderGuageChart(today);
            getElectricityData(today);
            getSpendChartData(today);
            getHVACData(today);
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
            RenderGuageChart(Date);
            getElectricityData(Date);
            getSpendChartData(Date);
            TimeSet = setInterval(function () {
                GetConsumptionTableData(Date);
                RenderGuageChart(Date);
                getElectricityData(Date);
                getSpendChartData(Date);
            }, 300000);
        }
        else if (TimeId == 2) {
            clearTimeout(TimeSet);
            GetConsumptionTableData(Date);
            RenderGuageChart(Date);
            getElectricityData(Date);
            getSpendChartData(Date);
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
                    Status.push('Main');
                    CCount.push(Temp[i].Main);
                    Status.push('DG');
                    CCount.push(Temp[i].DG);
                    Status.push('Total');
                    CCount.push(Temp[i].Total);
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
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    if (Temp[i].MeterName == 'FA & Exhaust') {
                        Temp[i].MeterName = 'Exhaust';
                    } else if (Temp[i].MeterName == 'RO and Lighting') {
                        Temp[i].MeterName = 'Lighting';
                    }
                    Status.push(Temp[i].MeterName);
                    CCount.push(Temp[i].Consumption);
                }
                $("#SpendBarChartDiv").empty();
                var str = '<canvas id="spendBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#SpendBarChartDiv").append(str);
                //genrateBarChart(Status, CCount, 'spendBarChart')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }

    function genrateBarChart(Status, CCount, id) {
        var barColor;
        if (id == 'spendBarChart') {
            barColor = 'blue';
        } else {
            barColor = ["blue", "#ff0c0c", "#fc6c00"];
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
                        display: true,
                        scaleLabel: {
                            display: false,
                        }
                    }],
                    yAxes: [{
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
                    str += '<tr><td>' + Temp[i].Category + '</td><td class="text-right">' + Temp[i].ToDayCons + '</td><td class="text-right">' + Temp[i].PrevDayCons + '</td><td class="text-right">' + Temp[i].MonthCons + '</td></tr>';
                }
                $("#tblConsumption").append(str);
                lblupdTime.innerHTML = moment().format('h:mm:ss A');
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }

    function RenderGuageChart(today) {
        $.ajax({
            url: "SiteDashboard.aspx/GetConsumption",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                 $("#lblElec").html(Temp[0].DayCons_Electrical);
                 $("#lblWater").html(Temp[0].DayCons_Water);
                 $("#lblDG").html(Temp[0].DayCons_DG);
                 $("#lblFuel").html(Temp[0].DayCons_Fuel);

                RenderElectricityGuage(Temp[0].DayCons_Electrical, 'ElectricityGuage');
                RenderWaterGuage(Temp[0].DayCons_Water, 'WaterGuage');
                RenderDGGuage(Temp[0].DayCons_DG, 'DGGuage');
                RenderFuelGuage(Temp[0].DayCons_Fuel, 'FuelGuage');
                RenderGasGuage(Temp[0].DayCons_Gas, 'GasGuage');
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function RenderElectricityGuage(consumption, id) {
        //var myConfig1 = {
        //    "type": "gauge",
        //    "series": [
        //      { "values": [consumption] }
        //    ]
        //};

        //zingchart.render({
        //    id: id,
        //    data: myConfig1,
        //    height: "100%",
        //    width: "100%"
        //});
        $("#chart-container").insertFusionCharts({
            type: "angulargauge",
            width: "100%",
            height: "100%",
            dataFormat: "json",
            dataSource: {
                "chart": {

                    "lowerlimit": "0",
                    "upperlimit": "100",
                    "showvalue": "10",
                    "numbersuffix": "%",
                    "theme": "ocean"
                },
                "colorrange": {
                    "color": [
                        {
                            "minvalue": "0",
                            "maxvalue": "100",
                            "code": "#4868e4"
                        }
                    ]
                },
                "dials": {
                    "dial": [
                        {
                            "value": consumption,
                            "tooltext": consumption
                        }
                    ]
                },
                "trendpoints": {
                    "point": [
                        //{
                        //    "startvalue": "80",
                        //    "displayvalue": "Target",
                        //    "thickness": "2",
                        //    "color": "#E15A26",
                        //    "usemarker": "1",
                        //    "markerbordercolor": "#E15A26",
                        //    "markertooltext": "80%"
                        //}
                    ]
                }
            }
        });

    }
    function RenderWaterGuage(consumption, id) {
        $("#WaterGuage").insertFusionCharts({
            type: "angulargauge",
            width: "100%",
            height: "100%",
            dataFormat: "json",
            dataSource: {
                "chart": {
                   
                    "lowerlimit": "0",
                    "upperlimit": "100",
                    "showvalue": "10",
                    "numbersuffix": "",
                    "theme": "ocean"
                },
                "colorrange": {
                    "color": [
                        {
                            "minvalue": "0",
                            "maxvalue": "100",
                            "code": "#66e448"
                        }
                    ]
                },
                "dials": {
                    "dial": [
                        {
                            "value": consumption,
                            "tooltext": consumption,
                        }
                    ]
                },
                "trendpoints": {
                    "point": [
                        {
                            //"startvalue": "90",
                            //"displayvalue": "Target",
                            //"thickness": "2",
                            //"color": "#E15A26",
                            //"usemarker": "1",
                            //"markerbordercolor": "#E15A26",
                            //"markertooltext": "90%"
                        }
                    ]
                }
            }
        });

    }
    function RenderDGGuage(consumption, id) {
        //var myConfig1 = {
        //    "type": "gauge",
        //    "series": [
        //      { "values": [consumption] }
        //    ]
        //};

        //zingchart.render({
        //    id: id,
        //    data: myConfig1,
        //    height: "100%",
        //    width: "100%"
        //});
        $("#FuelGuage").insertFusionCharts({
            type: "angulargauge",
            width: "100%",
            height: "100%",
            dataFormat: "json",
            dataSource: {
                "chart": {

                    "lowerlimit": "0",
                    "upperlimit": "100",
                    "showvalue": "10",
                    "numbersuffix": "%",
                    "theme": "ocean"
                },
                "colorrange": {
                    "color": [
                        {
                            "minvalue": "0",
                            "maxvalue": "100",
                            "code": "#e247c7"
                        }
                    ]
                },
                "dials": {
                    "dial": [
                        {
                            "value": consumption,
                            "tooltext": consumption
                        }
                    ]
                },
                "trendpoints": {
                    "point": [
                        {
                            //"startvalue": "80",
                            //"displayvalue": "Target",
                            //"thickness": "2",
                            //"color": "#E15A26",
                            //"usemarker": "1",
                            //"markerbordercolor": "#E15A26",
                            //"markertooltext": "80%"
                        }
                    ]
                }
            }
        });

    }
    function RenderFuelGuage(consumption, id) {
        //var myConfig1 = {
        //    "type": "gauge",
        //    "series": [
        //      { "values": [consumption] }
        //    ]
        //};

        //zingchart.render({
        //    id: id,
        //    data: myConfig1,
        //    height: "100%",
        //    width: "100%"
        //});
        $("#FuelGuage").insertFusionCharts({
            type: "angulargauge",
            width: "100%",
            height: "100%",
            dataFormat: "json",
            dataSource: {
                "chart": {

                    "lowerlimit": "0",
                    "upperlimit": "100",
                    "showvalue": "10",
                    "numbersuffix": "%",
                    "theme": "ocean"
                },
                "colorrange": {
                    "color": [
                        {
                            "minvalue": "0",
                            "maxvalue": "100",
                            "code": "#21c4e0"
                        }
                    ]
                },
                "dials": {
                    "dial": [
                        {
                            "value": consumption,
                            "tooltext": consumption
                        }
                    ]
                },
                "trendpoints": {
                    "point": [
                        {
                            //"startvalue": "80",
                            //"displayvalue": "Target",
                            //"thickness": "3",
                            //"color": "#E15A26",
                            //"usemarker": "1",
                            //"markerbordercolor": "#E15A26",
                            //"markertooltext": "80%"
                        }
                    ]
                }
            }
        });

    }
    function RenderGasGuage(consumption, id) {
        //var myConfig1 = {
        //    "type": "gauge",
        //    "series": [
        //        { "values": [consumption] }
        //    ]
        //};

        //zingchart.render({
        //    id: id,
        //    data: myConfig1,
        //    height: "100%",
        //    width: "100%"
        //});
        $("#GasGuage").insertFusionCharts({
            type: "angulargauge",
            width: "100%",
            height: "100%",
            dataFormat: "json",
            dataSource: {
                "chart": {

                    "lowerlimit": "0",
                    "upperlimit": "100",
                    "showvalue": "10",
                    "numbersuffix": "%",
                    "theme": "ocean"
                },
                "colorrange": {
                    "color": [
                        {
                            "minvalue": "0",
                            "maxvalue": "100",
                            "code": "#F2726F"
                        }
                    ]
                },
                "dials": {
                    "dial": [
                        {
                            "value": consumption,
                            "tooltext": consumption
                        }
                    ]
                },
                "trendpoints": {
                    "point": [
                        //{
                        //    "startvalue": "80",
                        //    "displayvalue": "80",
                        //    "thickness": "2",
                        //    "color": "#E15A26",
                        //    "usemarker": "1",
                        //    "markerbordercolor": "#E15A26",
                        //    "markertooltext": "80%"
                        //}
                    ]
                }
            }
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


                    str += '<tr><td>' + Temp[i].LocationName + '</td><td align="center"><img src="' + src + '" height="auto" width="25px" background="none"/></td><td align="center"><img src="' + src1 + '" height="auto" width="25px"/></td><td>' + Temp[i].Temp_Set_Reading + '</td><td>' + Temp[i].Temp_Ret_Reading + '</td><td>' + Temp[i].Temp_Sup_Reading + '</td></tr>';
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
                    <a class="navbar-brand" href="../DashBoard/LiveDashboard.aspx">
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
                        <a class="navbar-brand" href="../DashBoard/Fuel.aspx">
                            <img src="../Plugins/images/teams-Logo.png" width="200" height="auto" class="d-inline-block align-top pt-2" alt="" />
                        </a>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row pl-1 pb-0 pr-1 pt-1">
            <div class="col-md-3 pl-1 pb-0 pr-1 pt-1">
                <div class="bg-light card p-2 mb-2">
                    <div class="row">
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
                    </div>
                </div>
                <div class="bg-light card p-2 mb-1">
                    <div class="row">
                        <p class="col-md-4 small mb-1">No of PAK</p>
                        <p class="col-md-8 small mb-1">: 560</p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small mb-1">Area Soft</p>
                        <p class="col-md-8 small mb-1">: 345667</p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small mb-1">OPs Hours</p>
                        <p class="col-md-8 small mb-1">: 12 AM - 12 PM</p>
                    </div>
                </div>
                <div class="bg-light card p-2 mb-1">
                    <div class="row">
                        <p class="col-md-12 small mb-1"><strong>IN STORE QUALITY</strong></p>
                        <p class="col-md-3 small mb-1">Temp</p>
                        <p class="col-md-3 small mb-1">: 45C</p>
                        <p class="col-md-3 small mb-1 text-right">Oxygen</p>
                        <p class="col-md-3 small mb-1">: 80%</p>
                    </div>
                    <div class="row">
                        <p class="col-md-3 small mb-1">Lux</p>
                        <p class="col-md-2 small mb-1">: 25</p>
                        <p class="col-md-4 small mb-1 text-right">Humidity</p>
                        <p class="col-md-3 small mb-1">: 80%</p>
                        <p class="col-md-3 small mb-1">Co2</p>
                        <p class="col-md-3 small mb-1">: 18%</p>
                    </div>
                </div>
                <div class="bg-light card p-2 mb-1">
                    <div class="row">
                        <p class="col-md-12 small mb-1"><strong>KITCHEN AIR</strong></p>
                        <p class="col-md-3 small mb-1">Temp</p>
                        <p class="col-md-3 small mb-1">: 45C</p>
                        <p class="col-md-3 small mb-1 text-right">Oxygen</p>
                        <p class="col-md-3 small mb-1">: 80%</p>
                    </div>
                    <div class="row">
                        <p class="col-md-3 small mb-1">Co2</p>
                        <p class="col-md-3 small mb-1">: 18%</p>
                    </div>
                </div>
                <div class="bg-light card p-2 pb-4">
                    <div class="row">
                        <p class="col-md-12 small mb-1"><strong>Rest Room Air Quality</strong></p>
                        <p class="col-md-4 small mb-1">Ammonia</p>
                        <p class="col-md-8 small mb-1">: Sample Text Here</p>
                        <%--<p class="col-md-4 small mb-1">&nbsp;</p>--%>

                    </div>
                </div>
            </div>
            <div class="col-md-6 p-1">
                <div class="bg-light card p-2 mb-1">
                     <div class="row">
                        <div class="col-md-6" >

                            <div id='chart-container' style="height: 120px;"">
                            </div>
                             <p class="small text-center mb-0" id="lblElec"></p>
                             <p class="small text-center mb-0"><strong><a href="electricity.aspx" class="text-primary">Electricity</a></strong></p>
                        </div>
                        <div class="col-md-6">
                            <div id='WaterGuage' style="height: 120px;">
                            </div>
                              <p class="small text-center mb-0" id="lblWater"></p>
                            <p class="small text-center mb-0"><strong><a href="water.aspx" class="text-primary">Water</a></strong></p>
                        </div>
                         </div>
                     <div class="row">
                        <div class="col-md-6">
                            <div id='GasGuage' style="height: 120px;">
                            </div>
                              <p class="small text-center mb-0" id="lblDG"></p>
                            <p class="small text-center mb-0"><strong><a href="fuel.aspx" class="text-primary">DG</a></strong></p>
                        </div>
                        <div class="col-md-6">
                            <div id='FuelGuage' style="height: 120px;">
                            </div>
                              <p class="small text-center mb-0" id="lblFuel"></p>
                            <p class="small text-center mb-0"><strong><a href="fuel.aspx" class="text-primary">Fuel</a></strong></p>
                        </div>

                    </div>
                </div>
                <div class="row">
                   
                    <%--<div class="col-md-4 pr-0">
                        <div class="bg-light card p-2 mb-1">
                            <div class="row">
                                <p class="col-md-12 small mb-0"><strong>Request</strong></p>
                                <p class="col-md-5 small mb-0">Pending</p>
                                <p class="col-md-7 small mb-0">: 1234</p>
                                <p class="col-md-5 small mb-0">Done</p>
                                <p class="col-md-7 small mb-0">: 3435</p>
                            </div>
                        </div>
                        <div class="bg-light card p-2 mb-1">
                            <div class="row">
                                <p class="col-md-12 small mb-0"><strong>PPM</strong></p>
                                <p class="col-md-5 small mb-0">Pending</p>
                                <p class="col-md-7 small mb-0">: 1544</p>
                                <p class="col-md-5 small mb-0">Done</p>
                                <p class="col-md-7 small mb-0">: 56456</p>
                            </div>
                        </div>
                        <div class="bg-light card p-2 mb-1">
                            <div class="row">
                                <p class="col-md-12 small mb-0"><strong>HSQE</strong></p>
                                <p class="col-md-7 small mb-0">Incedent</p>
                                <p class="col-md-5 small mb-0">: 23</p>
                                <p class="col-md-7 small mb-0">Near Incident</p>
                                <p class="col-md-5 small mb-0">: 5</p>
                                <p class="col-md-7 small mb-0">Unsafe Act</p>
                                <p class="col-md-5 small mb-0">: 5</p>
                            </div>
                        </div>
                    </div>--%>
                    <div class="col-md-12 pl-2">
                        <div class="bg-light card p-2">
                            <p class="small text-left mb-0"><strong><a href="HVAC.aspx" class="text-primary">AC</a></strong></p>
                        
                            <%--<div id="SpendBarChartDiv"></div>--%>
                            <table class="table table-bordered table-sm" style="font-size: 10px !important">
                                <thead>
                                    <tr style="background: #e8e8e8 !important">
                                        <th>AC</th>
                                        <th>Unit Status</th>
                                        <th>Cooling Status</th>
                                        <th>Temp. Set.</th>
                                        <th>Temp. Ret</th>
                                        <th>Temp. Sup</th>
                                    </tr>
                                </thead>
                                <tbody id="tblHVAC" style="height:10px; overflow-y: scroll;"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 p-1">
                <div class="bg-light card p-2 mb-2">
                    <p class="small"><strong>Consumption Table</strong></p>
                    <table class="table table-bordered table-sm" style="font-size: 11px !important">
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
                </div>
                <div class="bg-light card p-2 mt-1">
                    <p class="small"><strong>Alerts</strong> <i class="fas fa-bell text-danger"></i></p>
                    <div class="row">
                        <p class="col-md-4 small">Electricity</p>
                        <p class="col-md-6 " style="background-color: #dbffd9"></p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small">DG</p>
                        <p class="col-md-6 "><i class="fas fa-bell text-danger"></i>&nbsp;<i class="fas fa-bell text-danger"></i></p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small">Gas</p>
                        <p class="col-md-6 " style="background-color: #dbffd9"></p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small">Fuel</p>
                        <p class="col-md-6 "><i class="fas fa-bell text-danger"></i>&nbsp;<i class="fas fa-bell text-danger"></i></p>
                    </div>
                    <div class="row">
                        <p class="col-md-4 small">Water</p>
                        <p class="col-md-6 " style="background-color: #dbffd9"></p>
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

