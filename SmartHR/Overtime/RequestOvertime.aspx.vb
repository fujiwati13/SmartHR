Imports System.Data.SqlClient
Imports EASendMail

Public Class RequestOvertime
    Inherits System.Web.UI.Page
#Region "Property"
    Private Property TableOvertime() As DataTable
        Get
            Return (CType(ViewState("TableOvertime"), DataTable))
        End Get
        Set(ByVal Value As DataTable)
            ViewState("TableOvertime") = Value
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
    Protected Property EmailTo() As String
        Get
            Return DirectCast(ViewState("EmailTo"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("EmailTo") = Value
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
    Private ReadOnly Property Message() As String
        Get
            If Request.QueryString("Message") Is Nothing Or Request.QueryString("Message") = "" Then
                Return ""
            Else
                Return Request.QueryString("Message")
            End If
        End Get
    End Property
#End Region
    Private CounterColumn As Integer = 0
    Dim constr As String = System.Configuration.ConfigurationManager.AppSettings("constr")
    Dim EmailFrom As String = System.Configuration.ConfigurationManager.AppSettings("EmailFrom")
    Dim EmailPort As String = System.Configuration.ConfigurationManager.AppSettings("EmailPort")
    Dim EmailUser As String = System.Configuration.ConfigurationManager.AppSettings("EmailUser")
    Dim EmailPassword As String = System.Configuration.ConfigurationManager.AppSettings("EmailPassword")
    Dim EmailSMTP As String = System.Configuration.ConfigurationManager.AppSettings("EmailSMTP")
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Me.EmployeeID = Session("EmployeeId")
            GetUserApproval()
            GetOvertime()
            If Message <> "" Then
                lblMessage.Visible = True
                lblMessage.Text = Message
            Else
                lblMessage.Visible = False
                lblMessage.Text = ""
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
#Region "Generate Table"
    Private Function GenerateTableOvertime() As DataTable
        Dim lObjDataTable As New DataTable("TableOvertime")
        With lObjDataTable
            .Columns.Add("OvertimeID", System.Type.GetType("System.String"))
            .Columns.Add("OvertimeType", System.Type.GetType("System.String"))
            .Columns.Add("OvertimeDate", System.Type.GetType("System.DateTime"))
            .Columns.Add("Hour", System.Type.GetType("System.String"))
            .Columns.Add("Notes", System.Type.GetType("System.String"))
        End With
        Return lObjDataTable
    End Function
#End Region

    Private Sub SaveDataGridToDataTable()
        Dim lObjDataRow As DataRow
        lObjDataRow = Me.TableOvertime.NewRow()
        lObjDataRow("OvertimeID") = ddlOvertimeType.SelectedValue.Trim
        lObjDataRow("OvertimeType") = ddlOvertimeType.SelectedItem
        lObjDataRow("OvertimeDate") = ConvertDate2(txtDate.Text)
        lObjDataRow("Notes") = txtNotes.Text
        lObjDataRow("Hour") = txtHour.Text
        Me.TableOvertime.Rows.Add(lObjDataRow)
    End Sub

    Private Sub dtgOvertime_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dtgOvertime.ItemCommand
        If e.CommandName = "DELETE" Then
            Me.TableOvertime.Rows.RemoveAt(CInt(e.Item.ItemIndex()))
            dtgOvertime.DataSource = Me.TableOvertime.DefaultView
            dtgOvertime.DataBind()
        End If
    End Sub

    Private Sub dtgOvertime_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dtgOvertime.ItemDataBound
        Dim lblOvtNo As Label
        If e.Item.ItemIndex >= 0 Then
            lblOvtNo = DirectCast(e.Item.FindControl("lblOvtNo"), Label)
            CounterColumn += 1
            lblOvtNo.Text = CStr(CounterColumn)
        End If
    End Sub

    Protected Sub btnAdd_Click(sender As Object, e As EventArgs)
        lblMessage.Text = ""

        If Me.TableOvertime Is Nothing Then
            Me.TableOvertime = GenerateTableOvertime()
        End If

        pnlGrid.Visible = True

        SaveDataGridToDataTable()
        dtgOvertime.DataSource = Me.TableOvertime.DefaultView
        dtgOvertime.DataBind()
        Reset()


    End Sub

    Protected Sub Reset()
        ddlOvertimeType.SelectedValue = ""
        txtHour.Text = ""
        txtNotes.Text = ""
        txtDate.Text = ""
    End Sub

    Protected Sub btnCancelAdd_Click(sender As Object, e As EventArgs)
        Reset()
    End Sub
    Protected Sub GetUserApproval()
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetUserApproval")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ApprovalType", "OVT")
                cmd.Parameters.AddWithValue("@ReqNo", "")
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData


                    With ddlUserApproval
                        .DataSource = dtEntity.DefaultView
                        .DataTextField = "EmployeeName"
                        .DataValueField = "EmployeeID"
                        .DataBind()
                        .Items.Insert(0, "Select One")
                        .Items(0).Value = ""
                    End With
                End Using
            End Using
        End Using
    End Sub
    Protected Sub GetOvertime()
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetOvertime")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData


                    With ddlOvertimeType
                        .DataSource = dtEntity.DefaultView
                        .DataTextField = "OvertimeType"
                        .DataValueField = "OvertimeID"
                        .DataBind()
                        .Items.Insert(0, "Select One")
                        .Items(0).Value = ""
                    End With
                End Using
            End Using
        End Using
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        Response.Redirect("RequestOvertime.aspx")
    End Sub
    Function GetEmailUserApproval()
        Dim conn As New SqlConnection(constr)
        Dim EmailUserApv As String
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetEmailUserApproval")
                Using sda As New SqlDataAdapter()
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@EmployeeID", ddlUserApproval.SelectedValue.Trim)
                    cmd.Parameters.AddWithValue("@ApprovalType", "OVT")
                    cmd.Connection = con
                    con.Open()
                    EmailUserApv = cmd.ExecuteScalar()
                    con.Close()
                End Using
            End Using
        End Using
        Return EmailUserApv
    End Function
    Sub Mail()
        'Dim oMail As New SmtpMail("TryIt")
        'Dim oSmtp As New SmtpClient()
        'Me.EmailTo = GetEmailUserApproval()
        'oMail.From = EmailFrom
        'oMail.To = Me.EmailTo '"fujiwati.hh@ad-ins.com"
        'oMail.Subject = "Request Overtime - ReqNo : " & Me.ReqNo
        'oMail.TextBody = "Mohon Untuk di Proses Request Pengajuan Lembur Dengan Request No : " & Me.ReqNo
        'Dim oServer As New SmtpServer(EmailSMTP)

        'oServer.Port = EmailPort

        '' detect SSL/TLS automatically
        'oServer.ConnectType = SmtpConnectType.ConnectSSLAuto
        'oServer.User = EmailUser
        'oServer.Password = EmailPassword

        'Try
        '    oSmtp.SendMail(oServer, oMail)
        '    lblMessage.Text = "Email was sent successfully!"
        'Catch ep As Exception
        '    lblMessage.Text = "failed to send email with the following error:"
        '    lblMessage.Text = lblMessage.Text & ep.Message
        'End Try
        Dim mail As New InterfacingMailEngine.MailService
        Dim isSend As Boolean
        Dim strHtmlBody As String
        Dim emailTitle As String
        Dim SmtpServerName As String, SmtpServerUsername As String, SmtpServerPassword As String
        Dim MailToEmail As String
        'set body of html
        strHtmlBody = "Mohon Untuk di Proses Request Pengajuan Lembur Dengan Request No : " & Me.ReqNo
        Me.EmailTo = GetEmailUserApproval()
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

    Protected Sub btnsave_Click(sender As Object, e As EventArgs)
        Dim i As Integer
        Try
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("spSaveRequestOvertimeHeader")
                    Using sda As New SqlDataAdapter()
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@EmployeeID", Me.EmployeeID)
                        cmd.Parameters.AddWithValue("@UserApproval", ddlUserApproval.SelectedValue.Trim)
                        cmd.Parameters.AddWithValue("@RequestDate", DateTime.Now)
                        cmd.Connection = con
                        con.Open()
                        Me.ReqNo = cmd.ExecuteScalar()
                        con.Close()
                    End Using
                End Using
                
                For i = 0 To Me.TableOvertime.Rows.Count - 1
                    Using cmddtl As New SqlCommand("spSaveRequestOvertimeDetail")
                        Using sda As New SqlDataAdapter()
                            cmddtl.CommandType = CommandType.StoredProcedure
                            cmddtl.Parameters.AddWithValue("@ReqOvertimeNo", Me.ReqNo)
                            cmddtl.Parameters.AddWithValue("@OvertimeID", Me.TableOvertime.Rows(i).Item("OvertimeID"))
                            cmddtl.Parameters.AddWithValue("@OvertimeDate", Me.TableOvertime.Rows(i).Item("OvertimeDate"))
                            cmddtl.Parameters.AddWithValue("@Hour", Me.TableOvertime.Rows(i).Item("Hour"))
                            cmddtl.Parameters.AddWithValue("@Notes", Me.TableOvertime.Rows(i).Item("Notes"))
                            cmddtl.Parameters.AddWithValue("@EmployeeID", Me.EmployeeID)
                            cmddtl.Connection = con
                            con.Open()
                            cmddtl.ExecuteScalar()
                            con.Close()
                        End Using
                    End Using
                Next

                Using cmd2 As New SqlCommand("spSaveTotalAmountOvertime")
                    Using sda As New SqlDataAdapter()
                        cmd2.CommandType = CommandType.StoredProcedure
                        cmd2.Parameters.AddWithValue("@ReqOvertimeNo", Me.ReqNo)
                        cmd2.Connection = con
                        con.Open()
                        cmd2.ExecuteScalar()
                        con.Close()
                    End Using
                End Using

            End Using
            lblMessage.Visible = True
            Mail()
            Me.TableOvertime.Clear()
            Reset()
            dtgOvertime.DataSource = Me.TableOvertime
            lblMessage.Text = "Save Successfully Your Request No : " & Me.ReqNo
            Response.Redirect("Requestovertime.aspx?Message=" & lblMessage.Text)
        Catch ex As Exception
            lblMessage.Text = ex.Message
        End Try
    End Sub
End Class