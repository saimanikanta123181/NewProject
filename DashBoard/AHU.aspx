<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AHU.aspx.cs" Inherits="CMS.DashBoard_AHU" %>

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
        p{
           font-size:14px !important;
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
        getAHUMeters();
        getAHUData(today);
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
            getAHUData(Date)
            TimeSet = setInterval(function () {
                getAHUData(Date)
            }, 300000);
        }
        else if (TimeId == 2) {
            clearTimeout(TimeSet);
            getAHUData(Date)
        }
    };
    function getAHUMeters(today) {
        $.ajax({
            url: "AHU.aspx/GetAHUMeter",
            type: "POST",
            dataType: "json",
            data: "{'TypeId':'" + 3 + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                var str = '';
                $("#DivAHUName").empty();
                for (var i = 0; i < Temp.length; i++) {
                    str += '<div class="row justify-content-center pt-2 pb-2"  id="' + Temp[i].Id + '"><div class="col-md-10 "><button class="btn btn-dark btn-block btn-lg" data-attr="">AHU '+(i+1)+'</button><p class="text-center pt-2">' + Temp[i].Name + '</p></div></div>';
                }
                $("#DivAHUName").append(str);
                FirstMeterId = Temp[0].Id;
                FirstMeterName = Temp[0].Name;
                $("#" + FirstMeterId).trigger("click");
            },
            error: function (xhr, ajaxOptions, thrownError) { }
        });
    }
    function getAHUData(today) {
        $.ajax({
            url: "AHU.aspx/GetAHUData",
            type: "POST",
            dataType: "json",
            data: "{'date':'" + today + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data, textStatus, jqXHR) {
                var Temp = JSON.parse(data.d);
                var str = '';
                if (Temp[0].Unit_Status == 1) {
                    $('.divAHU').css('backgroundImage', 'url(../Plugins/images/chiller-working.gif)');

                } else {
                    $('.divAHU').css('backgroundImage', 'url(../Plugins/images/chiller-working-fan-off.gif)');
                }
                 $("#DivAHUTbl").empty();
                 str += '<tbody><tr><th>Supply Air Temp.</th><td>' + Temp[0].Supply_Air_Temp + '</td></tr><tr><th>Return Air Temp.</th><td>' + Temp[0].Return_Air_Temp + '</td></tr></tbody>';
                 $("#DivAHUTbl").append(str);

                 $("#txtReturnTemp").html(Temp[0].Return_Air_Temp);
                 $("#txtSupplyTemp").html(Temp[0].Supply_Air_Temp);
                 $("#txtFilterPressure").html(Temp[0].Filter_Pressure);
                 $("#txtChiiledWaterSupply,#lblChilledWaterSupply").html(Temp[0].CW_Sup_Temp);
                 $("#txtChiiledWaterReturn,#lblChilledWaterReturn").html(Temp[0].CH_Ret_Temp);
                 $("#lblONRunningTime").html(Temp[0].UnitRunTime+' Min');
                 $("#lblSetTemprature").html(Temp[0].Set_Temp);
                 $("#lblDeltaT").html(Temp[0].Delta_T_Reading);
            
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
                    <%--<a class="navbar-brand" href="">
                        <img src="../Plugins/images/Flechazo-Logo.png" width="130" height="auto" class="d-inline-block align-top" alt="" />
                    </a>--%>
                    <ul class="navbar-nav flex-row ml-md-auto d-none d-md-flex">

                      <%--  <li class="m-3 pt-2">
                            <h6><strong><span id="txtLocation"></span></strong></h6>
                        </li>--%>
                       <%-- <li class="m-3">
                            <button class="btn btn-primary" id="btnSwitch">
                                <i class="fas fa-home"></i>
                             </button>
                        </li>--%>
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
                        <li class="m-3 text-right pt-2" style="width: 200px; line-height: 14px;"><span>
                            <label id="lblTime"></label>
                        </span>
                         <%--   <br />
                            <small>Last Updated :
                                <label id="lblupdTime"></label>
                            </small>--%>

                        </li>
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
            <div class="col-md-2 pl-1 pb-0 pr-3 pt-1">
                <div class="bg-light card p-2 mb-2" id="DivAHUName">
                <%--   <div class="row justify-content-center pt-2 pb-2">
                        <div class="col-md-10 ">
                            <button class="btn btn-dark btn-block btn-lg" data-attr="">AHU 1</button>
                            <p class="text-center pt-2">Location XYX</p>
                        </div>
                    </div>
                    <div class="row justify-content-center pt-2 pb-2">
                        <div class="col-md-10">
                            <button class="btn btn-dark  btn-block btn-lg" data-attr="">AHU 2</button>
                            <p class="text-center pt-2">Location XYX</p>
                        </div>
                    </div>--%>
                </div>
            </div>
            <div class="col-md-7 pl-1 pb-0 pr-3 pt-1 divAHU" style="background-size: 700px 300px;background-repeat: no-repeat;
  background-position: center top; min-height:350px">
                <div class="row" >
                    <div class="col-md-3">
                        <p class="pt-4"><strong>AHU 1</strong></p>
                        <p class="" style="margin-top: 120px;"><strong>Return</strong><br /><span id="txtReturnTemp"></span><sup>o</sup>C<i class="fas fa-thermometer-half pl-2 fa-2x"></i></p>
                    </div>
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-5">
                                <p class="text-right pt-4"><strong>Actuator</strong></p>
                            </div>
                            <div class="col-md-7 pt-4">
                                <p ><strong>CHWS</strong> <i class="fas fa-thermometer-half pl-2 fa-2x"></i><span id="txtChiiledWaterSupply"></span><sup>o</sup>C</p>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-md-3">
                                <p class="pt-3"  style="margin-top: 160px;"><strong>FILTER</strong><br /><span id="txtFilterPressure"></span> Pascal</p>
                            </div>
                            <div class="col-md-3 pt-4 pl-0">
                                <p  class="pt-4 pl-0"  style="margin-top: 130px;"><strong>CHWR</strong><br /><i class="fas fa-thermometer-half pl-2 fa-2x"></i><span class="pl-2" id="txtChiiledWaterReturn"></span><sup>o</sup>C</p>
                            </div>
                              <div class="col-md-3 pt-4 pl-0">
                                <p  class="pt-4"  style="margin-top: 130px;"><strong>VFD</strong><br />-</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <p class="text-left" style="margin-top: 180px;"><strong>Supply</strong><br /><i class="fas fa-thermometer-half pl-2 fa-2x"></i><span class="pl-2" id="txtSupplyTemp"></span><sup>o</sup>C</p>
                    </div>
                   </div>
             </div>
            <div class="col-md-3 p-1">
                <div class="bg-light card p-2 mb-1">
                    <p class="small mb-0"><label><strong>Table</strong></label></p>
                    <table class="table table-bordered table-sm" style="font-size: 12px !important" id="DivAHUTbl">
                        <thead>
                        </thead>
                     </table>
                   </div>
                <div class="bg-light card p-2 mt-1">
                    <p class="small mb-0 pb-1"><strong>Parameters</strong></p>
                    <div class="row">
                        <p class="col-md-8 small pt-1 pb-1 mb-0">Chilled Water Supply</p>
                        <p class="col-md-4 pt-1 pb-1 mb-0" id="lblChilledWaterSupply"></p>
                    </div>
                    <div class="row">
                        <p class="col-md-8 small pt-1 pb-1 mb-0">Chilled Water Return</p>
                        <p class="col-md-4 pt-1 pb-1 mb-0" id="lblChilledWaterReturn"></p>
                    </div>
                    <div class="row">
                        <p class="col-md-8 small pt-1 pb-1 mb-0">Filter Drop Pressure</p>
                        <p class="col-md-4 pt-1 pb-1 mb-0">-</p>
                    </div>
                    <div class="row">
                        <p class="col-md-8 small pt-1 pb-1 mb-0">Actuator Status</p>
                        <p class="col-md-4 pt-1 pb-1 mb-0">-</p>
                    </div>
                    <div class="row">
                        <p class="col-md-8 small pt-1 pb-1 mb-0">VFD Status</p>
                        <p class="col-md-4 pt-1 pb-1 mb-0">-</p>
                    </div>
                      <div class="row">
                        <p class="col-md-8 small pt-1 pb-1 mb-0">ON Running Time</p>
                        <p class="col-md-4 pt-1 pb-1 mb-0" id="lblONRunningTime"></p>
                    </div>
                       <div class="row">
                        <p class="col-md-8 small pt-1 pb-1 mb-0">Set Temperature</p>
                        <p class="col-md-4 pt-1 pb-1 mb-0" id="lblSetTemprature"></p>
                    </div>
                      <div class="row">
                        <p class="col-md-8 small pt-1 pb-1 mb-0">Delta T</p>
                        <p class="col-md-4 pt-1 pb-1 mb-0" id="lblDeltaT"></p>
                    </div>
                 </div>
            </div>
       </div>
        <div class="row pl-1 pb-1 pr-1 pt-0">
            <div class="col-md-6 p-1">
                <div class="bg-light card p-2 mb-1">
                        <label>VFD Status Graph</label>
                  </div>
            </div>
            <div class="col-md-6 p-1">
                <div class="bg-light card p-2 mb-1">
                        <label>Actuator Graph</label>
                    </div>
                </div>
           </div>
    </div>
</body>
</html>
