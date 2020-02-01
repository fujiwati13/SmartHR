Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data.SqlClient
Imports CrystalDecisions.Web
Imports CrystalDecisions.ReportSource
Public Class MonthlyReportViewer
    Inherits System.Web.UI.Page
#Region "Property"
    Protected Property ReportType() As String
        Get
            Return DirectCast(ViewState("ReportType"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("ReportType") = Value
        End Set
    End Property
    Protected Property EmployeeName() As String
        Get
            Return DirectCast(ViewState("EmployeeName"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("EmployeeName") = Value
        End Set
    End Property
    Protected Property DateFrom() As String
        Get
            Return DirectCast(ViewState("DateFrom"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("DateFrom") = Value
        End Set
    End Property
    Protected Property DateTo() As String
        Get
            Return DirectCast(ViewState("DateTo"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("DateTo") = Value
        End Set
    End Property

#End Region
    Dim constr As String = System.Configuration.ConfigurationManager.AppSettings("constr")
    Private oDocumentReport As New CrystalDecisions.CrystalReports.Engine.ReportDocument
    Dim discrete As ParameterDiscreteValue
    Dim ParamFields As ParameterFields
    Dim ParamField As ParameterFieldDefinition
    Dim CurrentValue As ParameterValues
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Call BindReport()
    End Sub
#Region "Private Sub & Function"
    Private Sub GetCookie()
        Dim cookie As HttpCookie = Request.Cookies("MonthlyReport")
        Me.ReportType = cookie.Values("ReportType")
        Me.EmployeeName = cookie.Values("EmployeeName")
        Me.DateFrom = cookie.Values("DateFrom")
        Me.DateTo = cookie.Values("DateTo")
    End Sub
    Public Sub ReportPath(ByVal oPathReport As String, ByVal oReportName As String)
        Dim _Path As String
        'appPath = MapPath(".")
        _Path = "D:\Project\Kuliah\PPSI\SmartHR\SmartHR\Report\LeaveReport.rpt" 'oPathReport + "\" + oReportName
        oDocumentReport.Load(_Path)
    End Sub
    Sub InsertTwoCollomsToDataTable(ByVal DataTable As DataTable, ByVal NameCol1 As String, ByVal ValueCol1 As String, ByVal NameCol2 As String, ByVal ValueCol2 As String)
        Dim oRow As DataRow
        oRow = DataTable.NewRow()
        oRow(NameCol1.Trim) = ValueCol1.Trim
        oRow(NameCol2.Trim) = ValueCol2.Trim
        DataTable.Rows.Add(oRow)
    End Sub
    Public Sub AddParameter(ByVal oParametersName As String, ByVal oParametersValue As String)
        '----------Parameter---------
        ParamFields = New ParameterFields
        ParamField = oDocumentReport.DataDefinition.ParameterFields(oParametersName)
        discrete = New ParameterDiscreteValue
        discrete.Value = oParametersValue
        CurrentValue = New ParameterValues
        CurrentValue = ParamField.DefaultValues
        CurrentValue.Add(discrete)
        ParamField.ApplyCurrentValues(CurrentValue)
    End Sub
    Public Overloads Sub DataSource(ByVal oDataSet As DataSet)
        Dim oDatatable As DataTable
        oDatatable = oDataSet.Tables(0)
        oDocumentReport.SetDataSource(oDatatable)
    End Sub
    Public Function ReportBind() As CrystalDecisions.CrystalReports.Engine.ReportDocument
        Return oDocumentReport
    End Function
    Private Sub BindReport()
        Dim dsreport As New DataSet
        Dim objectDataTable As New DataTable
        Dim spName As String
        Try
            Call GetCookie()



            Select Case Me.ReportType
                Case "L"
                    spName = "spLeaveReport"
                    ReportPath("Report", "LeaveReport.rpt")
                Case "P"
                    spName = "spARSummaryByPayment"
                    ReportPath("Report", "ARSummaryPRpt.rpt")
            End Select


            With objectDataTable
                .Columns.Add(New DataColumn("Params", GetType(String)))
                .Columns.Add(New DataColumn("ParamsValue", GetType(String)))
            End With


            InsertTwoCollomsToDataTable(objectDataTable, "Params", "@EmployeeName", "ParamsValue", Me.EmployeeName)
            InsertTwoCollomsToDataTable(objectDataTable, "Params", "@DateFrom", "ParamsValue", Me.DateFrom)
            InsertTwoCollomsToDataTable(objectDataTable, "Params", "@DateTo", "ParamsValue", Me.DateTo)


            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("spLeaveReport")
                    cmd.Connection = con
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add(New SqlParameter("@EmployeeName", Me.EmployeeName))
                    cmd.Parameters.Add(New SqlParameter("@DateFrom", Me.DateFrom))
                    cmd.Parameters.Add(New SqlParameter("@DateTo", Me.DateTo))

                    Using sda As New SqlDataAdapter(cmd)
                        Dim dt As New DataSet()
                        sda.Fill(dt)
                        dsreport = dt
                        
                    End Using
                End Using
            End Using




            DataSource(dsreport)

            AddParameter("EmployeeName", Me.EmployeeName)
            AddParameter("DateFrom", Me.DateFrom)
            AddParameter("DateTo", Me.DateTo)
            Dim rpt As LeaveReport
            rpt = New ReportDocument()
            rpt.SetDataSource(dsreport)
            CRVARReport.ReportSource = rpt 'ReportBind()
            CRVARReport.Visible = True
            'CRVARReport.DataBind()

        Catch exp As Exception
            Response.Write(exp.Message)
        Finally
            ' dsreport.Dispose()
        End Try

    End Sub
#End Region
    Protected Sub btnBackReport_Click(sender As Object, e As EventArgs)
        Response.Redirect("MonthlyReport.aspx")
    End Sub
End Class