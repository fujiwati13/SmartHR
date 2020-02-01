Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Public Class InquiryReimburse
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
    Protected Property AttachmentID() As String
        Get
            Return DirectCast(ViewState("AttachmentID"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("AttachmentID") = Value
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

#Region "PrivateConstanta"
    Private currentPage As Integer = 1
    Private pageSize As Int16 = 10
    Private currentPageNumber As Int32 = 1
    Private totalPages As Double = 1
    Private recordCount As Int64 = 1

    Dim constr As String = System.Configuration.ConfigurationManager.AppSettings("constr")
  

#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            pnlList.Visible = False
            Me.LoginID = Session("EmployeeID")
        End If
    End Sub
    Protected Sub BindData(ByVal CmdWhere As String)
        Dim dvEntity As DataView
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spPagingInquiryReimburse")
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
    Private Sub imbSearch_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imbSearch.Click
        Me.CmdWhere = ""
        Me.SearchBy = ""
        Me.SortBy = ""
        lblMessage.Text = ""

        If Session("Role") = "User" Then
            Me.CmdWhere = " R.EmployeeID='" & Session("EmployeeID") & "' And "
        End If

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
    Private Sub dtgList_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dtgList.ItemCommand
        Dim lblReqNo As Label
        Dim lblData As Label
        Dim lblBuktiTransferName As Label

        Select Case e.CommandName
            Case "Print"

                lblMessage.Text = ""

                lblReqNo = DirectCast(e.Item.FindControl("lblReqNo"), Label)
                Me.ReqNo = Replace(lblReqNo.Text, "/", "")
                lblData = DirectCast(e.Item.FindControl("lblData"), Label)
                lblBuktiTransferName = DirectCast(e.Item.FindControl("lblBuktiTransferName"), Label)
                Me.PathDir = lblBuktiTransferName.Text 'Download(lblData.Text, lblAttachment.Text)

                Response.Redirect(Me.PathDir)
        End Select
    End Sub
#Region "itemBound"
    Private Sub dtgList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dtgList.ItemDataBound
        If e.Item.ItemIndex >= 0 Then
            Dim lnkAddAttachment As LinkButton
            Dim lblEmployeeID As Label
            Dim lblEmployeeName As Label
            Dim lblRaimburseType As Label
            Dim lblAttachmentID As Label

            lnkAddAttachment = DirectCast(e.Item.FindControl("lnkAddAttachment"), LinkButton)
            lblEmployeeID = DirectCast(e.Item.FindControl("lblEmployeeID"), Label)
            lblEmployeeName = DirectCast(e.Item.FindControl("lblEmployeeName"), Label)
            lblRaimburseType = DirectCast(e.Item.FindControl("lblRaimburseType"), Label)
            lblAttachmentID = DirectCast(e.Item.FindControl("lblAttachmentID"), Label)
            lnkAddAttachment.Attributes.Add("OnClick", "return OpenAttachment('" & lblEmployeeName.Text & "','" & lblRaimburseType.Text & "','" & lblAttachmentID.Text & "','" & lblEmployeeID.Text & "');")
        End If
    End Sub
#End Region
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