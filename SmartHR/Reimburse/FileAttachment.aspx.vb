Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.IO
Imports System.IO.Compression

Public Class FileAttachment
    Inherits System.Web.UI.Page
#Region "Property"
    Private ReadOnly Property EmployeeName() As String
        Get
            Return Request.QueryString("EmployeeName")
        End Get
    End Property
    Private ReadOnly Property EmployeeID() As String
        Get
            Return Request.QueryString("EmployeeID")
        End Get
    End Property
    Private ReadOnly Property AttachmentID() As String
        Get
            Return Request.QueryString("AttachmentID")
        End Get
    End Property
    Private ReadOnly Property ReimburseType() As String
        Get
            Return Request.QueryString("ReimburseType")
        End Get
    End Property
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
    Protected Property ReqDocNo() As String
        Get
            Return DirectCast(ViewState("ReqDocNo"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("ReqDocNo") = Value
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
    Protected Property UserApproval() As String
        Get
            Return DirectCast(ViewState("UserApproval"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("UserApproval") = Value
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
    Protected Property UserRequest() As String
        Get
            Return DirectCast(ViewState("UserRequest"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("UserRequest") = Value
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
  
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.CmdWhere = " AttachmentID ='" & Me.AttachmentID & "'"
            BindData(Me.CmdWhere)
            lblDetEmployeeName.Text = Me.EmployeeName
            lblDetReimburseType.Text = Me.ReimburseType
            pnlData.Visible = True
            pnlList.Visible = True
            pnlDetail.Visible = False
            Me.LoginID = Session("EmployeeID")
            If Me.LoginID <> Me.EmployeeID Then
                btnAdd.Visible = False
            Else
                btnAdd.Visible = True
            End If
        End If
    End Sub
    Protected Sub BindData(ByVal CmdWhere As String)
        Dim dvEntity As DataView
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)
        'Me.CmdWhere = ""
        Me.SearchBy = ""
        Me.SortBy = ""
        lblMessage.Text = ""

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spPagingFileAttachmentDetail")
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
    Protected Sub btnAdd_Click(sender As Object, e As EventArgs)
        lblMessage.Text = ""
        pnlData.Visible = False
        pnlList.Visible = False
        pnlDetail.Visible = True
    End Sub
    Function UploadNew() As String
        Dim STRPATH As String = System.Configuration.ConfigurationManager.AppSettings("FileAttachmentPath")
        Dim folderPath As String = STRPATH + "FileAttach\"

        Dim folderPathTemp As String = folderPath + "Reimburse\"

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
    Protected Sub btnsave_Click(sender As Object, e As EventArgs)
        Dim STRPATH As String = "..\fileAttachment\"
        Me.MaxSizeFile = 2048
        Dim SizeDoc As Integer
        SizeDoc = inpBrowse.PostedFile.ContentLength / 1024
        If SizeDoc > MaxSizeFile Then
            lblMessage.Text = "File to Large, File Must be Less Than " + CStr(MaxSizeFile) + "Kb"
        Else

            If inpBrowse.PostedFile.FileName.Trim = "" Then
                lblMessage.Text = "Please Fill FileName!"
                Exit Sub
            End If
            Dim folderPath As String = STRPATH + "FileAttach\"
            'Dim folderZipPath As String = STRPATH + "zip\"

            Dim folderPathTemp As String = folderPath + "Reimburse\"

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
                    Using cmd As New SqlCommand("spSaveAttachmentDetail")
                        Using sda As New SqlDataAdapter()
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Parameters.AddWithValue("@AttachmentID", Me.AttachmentID)
                            cmd.Parameters.AddWithValue("@Data", Me.Base64Data)
                            cmd.Parameters.AddWithValue("@DocumentName", inpBrowse.PostedFile.FileName)
                            cmd.Parameters.AddWithValue("@FILEPATH", filePath)
                            cmd.Parameters.AddWithValue("@EmployeeID", Me.LoginID)
                            cmd.Connection = con
                            con.Open()
                            cmd.ExecuteScalar()
                            con.Close()
                        End Using
                    End Using
                End Using
                lblMessage.Visible = True
                pnlData.Visible = True
                pnlList.Visible = True
                pnlDetail.Visible = False
                reset()
                BindData(Me.CmdWhere)
                lblMessage.Text = "Save Successfully"
            Catch ex As Exception
                lblMessage.Text = ex.Message
            End Try
        End If
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        Response.Redirect("FileAttachment.aspx")
    End Sub
    Sub reset()
        txtKeterangan.Text = ""
    End Sub

    Protected Sub btnClose_Click(sender As Object, e As EventArgs)
        ClientScript.RegisterClientScriptBlock(Me.GetType(), "Close", "window.close()", True)
    End Sub
    Private Sub dtgList_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dtgList.ItemCommand
        Dim lblFilePath As Label
        Dim DocumentNo As LinkButton
      
        Select Case e.CommandName
            Case "Print"

                lblMessage.Text = ""

                lblFilePath = DirectCast(e.Item.FindControl("lblFilePath"), Label)
                Me.PathDir = lblFilePath.Text 'Download(lblData.Text, lblAttachment.Text)

                Response.Redirect(Me.PathDir)
            Case "Delete"
                DocumentNo = DirectCast(e.Item.FindControl("lblDocumentNo"), LinkButton)

                Try
                    Using con As New SqlConnection(constr)
                        Using cmd As New SqlCommand("spSaveAttachmentDetailDelete")
                            Using sda As New SqlDataAdapter()
                                cmd.CommandType = CommandType.StoredProcedure
                                cmd.Parameters.AddWithValue("@DocumentNo", DocumentNo.Text)
                                cmd.Connection = con
                                con.Open()
                                cmd.ExecuteScalar()
                                con.Close()
                            End Using
                        End Using
                    End Using

                    BindData(Me.CmdWhere)
                    lblMessage.Text = "Delete Successfully"
                Catch ex As Exception
                    lblMessage.Text = ex.Message
                End Try
        End Select
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
End Class