<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HVAC.aspx.cs" Inherits="CMS.DashBoard_HVAC" %>

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
        #HVACAirtTempLineChart, #HVACCompRuntimeChart {
            height: 200px !important;
            margin-top: -30px;
        }


        .p-2 {
            padding: 0.1rem !important;
        }
    </style>
</head>
<script>
    var TimeId = 0; var TimeSet = ""; var FirstMeterId = ''; var FirstMeterName = '';
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

        getHVACMeters();
    });
    $(document).on('click', '.HVACMeter', function () {
        var MeterId = $(this).attr('id');
        var MeterName = $(this).html();
        getHVACSupplyTempData($("#txtDate").val() + ' ' + '23:59 PM', MeterId, MeterName);
       // getHVACCompRunTimeData($("#txtDate").val() + ' ' + '23:59 PM', MeterId, MeterName);
        getHVACAnalysisTblData($("#txtDate").val() + ' ' + '23:59 PM', MeterId, MeterName);

    })
    function getHVACMeters(today) {
        $.ajax({
            url: "HVAC.aspx/GetHVACMeter",
            type: "POST",
            dataType: "json",
            data: "{'TypeId':'" + TypeId + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                var str = '<div class="row"> <div class="col-md-12 text-center">';
                $("#btnFilter").empty();
                for (var i = 0; i < Temp.length; i++) {
                    str += '<button class="btn btn-primary btn-sm  HVACMeter" id="' + Temp[i].Id + '">' + Temp[i].Name + '</button>&nbsp&nbsp';
                }
                str += '</div></div>';
                $("#btnFilter").append(str);
                FirstMeterId = Temp[0].Id;
                FirstMeterName = Temp[0].Name;
                $("#" + FirstMeterId).trigger("click");
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getHVACAnalysisTblData(today, MeterId, MeterName) {
        $.ajax({
            url: "HVAC.aspx/GetHVACAnalysisData",
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
            url: "HVAC.aspx/GetHVACSupplyTempData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':'" + TypeId + "','MeterId':'" + MeterId + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                if (TypeId == 1) {
                    for (var i = 0; i < Temp.length; i++) {
                        Status.push(Temp[i].HR);
                        AC.push(Temp[i][Meter]);
                    }
                    getHVACReturnTempData(today, AC, MeterId, MeterName);
                } else if (TypeId == 2) {
                    for (var i = 0; i < Temp.length; i++) {
                        Status.push(Temp[i].HR);
                        AC.push(Temp[i][Meter]);
                    }
                    getHVACReturnTempData(today, AC, MeterId, MeterName);
                }
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getHVACReturnTempData(today, AC, MeterId, MeterName) {
        var Status = [];
        var AC1 = [];
        var Meter = MeterName;
        $.ajax({
            url: "HVAC.aspx/GetHVACReturnTempData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':'" + TypeId + "','MeterId':'" + MeterId + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                $("#HVACAirTemp").empty();
                var str = '<canvas id="HVACAirtTempLineChart" height="220" width="400" style="color:black;"></canvas>';
                $("#HVACAirTemp").append(str);
                if (TypeId == 1) {
                    for (var i = 0; i < Temp.length; i++) {
                        Status.push(Temp[i].HR);
                        AC1.push(Temp[i][Meter]);
                    }
                    genrateTempLineChartForPune(Status, AC, AC1, 'HVACAirtTempLineChart')
                } else if (TypeId == 2) {
                    for (var i = 0; i < Temp.length; i++) {
                        Status.push(Temp[i].HR);
                        AC1.push(Temp[i][Meter]);
                    }
                    genrateTempLineChartForPune(Status, AC, AC1, 'HVACAirtTempLineChart')
                }
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getHVACCompRunTimeData(today, MeterId, MeterName) {
        var Status = [];
        var ArrayAC = [];
        var Meter = MeterName;
        $.ajax({
            url: "HVAC.aspx/GetHVACCompRunTimeData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':'" + TypeId + "','MeterId':'" + MeterId + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                if (TypeId == 1) {
                    for (var i = 0; i < Temp.length; i++) {
                        Status.push(Temp[i].HR);
                        ArrayAC.push(Temp[i][Meter]);
                    }
                    getHVACUnitRunTimeData(today, ArrayAC, MeterId, MeterName);
                } else if (TypeId == 2) {
                    for (var i = 0; i < Temp.length; i++) {
                        Status.push(Temp[i].HR);
                        ArrayAC.push(Temp[i][Meter]);
                    }
                    getHVACUnitRunTimeData(today, ArrayAC, MeterId, MeterName);
                }
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getHVACUnitRunTimeData(today, ArrayAC, MeterId, MeterName) {
        var Status = [];
        var ArrayAC1 = [];
        var Meter = MeterName;
        $.ajax({
            url: "HVAC.aspx/GetHVACUnitRunTimeData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "','TypeId':'" + TypeId + "','MeterId':'" + MeterId + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                $("#HVACCompRuntime").empty();
                var str = '<canvas id="HVACCompRuntimeChart" height="220" width="400" style="color:black;"></canvas>';
                $("#HVACCompRuntime").append(str);
                if (TypeId == 1) {
                    for (var i = 0; i < Temp.length; i++) {
                        Status.push(Temp[i].HR);
                        ArrayAC1.push(Temp[i][Meter]);
                    }
                    genrateTimeChartForHyderabad(Status, ArrayAC, ArrayAC1, 'HVACCompRuntimeChart');
                } else if (TypeId == 2) {
                    for (var i = 0; i < Temp.length; i++) {
                        Status.push(Temp[i].HR);
                        ArrayAC1.push(Temp[i][Meter]);
                    }
                    genrateTimeChartForHyderabad(Status, ArrayAC, ArrayAC1, 'HVACCompRuntimeChart');
                }
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
    function genrateTimeChartForHyderabad(Status, AC, AC1, id) {

        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                datasets: [
                     {
                         label: 'Comp Run Time',
                         data: AC,
                         fill: true,
                         borderColor: 'green',
                         borderWidth: 1,
                         backgroundColor: 'green',
                         pointBorderColor: 'green',
                         pointHoverBackgroundColor: 'green',
                         pointHoverBorderColor: 'green',
                         type: 'bar'
                     },
                {
                    label: 'Unit Run Time',
                    data: AC1,
                    fill: true,
                    borderColor: 'blue',
                    borderWidth: 1,
                    backgroundColor: 'blue',
                    pointBorderColor: 'blue',
                    pointHoverBackgroundColor: 'blue',
                    pointHoverBorderColor: 'blue',
                    type: 'bar'
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

            TimeOut(yesterday + ' ' + '23:59');
            $("#txtDate").val(yesterday);
        });
    }
    function TimeOut(Date) {
        if (TimeId == 1) {
            getHVACSupplyTempData(Date, FirstMeterId, FirstMeterName);
           // getHVACCompRunTimeData(Date, FirstMeterId, FirstMeterName);
            getHVACAnalysisTblData(Date, FirstMeterId, FirstMeterName);
        }
        else if (TimeId == 2) {
            getHVACSupplyTempData(Date, FirstMeterId, FirstMeterName);
          //  getHVACCompRunTimeData(Date, FirstMeterId, FirstMeterName);
            getHVACAnalysisTblData(Date, FirstMeterId, FirstMeterName);
        }
    };
</script>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 p-0">
                <nav class="navbar navbar-light bg-light navbar-expand-lg p-1" style="background-color: white !important">
                    <a class="navbar-brand" href="../DashBoard/Fuel.aspx">
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
            <div class="col-md bg-light card-hvac-active mr-3">
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
            <div class="col-md-12" id="btnFilter">
            </div>
        </div>
        <div class="row p-1 justify-content-center">
            <%-- <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Supply Air Tempeature</strong></h6>
					 <div id="HVACSupplyTemp">
                    </div>
                </div>
            </div>--%>
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Air Tempeature In <sup>o</sup>C</strong></h6>
                    <div id="HVACAirTemp">
                    </div>
                </div>
            </div>
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Analysis Table</strong></h6>
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
           <%-- <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Comp Runtime</strong></h6>
                    <div id="HVACCompRuntime">
                    </div>
                </div>
            </div>--%>
        </div>
    </div>
</body>
</html>

