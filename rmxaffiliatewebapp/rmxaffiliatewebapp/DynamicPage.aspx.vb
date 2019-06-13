Imports System.IO
Imports rmxaffiliatewebapp

Public Class DynamicPage
    Inherits Page
    Protected _listOfClass As IEnumerable(Of FeaturedVehicleViewModel)
    Protected _locationInfo As LocationModel
    Protected _eventPath As String = "~/UserData/Content/Default.com/Event.html"
    Protected _locationContent As String = String.Empty
    Protected _modeContent As Boolean = False
    Protected _pageName As String
    Protected _optionalParam As String = String.Empty
    Protected _dirName As String = String.Empty
    Protected _hamburgerMenu As Boolean = False
    Protected _pathOfContentFile As String = String.Empty

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim master As SiteMaster = TryCast(Me.Master, SiteMaster)
        Dim dir As DirectoryInfo = master._targetDir
        _eventPath = "~/UserData/Content/" + dir.Name + "/Event.html"
        _optionalParam = master._kingOfHammerParam

        _locationContent = master.GetLocationContent(dir)
        _modeContent = master.GetModeContent(dir)
        _locationInfo = master._location
        _dirName = dir.Name

        Dim page As String = Me.Page.RouteData.Values("PageName").ToString()
        _pageName = page.Split(".aspx").FirstOrDefault().ToString()
        Dim listOfClass As List(Of FeaturedVehicleViewModel) = GetClassList(_pageName, master)

        If listOfClass Is Nothing Then
            goHamburgerMenu(master._rootPath, dir.Name, _pageName)
            _hamburgerMenu = True
        Else
            goClassNameMenu(listOfClass)
            _hamburgerMenu = False
        End If
    End Sub

    Private Sub goHamburgerMenu(rootPath As String, siteName As String, pageName As String)
        Dim selectedPath As DirectoryInfo = New DirectoryInfo(rootPath + "UserData\Content\" + siteName + "\pages\" + pageName)
        Dim file As FileInfo = selectedPath.GetFiles("*.html").FirstOrDefault()
        _pathOfContentFile = "~/UserData/Content/" + siteName + "/pages/" + pageName + "/" + file.Name
    End Sub

    Private Sub goClassNameMenu(listOfClass As List(Of FeaturedVehicleViewModel))
        If listOfClass.Count < 1 Then
            _listOfClass = Nothing
        Else
            _listOfClass = listOfClass
        End If
    End Sub

    Private Function GetClassList(pageName As String, master As SiteMaster) As List(Of FeaturedVehicleViewModel)
        Dim baseClass As Integer = 0
        Select Case pageName
            Case "Class A"
                baseClass = 1
            Case "Class B"
                baseClass = 2
            Case "Class C"
                baseClass = 3
            Case "Class CT"
                baseClass = 4
            Case "Class FW"
                baseClass = 5
            Case "Class PU"
                baseClass = 6
            Case "Class TH"
                baseClass = 7
            Case "Class TT"
                baseClass = 8
            Case "Class UT"
                baseClass = 9
        End Select

        If baseClass = 0 Then
            Return Nothing
        End If

        Dim list As List(Of FeaturedVehicleViewModel) = SaveClassList(master, baseClass)
        Return list
    End Function

    Private Function SaveClassList(master As SiteMaster, baseClass As Integer) As List(Of FeaturedVehicleViewModel)
        Dim oids As List(Of VehicleClassModel) = master._classes.FirstOrDefault(Function(x) x.BaseClass = baseClass).Classes
        Dim list As List(Of FeaturedVehicleViewModel) = New List(Of FeaturedVehicleViewModel)
        Dim rvs As IEnumerable(Of FeaturedVehicleViewModel) = master._rvs
        If rvs IsNot Nothing Then
            For Each item As VehicleClassModel In oids
                Dim featuredRVs As List(Of FeaturedVehicleViewModel) = master._rvs.Where(Function(x) x.VehicleClass = item.Oid).ToList()
                list.AddRange(featuredRVs)
            Next
            Return list
        End If
        Return list
    End Function
End Class