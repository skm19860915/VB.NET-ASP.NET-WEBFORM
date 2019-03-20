<%@ Page Title="Contact Us" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ContactUs.aspx.vb" Inherits="rmxaffiliatewebapp.ContactUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <link href="Styles/common.css" rel="stylesheet" />
    <div class="container body-content">
        <div class="row">
            <div class="col-md-12">
                <h2 style="color:#022a3b; padding-bottom:10px;">Contact us</h2>
                <div id="map" style="height:350px;background:yellow"></div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <h3 style="color:#022a3b; padding-bottom:10px;" id="overview-spec"></h3>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3">
                <div class="form-group">
                    <label>Name</label><span style="color:red;">*</span>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="contactName" ErrorMessage=" User Name is required." ForeColor="Red" Font-Italic="true" />
                    <asp:TextBox ID="contactName" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Phone</label><span style="color:red;">*</span>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="contactPhone" ErrorMessage=" Phone Number is required." ForeColor="Red" Font-Italic="true" />
                    <asp:TextBox ID="contactPhone" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Email</label><span style="color:red;">*</span>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="contactEmail" ErrorMessage=" Email is required." ForeColor="Red" Font-Italic="true" />
                    <asp:TextBox ID="contactEmail" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-3">
                <div style="padding-top:65px;"><asp:Image ID="imgCaptcha" runat="server" ImageUrl="~/CaptchaImage.aspx" /><label><%= _locationInfo.WebStoreHours %></label></div>
                <div><label style="padding-top:10px;">Input Symbols</label></div>
                <div><asp:TextBox ID="txtCaptchaText" runat="server" /></div>
                <asp:Label ID="lblMessage" runat="server" />
            </div>
            <div class="col-md-6" style="text-align:center;">
                <br />
                <div><h4 style="color:black;">Thank you for your interest in <%= _siteName %></h4></div>
                <div><h4 style="color:black;">ALWAYS CALL FOR APPOINTMENT</h4></div>
                <br />
                <div id="location_info_div"></div>
                <br />
                <span style="color:black; font-weight:normal;">For additional information and help or to reserve your RV please contact us.</span>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label>Message</label><span style="color:red;">*</span>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="contactComment" ErrorMessage=" Message is required." ForeColor="Red" Font-Italic="true" />
                    <asp:TextBox ID="contactComment" TextMode="MultiLine" runat="server" CssClass="form-control" Rows="4" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3">
                <div class="form-group">
                    <asp:Button ID="btnSubmit" runat="server" Text="Send Now" CssClass="btn send-btn" />
                </div>
            </div>
        </div>
    </div>
    <script>
        var latitude = '<%= _locationInfo.Latitude %>';
        var longitude = '<%= _locationInfo.Longitude %>';
        var api_key = '<%= _locationInfo.WebGoogleMapJavaScriptAPIKey %>';
        var zoom_level = <%= Convert.ToInt32(_locationInfo.WebMapZoomLevel) %>;
        var location_name = '<%= _locationInfo.LocationName%>'
        $(document).ready(function () {
            var phone = '<%= _locationInfo.PrimaryPhone%>';
            var organization_name = '<%= _locationInfo.OrganizationName%>';
            var address = '<%= _locationInfo.Address%>';
            var city = '<%= _locationInfo.City%>';
            var state = '<%= _locationInfo.State%>';
            var zip = '<%= _locationInfo.Zip%>';
            document.getElementById('overview-spec').innerHTML = "We would love to hear from you. Give us a call at <a href='tel:" + 1 + phone.match(/[\d\.]+/g) + "'>" + phone + "</a>";
            document.getElementById('location_info_div').innerHTML = '<a href="tel:' + 1 + phone.match(/[\d\.]+/g) + '">' + phone + '</a><br /><br /><label>' + organization_name + '</label><br /><label>'
                    + address + '</label><br /><label>' + city + ' ' + state + ' ' + zip + '</label>';
        });
        function myMap() 
        {
            var mapProp = { center: new google.maps.LatLng(latitude, longitude), zoom: zoom_level };
            var map = new google.maps.Map(document.getElementById("map"), mapProp);
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(latitude, longitude),
                map: map,
                title: location_name
            });
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyByczEacgQD1DOTUQI_LSpmbhLgmCZWHZg&callback=myMap"></script>
</asp:Content>
