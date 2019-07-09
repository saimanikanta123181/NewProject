<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Gas.aspx.cs" Inherits="CMS.DashBoard_Gas" %>

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
        #GasMonthlyBarChart, #GasDailyBarChart, #GasYearlyPieChart, #GasHourlyBarChart {
            height: 250px !important;
            margin-top: -30px;
        }

        #GasYearlyPieChart {
            width: 540px !important;
        }

        .p-2 {
            padding: 0.1rem !important;
        }
    </style>
</head>
<script>
    var ArrMonth = [];
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
        $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        setInterval(function () {
            $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        }, 1000);

        getGasMonthlyData(moment().year());
        getGasDailyData(moment().format('M'), moment().format('MMM'), moment().year());
        getGasHourlyData(moment(new Date()).format("DD/MM/YYYY"));

    });
    function click() {
        $("#btnToday").click(function (e) {
            $('#btnYesterday').removeClass('btn-primary').addClass('btn-outline-primary');
            $('#btnToday').removeClass('btn-outline-primary').addClass('btn-primary');
            TimeId = 1;
            $("#txtDate").val(moment().format('DD/MM/YYYY'));
            TimeOut(moment().format('DD/MM/YYYY HH:MM:SS'));
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
            getGasMonthlyData(moment(Date, "DD/MM/YYYY").year());
            getGasDailyData(moment(moment().format('M')).format('M'), moment(moment(Date, "DD/MM/YYYY")).format('MMM'), moment(Date, "DD/MM/YYYY").year());
            getGasHourlyData(moment(moment(Date, "DD/MM/YYYY")).format('DD/MM/YYYY'));
            TimeSet = setInterval(function () {
                getGasMonthlyData(moment(Date, "DD/MM/YYYY").year());
                getGasDailyData(moment(moment().format('M')).format('M'), moment(moment(Date, "DD/MM/YYYY")).format('MMM'), moment(Date, "DD/MM/YYYY").year());
                getGasHourlyData(moment(moment(Date, "DD/MM/YYYY")).format('DD/MM/YYYY'));
            }, 300000);
        }
        else if (TimeId == 2) {
            clearTimeout(TimeSet);
            getGasMonthlyData(moment(Date, "DD/MM/YYYY").year());
            getGasDailyData(moment(moment().format('M')).format('M'), moment(moment(Date, "DD/MM/YYYY")).format('MMM'), moment(Date, "DD/MM/YYYY").year());
            getGasHourlyData(moment(moment(Date, "DD/MM/YYYY")).format('DD/MM/YYYY'));
        }
    };
    function getGasMonthlyData(Year) {
        var Status = [];
        var CCount = [];
        $("#txtMonthlyYear").html(Year);
        $.ajax({
            url: "Gas.aspx/GetGasMonthlyData",
            type: "POST",
            dataType: "json",
            data: "{'Year':'" + Year + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].Month);
                    CCount.push(Temp[i].Consumption);
                    ArrMonth.push(Temp[i].MonthNo);
                }
                $("#GasMonthlyChartDiv").empty();
                var str = '<canvas id="GasMonthlyBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#GasMonthlyChartDiv").append(str);
                genrateBarChartForMonthly(Status, CCount, 'GasMonthlyBarChart', 'blue', 'Monthly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }

    function getGasDailyData(Month, MonthName, Year) {
        var Status = [];
        var CCount = [];
        $("#txtDailyYear").html(Year);
        $("#txtDailyMonth").html(MonthName);
        $("#txtDailyMonth").attr("monthId", Month);
        $.ajax({
            url: "Gas.aspx/GetGasDailyData",
            type: "POST",
            dataType: "json",
            data: "{'Year':'" + Year + "','Month':'" + Month + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].Days);
                    CCount.push(Temp[i].Consumption);
                }
                $("#GasDailyChartDiv").empty();
                var str = '<canvas id="GasDailyBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#GasDailyChartDiv").append(str);
                genrateBarChartForDaily(Status, CCount, 'GasDailyBarChart', '#40b37c', 'Daily')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getGasHourlyData(Date) {
        $("#txtHourlyDate").html(Date);
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Gas.aspx/getGasHourlyData",
            type: "POST",
            dataType: "json",
            data: "{'TodayDate':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                }
                $("#GasHourlyChartDiv").empty();
                var str = '<canvas id="GasHourlyBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#GasHourlyChartDiv").append(str);
                genrateBarChartForHourly(Status, CCount, 'GasHourlyBarChart', 'orange', 'Hourly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function genrateBarChartForMonthly(Status, CCount, id, barColor, labelString) {
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            maintainAspectRatio: false,
            data: {
                datasets: [{
                    label: 'Consumption',
                    backgroundColor: barColor,
                    data: CCount,
                    lineTension: 0,
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
                            labelString: labelString
                        }
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Units in Kg'
                        }
                    }]
                },
                responsive: true,

            },

        });
        $("#GasMonthlyBarChart").unbind().click(function (evt) {
            var monthId = '';
            var activePoints = myChart.getElementsAtEvent(evt);
            if (activePoints.length > 0) {
                var clickedElementindex = activePoints[0]["_index"];
                var label = myChart.data.labels[clickedElementindex];
                var value = myChart.data.datasets[0].data[clickedElementindex];
                $.each(ArrMonth, function (index, value) {

                    if (clickedElementindex == index) {
                        monthId = ArrMonth[index];
                        return false;
                    }
                });
                getGasDailyData(monthId, label, $("#txtMonthlyYear").html())
            }

        });

    }
    function genrateBarChartForDaily(Status, CCount, id, barColor, labelString) {
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            maintainAspectRatio: false,
            data: {
                datasets: [{
                    label: 'Consumption',
                    backgroundColor: barColor,
                    data: CCount,
                    lineTension: 0,
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
                            labelString: labelString
                        }
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Units in Kg'
                        }
                    }]
                },
                responsive: true,

            },

        });
        $("#GasDailyBarChart").unbind().click(function (evt) {
            var activePoints = myChart.getElementsAtEvent(evt);
            if (activePoints.length > 0) {
                var clickedElementindex = activePoints[0]["_index"];
                var label = myChart.data.labels[clickedElementindex];
                var value = myChart.data.datasets[0].data[clickedElementindex];

                var txtDate = label + '/' + $("#txtDailyMonth").attr('monthid') + '/' + $("#txtDailyYear").html()
                getGasHourlyData(txtDate);
            }

        });
    }
    function genrateBarChartForHourly(Status, CCount, id, barColor, labelString) {
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            maintainAspectRatio: false,
            data: {
                datasets: [{
                    label: 'Consumption',
                    backgroundColor: barColor,
                    data: CCount,
                    lineTension: 0,
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
                            labelString: labelString
                        }
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Units in Kg'
                        }
                    }]
                },
                responsive: true,

            },

        });
    }

    function getGasYearlyData() {
        var Status = [];
        var CCount = [];
        var AvgReading = [];
        $.ajax({
            url: "Gas.aspx/GetGasYearlyData",
            type: "POST",
            dataType: "json",
            data: "{'FromDate':'" + $("#fromDate").val() + "','ToDate':'" + $("#toDate").val() + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].Years);
                    CCount.push(Temp[i].Consumption);
                }
                $("#GasYearlyChartDiv").empty();
                var str = '<canvas id="GasYearlyPieChart" height="250" width="400" style="color:black;"></canvas>';
                $("#GasYearlyChartDiv").append(str);
                renderPieChart(Status, CCount, AvgReading)
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }

    function renderPieChart(Status, CCount) {
        var tooltipStatus = true;
        if (Status.length == 1 && CCount[0] == 0)
        {
            tooltipStatus = false;
        }
        Chart.pluginService.register({
            beforeRender: function (chart) {
                if (chart.config.options.showAllTooltips) {
                    // create an array of tooltips
                    // we can't use the chart tooltip because there is only one tooltip per chart
                    chart.pluginTooltips = [];
                    chart.config.data.datasets.forEach(function (dataset, i) {
                        chart.getDatasetMeta(i).data.forEach(function (sector, j) {
                            chart.pluginTooltips.push(new Chart.Tooltip({
                                _chart: chart.chart,
                                _chartInstance: chart,
                                _data: chart.data,
                                _options: chart.options.tooltips,
                                _active: [sector]
                            }, chart));
                        });
                    });

                    // turn off normal tooltips
                    chart.options.tooltips.enabled = false;
                }
            },
            afterDraw: function (chart, easing) {
                if (chart.config.options.showAllTooltips) {
                    // we don't want the permanent tooltips to animate, so don't do anything till the animation runs atleast once
                    if (!chart.allTooltipsOnce) {
                        if (easing !== 1)
                            return;
                        chart.allTooltipsOnce = true;
                    }

                    // turn on tooltips
                    chart.options.tooltips.enabled = true;
                    Chart.helpers.each(chart.pluginTooltips, function (tooltip) {
                        tooltip.initialize();
                        tooltip.update();
                        // we don't actually need this since we are not animating tooltips
                        tooltip.pivot();
                        tooltip.transition(easing).draw();
                    });
                    chart.options.tooltips.enabled = false;
                }
            }
        });

        var ctx = document.getElementById("GasYearlyPieChart").getContext("2d");
        var myChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: Status,
                datasets: [{
                    data: CCount,
                    backgroundColor: [
                      'blue',
                      'green',
                      'red'
                    ]
                }]
            },
            options: {
                responsive: true,
                showAllTooltips: tooltipStatus

            }
        });
        $("#GasYearlyPieChart").unbind().click(function (evt) {
            var activePoints = myChart.getElementsAtEvent(evt);
            if (activePoints.length > 0) {
                var clickedElementindex = activePoints[0]["_index"];
                var label = myChart.data.labels[clickedElementindex];
                var value = myChart.data.datasets[0].data[clickedElementindex];
                getGasMonthlyData(label);
            }

        });


    }
