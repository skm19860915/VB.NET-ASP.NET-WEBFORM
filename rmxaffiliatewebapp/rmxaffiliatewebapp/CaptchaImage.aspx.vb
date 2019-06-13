Imports System.Drawing
Imports System.Drawing.Imaging
Imports SRVTextToImage
Public Class CaptchaImage
    Inherits Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim ci As CaptchaRandomImage = New CaptchaRandomImage()
        Dim captchaText As String = ci.GetRandomString(5)
        Session("CaptchaText") = captchaText
        ci.GenerateImage(captchaText, 175, 80, Color.DarkBlue, Color.White)

        Response.Clear()
        Response.ContentType = "image/jpeg"
        ci.Image.Save(Response.OutputStream, ImageFormat.Jpeg)
        ci.Dispose()
    End Sub
End Class