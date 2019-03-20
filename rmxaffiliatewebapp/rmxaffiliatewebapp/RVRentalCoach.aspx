<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="RVRentalCoach.aspx.vb" Inherits="rmxaffiliatewebapp.RVRentalCoach" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Styles/detail.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css">
     <div class="container body-content">
        <div class="row">
            <div class="col-md-9">
                <h2 style="color:#022a3b; padding-bottom:10px;"><%= _detailModel.NameOnWeb %></h2>
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                        <div id="primary-img" style="margin-top:10px;">
                            <img src="data:image/jpg;base64, <%= _detailModel.MediaList.FirstOrDefault(Function(x) x.PhotoCode = 0).Photo %>" >
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                        <div id="overview-div" style="margin-top:10px;">
                            <h2 style="margin-top:2px;">Overview</h2>
                            <table cellpadding="5" cellspacing="5" width="100%">
                                <thead id="overview-table">
                                    <tr><th>Model:</th><td><%= _detailModel.NameOnWeb %></td></tr>
                                    <tr><th>Manufacturer:</th><td><%= _detailModel.Make %></td></tr>
                                    <tr><th>Daily Rate:</th><td><%= _detailModel.DailyRate %></td></tr>
                                    <tr><th>Class/Type:</th><td><%= _detailModel.ClassName %></td></tr>
                                    <tr><th>Location:</th><td><%= _detailModel.LocationName %></td></tr>
                                    <tr><th>Seats:</th><td><%= _detailModel.Belts %></td></tr>
                                    <tr><th>Sleeps:</th><td>Up to <%= Convert.ToInt32(_detailModel.Adolescents) + Convert.ToInt32(_detailModel.Adults) + Convert.ToInt32(_detailModel.Children) %></td></tr>
                                    <tr><th>Length:</th><td><%= _detailModel.Length %></td></tr>
                                    <%If _detailModel.NoDogs = True Then %>
                                        <tr><th>Pets Allowed:</th><td>Yes</td></tr>
                                    <%Else %>
                                        <tr><th>Pets Allowed:</th><td>No</td></tr>
                                    <%End If %>
                                    <%If _detailModel.SmokingAllowed = True Then %>
                                        <tr><th>Smoking Allowed:</th><td>Yes</td></tr>
                                    <%Else %>
                                        <tr><th>Smoking Allowed:</th><td>No</td></tr>
                                    <%End If %>
                                    <%If _detailModel.NoTowing = True Then %>
                                        <tr><th>Towing Allowed:</th><td>Yes</td></tr>
                                    <%Else %>
                                        <tr><th>Towing Allowed:</th><td>No</td></tr>
                                    <%End If %>
                                </thead>                                                                
                            </table>
                        </div>
                    </div>
                </div>
                <br>
                <br>
                <div class="row">
                    <div class="col-md-12">
                        <ul id="thumbnail-imgs">
                            <%For Each img As rmxaffiliatewebapp.VehicleMediaItemModel In _detailModel.MediaList %>
                                <li style="display:inline;"><img class="thumbs" style="height:70px; width:auto; padding-right:10px;" src="data:image/jpg;base64, <%= img.Photo %>" onclick="selectedPhoto(<%= img.PhotoCode %>)" ></li>
                            <%Next %>
                        </ul>
                    </div>
                </div>
                <br>
                <br>
                <%If Not String.IsNullOrEmpty(_detailModel.YouTubeID) Then %>
                    <div class="row">
                        <div class="col-md-12">
                            <div style="text-align:center; margin-left:20%; margin-right:20%;">
                                <div class="embed-responsive embed-responsive-4by3" id="youtube">
                                    <object class="embed-responsive-item">
                                        <param name="movie" value="https://www.youtube.com/v/<%= _detailModel.YouTubeID %>">
                                        <param name="allowFullScreen" value="true">
                                        <param name="allowScriptAccess" value="always">
                                        <embed src="https://www.youtube.com/v/<%= _detailModel.YouTubeID %>" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always">
                                    </object>
                                </div>
                            </div>
                            <br />
                        </div>
                    </div>
                    <br>
                    <br>
                <%End if %>
                <%If _modeContent %>
                    <div class="row">
                        <div class="col-md-12">
                            <div style="margin-top:-20px;">
                                <h3 style="color:black;">Event Description</h3>
                            </div>
                            <p>
                                <strong><%= _detailModel.WebEventDescription %></strong>
                                <br><br>
                            </p>
                        </div>
                    </div>
                <%Else %>
                    <div class="row">
                        <div class="col-md-6">
                            <div style="margin-top:-20px;">
                                <h3 style="color:black;">Description</h3>
                            </div>
                            <p id="description">
                                <strong><%= _detailModel.WebDescription %></strong>
                                <br><br>
                                <%= _detailModel.OtherCostsDesc %>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <div style="margin-top:-20px; padding-left:35px;">
                                <h3 style="color:black;">Additional Equipment</h3>
                            </div>
                            <div id="additional_equipment">
                                <%For Each item As rmxaffiliatewebapp.SortAddEquipmentModel In equipmentModel %>
                                <%If item.IsEquipmentType = True Then %>
                                    <div class="checkbox">
                                        <label style="padding-left:55px;">
                                            <input type="hidden" value="<%= item.WebPrice %>" />
                                            <input type="checkbox" value="<%= item.Oid %>" name="equipment_oid" class="equipment_oid">
                                            <%= item.Name %>
                                        </label>
                                        <label style="float:right; padding-right:30px;" class="web_price"><%= item.WebPrice %></label>
                                    </div>
                                <%Else %>
                                    <div class="checkbox">
                                        <label style="padding-left:55px;">
                                            <input type="hidden" value="<%= item.WebPrice %>" />
                                            <input type="checkbox" value="<%= item.Oid %>" name="fee_oid" class="fee_oid">
                                            <%= item.Name %>
                                        </label>
                                        <label style="float:right; padding-right:30px;" class="web_price"><%= item.WebPrice %></label>
                                    </div>
                                <%End If %>
                                <%Next %>
                            </div>
                        </div>
                    </div>
                    <br>
                    <h3 style="color:#022a3b; padding-bottom:10px;">General amenities</h3>
                    <div class="row">
                        <div class="col-md-12">
                            <ul style="padding:0px; columns:4; list-style-type:none;" id="amenity">
                                <%For Each amenity As rmxaffiliatewebapp.AmenityViewModel In _detailModel.AmenityList %>
                                    <li><span class="glyphicon glyphicon-ok" style="font-size:10px; padding-right:5px;"></span><%= amenity.AmenityName %></li>
                                <%Next %>
                            </ul>
                        </div>
                    </div>
                <%End If %>
                <br>
                <br>
                <br>
                <br>
            </div>
            <div class="col-md-3">
                <div class="row">
                    <h3 style="color:#707070; font-weight:bold; padding-bottom:17px;">Book Now</h3>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" class="form-control" id="first_name" name="first_name" />
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" class="form-control" id="last_name" name="last_name" />
                        </div>
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="text" class="form-control" id="email" name="email" />
                        </div>
                        <div class="form-group">
                            <label>Phone No</label>
                            <input type="text" class="form-control" id="phone_no" name="phone_no" />
                        </div>
                        <div class="form-group">
                            <label>Departure Date: </label>
                            <div class="input-group date" id="departureDate">
                                <input type="text" class="form-control" name="departure_date" id="departure_date">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Return Date: </label>
                            <div class="input-group date" id="returnDate">
                                <input type="text" class="form-control" name="return_date" id="return_date">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Total Adults</label>
                            <input type="text" class="form-control" id="total_adults" name="total_adults" />
                        </div>
                        <div class="form-group">
                            <label>Total Kid(s)</label>
                            <input type="text" class="form-control" id="total_kids" name="total_kids" />
                        </div>
                        <div class="form-group">
                            <label>Message</label>
                            <textarea class="form-control" rows="4" id="message" name="message"></textarea>
                        </div>
                    </div>
                </div>
                <div class="row" style="text-align:center;">
                    <div class="col-xs-6">
                        <!-- Hidden datas -->
                        <input type="hidden" value="<%= _detailModel.Oid %>" id="vehicle_oid" name="vehicle_oid" />
                        <input type="hidden" value="<%= _detailModel.NameOnWeb %>" id="vehicle_name" name="vehicle_name" />
                        <input type="hidden" value="<%= _detailModel.QuickFindKeyWord %>" id="vehicle_key" name="vehicle_key" />
                        <input type="hidden" value="<%= _detailModel.Location %>" id="location" name="location" />
                        <input type="hidden" value="<%= _detailModel.LocationName %>" id="location_name" name="location_name" />
                        <input type="hidden" value="<%= _detailModel.Organization %>" id="organization" name="organization" />
                        <input type="hidden" value="<%= _detailModel.OrganizationName %>" id="organization_name" name="organization_name" />
                        <input type="hidden" value="<%= _detailModel.ClassOid %>" id="class_oid" name="class_oid" />
                        <input type="hidden" value="<%= _detailModel.ClassName %>" id="vehicle_class" name="vehicle_class" />
                        <input type="hidden" value="<%= _detailModel.OutgoingUserName %>" id="outgoing_username" name="outgoing_username" />
                        <input type="hidden" value="<%= _detailModel.OutgoingServerName %>" id="outgoing_servername" name="outgoing_servername" />
                        <input type="hidden" value="<%= _detailModel.OutgoingServerPort %>" id="outgoing_serverport" name="outgoing_serverport" />
                        <input type="hidden" value="<%= _detailModel.OutgoingPassword %>" id="outgoing_password" name="outgoing_password" />
                        <input type="hidden" value="<%= _detailModel.EmailAddress %>" id="email_address" name="email_address" />
                        <input type="hidden" value="<%= _detailModel.WebQuoteEmailAddress %>" id="web_quote_email_address" name="web_quote_email_address" />
                        <input type="hidden" value="<%= _detailModel.LocationSequenceId %>" id="location_sequence_id" name="location_sequence_id" />
                        <input type="hidden" value="<%= _detailModel.PrimaryPhone %>" id="primary_phone" name="primary_phone" />
                        <%If _modeContent Then %>
                        <input type="hidden" value="$<%= Convert.ToInt32(_detailModel.WebEventPriceForPickedUp) %>" id="web_event_price_for_pick_up" name="web_event_price_for_pick_up" />
                        <input type="hidden" value="$<%= Convert.ToInt32(_detailModel.WebEventPriceForDelivered) %>" id="web_event_price_for_delivered" name="web_event_price_for_delivered" />
                        <input type="hidden" value="$<%= Convert.ToInt32(_detailModel.WebEventPriceForDelivered2) %>" id="web_event_price_for_delivered2" name="web_event_price_for_delivered2" />
                        <%End If %>
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary" value="Submit" />
                        </div>
                    </div>
                    <%If Not _modeContent Then%>
                        <div class="col-xs-6 visible-xs">
                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#estimate_modal" style="margin-right:15px;" value="<%= _detailModel.QuickFindKeyWord %>">Get Estimate</button>
                        </div>
                    <%End If %>
                </div>
            </div> 
        </div>

         <%If Not _modeContent Then %>
            <div id="element" style="display:block; z-index:1000;">
            </div>
             <div class="modal fade" id="estimate_modal" tabindex="-1" role="dialog">
                <div class="modal-dialog hidden-lg hidden-md hidden-sm visible-xs" style="margin-left:55px; margin-right:55px;">
                    <div style="background-color:white;">
                        <div class="modal-body" style="padding:0px;">
                            <div id="modal_sticky">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
         <%End If %>
    </div>

    <script src="Scripts/moment.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.8.0/js/bootstrap-datepicker.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js"></script>
    <script>
        var imgs = null;
        var vehicle_key, daily_rate, life_date, interval, cleaning_fee, prep_fee, deposit, hours, miles, dateDeparture, dateReturn, minimumNumberOfTimeInterval, calcByNights;
        var estimate_output, cleaning_output, prep_output, add_equipment_output, total_output, deposit_output, hour_output, mile_output;
        var additional_equipment = 0;
        $(document).ready(function () {
            vehicle_key = '<%= _detailModel.QuickFindKeyWord%>';
            daily_rate = <%= Convert.ToInt32(_detailModel.HigherRate)%>;
            cleaning_fee = <%= Convert.ToInt32(_detailModel.WebCleaningFee)%>;
            prep_fee = <%= Convert.ToInt32(_detailModel.WebPrepFee)%>;
            deposit = <%= Convert.ToInt32(_detailModel.WebRefundableSecurityDeposit)%>;
            hours = <%= Convert.ToInt32(_detailModel.WebGeneratorFreeHours)%>;
            miles = <%= Convert.ToInt32(_detailModel.WebIncludesTheseMilesFreePerDay)%>;
            minimumNumberOfTimeInterval = <%= Convert.ToInt32(_detailModel.MinimumNumberOfTimeInterval)%>;
            calcByNights = <%= Convert.ToInt32(_detailModel.CalcByNights)%>;

            <%Dim serializer = New Script.Serialization.JavaScriptSerializer()
            serializer.MaxJsonLength = Int32.MaxValue  %>
            imgs = <%= serializer.Serialize(_detailModel.MediaList) %>;

            getInitDates();
            loadStickyForm();

            var e = document.getElementById('element');
            var stickyHeight = $("#element").outerHeight();
            var currentWindowHeight = $(window).height();

            initialMethod();
            <%If Not _modeContent Then%>
                $(window).resize(function(){
                    var documentWidth = $(document).width();
                    if(documentWidth >= 1200){
                        e.style.marginLeft = '325px';
                    }
                    else if(documentWidth >= 992 && documentWidth < 1200){
                        e.style.marginLeft = '240px';
                    }
                    else if(documentWidth >= 768 && documentWidth < 992){
                        e.style.marginLeft = '130px';
                    }
                    else if(documentWidth < 768){
                        e.style.marginLeft = '-800px';
                    }
                })
            <%End If%>

            function initialMethod() {
                $("#element").css('top', currentWindowHeight - stickyHeight +'px');
                $("#element").css('position', 'fixed');
            }

            function loadStickyForm()
            {
                var interval_value, interval_day;
                var departure_date = getFormatDate(dateDeparture);
                var return_date = getFormatDate(dateReturn);
                life_date = departure_date + ' - ' + return_date;
                interval = getDateInterval(dateDeparture, dateReturn);
                if(calcByNights > 0)
                {
                    interval_value = interval;
                    interval_day = interval_value + ' nights';
                }
                else
                {
                    interval_value = interval + 1;
                    interval_day = interval_value + ' days';
                }

                estimate_output = 'Estimate Price: $' + daily_rate + '&nbsp;&#215;&nbsp;' + interval_day + ' = $' + Math.floor(daily_rate * interval_value);
                cleaning_output = 'Cleaning Fee: $' + cleaning_fee;
                prep_output = 'Prep. Fee: $' + prep_fee;
                add_equipment_output = 'Additional Equipment: $' + additional_equipment;
                total_output = 'Total: $' + Math.floor(daily_rate * interval_value + cleaning_fee + prep_fee + additional_equipment);
                deposit_output = 'Security Deposit: $' + deposit;
                hour_output = 'Includes ' + Math.floor(interval_value * hours) + ' Free Hours Generator';
                mile_output = 'Includes ' + Math.floor(interval_value * miles) + ' Free Miles';

                <%If Not _modeContent Then%>
                window.onload = document.getElementById('element').innerHTML =
                '<div style="border: 2px solid darkgrey"><div style="background-color:black; padding-bottom:45px; padding-left:15px; padding-right:15px; padding-top:20px;"><span style="padding-right:40px; float:left; color:white; font-size:18px; font-family:Lato; font-weight:bold;">Veh #' + vehicle_key + '</span><span style="float:right; color:white; font-size:18px; font-family:Lato; font-weight:bold;">$' + daily_rate + ' per day</span></div>' +
                '<div class="estimateDiv"><span style="color:#555; font-family:Lato; font-weight:bold;">' + life_date + '</span></div>' +
                '<span style="padding-left:15px; float:left; color:#555; font-family:Lato; font-weight:bold;">$' + daily_rate + '&nbsp;&#215;&nbsp;' + interval_day + '</span><span style="padding-right:15px; float:right; color:#555; font-family:Lato; font-weight:bold;">$' + Math.floor(daily_rate * interval_value) + '</span><br />' +
                '<span style="padding-left:15px; float:left; color:#555; font-family:Lato; font-weight:bold;">Cleaning</span><span style="padding-right:15px; float:right; color:#555; font-family:Lato; font-weight:bold;">$' + cleaning_fee + '</span><br />' +
                '<span style="padding-left:15px; float:left; font-family:Lato; font-weight:bold;">Prep.&nbsp;&nbsp;Fee</span><span style="padding-right:15px; float:right; font-family:Lato; font-weight:bold;">$' + prep_fee + '</span><br />' +
                '<span style="padding-left:15px; float:left; font-family:Lato; font-weight:bold;">Add.&nbsp;&nbsp;&nbsp;Equipment</span><span style="padding-right:15px; float:right; font-family:Lato; font-weight:bold;">$' + additional_equipment + '</span>' +
                '<br /><hr style="margin:10px; border:0; border-top:1px solid black;" />' +
                '<span style="padding-left:15px; float:left; color:#555; font-family:Lato; font-weight:bold;">Total</span><span style="padding-right:15px; float:right; color:#555; font-family:Lato; font-weight:bold;">$' + Math.floor(daily_rate * interval_value + cleaning_fee + prep_fee + additional_equipment) + '</span>' +
                '<br /><hr style="margin-top:10px; margin-bottom:10px; border:0; border-top:1px solid #e1e1e1;" />' +
                '<span style="padding-left:15px; float:left; color:#555; font-family:Lato; font-weight:bold;">Security Deposit</span><span style="padding-right:15px; float:right; color:#555; font-family:Lato; font-weight:bold;">$' + deposit + '</span><br />' +
                '<div style="margin-top:10px;"><span style="padding-left:15px;color:black; font-size:14px; font-family:Lato;">Includes <b>' + Math.floor(interval_value * hours) + '</b> Free Hours Generator</span></div>' +
                '<h5 style="padding-left:15px;color:black; font-weight:normal;">Includes <b>' + Math.floor(interval_value * miles) + '</b> Free Miles</h5><br /><br />' +
                '<input type="hidden" value="' + estimate_output + '" id="estimate_output" name="estimate_output" />' + 
                '<input type="hidden" value="' + cleaning_output + '" id="cleaning_output" name="cleaning_output" />' + 
                '<input type="hidden" value="' + prep_output + '" id="prep_output" name="prep_output" />' +
                '<input type="hidden" value="' + add_equipment_output + '" id="add_equipment_output" name="add_equipment_output" />' + 
                '<input type="hidden" value="' + total_output + '" id="total_output" name="total_output" />' + 
                '<input type="hidden" value="' + deposit_output + '" id="deposit_output" name="deposit_output" />' + 
                '<input type="hidden" value="' + hour_output + '" id="hour_output" name="hour_output" />' + 
                '<input type="hidden" value="' + mile_output + '" id="mile_output" name="mile_output" />'; 
                
                <%End If%>
            }

            function getFormatDate(date)
            {
                var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                var format = new Date(date);
                var day = format.getDate();
                var monthIndex = format.getMonth();
                var year = format.getFullYear();

                return monthNames[monthIndex] + ' ' + day + ', ' + year;
            }

            function getDateInterval(date1, date2)
            {
                var departure_date = new Date(date1);
                var return_date = new Date(date2);
                var interval = Math.floor((return_date - departure_date)/(24*60*60*1000));

                return interval;
            }

            function getInitDates()
            {
                var today = new Date();
                dateDeparture = today.setDate(today.getDate() + 2);
                dateReturn = today.setDate(today.getDate() + minimumNumberOfTimeInterval - calcByNights);

                $('#departureDate').datepicker({
                    format: 'mm/dd/yyyy',
                    startDate: new Date(dateDeparture),
                });
                $('#departureDate').datepicker('setDate', new Date(dateDeparture));
                $('#returnDate').datepicker({
                    format: 'mm/dd/yyyy',
                    startDate: new Date(dateReturn),
                });
                $('#returnDate').datepicker('setDate', new Date(dateReturn));
            }

            $('#departureDate').datepicker().on('changeDate', function (e) {
                var d_change_date = e.date;
                var date_obj = new Date(d_change_date);
                var r_change_date = date_obj.setDate(date_obj.getDate() + minimumNumberOfTimeInterval - calcByNights);
                $('#returnDate').datepicker('setStartDate', new Date(r_change_date));
                $('#returnDate').datepicker('setDate', new Date(r_change_date));
                dateDeparture = d_change_date;
                dateReturn = r_change_date;
                loadStickyForm();
            });

            $('#returnDate').datepicker().on('changeDate', function(e){
                dateReturn = e.date;
                loadStickyForm();
            });

            $('#additional_equipment :checkbox').change(function(){
                if ($(this).is(':checked')) {
                    var add_price = 0;
                    var add_value = $(this).parent().parent().find('.web_price').text();
                    if(add_value == "" || add_value == null){
                        add_price = 0;
                    }
                    else{
                        add_price = parseInt(add_value.split("$").pop());
                    }
                    additional_equipment += add_price;
                }
                else if($(this).is(':checked') == false){
                    var del_price = 0;
                    var del_value = $(this).parent().parent().find('.web_price').text();
                    if(del_value == "" || del_value == null){
                        del_price = 0;
                    }
                    else{
                        del_price = parseInt(del_value.split("$").pop());
                    }
                    additional_equipment -= del_price;
                }
                loadStickyForm();
            });
        });
        function selectedPhoto(photo)
        {
            var target_img = null;
            for(var i = 0; i < imgs.length; i++)
            {
                if(imgs[i].PhotoCode == photo)
                {
                    target_img = '<img src="data:image/jpg;base64, ' + imgs[i].Photo + '" >';
                }
            }
            document.getElementById("primary-img").innerHTML = target_img;
        }
    </script>
    <script>
        $('#estimate_modal').on('show.bs.modal', function (){
            $('#modal_sticky').html('<div style="border: 2px solid darkgrey"><div style="background-color:black; padding-bottom:45px; padding-left:15px; padding-right:15px; padding-top:20px;"><span style="padding-right:40px; float:left; color:white; font-size:18px; font-family:Lato; font-weight:bold;">Veh #' + vehicle_key + '</span><span style="float:right; color:white; font-size:18px; font-family:Lato; font-weight:bold;">$' + daily_rate + ' per day</span></div>' +
                '<div class="estimateDiv"><span style="color:#555; font-family:Lato; font-weight:bold;">' + life_date + '</span></div>' +
                '<span style="padding-left:15px; float:left; color:#555; font-family:Lato; font-weight:bold;">$' + daily_rate + '&nbsp;&#215;&nbsp;' + interval + ' days</span><span style="padding-right:15px; float:right; color:#555; font-family:Lato; font-weight:bold;">$' + Math.floor(daily_rate * interval) + '</span><br />' +
                '<span style="padding-left:15px; float:left; color:#555; font-family:Lato; font-weight:bold;">Cleaning</span><span style="padding-right:15px; float:right; color:#555; font-family:Lato; font-weight:bold;">$' + cleaning_fee + '</span><br />' +
                '<span style="padding-left:15px; float:left; font-family:Lato; font-weight:bold;">Prep.Fee</span><span style="padding-right:15px; float:right; font-family:Lato; font-weight:bold;">$' + prep_fee + '</span><br />' +
                '<span style="padding-left:15px; float:left; font-family:Lato; font-weight:bold;">Add.Equipment</span><span style="padding-right:15px; float:right; font-family:Lato; font-weight:bold;">$' + additional_equipment + '</span>' +
                '<br /><hr style="margin:10px; border:0; border-top:1px solid black;" />' +
                '<span style="padding-left:15px; float:left; color:#555; font-family:Lato; font-weight:bold;">Total</span><span style="padding-right:15px; float:right; color:#555; font-family:Lato; font-weight:bold;">$' + Math.floor(daily_rate * interval + cleaning_fee + prep_fee + additional_equipment) + '</span>' +
                '<br /><hr style="margin-top:10px; margin-bottom:10px; border:0; border-top:1px solid #e1e1e1;" />' +
                '<span style="padding-left:15px; float:left; color:#555; font-family:Lato; font-weight:bold;">Security Deposit</span><span style="padding-right:15px; float:right; color:#555; font-family:Lato; font-weight:bold;">$' + deposit + '</span><br />' +
                '<div style="margin-top:10px;"><span style="padding-left:15px;color:black; font-size:14px; font-family:Lato; font-weight:bold;">Includes ' + Math.floor(interval * hours) + ' Free Hours</span><span style="float:right; padding-right:15px; font-weight:bold; font-family:Lato; font-size:14px;">Generator</span></div>' +
                '<h5 style="padding-left:15px;color:black;">Includes ' + Math.floor(interval * miles) + ' Free Miles</h5><br /><br />' +
                '<div style="text-align:center;"><button type="button" class="btn btn-primary" data-dismiss="modal">Close</button><br /><br /></div>' + 
                '<input type="hidden" value="' + estimate_output + '" id="estimate_output" name="estimate_output" />' + 
                '<input type="hidden" value="' + cleaning_output + '" id="cleaning_output" name="cleaning_output" />' + 
                '<input type="hidden" value="' + prep_output + '" id="prep_output" name="prep_output" />' +
                '<input type="hidden" value="' + add_equipment_output + '" id="add_equipment_output" name="add_equipment_output" />' + 
                '<input type="hidden" value="' + total_output + '" id="total_output" name="total_output" />' + 
                '<input type="hidden" value="' + deposit_output + '" id="deposit_output" name="deposit_output" />' + 
                '<input type="hidden" value="' + hour_output + '" id="hour_output" name="hour_output" />' + 
                '<input type="hidden" value="' + mile_output + '" id="mile_output" name="mile_output" />');
        });
    </script>
    <script type="text/javascript">
    $(document).ready(function() {
        $('#AffiliateForm').bootstrapValidator({
            fields: {
                first_name: {
                    validators: {
                        stringLength: {
                            min: 2,
                        },
                        notEmpty: {
                            message: 'Please enter your first name'
                        }
                    }
                },
                last_name: {
                    validators: {
                        stringLength: {
                            min: 2,
                        },
                        notEmpty: {
                            message: 'Please enter your last name'
                        }
                    }
                },
                email: {
                    validators: {
                        notEmpty: {
                            message: 'Please enter your email address'
                        },
                        emailAddress: {
                            message: 'Please supply a valid email address'
                        }
                    }
                },
                phone_no: {
                    validators: {
                        notEmpty: {
                            message: 'Please enter your phone number'
                        },
                        phone: {
                            country: 'US',
                            message: 'Please supply a vaild phone number'
                        }
                    }
                }
            }
        })
        .on('success.form.bv', function(e) {
            $('#success_message').slideDown({ opacity: "show" }, "slow") // Do something ...
            $('#QuoteForm').data('bootstrapValidator').resetForm();
            e.preventDefault();
            var $form = $(e.target);
            var bv = $form.data('bootstrapValidator');
            $.post($form.attr('action'), $form.serialize(), function(result) {
            }, 'json');
        });
    });
</script>
</asp:Content>
