Imports System.IO
Imports System.Net
Imports Newtonsoft.Json
Imports System.IO.Compression
Imports System.IO.IsolatedStorage
Imports System.IO.MemoryMappedFiles
Imports System.Net.Cache
Imports System.Net.Configuration

Public Class TokenReceiver
    Protected _TOKEN_SERVICE_PATH As String = "http://localhost:2124/api/"

    Public Function GetRMXToken() As String
        'Dim resp As String = GetResponseFromWebAPI("values")
        'Dim result As String = JsonConvert.DeserializeObject(Of String)(resp)

        Dim result As String = "AIzaSyAJSErr4vFLsOoylqQYkfQLKM26lnsHLXY"
        Return result
    End Function

    Private Function GetResponseFromWebAPI(method As String) As String
        If String.IsNullOrEmpty(method) Then
            Return Nothing
        End If

        Dim request As WebRequest = WebRequest.Create(_TOKEN_SERVICE_PATH + method)
        request.Credentials = CredentialCache.DefaultCredentials
        Dim response As WebResponse = request.GetResponse()
        If response Is Nothing Then
            Return Nothing
        End If

        Dim dataStream As Stream = response.GetResponseStream()
        Dim reader As New StreamReader(dataStream)
        Dim responseFromServer As String = reader.ReadToEnd()
        reader.Close()
        response.Close()
        Return responseFromServer
    End Function
End Class
