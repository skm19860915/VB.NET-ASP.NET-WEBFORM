<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="rmxaffiliatewebapp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/carouselengine/amazingcarousel.js"></script>
    <script src="Scripts/carouselengine/initcarousel-1.js"></script>
    <link href="Scripts/carouselengine/initcarousel-1.css" rel="stylesheet" />
    <link href="Styles/common.css" rel="stylesheet" />
    <% If String.Compare(_locationContent, "-1") = 0 Then %>
        <div class="row" style="text-align:center;"><h2 style="height:525px;">File does not exist</h2></div>
    <%Else %>
        <% If _locationInfo Is Nothing Or _list Is Nothing Then %>
            <div class="row" style="text-align:center;"><h2 style="height:525px;">Location doesn't exist</h2></div>
        <%Else %>
            <div style="background-color:#022a3b; height:450px;">
            <div id="amazingcarousel-container-1">
                <div id="amazingcarousel-1" style="display:none; position:relative; width:100%; margin:0px auto 0px;">
                    <div class="amazingcarousel-list-container">
                        <h2 id="carousel-h2" style="color:white; padding-left:10px; padding-bottom: 20px; margin-top: -15px;">Here are our Featured Vehicles</h2>
                        <ul class="amazingcarousel-list">
                            <% For Each item As rmxaffiliatewebapp.FeaturedVehicleViewModel In _listOfGallery %>
                                <%If _modeContent And item.WebEventPriceForPickedUp IsNot Nothing Then%>
                                    <li class="amazingcarousel-item">
                                        <div class="amazingcarousel-item-container">
                                            <%If item.IsSquarePhoto = True Then %>
                                                <div class="amazingcarousel-image clip-carousel-div">
                                                    <%If String.IsNullOrEmpty(_optionalParam) Then %>
                                                        <a class="img-a" href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>" target="_blank"></a>
                                                    <%Else %>
                                                        <a class="img-a" href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>" target="_blank"></a>
                                                    <%End If %>
							                        <img src="data:image/jpg;base64, <%= item.Photo%>">
                                                </div>
                                            <%Else %>
                                                <div class="amazingcarousel-image carousel-div">
                                                    <%If String.IsNullOrEmpty(_optionalParam) Then %>
                                                        <a class="img-a" href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>" target="_blank"></a>
                                                    <%Else %>
                                                        <a class="img-a" href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>" target="_blank"></a>
                                                    <%End If %>
							                        <img src="data:image/jpg;base64, <%= item.Photo%>">
                                                </div>
                                            <%End If %>
                                            <div class="info-div">
                                                <%If String.IsNullOrEmpty(_optionalParam) Then %>
                                                    <a href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>" target="_blank"><%= item.Name %></a>
                                                <%Else %>
                                                    <a href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>" target="_blank"><%= item.Name %></a>
							                    <%End If %>
							                    <h5><%= _locationInfo.Name %></h5>
                                                <span style="font-size:12px;"><b>$ for Picked up</b>&nbsp;:<%= Convert.ToInt32(item.WebEventPriceForPickedUp)%></span>
                                                <%If item.WebEventPriceForDelivered IsNot Nothing %>
                                                    <br/><span style="font-size:12px;"><b>$ Price Delivered</b>&nbsp;:<%= Convert.ToInt32(item.WebEventPriceForDelivered) %></span>
                                                <%End If %>
                                                <%If item.WebEventPriceForDelivered2 IsNot Nothing %>
                                                    <br/><span style="font-size:12px;"><b>$ Price Delivered 2</b>&nbsp;:<%= Convert.ToInt32(item.WebEventPriceForDelivered2) %></span>
                                                <%End If %>
                                                <span class="sleeps-span" style="font-size:12px;">Up to <%= Convert.ToInt32(item.Adolescents) + Convert.ToInt32(item.Adults) + Convert.ToInt32(item.Children)%></span>
						                    </div>
                                        </div>
                                    </li>
                                <% ElseIf Not _modeContent %>
                                    <li class="amazingcarousel-item">
                                        <div class="amazingcarousel-item-container">
                                            <%If item.IsSquarePhoto = True Then %>
                                                <div class="amazingcarousel-image clip-carousel-div">
                                                    <%If String.IsNullOrEmpty(_optionalParam) Then %>
                                                        <a class="img-a" href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>" target="_blank"></a>
                                                    <%Else %>
                                                        <a class="img-a" href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>" target="_blank"></a>
                                                    <%End If %>
							                        <img src="data:image/jpg;base64, <%= item.Photo%>">
                                                </div>
                                            <%Else %>
                                                <div class="amazingcarousel-image carousel-div">
                                                    <%If String.IsNullOrEmpty(_optionalParam) Then %>
                                                        <a class="img-a" href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>" target="_blank"></a>
                                                    <%Else %>
                                                        <a class="img-a" href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>" target="_blank"></a>
                                                    <%End If %>
							                        <img src="data:image/jpg;base64, <%= item.Photo%>">
                                                </div>
                                            <%End If %>
                                            <div class="info-div">
                                                <%If String.IsNullOrEmpty(_optionalParam) Then %>
                                                    <a href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>" target="_blank"><%= item.Name %></a>
                                                <%Else %>
                                                    <a href="RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>" target="_blank"><%= item.Name %></a>
                                                <%End If %>
							                    <h5><%= _locationInfo.Name %></h5>
                                                <span><b>DailyRate</b>&nbsp;:<%= item.Price %></span>
                                                <span class="sleeps-span">Up to <%= Convert.ToInt32(item.Adolescents) + Convert.ToInt32(item.Adults) + Convert.ToInt32(item.Children)%></span>
						                    </div>
                                        </div>
                                    </li>
                                <%End If %>
                            <%Next %>
                        </ul>
                        <div class="amazingcarousel-prev"></div>
                        <div class="amazingcarousel-next"></div>
                    </div>
                    <div class="amazingcarousel-nav"></div>
                    <div class="amazingcarousel-engine"><a href="http://amazingcarousel.com">JavaScript Scroller</a></div>
                </div>
            </div>
        </div>
        <div class="container body-content">
            <div class="row">
                <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
                    <h2 style="color:#022a3b; padding-bottom:10px;">All Luxury Class A - RV Rental</h2>
                    <div id="ListVehicles" class="row">
                    </div>
                    <div>
                        <h3><%= _locationInfo.WebStoreHours %></h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <div class="row">
                        <h3 style="color:#707070; font-weight:bold; padding-left:10px; padding-bottom:17px;">Latest Events</h3>
                        <% Response.WriteFile(_eventPath)%>
                    </div>
                    <% If String.Compare("rvrentalsusainc.com", _dirName, StringComparison.InvariantCultureIgnoreCase) = 0 %>
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <br /><br /><br /><br />
                                <h4>RV Rentals USA, Inc.</h4>
                                <h5>Proud Member of</h5>
                                <a href="http://www.cleburnechamber.com" target="_blank">
                                    <img src="UserData/Content/rvrentalsusainc.com/images/Cleburne_Chamber_Logo.png" alt="Cleburne Chamber of Commerce" title="Cleburne Chamber of Commerce" style="margin-top:-30px;" />
                                </a>
                            </div>
                        </div>
                    <% End If %>
                </div>
            </div>
        </div>
        <%End If %>
    <%End If %>
   
    <script>
        $(document).ready(function ()
        {
            GenerateVehicleList();
            function GenerateVehicleList()
            {
                var html = '', photo_div = '', name = '', price = '', region = '', sleeps = '', info_div = '', event_value = '', event_pick_value = '', event_delivery_value = '', event_delivery2_value = '';

                <% If _list IsNot Nothing %>
                    <% For Each item As rmxaffiliatewebapp.FeaturedVehicleViewModel In _listOfClassA %>
                    <% If _modeContent And item.WebEventPriceForPickedUp IsNot Nothing Then %>
                        <% If String.IsNullOrEmpty(_optionalParam) Then %>
                            <% If item.IsSquarePhoto = True Then %>
                                photo_div = "<div class='clip-img-div'><a class='img-a' href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>' target='_blank'></a><img src='data:image/jpg;base64,"
                                                            + "<%= item.Photo%>" + "'></div>"
                            <%Else%>
                                photo_div = "<div class='img-div'><a class='img-a' href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>' target='_blank'></a><img src='data:image/jpg;base64,"
                                                            + "<%= item.Photo%>" + "'></div>"
                            <%End If%>
                        <% Else %>
                            <%If item.IsSquarePhoto = True Then %>
                                photo_div = "<div class='clip-img-div'><a class='img-a' href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>' target='_blank'></a><img src='data:image/jpg;base64,"
                                                            + "<%= item.Photo%>" + "'></div>"
                            <%Else%>
                                photo_div = "<div class='img-div'><a class='img-a' href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>' target='_blank'></a><img src='data:image/jpg;base64,"
                                                            + "<%= item.Photo%>" + "'></div>"
                            <%End If%>
                        <% End If%>
                        <%If String.IsNullOrEmpty(_optionalParam) Then%>
                            name = "<a href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>' target='_blank'>" + "<%= item.Name%>" + "</a>"
                        <%Else%>
                            name = "<a href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>' target='_blank'>" + "<%= item.Name%>" + "</a>"
                        <%End If%>
                        region = "<h5>" + "<%= _locationInfo.Name%>" + "</h5>"
                        event_pick_value = "<span style='font-size:12px;'><b>$ for Picked up</b>&nbsp;:" + "<%= Convert.ToInt32(item.WebEventPriceForPickedUp)%>" + "</span>"
                        <%If item.WebEventPriceForDelivered IsNot Nothing%>
                            event_delivery_value = "<br/><span style='font-size:12px;'><b>$ Price Delivered</b>&nbsp;:" + "<%= Convert.ToInt32(item.WebEventPriceForDelivered) %>" + "</span>"
                        <%End If%>
                        <%If item.WebEventPriceForDelivered2 IsNot Nothing Then%>
                            event_delivery2_value = "<br/><span style='font-size:12px;'><b>$ Price Delivered 2</b>&nbsp;:" + "<%= Convert.ToInt32(item.WebEventPriceForDelivered2) %>" + "</span>"
                        <%End If%>
                        event_value = event_pick_value + event_delivery_value + event_delivery2_value
                        sleeps = "<span class='sleeps-span' style='font-size:12px;'>Up to " + "<%= Convert.ToInt32(item.Adolescents) + Convert.ToInt32(item.Adults) + Convert.ToInt32(item.Children)%>" + "</span>"
                        info_div = "<div class='info-div'>" + name + region + event_value + sleeps + "</div>";
                        html += "<div class='col-lg-4 col-md-6 col-sm-6 col-xs-12'><div class='vehicle-div'>" + photo_div + info_div + "</div></div>"
                    <% ElseIf Not _modeContent %>
                        <% If String.IsNullOrEmpty(_optionalParam) Then %>
                            <% If item.IsSquarePhoto = True Then %>
                                photo_div = "<div class='clip-img-div'><a class='img-a' href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>' target='_blank'></a><img src='data:image/jpg;base64,"
                                                            + "<%= item.Photo%>" + "'></div>"
                            <%Else%>
                                photo_div = "<div class='img-div'><a class='img-a' href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>' target='_blank'></a><img src='data:image/jpg;base64,"
                                                            + "<%= item.Photo%>" + "'></div>"
                            <%End If%>
                        <% Else %>
                            <%If item.IsSquarePhoto = True Then%>
                                photo_div = "<div class='clip-img-div'><a class='img-a' href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>' target='_blank'></a><img src='data:image/jpg;base64,"
                                                        + "<%= item.Photo%>" + "'></div>"
                            <%Else%>
                                photo_div = "<div class='img-div'><a class='img-a' href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>' target='_blank'></a><img src='data:image/jpg;base64,"
                                                        + "<%= item.Photo%>" + "'></div>"
                            <%End If%>
                        <% End If%>
                        <%If String.IsNullOrEmpty(_optionalParam) Then%>
                            name = "<a href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>' target='_blank'>" + "<%= item.Name%>" + "</a>"
                        <%Else%>
                            name = "<a href='RVRentalCoach.aspx?seq=<%= _locationInfo.SequenceId %>&key=<%= item.VehicleKey %>&<%= _optionalParam %>' target='_blank'>" + "<%= item.Name%>" + "</a>"
                        <%End If%>
                        region = "<h5>" + "<%= _locationInfo.Name%>" + "</h5>"
                        price = "<span><b>DailyRate</b>&nbsp;:&nbsp;" + "<%= item.Price%>" + "</span>"
                        sleeps = "<span class='sleeps-span'>Up to " + "<%= Convert.ToInt32(item.Adolescents) + Convert.ToInt32(item.Adults) + Convert.ToInt32(item.Children)%>" + "</span>"
                        info_div = "<div class='info-div'>" + name + region + price + sleeps + "</div>"
                        html += "<div class='col-lg-4 col-md-6 col-sm-6 col-xs-12'><div class='vehicle-div'>" + photo_div + info_div + "</div></div>"
                    <%End If%>
                    <%Next%>

                    document.getElementById("ListVehicles").innerHTML = html;    
                <%End If%>
            }
        });
    </script>
</asp:Content>
