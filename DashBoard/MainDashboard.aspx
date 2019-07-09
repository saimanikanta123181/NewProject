<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainDashboard.aspx.cs" Inherits="CMS.DashBoard_MainDashboard" %>

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
        #electricityBarChart,#waterBarChart,#gasBarChart,#fuelLineChart,#fuelBarChart
        {
            height:202px !important;
             margin-top: -30px;
        }
        .p-2{
            padding: 0.1rem !important;
        }
    </style>
</head>
<script>
    var TimeId = 0; var TimeSet = "";
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

        getElectricityData(today);
        getWaterData(today);
        getGasData(today);
        getFuelLineData(today);
        getFuelData(today);
        getHVACData(today);
        GetConsumption(today);
        TimeSet = setInterval(function () {

            var today = moment().format('DD/MM/YYYY HH:mm ');

            getElectricityData(today);
            getWaterData(today);
            getGasData(today);
            getFuelLineData(today);
            getFuelData(today);
            getHVACData(today);
            GetConsumption(today);
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
            getElectricityData(Date);
            getWaterData(Date);
            getGasData(Date);
            getFuelLineData(Date);
            getFuelData(Date);
            getHVACData(Date);
            GetConsumption(Date);
            TimeSet = setInterval(function () {
                getElectricityData(Date);
                getWaterData(Date);
                getGasData(Date);
                getFuelLineData(Date);
                getFuelData(Date);
                getHVACData(Date);
                GetConsumption(today);
            }, 300000);
        }
        else if (TimeId == 2) {
            clearTimeout(TimeSet);
            getElectricityData(Date);
            getWaterData(Date);
            getGasData(Date);
            getFuelLineData(Date);
            getFuelData(Date);
            getHVACData(Date);
            GetConsumption(Date);
        }
    };
    function getElectricityData(today) {
        var Status = [];
        var CCount = [];
        var AvgReading = [];
        $.ajax({
            url: "LiveDashboard.aspx/GetElectricityData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                    AvgReading.push(Temp[i].AvgReading);
                }
                $("#ElectricityBarChartDiv").empty();
                var str = '<canvas id="electricityBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityBarChartDiv").append(str);
                genrateBarChart(Status, CCount, AvgReading, 'electricityBarChart', '#fc6c00', 'Units in KWH')
                lblupdTime.innerHTML = moment().format('h:mm:ss A')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getWaterData(today) {
        var Status = [];
        var CCount = [];
        var AvgReading = [];
        $.ajax({
            url: "LiveDashboard.aspx/GetWaterData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                    AvgReading.push(Temp[i].AvgReading);
                }
                $("#WaterBarChartDiv").empty();
                var str = '<canvas id="waterBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#WaterBarChartDiv").append(str);
                genrateBarChart(Status, CCount, AvgReading, 'waterBarChart', 'blue', 'Units in Liters')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getGasData(today) {
        var Status = [];
        var CCount = [];
        var AvgReading = [];
        $.ajax({
            url: "LiveDashboard.aspx/GetGasData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                    AvgReading.push(Temp[i].AvgReading);
                }
                $("#GasBarChartDiv").empty();
                var str = '<canvas id="gasBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#GasBarChartDiv").append(str);
                genrateBarChart(Status, CCount, AvgReading, 'gasBarChart', '#f96262', 'Units in Kgs')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getFuelLineData(today) {
        var Status = [];
        var MinReading = [];
        var MaxReading = [];
        var AvgReading = [];
        $.ajax({
            url: "LiveDashboard.aspx/GetFuelData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    MinReading.push(Temp[i].MinReading);
                    MaxReading.push(Temp[i].MaxReading);
                    AvgReading.push(Temp[i].AvgReading);
                }
                $("#FuelLineChartDiv").empty();
                var str = '<canvas id="fuelLineChart" height="220" width="400" style="color:black;"></canvas>';
                $("#FuelLineChartDiv").append(str);
                genrateFuelLineChart(Status, MinReading, MaxReading, AvgReading, 'fuelLineChart')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getFuelData(today) {
        var Status = [];
        var RunningHrs = [];

        $.ajax({
            url: "LiveDashboard.aspx/GetFuelBarData",
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
                $("#FuelBarChartDiv").empty();
                var str = '<canvas id="fuelBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#FuelBarChartDiv").append(str);
                genrateFuelBarChart(Status, RunningHrs, 'fuelBarChart')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function genrateBarChart(Status, CCount, AvgReading, id, barColor, ScaleLabel) {
        var barLabel = '';
        var LineLabel = '';
        if (id == 'electricityBarChart' || id == 'waterBarChart' || id == 'gasBarChart') {
            barLabel = 'Consumption';
            LineLabel = 'Average';
        } else {
            barLabel = 'Current Level';
            LineLabel = 'Average';
        }
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                datasets: [{
                    label: barLabel,
                    backgroundColor: barColor,
                    data: CCount,
                    lineTension: 0,
                }, {
                    label: LineLabel,
                    data: AvgReading,
                    lineTension: 0.2,
                    fill: false,
                    borderColor: '#ea2d2d',
                    borderWidth: 1,
                    backgroundColor: '#ea2d2d',
                    pointBorderColor: '#ea2d2d',
                    pointHoverBackgroundColor: '#ea2d2d',
                    pointHoverBorderColor: '#ea2d2d',
                    // Changes this dataset to become a line
                    type: 'line'
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
                            labelString: ScaleLabel
                        }
                    }]
                },
            },
        });
    }
    function getHVACData(today) {
        $.ajax({
            url: "LiveDashboard.aspx/GetHVACData",
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
    function genrateFuelLineChart(Status, MinReading, MaxReading, AvgReading, id) {

        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                datasets: [
                     {
                         label: 'Min',
                         data: MinReading,
                         fill: false,
                         borderColor: 'green',
                         borderWidth: 1,
                         backgroundColor: 'green',
                         pointBorderColor: 'green',
                         pointHoverBackgroundColor: 'green',
                         pointHoverBorderColor: 'green',
                         type: 'line'
                     },
                {
                    label: 'Max',
                    data: MaxReading,
                    fill: false,
                    borderColor: 'blue',
                    borderWidth: 1,
                    backgroundColor: 'blue',
                    pointBorderColor: 'blue',
                    pointHoverBackgroundColor: 'blue',
                    pointHoverBorderColor: 'blue',
                    type: 'line'
                },
                    {
                        label: 'Avg',
                        data: AvgReading,
                        fill: false,
                        borderColor: '#ea2d2d',
                        borderWidth: 1,
                        backgroundColor: '#ea2d2d',
                        pointBorderColor: '#ea2d2d',
                        pointHoverBackgroundColor: '#ea2d2d',
                        pointHoverBorderColor: '#ea2d2d',
                        type: 'line'
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
                            labelString: 'Units in Liters'
                        }
                    }]
                },
            },
        });
    }
    function genrateFuelBarChart(Status, RunningHrs, id) {
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                datasets: [{
                    label: 'DG Running Time',
                    backgroundColor: 'green',
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
                            labelString: 'Units in Min'
                        }
                    }]
                },
            },
        });
    }
    function GetConsumption(today) {


        $.ajax({
            url: "LiveDashboard.aspx/GetConsumption",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);

                lblElectricityMTD.innerHTML = Temp[0].MonthCons_Electrical;
                lblElectricityComsumption.innerHTML = Temp[0].MonthCons_Electrical;
                lblElectricityComsumption.innerHTML = Temp[0].DayCons_Electrical;
                lblWaterComsumption.innerHTML = Temp[0].DayCons_Water;
                lblWaterMTD.innerHTML = Temp[0].MonthCons_Water;
                lblGasComsumption.innerHTML = Temp[0].DayCons_Gas;
                lblGasMTD.innerHTML = Temp[0].MonthCons_Gas;
                lblFuelComsumption.innerHTML = Temp[0].DayCons_Fuel;
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
</script>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 p-0">
                <nav class="navbar navbar-light bg-light navbar-expand-lg p-1" style="background-color:white !important">
                    <a class="navbar-brand" href="../DashBoard/LiveDashboard.aspx">
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
                        <li class="m-3 text-right" style="width:200px; line-height:14px;"><span><label id="lblTime"></label></span><br /><small>Last Updated : <label id="lblupdTime"></label></small></li>
                        <a class="navbar-brand" href="../DashBoard/Fuel.aspx">
                            <img src="../Plugins/images/teams-Logo.png" width="200" height="auto" class="d-inline-block align-top pt-2" alt="" />
                        </a>
                    </ul>


                </nav>
            </div>
        </div>
    </div>



    <div class="container-fluid">
        <div class="row p-1">
            <div class="col-md-4 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Electricity</strong></br>
						<small>Comsumption : <strong><span id="ElectricityComsumption"><label id="lblElectricityComsumption"></label></span></strong> KWH<span style="float: right">MTD : <strong><span id="ElectricityMTD"><label id="lblElectricityMTD"></label></span></strong> KWH</span></small></h6>
                    <hr />
                    <div id="ElectricityBarChartDiv">
                    </div>
                </div>
            </div>
       </div>
    </div>
</body>
</html>
