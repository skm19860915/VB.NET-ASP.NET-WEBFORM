Public Class VehicleDetailViewModel
    ' Vehicle
    Public Property Oid() As Guid
    Public Property QuickFindKeyWord As String
    Public Property Location As Guid?
    Public Property LocationName As String
    Public Property VehicleClass As Guid?
    Public Property NameOnWeb As String
    Public Property DailyRate As String
    Public Property YouTubeID As String
    Public Property NoTowing As Boolean?
    Public Property Belts As Integer?
    Public Property Length As Integer?
    Public Property NoDogs As Boolean?
    Public Property FuelType As Integer?
    Public Property Model As String
    Public Property SmokingAllowed As Boolean?
    Public Property Make As String
    Public Property Year As String
    Public Property Children As Integer?
    Public Property Adolescents As Integer?
    Public Property Adults As Integer?
    Public Property WebDescription As String
    Public Property OtherCostsDesc As String
    Public Property VehicleSequenceId As Long?
    Public Property WebPrepFee As Decimal?
    Public Property WebCleaningFee As Decimal?
    Public Property WebRefundableSecurityDeposit As Decimal?
    Public Property WebGeneratorFreeHours As Integer?
    Public Property WebIncludesTheseMilesFreePerDay As Integer?
    Public Property HigherRate As Decimal?
    Public Property WebEventPriceForPickedUp() As Decimal?
    Public Property WebEventPriceForDelivered() As Decimal?
    Public Property WebEventPriceForDelivered2() As Decimal?
    Public Property WebEventDescription() As String
    ' location
    Public Property isShowCalendarOnWeb As Boolean?
    Public Property IsCalendarWithBookings As Boolean?
    Public Property PrimaryPhone As String
    Public Property DBAName As String
    Public Property Address As String
    Public Property City As String
    Public Property State As String
    Public Property Zip As String
    Public Property Longitude As Double?
    Public Property Latitude As Double?
    Public Property WebGoogleMapJavaScriptAPIKey As String
    Public Property IsLocationBehindOnPaying As Boolean?
    Public Property LocationSequenceId As Long?
    Public Property Organization As Guid?
    Public Property OrganizationName As String
    Public Property OutgoingUserName As String
    Public Property OutgoingServerName As String
    Public Property OutgoingServerPort As Integer?
    Public Property OutgoingPassword As String
    Public Property EmailAddress As String
    Public Property MinimumNumberOfTimeInterval As Integer?
    Public Property CalcByNights As Boolean?
    Public Property WebQuoteEmailAddress As String
    ' vehicleclass
    Public Property ClassOid As Guid
    Public Property ClassName As String
    Public Property ClassType As Integer?
    ' media list
    Public Property MediaList As List(Of VehicleMediaItemModel)
    ' amenity list
    Public Property AmenityList As List(Of AmenityViewModel)
End Class
