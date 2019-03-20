Imports System.IO

Public Class About
    Inherits Page
    Protected _pathUrl As String = "~/UserData/Content/Default.com/AboutUs.html"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim master As SiteMaster = TryCast(Me.Master, SiteMaster)
        Dim dir As DirectoryInfo = master._targetDir
        _pathUrl = "~/UserData/Content/" + dir.Name + "/AboutUs.html"
    End Sub
End Class