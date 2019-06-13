Public Class Result
    Inherits Page
    Protected _success As Integer
    Protected _primaryPhone As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim master As SiteMaster = TryCast(Me.Master, SiteMaster)
        _primaryPhone = master._location.PrimaryPhone
        Dim status As String = Request.QueryString("success")
        _success = Convert.ToInt32(status)
    End Sub
End Class