</script>
<body>
    <div class="container-fluid">
      <div class="row">
            <div class="col-md-12 p-0">
                <nav class="navbar navbar-light bg-light navbar-expand-lg p-1" style="background-color: white !important">
                    <a class="navbar-brand" href="SiteDashboard.aspx">
                        <img src="../Plugins/images/Flechazo-Logo.png" width="130" height="auto" class="d-inline-block align-top" alt="" />
                    </a>
                    <ul class="navbar-nav flex-row ml-md-auto d-none d-md-flex">
                        <li class="m-3 pt-2">
                            <h6><strong><span id="txtLocation"></span></strong></h6>
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
                        </li>
                        <a class="navbar-brand" href="SiteDashboard.aspx">
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
            <div class="col-md bg-light card-fuel mr-3">
                <a href="Fuel.aspx" title="Fuel">
                    <div class="media pt-1 pb-1">
                        <img src="../Plugins/images/Fuel.svg" width="45px" class="mr-3" alt="Fuel" />
                        <div class="media-body">
                            <h5 class="mt-2">Fuel</h5>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md bg-light card-gas-active mr-3">
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

        <div class="row p-1 row p-1 justify-content-center">
             <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Monthly Consumption In KG</strong><strong style="float: right"><span id="txtMonthlyYear">Comsumption</span></strong></h6>
                    <div id="GasMonthlyChartDiv">
                    </div>

                </div>
            </div>
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Daily Consumption In KG</strong><strong style="float: right"><span id="txtDailyMonth">Jan</span><span id="txtDailyYear" style="padding-left: 5px"></span></strong></h6>
                    <div id="GasDailyChartDiv">
                    </div>
                </div>
            </div>
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Hourly Consumption In KG</strong><strong style="float: right"><span id="txtHourlyDate"></span></strong></h6>
                    <div id="GasHourlyChartDiv">
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

