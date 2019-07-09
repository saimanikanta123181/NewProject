<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Electricity.aspx.cs" Inherits="CMS.DashBoard_Electricity" %>

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
        #electricityMonthlyBarChart, #electricityDailyBarChart, #electricityYearlyBarChart, #electricityHourlyBarChart,#electricityPFLineChart {
            height: 230px !important;
            margin-top: -30px;
        }

        #ElectricityPuneMainMeterChart, #ElectricityPuneMeterCategory, #ElectricityPuneHVACMeterChart, #ElectricityPuneExhaustMeterChart, #ElectricityPuneRawPowerMeterChart, #ElectricityPuneLightingMeterChart,#ElectricityWeekDayWiseChart {
            height: 240px !important;
            margin-top: -30px;
        }

        #electricityYearlyBarChart {
            width: 540px !important;
        }

        .p-2 {
            padding: 0.1rem !important;
        }

        #ElectricityHyderabadMeterCategory, #ElectricityHyderabadMainMeterChart, #ElectricityHyderabadHVACMeterChart, #ElectricityHyderabadKitchenMeterChart, #ElectricityHyderabadKitchenEquipMeterChart {
            height: 220px !important;
            margin-top: -30px;
        }

        #electricityHyderabadPieChart, #electricityPunePieChart {
            height: 240px !important;
            margin-top: -2px !important;
        }
        .slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
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
                TimeId;
                TimeOut($("#txtDate").val() + ' ' + '23:59 PM');
            }
        });
        $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        setInterval(function () {
            $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        }, 1000);

       // getElectricityMonthlyData(moment().year());
        getElectricityDailyData(moment().format('M'), moment().format('MMM'), moment().year());
       // getElectricityPFData(today);



        // getElectricityData(moment(new Date()).format("DD/MM/YYYY h:mm:ss"));
        //getSpendChartData(moment(new Date()).format("DD/MM/YYYY h:mm:ss"));
        //GetConsumptionTableData(moment(new Date()).format("DD/MM/YYYY h:mm:ss"))
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
            getElectricityMonthlyData(moment(Date, "DD/MM/YYYY").year());
            getElectricityDailyData(moment(moment().format('M')).format('M'), moment(moment(Date, "DD/MM/YYYY")).format('MMM'), moment(Date, "DD/MM/YYYY").year());
            getElectricityPFData(Date);
            //getElectricityData(Date);
           // getSpendChartData(Date);
           // GetConsumptionTableData(Date)
            TimeSet = setInterval(function () {
                getElectricityMonthlyData(moment(Date, "DD/MM/YYYY").year());
                getElectricityDailyData(moment(moment().format('M')).format('M'), moment(moment(Date, "DD/MM/YYYY")).format('MMM'), moment(Date, "DD/MM/YYYY").year());
                getElectricityPFData(Date);
               // getElectricityData(Date);
                //getSpendChartData(Date);
                //GetConsumptionTableData(Date);
            }, 300000);
        }
        else if (TimeId == 2) {
            clearTimeout(TimeSet);
            getElectricityMonthlyData(moment(Date, "DD/MM/YYYY").year());
            getElectricityDailyData(moment(moment().format('M')).format('M'), moment(moment(Date, "DD/MM/YYYY")).format('MMM'), moment(Date, "DD/MM/YYYY").year());
            getElectricityPFData(Date);
          //  getElectricityData(Date);
          //  getSpendChartData(Date);
            //GetConsumptionTableData(Date)
        }
    };
    /*
    function getElectricityMonthlyData(Year) {
        var Status = [];
        var CCount = [];
        $("#txtMonthlyYear").html(Year);
        $.ajax({
            url: "Electricity.aspx/GetElectricityMonthlyData",
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
                $("#ElectricityMonthlyChartDiv").empty();
                var str = '<canvas id="electricityMonthlyBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityMonthlyChartDiv").append(str);
                genrateBarChartForMonthly(Status, CCount, 'electricityMonthlyBarChart', 'blue', 'Monthly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    */
    function getElectricityDailyData(Month, MonthName, Year) {
        var Status = [];
        var CCount = [];
        var bgColrs = [];
        $("#txtDailyYear").html(Year);
        $("#txtDailyMonth").html(MonthName);
        $("#txtDailyMonth").attr("monthId", Month);
        $.ajax({
            url: "Electricity.aspx/GetElectricityDailyData",
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
                $("#ElectricityDailyChartDiv").empty();
                var str = '<canvas id="electricityDailyBarChart" height="196 !important;" width="400" style="color:black;"></canvas>';
                $("#ElectricityDailyChartDiv").append(str);
                genrateBarChartForDaily(Status, CCount, 'electricityDailyBarChart', bgColrs, 'Daily')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    } 
    /*
    function getElectricityPFData(Date) {
        $("#txtPFDate").html(Date.split(" ")[0]);
        var Status = [];
        var MinReading = [];
        var MaxReading = [];
        var AvgReading = [];
        $.ajax({
            url: "Electricity.aspx/GetElectricityPFData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    MinReading.push(Temp[i].MinReading);
                    MaxReading.push(Temp[i].MaxReading);
                    AvgReading.push(Temp[i].AvgReading);
                }
                $("#ElectricityPFChartDiv").empty();
                var str = '<canvas id="electricityPFLineChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityPFChartDiv").append(str);
                genratePFLineChart(Status, MinReading, MaxReading, AvgReading, 'electricityPFLineChart')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    */
    function genratePFLineChart(Status, MinReading, MaxReading, AvgReading, id) {
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
                            labelString: 'Units in PF'
                        }
                    }]
                },
            },
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
                            labelString: 'Units in KWH'
                        }
                    }]
                },
                responsive: true,

            },

        });
        $("#electricityMonthlyBarChart").unbind().click(function (evt) {
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
                getElectricityDailyData(monthId, label, $("#txtMonthlyYear").html())
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
                    backgroundColor: ['#803300', '#867e79', '#ff751a', '#99ffe6', '#a65959', '#40ff00', '#ff4000', '#00ffff','#0080ff'],
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
                            labelString: 'Units in KWH'
                        }
                    }]
                },
                responsive: true,

            },

        });

      
        $("#electricityDailyBarChart").unbind().click(function (evt) {
            var activePoints = myChart.getElementsAtEvent(evt);
            if (activePoints.length > 0) {
                var clickedElementindex = activePoints[0]["_index"];
                var label = myChart.data.labels[clickedElementindex];
                var value = myChart.data.datasets[0].data[clickedElementindex];

                var txtDate = label + '/' + $("#txtDailyMonth").attr('monthid') + '/' + $("#txtDailyYear").html();

                if (TypeId == 1) {
                    if ($("#chk_consumption").is(':checked')) {
                       // getElectricityData(txtDate+" 00:00:00");
                       // getSpendChartData(txtDate + " 00:00:00");
                       // GetConsumptionTableData(txtDate + " 00:00:00");
                    }
                    else {
                        $("#ElectricityModalForPune").modal('show');
                        getElectricityMeterConData(txtDate);
                        getElectricityWeekDayData(txtDate);
                        getElectricityPuneMainMeterData(txtDate);
                        getElectricityPuneHVACMeterData(txtDate);
                        getElectricityPuneFANExhaustMeterData(txtDate);
                        getElectricityPuneRawPowerMeterData(txtDate);
                        getElectricityPuneLightingMeterData(txtDate);
                    }

                }
                if (TypeId == 2) {
                    if ($("#chk_consumption").is(':checked')) {
                        //getElectricityData(txtDate + " 00:00:00");
                       // getSpendChartData(txtDate + " 00:00:00");
                       // GetConsumptionTableData(txtDate + " 00:00:00");
                    }
                    else {
                        $("#ElectricityModalForHyderabad").modal('show');
                        getElectricityMeterConData(txtDate);
                        getElectricityWeekDayData(txtDate);
                        getElectricityHyderabadMainMeterData(txtDate);
                        getElectricityHyderabadHVACMeterData(txtDate);
                        getElectricityHyderabadKitchenMeterData(txtDate);
                        getElectricityHyderabadKitchenEquipMeterData(txtDate);
                       // getElectricityData(txtDate);
                       // getSpendChartData(txtDate);
                    }
                }
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
                            labelString: 'Units in KWH'
                        }
                    }]
                },
                responsive: true,

            },

        });
    }

    function getElectricityYearlyData() {
        var Status = [];
        var CCount = [];
        var AvgReading = [];
        $.ajax({
            url: "Electricity.aspx/GetElectricityYearlyData",
            type: "POST",
            dataType: "json",
            data: "{'FromDate':'" + $("#fromDate").val() + "','ToDate':'" + $("#toDate").val() + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].Year);
                    CCount.push(Temp[i].Consumption);
                }
                $("#ElectricityYearlyChartDiv").empty();
                var str = '<canvas id="electricityYearlyBarChart" height="250" width="400" style="color:black;"></canvas>';
                $("#ElectricityYearlyChartDiv").append(str);
                //renderPieChart(Status, CCount, AvgReading)
                renderElectricityYearlyData(Status, CCount, 'electricityYearlyBarChart');
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function renderElectricityYearlyData(Status, CCount, id) {
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            maintainAspectRatio: false,
            data: {
                datasets: [{
                    label: 'Consumption',
                    backgroundColor: ['#fc6c00', '#ea2d2d'],
                    data: CCount,
                    lineTension: 0,
                }],
                labels: Status
            },
            options: {
                legend: {
                    display: false,
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
                            labelString: 'Consumption',
                            barThickness: 0.1
                            // barPercentage:0.2
                            // maxBarThickness:100

                        }
                    }],
                    yAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'Units in KWH'
                        }
                    }]
                },
                responsive: true,

            },

        });
        $("#electricityYearlyBarChart").unbind().click(function (evt) {
            var activePoints = myChart.getElementsAtEvent(evt);
            if (activePoints.length > 0) {
                var clickedElementindex = activePoints[0]["_index"];
                var label = myChart.data.labels[clickedElementindex];
                var value = myChart.data.datasets[0].data[clickedElementindex];
                getElectricityMonthlyData(label);
            }

        });


    }
    function renderPieChart(Status, CCount) {
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

        var ctx = document.getElementById("electricityYearlyPieChart").getContext("2d");
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
                showAllTooltips: true

            }
        });
        $("#electricityYearlyPieChart").unbind().click(function (evt) {
            var activePoints = myChart.getElementsAtEvent(evt);
            if (activePoints.length > 0) {
                var clickedElementindex = activePoints[0]["_index"];
                var label = myChart.data.labels[clickedElementindex];
                var value = myChart.data.datasets[0].data[clickedElementindex];
                getElectricityMonthlyData(label);
            }

        });


    }

    //for modal content fro pune
    function getElectricityMeterConData(Date) {
        var Status = [];
        var CCount = [];
        var AvgReading = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityMeterConData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                var str = '';
                var Total = 0;
                if (TypeId == 1)
                {
                    $("#txtElectricityPuneMain").html(Temp[0]['Main']);
                    $("#txtElectricityPuneHVAC").html(Temp[0][ 'HVAC' ]);
                    $("#txtElectricityPuneFAAndExhaust").html(Temp[0][ 'FA & Exhaust' ]);
                    $("#txtElectricityPuneRawPower").html(Temp[0][ 'Raw Power' ]);
                    $("#txtElectricityPuneROLighting").html(Temp[0][ 'RO and Lighting' ]);
                 }
                else if(TypeId == 2)
                {
                    $("#txtElectricityHyderabadMain").html(Temp[0]['Main']);
                    $("#txtElectricityHyderabadHVAC").html(Temp[0][ 'HVAC' ]);
                    $("#txtElectricityHyderabadKitchen").html( Temp[0][ 'Kitchen' ]);
                    $("#txtElectricityHyderabadKitchenExhaust").html(Temp[0][ 'Kitchen Equip' ]);
                 }
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function renderPieChartForMeter(Status, CCount, id) {
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

        var ctx = document.getElementById(id).getContext("2d");
        var myChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: Status,
                datasets: [{
                    data: CCount,
                    backgroundColor: [
                        'blue',
                        'green',
                        'red',

                        'orange',
                        'black'
                    ]
                }]
            },
            options: {
                responsive: true,
                showAllTooltips: true

            }
        });
    }
    
    function getElectricityWeekDayData(Date) {

        var Status = [];
        var CCount = [];
        var id = '';
        if (TypeId == 1)
        {
            id = 'ElectricityPuneMeter';
        } else if (TypeId == 2)
        {
            id = 'ElectricityHyderabadMeter';
        }
        $.ajax({
            url: "Electricity.aspx/getElectricityWeekDayData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].WeekDate);
                    CCount.push(Temp[i].Consumption);
                }
                $("#"+id).empty();
                var str = '<canvas id="ElectricityWeekDayWiseChart" height="220" width="400" style="color:black;"></canvas>';
                $("#"+id).append(str);
                //genrateBarChartForElectricityMeter(Status, CCount, 'ElectricityWeekDayWiseChart', 'blue', 'Week Date');
                genrateBarChartForDayOfTheWeek(Status, CCount, 'ElectricityWeekDayWiseChart', 'blue', 'Week Date')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getElectricityPuneMainMeterData(Date) {
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityPuneMainMeterData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                }
                $("#ElectricityPuneMain").empty();
                var str = '<canvas id="ElectricityPuneMainMeterChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityPuneMain").append(str);
                genrateBarChartForElectricityMeter(Status, CCount, 'ElectricityPuneMainMeterChart', 'orange', 'Hourly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getElectricityPuneHVACMeterData(Date) {
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityPuneHVACMeterData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                }
                $("#ElectricityPuneHVAC").empty();
                var str = '<canvas id="ElectricityPuneHVACMeterChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityPuneHVAC").append(str);
                genrateBarChartForElectricityMeter(Status, CCount, 'ElectricityPuneHVACMeterChart', 'blue', 'Hourly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getElectricityPuneFANExhaustMeterData(Date) {
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityPuneFANExhaustMeterData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                }
                $("#ElectricityPuneFAAndExhaust").empty();
                var str = '<canvas id="ElectricityPuneExhaustMeterChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityPuneFAAndExhaust").append(str);
                genrateBarChartForElectricityMeter(Status, CCount, 'ElectricityPuneExhaustMeterChart', 'red', 'Hourly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getElectricityPuneRawPowerMeterData(Date) {
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityPuneRawPowerMeterData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                }
                $("#ElectricityPuneRawPower").empty();
                var str = '<canvas id="ElectricityPuneRawPowerMeterChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityPuneRawPower").append(str);
                genrateBarChartForElectricityMeter(Status, CCount, 'ElectricityPuneRawPowerMeterChart', '#00ff89fa', 'Hourly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getElectricityPuneLightingMeterData(Date) {
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityPuneLightingMeterData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                }
                $("#ElectricityPuneROLighting").empty();
                var str = '<canvas id="ElectricityPuneLightingMeterChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityPuneROLighting").append(str);
                genrateBarChartForElectricityMeter(Status, CCount, 'ElectricityPuneLightingMeterChart', '#dc3545', 'Hourly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    } 
    function genrateBarChartForElectricityMeter(Status, CCount, id, barColor, labelString) {
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
                            labelString: 'Units in KWH'
                        }
                    }]
                },
                responsive: true,

            },

        });
    }
    function genrateBarChartForDayOfTheWeek(Status, CCount, id, barColor, labelString) {
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            maintainAspectRatio: false,
            data: {
                datasets: [{
                    label: 'Consumption',
                    backgroundColor: barColor,
                    data: CCount,
                    //lineTension: 0,
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
                        barPercentage: 0.3,
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
                            labelString: 'Units in KWH'
                        }
                    }]
                },
                responsive: true,

            },

        });
    }

    //for Hyderabad
    function getElectricityHyderabadPieChartData(Date) {
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityHyderabadPieChartData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':2}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                var str = '';
                var Total = 0;
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].MeterName);
                    CCount.push(Temp[i].Consumption);
                    str += '<tr><td>' + Temp[i].MeterName + '</td><td>' + Temp[i].Consumption + '</td></tr>';
                    Total += Temp[i].Consumption
                }
                str += '<tr><td style="font-size: larger;font-weight: 900;">Total</td><td>' + Math.round(Total) + '</td></tr>';
                $("#ElectricityHyderabadMeter").empty();
                $("#tblMeter1").empty();
                $("#tblMeter1").append(str);
                var str = '<canvas id="electricityHyderabadPieChart" height="250" width="400" style="color:black;"></canvas>';
                $("#ElectricityHyderabadMeter").append(str);
                renderPieChartForMeter(Status, CCount, 'electricityHyderabadPieChart')

            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
  
    function getElectricityHyderabadMainMeterData(Date) {
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityHyderabadMainMeterData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                }
                $("#ElectricityHyderabadMain").empty();
                var str = '<canvas id="ElectricityHyderabadMainMeterChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityHyderabadMain").append(str);
                genrateBarChartForElectricityMeter(Status, CCount, 'ElectricityHyderabadMainMeterChart', 'orange', 'Hourly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getElectricityHyderabadHVACMeterData(Date) {
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityHyderabadHVACMeterData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                }
                $("#ElectricityHyderabadHVAC").empty();
                var str = '<canvas id="ElectricityHyderabadHVACMeterChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityHyderabadHVAC").append(str);
                genrateBarChartForElectricityMeter(Status, CCount, 'ElectricityHyderabadHVACMeterChart', 'blue', 'Hourly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getElectricityHyderabadKitchenMeterData(Date) {
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityHyderabadKitchenMeterData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                }
                $("#ElectricityHyderabadKitchen").empty();
                var str = '<canvas id="ElectricityHyderabadKitchenMeterChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityHyderabadKitchen").append(str);
                genrateBarChartForElectricityMeter(Status, CCount, 'ElectricityHyderabadKitchenMeterChart', '#dc3545', 'Hourly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getElectricityHyderabadKitchenEquipMeterData(Date) {
        var Status = [];
        var CCount = [];
        $.ajax({
            url: "Electricity.aspx/getElectricityHyderabadKitchenEquipMeterData",
            type: "POST",
            dataType: "json",
            data: "{'Date':'" + Date + "','TypeId':" + TypeId + "}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    CCount.push(Temp[i].Consumption);
                }
                $("#ElectricityHyderabadKitchenExhaust").empty();
                var str = '<canvas id="ElectricityHyderabadKitchenEquipMeterChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityHyderabadKitchenExhaust").append(str);
                genrateBarChartForElectricityMeter(Status, CCount, 'ElectricityHyderabadKitchenEquipMeterChart', '#11e034', 'Hourly')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getElectricityData(today) {
        var Status = [];
        var CCount = [];
        var AvgReading = [];
        $.ajax({
            url: "Electricity.aspx/GetElectricityData",
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
                var str = '<canvas id="consumptionBarChart" height="180" width="400" style="color:black;"></canvas>';
                $("#ConsumptionBarChartDiv").append(str);
                //genrateBarChart(Status, CCount, 'consumptionBarChart');
                genrateBarChartForConsumption(Status, CCount, 'consumptionBarChart');
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getSpendChartData(today) {
        var Status = [];
        var CCount = [];
        var AvgReading = [];
        $.ajax({
            url: "Electricity.aspx/GetSpendChartData",
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
                var str = '<canvas id="spendBarChart" height="180" width="400" style="color:black;"></canvas>';
                $("#SpendBarChartDiv").append(str);
                genrateBarChartForConsumption(Status, CCount, 'spendBarChart');
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
    function genrateBarChartForConsumption(Status, CCount, id) {
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
                        barPercentage: 0.4,
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
            url: "Electricity.aspx/GetConsumptionData",
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
                    str += '<tr><td>' + Temp[i].Types + '</td><td>' + Temp[i].Values + ' KWH</td></tr>';
                }
                $("#tblConsumption").append(str);
             //   lblupdTime.innerHTML = moment().format('h:mm:ss A'); need to ask to sagar
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
            <div class="col-md bg-light card-electricity-active mr-3">
                <a href="Electricity.aspx" title="Electricity">
                    <div class="media pt-1 pb-1">
                        &nbsp;<div class="media-body">
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
            <%-- <div class="col-md-5 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong style="float: right">Yearly</strong></br></h6>
                    <div id="ElectricityYearlyChartDiv">
                    </div>
                </div>
            </div>--%>
           <!-- <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Monthly Comsumption In KWH</strong><strong style="float: right"><span id="txtMonthlyYear"></span></strong></h6>
                    <div id="ElectricityMonthlyChartDiv" style="height: 216px;">
                    </div>

                </div>
            </div>-->
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Daily Comsumption In KWH</strong>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input style="margin-bottom:20px;" id="chk_consumption" type="checkbox"/><label>Compare & spending </label><strong style="float: right"><span id="txtDailyMonth">Jan</span><span id="txtDailyYear" style="padding-left: 5px"></span></strong>
</h6>
                    <div id="ElectricityDailyChartDiv">
                    </div>
                </div>
            </div>
        </div>
        <div class="row p-1 justify-content-center">
            <%--      <div class="col-md-8 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Daily</strong><strong style="float: right"><span id="txtDailyMonth">Jan</span><span id="txtDailyYear" style="padding-left: 5px"></span></strong></h6>
                    <div id="ElectricityDailyChartDiv">
                    </div>
                </div>
            </div>--%>
             <!-- <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>PF</strong><strong style="float: right"><span id="txtPFDate"></span></strong></h6>
                    <div id="ElectricityPFChartDiv">
                    </div>
                 </div>
            -->
             </div>

           <%-- <div class="col-md-4" style="background-color:white;">
                <p class="small text-center"><strong>Consumption In KWH</strong></></p>
                <div id="ConsumptionBarChartDiv">
                </div>
            </div>
            <div class="col-md-4" style="background-color:white;">
                <p class="small text-center"><strong>Spend In KWH</strong></></p>
                <div id="SpendBarChartDiv">
                </div>
            </div>
              <div class="col-md-4" style="background-color:white;">
                <p class="small text-center"><strong>Energy Monitor</strong></></p>
                   <table class="table table-bordered table-sm" style="font-size: 10px !important;font-weight:bold">
                        <thead>
                            <tr style="background: #e8e8e8 !important">
                                <th style="text-align: center;">Type</th>
                                <th style="text-align: center;">Value</th>
                            </tr>
                        </thead>
                        <tbody id="tblConsumption"></tbody>
                    </table>
                
            </div>--%>
        </div>
    </div>

    <div id="ElectricityModalForPune" class="modal fade" style="padding-left: 17px;" aria-hidden="true" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modal-lg" style="max-width: -webkit-fill-available; height: 95% !important;">
            <div class="modal-content">
                <div class="modal-header" style="padding: 0px 12px 0px 17px;">
                    <h5 class="modal-title" style="display: inline-block;">Electricity</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body" style="overflow-y: scroll; height: 550px; padding-left: 26px; padding-right: 26px">
                    <div class="row p-1">
                        <div class="col-md-4 p-2">
                            <div class="bg-light card box-layout">
                                 <h6><strong>Day Of The Week Consumption</strong></h6>
                                <div id="ElectricityPuneMeter">
                                </div>
                            </div>
                        </div>
                       <%-- <div class="col-md-4 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>Meter Category</strong></h6>
                                <div id="ElectricityPuneMeterCategory">
                                    <table class="table table-bordered" style="font-size: 10px !important">
                                        <thead>
                                            <tr style="background: #e8e8e8 !important">
                                                <th>Category</th>
                                                <th>Consumption</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblMeter" style="font-weight: bold;"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>--%>
                        <div class="col-md-8 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>Main</strong><strong style="float: right">Comsumption : <span id="txtElectricityPuneMain"></span> KWH</strong></h6>
                                <div id="ElectricityPuneMain">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>HVAC</strong><strong style="float: right">Comsumption : <span id="txtElectricityPuneHVAC"></span> KWH</strong></h6>
                                <div id="ElectricityPuneHVAC">
                                </div>

                            </div>
                        </div>
                        <div class="col-md-6 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>FA & Exhaust</strong><strong style="float: right">Comsumption : <span id="txtElectricityPuneFAAndExhaust"></span> KWH</strong></h6>
                                <div id="ElectricityPuneFAAndExhaust">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>Raw Power</strong><strong style="float: right">Comsumption : <span id="txtElectricityPuneRawPower"></span> KWH</strong></h6>
                                <div id="ElectricityPuneRawPower">
                                </div>

                            </div>
                        </div>
                        <div class="col-md-6 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>RO & Lighting</strong><strong style="float: right">Comsumption : <span id="txtElectricityPuneROLighting"></span> KWH</strong></h6>
                                <div id="ElectricityPuneROLighting">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="padding: 5px 10px 5px 0px;">
                    <input type="button" class="btn btn-danger btn-sm" data-dismiss="modal" value="Cancel" />
                </div>
            </div>
        </div>
    </div>

    <div id="ElectricityModalForHyderabad" class="modal fade" style="padding-left: 17px;" aria-hidden="true" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modal-lg" style="max-width: -webkit-fill-available; height: 95% !important;">
            <div class="modal-content">
                <div class="modal-header" style="padding: 0px 12px 0px 17px;">
                    <h5 class="modal-title" style="display: inline-block;">Electricity</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body" style="overflow-y: scroll; height: 550px; padding-left: 26px; padding-right: 26px">
                    <div class="row p-1">
                        <div class="col-md-4 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>Day Of The Week Consumption</strong></h6>
                                <div id="ElectricityHyderabadMeter">
                                </div>
                            </div>
                        </div>
                        <%--<div class="col-md-4 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>Meter Category</strong></h6>
                                <div id="ElectricityHyderabadMeterCategory">
                                    <table class="table table-bordered" style="font-size: 10px !important">
                                        <thead>
                                            <tr style="background: #e8e8e8 !important">
                                                <th>Category</th>
                                                <th>Consumption</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblMeter1" style="font-weight: bold;"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>--%>
                        <div class="col-md-8 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>Main</strong><strong style="float: right">Comsumption : <span id="txtElectricityHyderabadMain"></span> KWH</strong></h6>
                                <div id="ElectricityHyderabadMain">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>HVAC</strong><strong style="float: right">Comsumption : <span id="txtElectricityHyderabadHVAC"></span> KWH</strong></h6>
                                <div id="ElectricityHyderabadHVAC">
                                </div>

                            </div>
                        </div>
                        <div class="col-md-4 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>Kitchen</strong><strong style="float: right">Comsumption : <span id="txtElectricityHyderabadKitchen"></span> KWH</strong></h6>
                                <div id="ElectricityHyderabadKitchen">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 p-2">
                            <div class="bg-light card box-layout">
                                <h6><strong>Kitchen Equip</strong><strong style="float: right">Comsumption : <span id="txtElectricityHyderabadKitchenExhaust"></span> KWH</strong></h6>
                                <div id="ElectricityHyderabadKitchenExhaust">
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="padding: 5px 10px 5px 0px;">
                    <input type="button" class="btn btn-danger btn-sm" data-dismiss="modal" value="Cancel" />
                </div>
            </div>
        </div>
    </div>
</body>
</html>

