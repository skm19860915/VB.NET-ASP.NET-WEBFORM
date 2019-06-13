Imports System.IO
Imports Microsoft.AspNet.Identity

Public Class SiteMaster
    Inherits MasterPage
    Private Const AntiXsrfTokenKey As String = "__AntiXsrfToken"
    Private Const AntiXsrfUserNameKey As String = "__AntiXsrfUserName"
    Private _antiXsrfTokenValue As String
    Protected _headerPath As String
    Public _footerPath As String
    Protected _hostName As String = HttpContext.Current.Request.Url.Host
    Public _rootPath As String = HttpContext.Current.Server.MapPath("~")
    Public _classes As List(Of BaseClassViewModel)
    Public _targetDir As DirectoryInfo
    Public _location As LocationModel
    Public _rvs As IEnumerable(Of FeaturedVehicleViewModel)
    Public _kingOfHammerParam As String = String.Empty
    Public _hamburgerMenuItems As List(Of HamburgerMenuItemViewModel)

    Protected Sub Page_Init(sender As Object, e As EventArgs)
        Dim requestCookie = Request.Cookies(AntiXsrfTokenKey)
        Dim requestCookieGuidValue As Guid
        If requestCookie IsNot Nothing AndAlso Guid.TryParse(requestCookie.Value, requestCookieGuidValue) Then
            _antiXsrfTokenValue = requestCookie.Value
            Page.ViewStateUserKey = _antiXsrfTokenValue
        Else
            _antiXsrfTokenValue = Guid.NewGuid().ToString("N")
            Page.ViewStateUserKey = _antiXsrfTokenValue

            Dim responseCookie = New HttpCookie(AntiXsrfTokenKey) With {
                 .HttpOnly = True,
                 .Value = _antiXsrfTokenValue
            }
            If FormsAuthentication.RequireSSL AndAlso Request.IsSecureConnection Then
                responseCookie.Secure = True
            End If
            Response.Cookies.[Set](responseCookie)
        End If

        Dim dir As DirectoryInfo = GetTargetDirectory()
        Dim client As WebAPI2Client = New WebAPI2Client()
        _targetDir = dir

        GetHeaderAndFooterContent(dir)

        Dim sequenceId As Integer = GetLocationSequenceId(dir)

        Dim token As String = GetTokenParameter()

        Dim location As LocationModel = GetLocationInfoFromWebApi(sequenceId, client, token)
        Dim rvs As IEnumerable(Of FeaturedVehicleViewModel) = GetFeaturedRVsFromWebApi(sequenceId, client, token)
        Dim classes As List(Of BaseClassViewModel) = GetClassesFromWebApi(rvs, client, token)
        _location = location
        _rvs = rvs
        _classes = classes
        If Page.ClientQueryString.ToLower().Contains("ls=koh") Then
            _kingOfHammerParam = "LS=KOH"
            Session("OptionalParam") = _kingOfHammerParam
        End If

        _hamburgerMenuItems = GetDynamicHamburgerMenuItems(dir)

        AddHandler Page.PreLoad, AddressOf master_Page_PreLoad
    End Sub

    Private Function GetDynamicHamburgerMenuItems(dir As DirectoryInfo) As List(Of HamburgerMenuItemViewModel)
        If dir Is Nothing Then
            Return Nothing
        End If

        Dim subDirs As IEnumerable(Of DirectoryInfo) = dir.GetDirectories()
        If subDirs Is Nothing Or subDirs.Count() = 0 Then
            Return Nothing
        End If

        Dim pageDir As DirectoryInfo = subDirs.FirstOrDefault(Function(x) x.Name.Equals("pages"))
        If pageDir Is Nothing Then
            Return Nothing
        End If

        Dim contentDirs As IEnumerable(Of DirectoryInfo) = pageDir.GetDirectories()
        If contentDirs Is Nothing Or contentDirs.Count() = 0 Then
            Return Nothing
        End If

        Dim list As List(Of HamburgerMenuItemViewModel) = New List(Of HamburgerMenuItemViewModel)
        For Each contentDir As DirectoryInfo In contentDirs
            Dim files As FileInfo() = contentDir.GetFiles("*.html")
            If files Is Nothing Or files.Count = 0 Then
                Continue For
            End If
            Dim record As HamburgerMenuItemViewModel = New HamburgerMenuItemViewModel()
            Dim fileName As String = Path.GetFileNameWithoutExtension(files.FirstOrDefault().Name)
            Dim dirName As String = contentDir.Name
            record.PageName = dirName + ".aspx"
            record.TitleName = GetTitleName(fileName)
            list.Add(record)
        Next

        Return list
    End Function

    Private Function GetTitleName(fileName As String) As String
        Dim title As String = String.Empty
        Dim nodes As String() = fileName.Split("_")
        For Each node As String In nodes
            title += node + " "
        Next
        Return title.TrimEnd(" ")
    End Function

    Private Function GetTokenParameter() As String
        Dim receiver As TokenReceiver = New TokenReceiver()
        Dim token = receiver.GetRMXToken()
        Return token
    End Function

    Private Sub GetHeaderAndFooterContent(dir As DirectoryInfo)
        _headerPath = "~/UserData/Content/" + dir.Name + "/Header.html"
        If dir.Name.Equals("Default.com") Then
            _footerPath = "rmxaffiliatewebapp.azurewebsites.net"
        Else
            _footerPath = dir.Name
        End If
    End Sub

    Protected Sub master_Page_PreLoad(sender As Object, e As EventArgs)
        If Not IsPostBack Then
            ViewState(AntiXsrfTokenKey) = Page.ViewStateUserKey
            ViewState(AntiXsrfUserNameKey) = If(Context.User.Identity.Name, String.Empty)
        Else
            If DirectCast(ViewState(AntiXsrfTokenKey), String) <> _antiXsrfTokenValue OrElse DirectCast(ViewState(AntiXsrfUserNameKey), String) <> (If(Context.User.Identity.Name, String.Empty)) Then
                Throw New InvalidOperationException("Validation of Anti-XSRF token failed.")
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Unnamed_LoggingOut(sender As Object, e As LoginCancelEventArgs)
        Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie)
    End Sub

    Public Function GetTargetDirectory() As DirectoryInfo
        Dim dirs As IEnumerable(Of DirectoryInfo) = New DirectoryInfo(_rootPath + "UserData\Content").GetDirectories()
        Dim dir As DirectoryInfo = dirs.FirstOrDefault(Function(x) x.Name.Equals("Default.com"))
        For Each item As DirectoryInfo In dirs
            If item.Name.ToLower().Equals(_hostName) Then
                dir = item
                Exit For
            End If
        Next
        Return dir
    End Function

    Private Function GetContentFromFile(dir As DirectoryInfo, fileName As String) As String
        Dim content As String = Nothing
        Dim file As FileInfo = dir.GetFiles("*.txt").FirstOrDefault(Function(x) x.Name.Equals(fileName))
        If file Is Nothing Then
            Return "-1"
        End If
        Dim st As StreamReader = file.OpenText()
        While st.EndOfStream = False
            content = st.ReadLine()
        End While
        st.Close()
        Return content
    End Function

    Public Function GetLocationContent(dir As DirectoryInfo) As String
        Dim locationContent As String = GetContentFromFile(dir, "LocationSequenceID.txt")
        Return locationContent
    End Function

    Public Function GetModeContent(dir As DirectoryInfo) As Boolean
        Dim modeContent As String = GetContentFromFile(dir, "mode.txt")
        If modeContent Is Nothing Then
            Return False
        End If
        If modeContent.Equals("Event") Then
            Return True
        End If
        Return False
    End Function

    Private Function GetLocationSequenceId(dir As DirectoryInfo) As Integer
        Dim locationContent As String = GetLocationContent(dir)
        If locationContent Is Nothing Then
            Return -1
        End If
        Return Convert.ToInt32(locationContent)
    End Function

    Private Function GetFeaturedRVsFromWebApi(id As Integer, client As WebAPI2Client, token As String) As IEnumerable(Of FeaturedVehicleViewModel)
        Dim rvs As IEnumerable(Of FeaturedVehicleViewModel) = Nothing
        If id = -1 Then
            Return Nothing
        Else
            rvs = client.GetAllFeaturedVehicles(id, token)
            If rvs Is Nothing Then
                Return Nothing
            End If
            Dim filterRVS As IEnumerable(Of FeaturedVehicleViewModel) = rvs.Where(Function(x) Not String.IsNullOrEmpty(x.VehicleKey))
            If filterRVS Is Nothing Then
                Return Nothing
            End If
            Return filterRVS
        End If
        Return Nothing
    End Function

    Private Function GetLocationInfoFromWebApi(id As Integer, client As WebAPI2Client, token As String) As LocationModel
        If id = -1 Then
            Return Nothing
        Else
            Dim locations As IEnumerable(Of LocationModel) = client.GetAllLocations(token)
            If locations Is Nothing Then
                Return Nothing
            End If
            Dim location As LocationModel = locations.FirstOrDefault(Function(x) x.SequenceId = id)
            Return location
        End If
    End Function

    Private Function GetClassesFromWebApi(rvs As IEnumerable(Of FeaturedVehicleViewModel), client As WebAPI2Client, token As String) As List(Of BaseClassViewModel)
        Dim classes As List(Of BaseClassViewModel) = Nothing
        Dim vehicles As IEnumerable(Of FeaturedVehicleViewModel) = Nothing
        classes = client.GetAllClassInfos(token)
        vehicles = rvs
        If vehicles Is Nothing Then
            Return classes
        Else
            Dim result As List(Of BaseClassViewModel) = New List(Of BaseClassViewModel)

            For Each bc As BaseClassViewModel In classes
                Dim showOnClasses As List(Of VehicleClassModel) = New List(Of VehicleClassModel)
                For Each c As VehicleClassModel In bc.Classes
                    Dim count As Integer = vehicles.Where(Function(x) x.VehicleClass = c.Oid).Count()
                    If count > 0 Then
                        showOnClasses.Add(c)
                    End If
                Next
                If showOnClasses.Count() > 0 Then
                    Dim record As BaseClassViewModel = New BaseClassViewModel()
                    record.BaseClass = bc.BaseClass
                    record.Classes = showOnClasses
                    result.Add(record)
                End If
            Next
            Return result
        End If
    End Function
End Class