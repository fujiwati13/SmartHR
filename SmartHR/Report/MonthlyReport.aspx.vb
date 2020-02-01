Imports System.Data.SqlClient

Public Class MonthlyReport
    Inherits System.Web.UI.Page
    Protected Property LoginID() As String
        Get
            Return DirectCast(ViewState("LoginID"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("LoginID") = Value
        End Set
    End Property
    Protected Property ListData() As DataTable
        Get
            Return DirectCast(ViewState("ListData"), DataTable)
        End Get
        Set(ByVal Value As DataTable)
            ViewState("ListData") = Value
        End Set
    End Property
    Dim constr As String = System.Configuration.ConfigurationManager.AppSettings("constr")
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Me.LoginID = Session("EmployeeID")
            GetEmployee()
            If Session("Role") = "User" Then
                ddlEmployee.SelectedValue = Session("EmployeeID")
                ddlEmployee.Enabled = False
            Else
                ddlEmployee.SelectedValue = "All"
                ddlEmployee.Enabled = True
            End If
        End If
    End Sub
    Protected Shared Function ConvertDate2(ByVal pStrValue As String) As Date
        Dim lStrValue As String = Trim(CStr(pStrValue))
        Dim lArrValue As Array
        lArrValue = CType(lStrValue.Split(CChar("/")), Array)
        If UBound(lArrValue) = 2 Then
            lArrValue.SetValue(Right(CStr("0" + lArrValue.GetValue(0).ToString), 2), 0)
            lArrValue.SetValue(Right(CStr("0" + lArrValue.GetValue(1).ToString), 2), 1)
            If Len(lArrValue.GetValue(2)) = 2 Then
                lArrValue.SetValue(Left(CStr(Year(Now())), 2) + lArrValue.GetValue(2).ToString, 2)
            End If
            lStrValue = lArrValue.GetValue(1).ToString & "/" & lArrValue.GetValue(0).ToString & "/" & lArrValue.GetValue(2).ToString
        End If
        Return CDate(lStrValue)
    End Function
    Protected Sub btnPrint_Click(sender As Object, e As EventArgs)

        Dim cookie As HttpCookie = Request.Cookies("MonthlyReport")
        If Not cookie Is Nothing Then
            cookie.Values("ReportType") = ddlReportType.SelectedValue
            cookie.Values("EmployeeName") = ddlEmployee.SelectedItem.ToString
            cookie.Values("DateFrom") = Format(ConvertDate2(txtDateFrom.Text), "yyyyMMdd")
            cookie.Values("DateTo") = Format(ConvertDate2(txtDateTo.Text), "yyyyMMdd")
            Response.AppendCookie(cookie)
        Else
            Dim cookieNew As New HttpCookie("MonthlyReport")
            cookieNew.Values.Add("ReportType", ddlReportType.SelectedValue)
            cookieNew.Values.Add("EmployeeName", ddlEmployee.SelectedItem.ToString)
            cookieNew.Values.Add("DateFrom", Format(ConvertDate2(txtDateFrom.Text), "yyyyMMdd"))
            cookieNew.Values.Add("DateTo", Format(ConvertDate2(txtDateTo.Text), "yyyyMMdd"))
            Response.AppendCookie(cookieNew)
        End If
        If Not (Me.Cache.Item(Me.Session.SessionID + Me.LoginID + "MonthlyReport" + ddlReportType.SelectedItem.Value.Trim)) Is Nothing Then
            Me.Cache.Remove(Me.Session.SessionID + Me.LoginID + "MonthlyReport" + ddlReportType.SelectedItem.Value.Trim)
        End If
        Response.Redirect("ReportViewer.aspx")
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        Response.Redirect("MonthlyReport.aspx")
    End Sub
    Protected Sub GetEmployee()
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetEmployee")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData


                    With ddlEmployee
                        .DataSource = dtEntity.DefaultView
                        .DataTextField = "EmployeeName"
                        .DataValueField = "EmployeeID"
                        .DataBind()
                        .Items.Insert(0, "All")
                        .Items(0).Value = "All"
                    End With
                End Using
            End Using
        End Using
    End Sub
End Class