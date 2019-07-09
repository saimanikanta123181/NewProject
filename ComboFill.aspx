<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ComboFill.aspx.cs" Inherits="CMS.ComboFill" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>-:: CMS - Combo Filling ::-</title>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ComboFill.aspx/FillBranches",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#ddlsite").empty();
                    $("#ddlsite").append($('<option />').attr('value', '0').text('Select Site'));
                    $.each(data.d, function (key, value) {
                        $("#ddlsite").append($("<option></option>").val(value.Id).html(value.Name));
                    });
                },
                error: function (result) {
                    alert("Error");
                }
            });

        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</html>
