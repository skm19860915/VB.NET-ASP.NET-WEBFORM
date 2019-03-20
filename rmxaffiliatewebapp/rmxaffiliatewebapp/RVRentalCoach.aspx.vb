Imports System.IO
Imports System.Net
Imports System.Net.Mail
Imports System.Net.Security
Imports System.Security.Cryptography.X509Certificates
Imports Newtonsoft.Json

Public Class RVRentalCoach
    Inherits Page
    Protected _modeContent As Boolean = False
    Protected _serviceModel As ServiceListViewModel
    Protected _detailModel As VehicleDetailViewModel
    Protected _dir As DirectoryInfo

    Property equipmentModel As List(Of SortAddEquipmentModel)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim master As SiteMaster = TryCast(Me.Master, SiteMaster)
        _dir = master._targetDir

        _modeContent = master.GetModeContent(_dir)

        Dim vehicleOid = Request.Form("vehicle_oid")
        Dim seq As Long = Request.QueryString("seq")
        Dim key As String = Request.QueryString("key")

        If vehicleOid IsNot Nothing Then
            ' general hidden data
            Dim vehicleName As String = Request.Form("vehicle_name")
            Dim locationOid As String = Request.Form("location")
            Dim locationName As String = Request.Form("location_name")
            Dim organizationOid As String = Request.Form("organization")
            Dim organizationName As String = Request.Form("organization_name")
            Dim classOid As String = Request.Form("class_oid")
            Dim className As String = Request.Form("vehicle_class")
            Dim outgoingUserName As String = Request.Form("outgoing_username")
            Dim outgoingServerName As String = Request.Form("outgoing_servername")
            Dim outgoingServerPort As String = Request.Form("outgoing_serverport")
            Dim outgoingPassword As String = Request.Form("outgoing_password")
            Dim emailAddress As String = Request.Form("email_address")
            Dim webQuoteEmailAddress As String = Request.Form("web_quote_email_address")
            Dim primaryPhone As String = Request.Form("primary_phone")
            Dim webEventPriceForPickUp As String = Request.Form("web_event_price_for_pick_up")
            Dim webEventPriceForDelivered As String = Request.Form("web_event_price_for_delivered")
            Dim webEventPriceForDelivered2 As String = Request.Form("web_event_price_for_delivered2")
            Dim estimateOutput As String = Request.Form("estimate_output")
            Dim cleaningOutput As String = Request.Form("cleaning_output")
            Dim prepOutput As String = Request.Form("prep_output")
            Dim addEquipmentOutput As String = Request.Form("add_equipment_output")
            Dim totalOutput As String = Request.Form("total_output")
            Dim depositOutput As String = Request.Form("deposit_output")
            Dim hourOutput As String = Request.Form("hour_output")
            Dim mileOutput As String = Request.Form("mile_output")

            ' input data
            Dim firstName As String = Request.Form("first_name")
            Dim lastName As String = Request.Form("last_name")
            Dim email As String = Request.Form("email")
            Dim phoneNo As String = Request.Form("phone_no")
            Dim departureDate As String = Request.Form("departure_date")
            Dim returnDate As String = Request.Form("return_date")
            Dim totalAdults As String = Request.Form("total_adults")
            Dim totalKids As String = Request.Form("total_kids")
            Dim message As String = Request.Form("message")

            Dim equipments As String = Request.Form("equipment_oid")
            Dim fees As String = Request.Form("fee_oid")

            Dim model As QuoteModel = New QuoteModel()
            model.Oid = Guid.NewGuid()
            model.Destination = Nothing
            model.Distance = Nothing
            model.LeaveOn = departureDate
            model.ReturnOn = returnDate
            model.FirstName = firstName
            model.LastName = lastName
            model.Name = firstName + " " + lastName
            model.Address = Nothing
            model.City = Nothing
            model.State = Nothing
            model.Zip = Nothing
            model.MobilePhonePrimary = phoneNo
            model.HomePhoneSecondary = Nothing
            model.EmailAddress = email
            model.LeadSource = Nothing
            model.Adults = totalAdults
            model.Children = totalKids
            model.LocationInsuranceCompanyOidsAndNames = Nothing
            model.WebUserSelectedCountry = Nothing
            model.EquipmentTypeOids = equipments
            model.FeeOids = fees
            Dim comment As String = "No Comment"
            If Not String.IsNullOrEmpty(message) Then
                comment = message
            End If
            If Session.Item("OptionalParam") IsNot Nothing Then
                model.WebUserComments = comment + Chr(10) + Chr(13) + Session.Item("OptionalParam")
            Else
                model.WebUserComments = comment
            End If

            Dim pickUp As String = Nothing
            Dim delivery As String = Nothing
            Dim delivery2 As String = Nothing
            If webEventPriceForPickUp IsNot Nothing Then
                pickUp = "WebEventPriceForPickedUp - " + webEventPriceForPickUp
            End If
            If webEventPriceForDelivered IsNot Nothing Then
                delivery = " WebEventPriceForDelivered - " + webEventPriceForDelivered
            End If
            If webEventPriceForDelivered2 IsNot Nothing Then
                delivery2 = " WebEventPriceForDelivered2 - " + webEventPriceForDelivered2
            End If
            model.Comments = pickUp + delivery + delivery2

            model.VehicleId = vehicleOid
            model.VehicleName = vehicleName
            model.ClassOid = classOid
            model.WebUserSelectedClass = className
            model.Location = locationOid
            model.LocationName = locationName
            model.Organization = organizationOid
            model.OrganizationName = organizationName

            Dim jsonData As String = JsonConvert.SerializeObject(model, Formatting.Indented)
            Dim byteData() As Byte = Encoding.UTF8.GetBytes(jsonData)
            Dim baseUrl As String = ConfigurationManager.AppSettings("RMXWebService")
            Dim req As WebRequest = WebRequest.Create(baseUrl + "quote/")
            req.Method = "POST"
            req.ContentType = "application/json; charset=UTF-8"
            req.ContentLength = byteData.Length
            Dim stream = req.GetRequestStream()
            stream.Write(byteData, 0, byteData.Length)
            stream.Close()
            Dim responseStream As Stream = Nothing
            Try
                responseStream = req.GetResponse().GetResponseStream()
            Catch ex As Exception
                responseStream = Nothing
            End Try
            If responseStream IsNot Nothing Then
                Dim reader As New StreamReader(responseStream)
                Dim res = reader.ReadToEnd()
                reader.Close()
                responseStream.Close()
                Dim success As Boolean = SendEmailToWebUser(firstName, outgoingUserName, outgoingServerName, outgoingServerPort, outgoingPassword, emailAddress, email, locationName, organizationName, primaryPhone)
                If success = True Then
                    Dim stickyDataOrEventPriceData As String = Nothing
                    If _modeContent Then
                        stickyDataOrEventPriceData = pickUp + "<br />" + delivery + "<br />" + delivery2 + "<br />"
                    Else
                        stickyDataOrEventPriceData = estimateOutput + "<br />" + cleaningOutput + "<br />" + prepOutput + "<br />" + addEquipmentOutput + "<br />" +
                            totalOutput + "<br />" + depositOutput + "<br />" + hourOutput + "<br />" + mileOutput + "<br />"
                    End If
                    SendEmailToRentalAgent(model, outgoingUserName, outgoingServerName, outgoingServerPort, outgoingPassword, emailAddress, webQuoteEmailAddress, comment, stickyDataOrEventPriceData)
                    If Session.Item("OptionalParam") IsNot Nothing Then
                        Response.Redirect("Result.aspx?success=1&" + Session.Item("OptionalParam"))
                    Else
                        Response.Redirect("Result.aspx?success=1")
                    End If
                Else
                    If Session.Item("OptionalParam") IsNot Nothing Then
                        Response.Redirect("Result.aspx?success=0&" + Session.Item("OptionalParam"))
                    Else
                        Response.Redirect("Result.aspx?success=0")
                    End If
                End If
            Else
                If Session.Item("OptionalParam") IsNot Nothing Then
                    Response.Redirect("Result.aspx?success=-1&" + Session.Item("OptionalParam"))
                Else
                    Response.Redirect("Result.aspx?success=-1")
                End If
            End If
        End If
        GetDetailInfo(seq, key, _dir.Name)
    End Sub

    Private Function SendEmailToRentalAgent(model As QuoteModel, userName As String, serverName As String, serverPort As String, password As String, fromEmail As String, toEmail As String, message As String, detailDescription As String)
        Dim pathName As String = model.LocationName
        If Session.Item("OptionalParam") IsNot Nothing Then
            pathName = _dir.Name
        End If
        Dim subject As String = model.FirstName + " " + model.LastName + "'s rental request from our affiliate " + pathName
        Dim adults As String = "No"
        If Not String.IsNullOrEmpty(model.Adults) Then
            adults = model.Adults
        End If
        Dim children As String = "No"
        If Not String.IsNullOrEmpty(model.Children) Then
            children = model.Children
        End If

        Dim body As String = "First Name: " + model.FirstName + "<br />Last Name: " + model.LastName + "<br />Email Address: " + model.EmailAddress + "<br />Phone Number: " +
            model.MobilePhonePrimary + "<br />Leave On: " + model.LeaveOn + "<br />Return On: " + model.ReturnOn + "<br />Adults: " + adults + "<br />Children: " +
            children + "<br />Message:<br />" + message + "<br />Form Data:<br />" + detailDescription

        Dim status As Boolean = DoEmail(serverName, userName, password, serverPort, fromEmail, toEmail, subject, body)
        Return status
    End Function

    Private Function SendEmailToWebUser(firstName As String, userName As String, serverName As String, serverPort As String, password As String, fromEmail As String, toEmail As String, locationName As String, organizationName As String, primaryPhone As String) As Boolean
        Dim subject As String = "Thank you for submitting a quote to " + locationName
        Dim body As String = "Dear " + firstName + "<br />This email has been automatically generated and we thank you for the request.<br />" +
            "Expect a quote via email or a call from our staff.<br />If you require immediate attention please call our office at: " +
            primaryPhone + "<br />- All of our coaches are set up with the housewares and needed necessities to operate the RV. " +
            "This is done at no charge to the renter as our way of keeping your total cost as low as possible.<br />" +
            "- We offer the most, free miles and generator use and we never charge for early pick ups or late returns.<br />" +
            "- Insurance covering you and the coach will normally be free or almost free with your auto policy. We can assist you in setting this up.<br />- At " +
            organizationName + " we're as excited as you are about your upcoming trip and look forward to being your RV connection.<br />Staff,<br />" + organizationName

        Dim status As Boolean = DoEmail(serverName, userName, password, serverPort, fromEmail, toEmail, subject, body)
        Return status
    End Function

    Private Function DoEmail(server As String, user As String, password As String, port As String, fromEmail As String, toEmail As String, subject As String, body As String) As Boolean
        Dim client As New SmtpClient(server)
        client.Port = 587
        client.EnableSsl = True
        client.UseDefaultCredentials = False
        client.Credentials = New NetworkCredential(user, password)

        Dim message As New MailMessage(fromEmail, toEmail)
        message.Subject = subject
        message.Body = body
        message.IsBodyHtml = True
        message.BodyEncoding = Encoding.UTF8

        ServicePointManager.ServerCertificateValidationCallback = Function(se As Object, cert As X509Certificate, chain As X509Chain, sslerror As SslPolicyErrors) True
        client.DeliveryMethod = SmtpDeliveryMethod.Network
        message.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure
        Dim oldSecurityProtocol As SecurityProtocolType = ServicePointManager.SecurityProtocol
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls

        Try
            client.Send(message)
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Private Sub GetDetailInfo(seq As Long, key As String, dirName As String)
        Dim client As WebAPI2Client = New WebAPI2Client()
        Dim token As String = GetTokenParameter()

        Dim detailModel As VehicleDetailViewModel = client.GetDetail(key, seq, token)
        Dim locationOid As Guid = detailModel.Location
        Dim serviceModel As ServiceListViewModel = client.GetAllServiceList(locationOid, dirName, token)

        _detailModel = detailModel
        _serviceModel = serviceModel

        Dim equipments As List(Of EquipmentTypeModel) = serviceModel.EquipmentTypeList
        Dim fees As List(Of FeeModel) = serviceModel.FeeList
        If equipments Is Nothing And fees Is Nothing Then
            equipmentModel = Nothing
        Else
            Dim list = New List(Of SortAddEquipmentModel)
            For Each equipment As EquipmentTypeModel In equipments
                Dim equipRecord As SortAddEquipmentModel = New SortAddEquipmentModel()

                equipRecord.WebPrice = equipment.WebPrice
                equipRecord.Oid = equipment.Oid
                equipRecord.Name = equipment.Name
                equipRecord.IsEquipmentType = True
                list.Add(equipRecord)
            Next
            For Each fee As FeeModel In fees
                Dim feeRecord As SortAddEquipmentModel = New SortAddEquipmentModel()
                feeRecord.Oid = fee.Oid
                feeRecord.Name = fee.Name
                feeRecord.WebPrice = fee.WebPrice
                feeRecord.IsEquipmentType = False
                list.Add(feeRecord)
            Next
            equipmentModel = list
        End If
    End Sub

    Private Function GetTokenParameter() As String
        Dim receiver As TokenReceiver = New TokenReceiver()
        Dim token = receiver.GetRMXToken()
        Return token
    End Function

    Private Function GetGuidList(str As String) As List(Of Guid?)
        If String.IsNullOrEmpty(str) = True Then
            Return Nothing
        End If
        Dim stringOfGuid As List(Of String) = str.Split(",").ToList()
        Dim listOfGuid As List(Of Guid?) = New List(Of Guid?)
        For Each item As String In stringOfGuid
            listOfGuid.Add(New Guid(item))
        Next
        Return listOfGuid
    End Function
End Class