Imports System.Configuration
Imports System.Data.SqlClient
Imports EASendMail
Imports System.Data
Imports System.IO
Imports System.IO.Compression

Public Class PaymentOvertime
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
    Private Property MaxSizeFile() As Integer
        Get
            Return DirectCast(ViewState("MaxSizeFile"), Integer)
        End Get
        Set(ByVal value As Integer)
            ViewState("MaxSizeFile") = value
        End Set
    End Property
    Protected Property Base64Data() As String
        Get
            Return DirectCast(ViewState("Base64Data"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("Base64Data") = Value
        End Set
    End Property
    Protected Property PathDir() As String
        Get
            Return DirectCast(ViewState("PathDir"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("PathDir") = Value
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
        End If
    End Sub
    Protected Sub BindData(ByVal CmdWhere As String)
        Dim dvEntity As DataView
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spPagingPaymentOvertime")
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
            Case "Payment"

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

                pnlList.Visible = False
                pnlSearch.Visible = False
                pnlDetail.Visible = True
                BindDataOvertimeDetail(Me.ReqNo)
           
        End Select
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
        BindData(CmdWhere)
        pnlList.Visible = True
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        Response.Redirect("PaymentOvertime.aspx")
    End Sub

    Protected Sub btnsave_Click(sender As Object, e As EventArgs)
        Dim STRPATH As String = "..\fileAttachment\"
        Me.MaxSizeFile = 2048
        Dim SizeDoc As Integer
        SizeDoc = inpBrowse.PostedFile.ContentLength / 1024
        If SizeDoc > MaxSizeFile Then
            lblMessage.Text = "File to Large, File Must be Less Than " + CStr(MaxSizeFile) + "Kb"
        Else
            'edit victor 16/5/2017
            If inpBrowse.PostedFile.FileName.Trim = "" Then
                lblMessage.Text = "Please Fill FileName!"
                Exit Sub
            End If
            Dim folderPath As String = STRPATH + "FileAttach\"
            'Dim folderZipPath As String = STRPATH + "zip\"

            Dim folderPathTemp As String = folderPath + "Overtime\"

            Dim ArrFileName As String()
            Dim strFileName As String
            Dim ArrExtension As String()
            Dim strExtension As String
            ArrExtension = inpBrowse.PostedFile.FileName.Trim.Split(New Char() {"."c})
            ArrFileName = ArrExtension(0).Trim.Split(New Char() {"\"c})
            strExtension = ArrExtension(ArrExtension.Length - 1)
            strFileName = ArrFileName(ArrFileName.Length - 1)
            Dim filePath As String = folderPathTemp + strFileName + "." + strExtension
            Me.Base64Data = UploadNew()

            Try
                Using con As New SqlConnection(constr)
                    Using cmd As New SqlCommand("spSavePaymentOvertime")
                        Using sda As New SqlDataAdapter()
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Parameters.AddWithValue("@ReqNo", Me.ReqNo)
                            cmd.Parameters.AddWithValue("@UserPayment", Me.LoginID)
                            cmd.Parameters.AddWithValue("@Data", Me.Base64Data)
                            cmd.Parameters.AddWithValue("@AttachmentName", filePath)
                            cmd.Connection = con
                            con.Open()
                            Me.Status = cmd.ExecuteScalar()
                            con.Close()
                        End Using
                    End Using
                End Using
                Reset()
                Mail()
                pnlList.Visible = False
                pnlDetail.Visible = False
                lblMessage.Visible = True
                lblMessage.Text = "Save Successfully"
            Catch ex As Exception
                lblMessage.Text = ex.Message
            End Try
        End If
    End Sub
    Function UploadNew() As String
        Dim STRPATH As String = System.Configuration.ConfigurationManager.AppSettings("FileAttachmentPath")
        Dim folderPath As String = STRPATH + "FileAttach\"

        Dim folderPathTemp As String = folderPath + "Overtime\"

        Dim ArrFileName As String()
        Dim strFileName As String
        Dim ArrExtension As String()
        Dim strExtension As String
        ArrExtension = inpBrowse.PostedFile.FileName.Trim.Split(New Char() {"."c})
        ArrFileName = ArrExtension(0).Trim.Split(New Char() {"\"c})
        strExtension = ArrExtension(ArrExtension.Length - 1)
        strFileName = ArrFileName(ArrFileName.Length - 1)
        Dim filePath As String = folderPathTemp + strFileName + "." + strExtension

        Dim hasilBase64 As String
 
        Try
            If Not IO.Directory.Exists(folderPathTemp) Then
                IO.Directory.CreateDirectory(folderPathTemp)
            End If
            inpBrowse.PostedFile.SaveAs(filePath)
            hasilBase64 = CStr(System.Convert.ToBase64String(File.ReadAllBytes(filePath)))
            Return hasilBase64
        Catch ex As Exception
            lblMessage.Text = "Error Upload !"
            Return ""
        End Try
    End Function

    Sub Mail()
        Dim mail As New InterfacingMailEngine.MailService
        Dim isSend As Boolean
        Dim strHtmlBody As String
        Dim emailTitle As String
        Dim SmtpServerName As String, SmtpServerUsername As String, SmtpServerPassword As String
        Dim MailToEmail As String
        'set body of html
        strHtmlBody = "Pembayaran Request Lembur Anda sudah Sukses,Kamu dapat mengecek dan mencetak bukti pembayaran melalui menu Inquiry"
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

    Function GetEmailUserApproval()
        Dim conn As New SqlConnection(constr)
        Dim EmailUserApv As String
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetEmailUserApproval")
                Using sda As New SqlDataAdapter()
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.AddWithValue("@EmployeeID", Me.UserRequest)
                    cmd.Parameters.AddWithValue("@ApprovalType", "OVT")
                    cmd.Parameters.AddWithValue("@Status", "Done")
                    cmd.Connection = con
                    con.Open()
                    EmailUserApv = cmd.ExecuteScalar()
                    con.Close()
                End Using
            End Using
        End Using
        Return EmailUserApv
    End Function
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
        Response.Redirect("PaymentOvertime.aspx")
    End Sub

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
            CmdWhere = "All"
            BindData(Me.CmdWhere)
        Catch ex As Exception
            lblMessage.Text = ex.Message
        End Try
    End Sub
End Class