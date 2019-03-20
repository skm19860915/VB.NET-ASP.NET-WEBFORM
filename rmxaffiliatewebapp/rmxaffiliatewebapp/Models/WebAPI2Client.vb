Imports System.IO
Imports System.Net
Imports Newtonsoft.Json

Public Class WebAPI2Client
    Protected _RMX_SERVICE_PATH As String = ConfigurationManager.AppSettings("RMXWebService")

    Public Function GetAllLocations(token As String) As IEnumerable(Of LocationModel)
        Dim resp As String = GetResponseFromWebAPI("location", "?token=" + token)
        If resp Is Nothing Then
            Return Nothing
        End If

        Dim result As IEnumerable(Of LocationModel) = JsonConvert.DeserializeObject(Of IEnumerable(Of LocationModel))(resp)
        Return result
    End Function

    Public Function GetAllFeaturedVehicles(id As Long, token As String) As IEnumerable(Of FeaturedVehicleViewModel)
        Dim resp As String = GetResponseFromWebAPI("featuredvehicle/", id.ToString() + "?token=" + token)
        If resp Is Nothing Then
            Return Nothing
        End If

        Dim result As IEnumerable(Of FeaturedVehicleViewModel) = JsonConvert.DeserializeObject(Of IEnumerable(Of FeaturedVehicleViewModel))(resp)
        Return result
    End Function

    Public Function GetDetail(key As String, seq As Long, token As String) As VehicleDetailViewModel
        Dim resp As String = GetResponseFromWebAPI("detail/", key + "?seq=" + seq.ToString() + "&token=" + token)
        If resp Is Nothing Then
            Return Nothing
        End If

        Dim result As VehicleDetailViewModel = JsonConvert.DeserializeObject(Of VehicleDetailViewModel)(resp)
        Return result
    End Function

    Public Function GetAllServiceList(id As Guid, tag As String, token As String) As ServiceListViewModel
        Dim resp As String = GetResponseFromWebAPI("servicelist/", id.ToString() + "?tag=" + tag + "&token=" + token)
        If resp Is Nothing Then
            Return Nothing
        End If

        Dim result As ServiceListViewModel = JsonConvert.DeserializeObject(Of ServiceListViewModel)(resp)
        Return result
    End Function

    Public Function GetAllClassInfos(token As String) As List(Of BaseClassViewModel)
        Dim resp As String = GetResponseFromWebAPI("vehicleclass", "?token=" + token)
        If resp Is Nothing Then
            Return Nothing
        End If

        Dim result As List(Of BaseClassViewModel) = JsonConvert.DeserializeObject(Of List(Of BaseClassViewModel))(resp)
        Return result
    End Function

    Private Function GetResponseFromWebAPI(method As String, param As String) As String
        Dim request As WebRequest = WebRequest.Create(_RMX_SERVICE_PATH + method + param)
        request.Credentials = CredentialCache.DefaultCredentials
        Dim response As WebResponse = request.GetResponse()
        Dim dataStream As Stream = response.GetResponseStream()
        Dim reader As New StreamReader(dataStream)
        Dim responseFromServer As String = reader.ReadToEnd()
        reader.Close()
        response.Close()
        Return responseFromServer
    End Function
End Class
