Imports System.Drawing
Imports System.IO
Imports System.Net
Imports Newtonsoft.Json

Public Class ContactUs
    Inherits Page
    Protected _locationInfo As LocationModel
    Protected _locationContent As String = String.Empty
    Protected _siteName As String
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim master As SiteMaster = TryCast(Me.Master, SiteMaster)
        Dim dir As DirectoryInfo = master._targetDir

        _siteName = master._footerPath
        _locationInfo = master._location
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        Dim isCaptchaValid As Boolean = False
        If Session("CaptchaText") IsNot Nothing And Session("CaptchaText").ToString() = txtCaptchaText.Text Then
            isCaptchaValid = True
        End If
        If isCaptchaValid = True Then
            Dim name As String = contactName.Text
            Dim phone As String = contactPhone.Text
            Dim email As String = contactEmail.Text
            Dim message As String = contactComment.Text
            Dim location As Guid = _locationInfo.Oid
            Dim postData As ContactModel = New ContactModel()

            postData.Name = name
            postData.Phone = phone
            postData.Email = email
            postData.Comment = message
            postData.Location = location
            postData.Subject = Nothing

            Dim success As Boolean = SendContactInfo(postData)
            If success = True Then
                Response.Redirect("Result.aspx?success=1")
            Else
                Response.Redirect("Result.aspx?success=0")
            End If
        Else
            lblMessage.Text = "Captcha Validation Failed"
            lblMessage.ForeColor = Color.Red
        End If
    End Sub

    Private Function SendContactInfo(data As ContactModel) As Boolean
        Dim json As String = JsonConvert.SerializeObject(data, Formatting.Indented)
        Dim byteData() As Byte = Encoding.UTF8.GetBytes(json)
        Dim baseUrl As String = ConfigurationManager.AppSettings("RMXWebService")
        Dim request As WebRequest = WebRequest.Create(baseUrl + "contact/")
        request.Method = "POST"
        request.ContentType = "application/json; charset=UTF-8"
        request.ContentLength = byteData.Length
        Dim stream = request.GetRequestStream()
        stream.Write(byteData, 0, byteData.Length)
        stream.Close()
        Dim response As Stream = Nothing
        Try
            response = request.GetResponse().GetResponseStream()
        Catch ex As Exception
            response = Nothing
        End Try
        If response IsNot Nothing Then
            Return True
        End If
        Return False
    End Function
End Class