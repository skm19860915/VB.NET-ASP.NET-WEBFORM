Imports System.IO

Public Class _Default
    Inherits Page
    Protected _list As IEnumerable(Of FeaturedVehicleViewModel)
    Protected _locationInfo As LocationModel
    Protected _locationContent As String = String.Empty
    Protected _modeContent As Boolean = False
    Protected _listOfClassA As List(Of FeaturedVehicleViewModel)
    Protected _eventPath As String = "~/UserData/Content/Default.com/Event.html"
    Protected _optionalParam As String = String.Empty
    Protected _listOfGallery As List(Of FeaturedVehicleViewModel)
    Protected _dirName As String = String.Empty

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim master As SiteMaster = TryCast(Me.Master, SiteMaster)
        Dim dir As DirectoryInfo = master._targetDir
        _eventPath = "~/UserData/Content/" + dir.Name + "/Event.html"
        _optionalParam = master._kingOfHammerParam
        _dirName = dir.Name

        _locationContent = master.GetLocationContent(dir)
        _modeContent = master.GetModeContent(dir)
        _locationInfo = master._location
        Dim rvs As IEnumerable(Of FeaturedVehicleViewModel) = master._rvs

        GetFeaturedRVList(rvs)
    End Sub

    Private Sub GetFeaturedRVList(list As IEnumerable(Of FeaturedVehicleViewModel))
        If list Is Nothing Then
            _list = Nothing
            _listOfClassA = Nothing
            _listOfGallery = Nothing
            Return
        End If

        _list = list
        _listOfGallery = list.Where(Function(x) x.FeaturedVehicle = True).ToList()
        Dim master As SiteMaster = TryCast(Me.Master, SiteMaster)
        Dim oids As List(Of VehicleClassModel) = master._classes.FirstOrDefault(Function(x) x.BaseClass = 1).Classes
        Dim listOfClassA As List(Of FeaturedVehicleViewModel) = New List(Of FeaturedVehicleViewModel)

        For Each item As VehicleClassModel In oids
            Dim featuredRVs As List(Of FeaturedVehicleViewModel) = list.Where(Function(x) x.VehicleClass = item.Oid).ToList()
            listOfClassA.AddRange(featuredRVs)
        Next
        _listOfClassA = listOfClassA
    End Sub
End Class