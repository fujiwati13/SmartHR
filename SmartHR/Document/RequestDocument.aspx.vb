Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Imports EASendMail
Imports InterfacingMailEngine

Public Class RequestDocument
    Inherits System.Web.UI.Page
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
    Protected Property EmployeeID() As String
        Get
            Return DirectCast(ViewState("EmployeeID"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("EmployeeID") = Value
        End Set
    End Property
    Protected Property FlagAddEdit() As String
        Get
            Return DirectCast(ViewState("FlagAddEdit"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("FlagAddEdit") = Value
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
    Protected Property EmailTo() As String
        Get
            Return DirectCast(ViewState("EmailTo"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("EmailTo") = Value
        End Set
    End Property
#End Region
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetDocType()
            Me.EmployeeID = Session("EmployeeId")
            GetUserApproval()
        End If
    End Sub
    Sub Reset()
        ddlDocument.SelectedValue = ""
        txtNotes.Text = ""
        txtDueDate.Text = ""
        ddlUserApproval.SelectedValue = ""
    End Sub
    Protected Sub GetDocType()
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetDocumentType")
                cmd.Connection = con
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData


                    With ddlDocument
                        .DataSource = dtEntity.DefaultView
                        .DataTextField = "DocumentDesc"
                        .DataValueField = "DocumentID"
                        .DataBind()
                        .Items.Insert(0, "Select One")
                        .Items(0).Value = ""
                    End With
                End Using
            End Using
        End Using
    End Sub
    Protected Sub btnsave_Click(sender As Object, e As EventArgs)
        Try
            Me.FlagAddEdit = "Add"
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("spSaveRequestDoc")
                    Using sda As New SqlDataAdapter()
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@DocumentID", ddlDocument.SelectedValue.Trim())
                        cmd.Parameters.AddWithValue("@DueDate", txtDueDate.Text.Trim())
                        cmd.Parameters.AddWithValue("@Notes", txtNotes.Text.Trim())
                        cmd.Parameters.AddWithValue("@EmployeeID", Me.EmployeeID)
                        cmd.Parameters.AddWithValue("@UserApproval", ddlUserApproval.SelectedValue.Trim)
                        cmd.Connection = con
                        con.Open()
                        Me.ReqNo = cmd.ExecuteScalar()
                        con.Close()
                    End Using
                End Using
            End Using
            lblMessage.Visible = True
            lblMessage.Text = "Save Successfully Your Request No : " & Me.ReqNo
            Mail()
            Reset()

            'pnlSearch.Visible = True
            'pnlDetail.Visible = False
            'pnlList.Visible = False
        Catch ex As Exception
            lblMessage.Text = ex.Message
        End Try

    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        Reset()
        Response.Redirect("HomeDoc.aspx")
    End Sub
    Private Function HtmlBody() As String
        Dim builder As New StringBuilder
        Dim body As String

        builder.Append("<body>")
        builder.Append("Dear User HRD")
        builder.Append("<BR><BR> Mohon Untuk di Proses Request Document Dengan Request No : " & Me.ReqNo)
        builder.Append("<BR><BR><BR><BR>")
        builder.Append("Regards <br>")
        builder.Append("Admin SMARTHR <br>")
        builder.Append("</body>")
        body = builder.ToString

        Return body
    End Function
    Sub Mail()
        Dim mail As New InterfacingMailEngine.MailService
        Dim isSend As Boolean
        Dim strHtmlBody As String
        Dim emailTitle As String
        Dim SmtpServerName As String, SmtpServerUsername As String, SmtpServerPassword As String
        Dim MailToEmail As String

        strHtmlBody = "Dear User HRD,Mohon Untuk di Proses Request Document Dengan Request No : " & Me.ReqNo

        Try
            emailTitle = "Request Document - ReqNo : " & Me.ReqNo
            SmtpServerName = EmailSMTP
            SmtpServerUsername = EmailUser
            Me.EmailTo = GetEmailUserApproval()
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
    Protected Sub GetUserApproval()
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetUserApproval")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ApprovalType", "DOC")
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
    Function GetEmailUserApproval()
        Dim StatusRequest As String
        StatusRequest = ""
        Dim conn As New SqlConnection(constr)
        Dim EmailUserApv As String
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetEmailUserApproval")
                Using sda As New SqlDataAdapter()
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@EmployeeID", ddlUserApproval.SelectedValue.Trim)
                    cmd.Parameters.AddWithValue("@ApprovalType", "DOC")
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
End Class