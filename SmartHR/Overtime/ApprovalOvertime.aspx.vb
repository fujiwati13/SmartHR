Imports System.Configuration
Imports System.Data.SqlClient
Imports EASendMail
Imports System.Data
Public Class ApprovalOvertime
    Inherits System.Web.UI.Page
#Region "PrivateConstanta"
    Private currentPage As Integer = 1
    Private pageSize As Int16 = 10
    Private currentPageNumber As Int32 = 1
    Private totalPages As Double = 1
    Private recordCount As Int64 = 1

    Dim constr As String = System.Configuration.ConfigurationManager.AppSettings("constr")
    Dim EmailFrom As String = System.Configuration.ConfigurationManager.AppSettings("EmailFrom")
    Dim EmailPort As String = System.Configuration.ConfigurationManager.AppSettings("EmailPort")
    Dim EmailUser As String = System.Configuration.ConfigurationManager.AppSettings("EmailUser")
    Dim EmailPassword As String = System.Configuration.ConfigurationManager.AppSettings("EmailPassword")
    Dim EmailSMTP As String = System.Configuration.ConfigurationManager.AppSettings("EmailSMTP")
    Dim dtReason As New DataTable
    Dim flag As Integer = 0
#End Region
#Region "Property"
    Private Property CmdWhere() As String
        Get
            Return DirectCast(ViewState("CmdWhere"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("CmdWhere") = Value
        End Set
    End Property
    Protected Property SearchBy() As String
        Get
            Return DirectCast(ViewState("SearchBy"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("SearchBy") = Value
        End Set
    End Property
    Protected Property SortBy() As String
        Get
            Return DirectCast(ViewState("Sort"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("Sort") = Value
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
    Protected Property ReqNo() As String
        Get
            Return DirectCast(ViewState("ReqNo"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("ReqNo") = Value
        End Set
    End Property
    Protected Property EmployeeID() As String
        Get
            Return DirectCast(ViewState("EmployeeID"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("EmployeeID") = Value
        End Set
    End Property
    Protected Property EmailTo() As String
        Get
            Return DirectCast(ViewState("EmailTo"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("EmailTo") = Value
        End Set
    End Property
    Protected Property Status() As String
        Get
            Return DirectCast(ViewState("Status"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("Status") = Value
        End Set
    End Property
    Protected Property UserRequest() As String
        Get
            Return DirectCast(ViewState("UserRequest"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("UserRequest") = Value
        End Set
    End Property
    Protected Property LoginID() As String
        Get
            Return DirectCast(ViewState("LoginID"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("LoginID") = Value
        End Set
    End Property
    Protected Property UserFinal() As String
        Get
            Return DirectCast(ViewState("UserFinal"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("UserFinal") = Value
        End Set
    End Property
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Role") = "User" Then
            Response.Redirect("Notauthorized.aspx")
            Exit Sub
        End If
        If Not IsPostBack Then
            pnlList.Visible = False
            pnlDetail.Visible = False
            Me.LoginID = Session("EmployeeID")
            trNextApv.Visible = True
        End If
    End Sub
    Protected Sub BindData(ByVal CmdWhere As String)
        Dim dvEntity As DataView
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spPagingApprovalOvertime")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add(New SqlParameter("@CurrentPage", currentPage))
                cmd.Parameters.Add(New SqlParameter("@PageSize", pageSize))
                cmd.Parameters.Add(New SqlParameter("@WhereCond", CmdWhere))
                cmd.Parameters.Add(New SqlParameter("@SortBy", Me.SortBy))
                Dim paramOut As New SqlParameter("@TotalRecords", SqlDbType.Int)
                paramOut.Direction = ParameterDirection.Output
                cmd.Parameters.Add(paramOut)
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData
                    dvEntity = dtEntity.DefaultView
                    dvEntity.Sort = Me.SortBy
                    If dvEntity.Count <= 0 Then
                        lblMessage.Text = "Data Not Found"
                        lblMessage.Visible = True
                    End If

                    dtgList.DataSource = dvEntity
                    If Me.ListData.Rows.Count > 0 Then
                        recordCount = CInt(paramOut.Value)
                    Else
                        recordCount = 0
                    End If
                    Try
                        dtgList.DataBind()
                    Catch
                        dtgList.CurrentPageIndex = 0
                        dtgList.DataBind()
                    End Try
                End Using
            End Using
        End Using

        PagingFooter()
    End Sub
    Protected Sub BindDataOvertimeDetail(ByVal ReqOvertimeNo As String)
        Dim dvEntity As DataView
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spPagingOvertimeDetail")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add(New SqlParameter("@CurrentPage", currentPage))
                cmd.Parameters.Add(New SqlParameter("@PageSize", pageSize))
                cmd.Parameters.Add(New SqlParameter("@WhereCond", ReqOvertimeNo))
                cmd.Parameters.Add(New SqlParameter("@SortBy", Me.SortBy))
                Dim paramOut As New SqlParameter("@TotalRecords", SqlDbType.Int)
                paramOut.Direction = ParameterDirection.Output
                cmd.Parameters.Add(paramOut)
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData
                    dvEntity = dtEntity.DefaultView
                    dvEntity.Sort = Me.SortBy
                    If dvEntity.Count <= 0 Then
                        lblMessage.Text = "Data Not Found"
                        lblMessage.Visible = True
                    End If

                    dtgOvertime.DataSource = dvEntity
                    Try
                        dtgOvertime.DataBind()
                    Catch
                        dtgOvertime.CurrentPageIndex = 0
                        dtgOvertime.DataBind()
                    End Try
                End Using
            End Using
        End Using


    End Sub
    Private Sub dtgList_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dtgList.ItemCommand
        Dim lblReqNo As Label
        Dim lblEmployeeName As Label
        Dim lblPositionName As Label
        Dim lblEmployeeID As Label
        Dim lblTotalAmount As Label


        Select Case e.CommandName
            Case "Approve"

                pnlDetail.Visible = True
                lblMessage.Text = ""

                lblReqNo = DirectCast(e.Item.FindControl("lblReqNo"), Label)
                Me.ReqNo = lblReqNo.Text

                lblEmployeeName = DirectCast(e.Item.FindControl("lblEmployeeName"), Label)
                lblName.Text = lblEmployeeName.Text

                lblEmployeeID = DirectCast(e.Item.FindControl("lblEmployeeID"), Label)
                Me.UserRequest = lblEmployeeID.Text

                lblPositionName = DirectCast(e.Item.FindControl("lblPositionName"), Label)
                lblDetPositionName.Text = lblPositionName.Text

                lblTotalAmount = DirectCast(e.Item.FindControl("lblTotalAmount"), Label)
                lblDetTotalAmount.Text = FormatNumber(lblTotalAmount.Text, 2)

                GetUserApproval()
                pnlList.Visible = False
                pnlSearch.Visible = False
                pnlDetail.Visible = True
                BindDataOvertimeDetail(Me.ReqNo)
            Case "Cancel"
                lblReqNo = DirectCast(e.Item.FindControl("lblReqNo"), Label)
                Me.ReqNo = lblReqNo.Text

                lblEmployeeID = DirectCast(e.Item.FindControl("lblEmployeeID"), Label)
                Me.UserRequest = lblEmployeeID.Text

                Try
                    Using con As New SqlConnection(constr)
                        Using cmd As New SqlCommand("spCancelOvertime")
                            Using sda As New SqlDataAdapter()
                                cmd.CommandType = CommandType.StoredProcedure
                                cmd.Parameters.AddWithValue("@ReqNo", lblReqNo.Text.Trim())
                                cmd.Connection = con
                                con.Open()
                                cmd.ExecuteNonQuery()
                                con.Close()
                            End Using
                        End Using
                    End Using
                    lblMessage.Visible = True
                    lblMessage.Text = "Cancel Overtime Successfully"
                    pnlSearch.Visible = True
                    pnlDetail.Visible = False
                    pnlList.Visible = True
                    Mail("Cancel")
                    CmdWhere = "All"
                    BindData(Me.CmdWhere)
                Catch ex As Exception
                    lblMessage.Text = ex.Message
                End Try
        End Select
    End Sub
    Protected Sub GetUserApproval()
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetUserApproval")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ApprovalType", "OVT")
                cmd.Parameters.AddWithValue("@ReqNo", Me.ReqNo)
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData

                    If dtEntity.Rows.Count > 0 Then
                        With ddlUserApproval
                            .DataSource = dtEntity.DefaultView
                            .DataTextField = "EmployeeName"
                            .DataValueField = "EmployeeID"
                            .DataBind()
                            .Items.Insert(0, "Select One")
                            .Items(0).Value = ""
                        End With
                    Else
                        trNextApv.Visible = False
                        Me.UserFinal = Me.LoginID
                    End If


                End Using
            End Using
        End Using
    End Sub
    Private Sub imbSearch_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imbSearch.Click
        Me.CmdWhere = ""
        Me.SearchBy = ""
        Me.SortBy = ""
        lblMessage.Text = ""
        Me.CmdWhere = " UserApproval='" & Me.LoginID & "' And "
        If txtSearch.Text <> "" Then
            If CBool(InStr(txtSearch.Text, "%")) Then
                CmdWhere = CmdWhere & ddlSearch.SelectedItem.Value.Trim & " like '" & txtSearch.Text.Trim & "' "
            Else
                CmdWhere = CmdWhere & ddlSearch.SelectedItem.Value.Trim & " = '" & txtSearch.Text.Trim & "' "
            End If
        End If

        Me.SearchBy = CmdWhere
        BindData(Me.CmdWhere)
        pnlList.Visible = True
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        Response.Redirect("ApprovalOvertime.aspx")
    End Sub

    Protected Sub btnsave_Click(sender As Object, e As EventArgs)
        If Me.UserFinal Is Nothing Then
            Me.UserFinal = ddlUserApproval.SelectedValue
        End If
        Try
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("spSaveApprovalOvertime")
                    Using sda As New SqlDataAdapter()
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@ReqNo", Me.ReqNo)
                        cmd.Parameters.AddWithValue("@UserApproval", Me.UserFinal)
                        cmd.Parameters.AddWithValue("@ApprovalDate", Date.Now)
                        cmd.Connection = con
                        con.Open()
                        Me.Status = cmd.ExecuteScalar()
                        con.Close()
                    End Using
                End Using
            End Using
            Mail(Me.Status)
            pnlList.Visible = False
            pnlDetail.Visible = False
            trNextApv.Visible = True
            lblMessage.Visible = True
            lblMessage.Text = "Save Successfully"
        Catch ex As Exception
            lblMessage.Text = ex.Message
        End Try
    End Sub
    Sub Mail(ByVal ReqNoEmail As String)
        Dim mail As New InterfacingMailEngine.MailService
        Dim isSend As Boolean
        Dim strHtmlBody As String
        Dim emailTitle As String
        Dim SmtpServerName As String, SmtpServerUsername As String, SmtpServerPassword As String
        Dim MailToEmail As String
        'set body of html
        Me.EmailTo = GetEmailUserApproval()

        If ReqNoEmail = "Done" Then
            strHtmlBody = "Request Overtime Anda sudah di Approved,Kamu dapat mengecek pada menu Inquiry"
        ElseIf ReqNoEmail = "Decline" Or ReqNoEmail = "Cancel" Then
            strHtmlBody = "Request Overtime Anda di " & ReqNoEmail & " ,Kamu dapat mengecek pada menu Inquiry"
        Else
            strHtmlBody = "Mohon Untuk di Proses Request Overtime Dengan Request No : " & Me.ReqNo
        End If

        Try
            emailTitle = "Request Overtime - ReqNo : " & Me.ReqNo
            SmtpServerName = EmailSMTP
            SmtpServerUsername = EmailUser
            MailToEmail = Me.EmailTo
            SmtpServerPassword = EmailPassword
            isSend = mail.SendMailWithAuth(SmtpServerName, MailToEmail, SmtpServerName, emailTitle, _
                                          emailTitle, strHtmlBody, SmtpServerUsername, SmtpServerPassword, _
                                          EmailPort, "True", "")
            If Not isSend Then
                lblMessage.Text = lblMessage.Text & " - Mail Notifikasi failed to send"
            End If
        Catch ex As Exception
            lblMessage.Text = lblMessage.Text & " - Mail Notifikasi failed to send"
        End Try
    End Sub
    Function GetEmailUserApproval()
        Dim StatusRequest As String
        Dim UserApv As String

        If Me.Status = "Done" Then
            StatusRequest = Me.Status
            UserApv = Me.UserRequest
        Else
            StatusRequest = ""
            UserApv = ddlUserApproval.SelectedValue.Trim
        End If

        Dim conn As New SqlConnection(constr)
        Dim EmailUserApv As String
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetEmailUserApproval")
                Using sda As New SqlDataAdapter()
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@EmployeeID", UserApv)
                    cmd.Parameters.AddWithValue("@ApprovalType", "OVT")
                    cmd.Parameters.AddWithValue("@Status", StatusRequest)
                    cmd.Connection = con
                    con.Open()
                    EmailUserApv = cmd.ExecuteScalar()
                    con.Close()
                End Using
            End Using
        End Using
        Return EmailUserApv
    End Function

    Protected Sub btnDecline_Click(sender As Object, e As EventArgs)
        Try
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("spDeclineOvertime")
                    Using sda As New SqlDataAdapter()
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@ReqNo", Me.ReqNo)
                        cmd.Connection = con
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                    End Using
                End Using
            End Using
            lblMessage.Visible = True
            lblMessage.Text = "Decline Overtime Successfully"
            pnlSearch.Visible = True
            pnlDetail.Visible = False
            pnlList.Visible = True
            Mail("Decline")
            CmdWhere = "All"
            BindData(Me.CmdWhere)
        Catch ex As Exception
            lblMessage.Text = ex.Message
        End Try
    End Sub
#Region " Navigation"
    Private Sub PagingFooter()
        lblPage.Text = currentPage.ToString()
        totalPages = Math.Ceiling(CType((recordCount / CType(pageSize, Integer)), Double))
        If totalPages = 0 Then
            lblMessage.Text = "Data Not Found"
            lblTotPage.Text = "1"
        Else
            lblTotPage.Text = (System.Math.Ceiling(totalPages)).ToString()
            rgvGo.MaximumValue = (System.Math.Ceiling(totalPages)).ToString()
        End If
        lblTotRec.Text = recordCount.ToString

        If currentPage = 1 Then
            imbPrevPage.Enabled = False
            imbFirstPage.Enabled = False
            If totalPages > 1 Then
                imbNextPage.Enabled = True
                imbLastPage.Enabled = True
            Else
                imbPrevPage.Enabled = False
                imbNextPage.Enabled = False
                imbLastPage.Enabled = False
                imbFirstPage.Enabled = False
            End If
        Else
            imbPrevPage.Enabled = True
            imbFirstPage.Enabled = True
            If currentPage = totalPages Then
                imbNextPage.Enabled = False
                imbLastPage.Enabled = False
            Else
                imbLastPage.Enabled = True
                imbNextPage.Enabled = True
            End If
        End If
    End Sub

    Protected Sub NavigationLink_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        Select Case e.CommandName
            Case "First" : currentPage = 1
            Case "Last" : currentPage = Int32.Parse(lblTotPage.Text)
            Case "Next" : currentPage = Int32.Parse(lblPage.Text) + 1
            Case "Prev" : currentPage = Int32.Parse(lblPage.Text) - 1
        End Select
        BindData(Me.CmdWhere)
    End Sub

    Private Sub imbGoPage_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imbGoPage.Click
        If IsNumeric(txtGoPage.Text) Then
            If CType(lblTotPage.Text, Integer) > 1 And CType(txtGoPage.Text, Integer) <= CType(lblTotPage.Text, Integer) Then
                currentPage = CType(txtGoPage.Text, Int32)
                BindData(Me.CmdWhere)
            End If
        End If
    End Sub
#End Region
    Public Sub Sorting(ByVal Sender As Object, ByVal e As DataGridSortCommandEventArgs) Handles dtgList.SortCommand
        If InStr(Me.SortBy, "DESC") > 0 Then
            Me.SortBy = e.SortExpression
        Else
            Me.SortBy = e.SortExpression + " DESC"
        End If
        Call BindData(Me.CmdWhere)
    End Sub

    Private Sub imbReset_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imbReset.Click
        Response.Redirect("ApprovalOvertime.aspx")
    End Sub
End Class