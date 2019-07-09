<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Linechat.aspx.cs" Inherits="CMS.DashBoard_Linechat" %>

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
        #electricityMonthlyBarChart, #electricityDailyBarChart, #electricityPFLineChart {
            height: 230px !important;
            margin-top: -30px;
        }

        #HVACAirtTempLineChart {
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
        var MeterName = 'HVAC1';
        var MeterId = '0256';
       // getHVACData($("#txtDate").val() + ' 23:59:00');
         getHVACSupplyTempData($("#txtDate").val() + ' ' + '23:59 PM', MeterId, MeterName);


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
        function getHVACSupplyTempData(today, MeterId, MeterName) {

            alert(MeterId);
            alert(MeterName);
        var Status = [];
        var AC = [];
        var Meter = MeterName;
        $.ajax({
            url: "Linechat.aspx/GetHVACSupplyTempData",
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
            url: "Linechat.aspx/GetHVACReturnTempData",
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
        <div class="row p-1 justify-content-center">
            <div class="col-md-6 p-2">
                <div class="bg-light card box-layout">
                    <h6><strong>Air Temperature In <sup>o</sup>C (HVAC)</strong></h6>
                    <div id="HVACAirTemp">
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</body>
</html>
