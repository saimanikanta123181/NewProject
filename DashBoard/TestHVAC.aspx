<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestHVAC.aspx.cs" Inherits="CMS.DashBoard_HVAC" %>

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
           #electricityMonthlyBarChart, #electricityDailyBarChart,#electricityPFLineChart {
            height: 230px !important;
            margin-top: -30px;
        }
         #HVACAirtTempLineChart{
                height: 210px !important;
            margin-top: -30px;
           }
        .btn.disabled, .btn:disabled {
            opacity: 0.3 !important;
        }
    </style>
</head>
<script>
    var ArrMonth = [];
    var TimeId = 0; var TimeSet = "";
    var today = moment().format('DD/MM/YYYY HH:mm ');
    var TypeId = localStorage.getItem('TypeId');
    var FirstMeterId = ''; var FirstMeterName = '';
    $(document).ready(function () {
        $("#btnSwitchCategory").click(function () {
            window.location.href = "CategorySelection.aspx";
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
        $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        setInterval(function () {
            $("#lblTime").text(moment().format('h:mm:ss A DD MMM YYYY'));
        }, 1000);

        getHVACData($("#txtDate").val() + ' 23:59:00');


    });
    $(document).on('click', '.HVAC', function () {

        var MeterId = $(this).attr('id');
        var MeterName = $(this).html();
        getHVACSupplyTempData($("#txtDate").val() + ' ' + '23:59 PM', MeterId, MeterName);
        // getHVACCompRunTimeData($("#txtDate").val() + ' ' + '23:59 PM', MeterId, MeterName);
        getHVACAnalysisTblData($("#txtDate").val() + ' ' + '23:59 PM', MeterId, MeterName);

    })
    function click() {

        $("#btnToday").click(function (e) {
            $('#btnYesterday').removeClass('btn-primary').addClass('btn-outline-primary');
            $('#btnToday').removeClass('btn-outline-primary').addClass('btn-primary');
            TimeId = 1;
            $("#txtDate").val(moment().format('DD/MM/YYYY'));
            TimeOut(moment().format('DD/MM/YYYY HH:MM:SS'));
            $("#DivElectricity").show();
            $("#DivHVAC").hide();
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
            $("#DivElectricity").show();
            $("#DivHVAC").hide();
        });
    }
    function TimeOut(Date) {
        if (TimeId == 1) {
            getConsmptionData(Date);
            getElectricityMonthlyData(moment(Date, "DD/MM/YYYY").year());
            getElectricityDailyData(moment(moment().format('M')).format('M'), moment(moment(Date, "DD/MM/YYYY")).format('MMM'), moment(Date, "DD/MM/YYYY").year());
            getElectricityPFData(Date);
        }
        else if (TimeId == 2) {
            clearTimeout(TimeSet);
            getConsmptionData(Date);
            getElectricityMonthlyData(moment(Date, "DD/MM/YYYY").year());
            getElectricityDailyData(moment(moment().format('M')).format('M'), moment(moment(Date, "DD/MM/YYYY")).format('MMM'), moment(Date, "DD/MM/YYYY").year());
            getElectricityPFData(Date);
        }
    };
    function getElectricityMonthlyData(Year) {
        var Status = [];
        var CCount = [];
        $("#txtMonthlyYear").html(Year);
        $.ajax({
            url: "TestHVAC.aspx/GetElectricityMonthlyData",
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

    function getElectricityDailyData(Month, MonthName, Year) {
        var Status = [];
        var CCount = [];
        $("#txtDailyYear").html(Year);
        $("#txtDailyMonth").html(MonthName);
        $("#txtDailyMonth").attr("monthId", Month);
        $.ajax({
            url: "TestHVAC.aspx/GetElectricityDailyData",
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
                var str = '<canvas id="electricityDailyBarChart" height="220" width="400" style="color:black;"></canvas>';
                $("#ElectricityDailyChartDiv").append(str);
                genrateBarChartForDaily(Status, CCount, 'electricityDailyBarChart', '#40b37c', 'Daily')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getElectricityPFData(Date) {
        $("#txtPFDate").html(Date.split(" ")[0]);
        var Status = [];
        var MinReading = [];
        var MaxReading = [];
        var AvgReading = [];
        $.ajax({
            url: "TestHVAC.aspx/GetElectricityPFData",
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


        $("#electricityDailyBarChart").unbind().click(function (evt) {
            var activePoints = myChart.getElementsAtEvent(evt);
            if (activePoints.length > 0) {
                var clickedElementindex = activePoints[0]["_index"];
                var label = myChart.data.labels[clickedElementindex];
                var value = myChart.data.datasets[0].data[clickedElementindex];

                var txtDate = label + '/' + $("#txtDailyMonth").attr('monthid') + '/' + $("#txtDailyYear").html();

                $("#ElectricityModalForMeters").modal('show');
                getElectricityMeter1(txtDate);
                getElectricityMeter2(txtDate);
                getElectricityMeterConData(txtDate);
            }

        });
    }

    function getConsmptionData(today) {
        $.ajax({
            url: "TestHVAC.aspx/GetConsmptionData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':'" + TypeId + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                var str = '';
                $("#txtElectricity").empty();
                $("#txtElectricity").html(Temp[0].Consumption);
                //    lblupdTime.innerHTML = moment().format('h:mm:ss A');
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getHVACData(today) {
        $.ajax({
            url: "TestHVAC.aspx/GetHVACData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "'}",
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


                    str += '<tr><td align="center"><a style="cursor:pointer" class="text-primary HVAC" id="' + Temp[i].MeterSerial + '">' + Temp[i].LocationName + '</a></td><td align="center"><img src="' + src + '" height="auto" width="20px" background="none"/></td><td align="center"><img src="' + src1 + '" height="auto" width="20px"/></td><td align="center">' + Temp[i].Temp_Set_Reading + '</td><td align="center">' + Temp[i].Temp_Ret_Reading + '</td><td align="center">' + Temp[i].Temp_Sup_Reading + '</td><td align="center">' + (Temp[i].Delta_T_Reading == null ? '' : Temp[i].Delta_T_Reading) + '</td></tr>';
                }
                $("#tblHVAC").append(str);
                FirstMeterId = Temp[0].MeterSerial;
                //FirstMeterName = Temp[0].Name;
                $("#" + FirstMeterId).trigger("click");
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getHVACAnalysisTblData(today, MeterId, MeterName) {
        $.ajax({
            url: "TestHVAC.aspx/GetHVACAnalysisData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':'" + TypeId + "','MeterId':'" + MeterId + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var str = '';
                var Temp = JSON.parse(data.d);
                $("#AnalysisTbl").empty();
                for (var i = 0; i < Temp.length; i++) {
                    str += '<tr><td>' + Temp[i].UtilityName + '</td><td style="text-align: center;">' + Temp[i].LocationName + '</td><td style="text-align: center;">' + Temp[i].RunningTime + ' Min</td><td style="text-align: center;">' + Temp[i].OffTime + ' Min</td></tr>';
                }
                $("#AnalysisTbl").append(str);
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getHVACSupplyTempData(today, MeterId, MeterName) {
        var Status = [];
        var AC = [];
        var Meter = MeterName;
        $.ajax({
            url: "TestHVAC.aspx/GetHVACSupplyTempData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','MeterId':'" + MeterId + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    AC.push(Temp[i][Meter]);
                }
                getHVACReturnTempData(today, AC, MeterId, MeterName);
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getHVACReturnTempData(today, AC, MeterId, MeterName) {
        var Status = [];
        var AC1 = [];
        var Meter = MeterName;
        $.ajax({
            url: "TestHVAC.aspx/GetHVACReturnTempData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','MeterId':'" + MeterId + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                $("#HVACAirTemp").empty();
                var str = '<canvas id="HVACAirtTempLineChart" height="210" width="400" style="color:black;"></canvas>';
                $("#HVACAirTemp").append(str);
                for (var i = 0; i < Temp.length; i++) {
                    Status.push(Temp[i].HR);
                    AC1.push(Temp[i][Meter]);
                }
                genrateTempLineChartForPune(Status, AC, AC1, 'HVACAirtTempLineChart')
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function genrateTempLineChartForPune(Status, AC, AC1, id) {

        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                datasets: [
                     {
                         label: 'Supply Air Temp',
                         data: AC,
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
                    label: 'Return Air Temp',
                    data: AC1,
                    fill: false,
                    borderColor: 'blue',
                    borderWidth: 1,
                    backgroundColor: 'blue',
                    pointBorderColor: 'blue',
                    pointHoverBackgroundColor: 'blue',
                    pointHoverBorderColor: 'blue',
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
                            labelString: 'Units in oC'
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
                <nav class="navbar navbar-light bg-light navbar-expand-lg p-1" style="background-color: white !important">
                    <a class="navbar-brand" href="">
                         <img src="../Plugins/images/bbq.png" width="80" height="auto" class="d-inline-block align-top" alt="" />
                    </a>


                    <ul class="navbar-nav flex-row ml-md-auto d-none d-md-flex">
                        <li class="m-3 pt-2">
                            <h6><strong><span id="txtLocation"></span></strong></h6>
                        </li>
                         <li class="m-3">
                            <button class="btn btn-primary" id="btnSwitchCategory">
                                <i class="fas fa-tachometer-alt"></i>
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
                        </li>
                      <%--  <a class="navbar-brand" href="../DashBoard/Fuel.aspx">
                            <img src="../Plugins/images/teams-Logo.png" width="200" height="auto" class="d-inline-block align-top pt-2" alt="" />
                        </a>--%>
                    </ul>


                </nav>
            </div>
        </div>
    </div>

    <div class="container-fluid" id="DivHVAC">
         <div class="row justify-content-center p-1 ">
                    <div class="col-md-12 ">
                        <div class="bg-light card p-2">
                            <p class="small text-left mb-0"><strong><a href="TestHVAC.aspx" class="text-primary">Dining Area</a></strong></p>
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
        <div class="row p-1 justify-content-center">
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Air Temperature In <sup>o</sup>C (HVAC)</strong></h6>
                    <div id="HVACAirTemp">
                    </div>
                </div>
            </div>
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Analysis Table (HVAC)</strong></h6>
                    <table class="table table-bordered table-sm" style="font-size: 10px !important">
                        <thead>
                            <tr style="background: #e8e8e8 !important">
                                <th style="text-align: center;">Utility Name</th>
                                <th style="text-align: center;">AC</th>
                                <th style="text-align: center;">Running Time</th>
                                <th style="text-align: center;">Off Time</th>
                            </tr>
                        </thead>
                        <tbody id="AnalysisTbl"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

