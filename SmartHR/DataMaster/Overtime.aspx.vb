﻿Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Public Class Overtime
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
    Protected Property FlagAddEdit() As String
        Get
            Return DirectCast(ViewState("FlagAddEdit"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("FlagAddEdit") = Value
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
    Dim dtReason As New DataTable
    Dim flag As Integer = 0
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Role") <> "Admin" Then
            Response.Redirect("Notauthorized.aspx")
            Exit Sub
        End If
        If Not IsPostBack Then
            pnlSearch.Visible = True
            pnlList.Visible = False
            lblMessage.Text = ""
            GetGolongan()
            Reset()
        End If
    End Sub
    Sub Reset()
        txtOvertimeID.Text = ""
        txtOvertimeType.Text = ""
        txtLocation.Text = ""
        ddlGolongan.SelectedValue = ""
        txtAmount.Text = "0"
        txtOvertimeID.Enabled = True
    End Sub
    Protected Sub BindData(ByVal CmdWhere As String)
        Dim dvEntity As DataView
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spPagingOvertime")
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
    Protected Sub GetGolongan()

        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetGolongan")
                cmd.Connection = con
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData


                    With ddlGolongan
                        .DataSource = dtEntity.DefaultView
                        .DataTextField = "GolonganName"
                        .DataValueField = "GolonganID"
                        .DataBind()
                        .Items.Insert(0, "Select One")
                        .Items(0).Value = ""
                    End With
                End Using
            End Using
        End Using
    End Sub
    Private Sub dtgList_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dtgList.ItemCommand
        Dim lblOvertimeID As Label
        Dim lblOvertimeType As Label
        Dim lblLocation As Label
        Dim lblGolongan As Label
        Dim lblGolonganID As Label
        Dim lblAmount As Label

        Select Case e.CommandName
            Case "Edit"
                Me.FlagAddEdit = "Edit"
                pnlDetail.Visible = True
                lblMessage.Text = ""

                lblOvertimeID = DirectCast(e.Item.FindControl("lblOvertimeID"), Label)
                txtOvertimeID.Text = lblOvertimeID.Text

                lblOvertimeType = DirectCast(e.Item.FindControl("lblOvertimeType"), Label)
                txtOvertimeType.Text = lblOvertimeType.Text

                lblLocation = DirectCast(e.Item.FindControl("lblLocation"), Label)
                txtLocation.Text = lblLocation.Text

                lblGolonganID = DirectCast(e.Item.FindControl("lblGolonganID"), Label)
                ddlGolongan.SelectedValue = lblGolonganID.Text

                lblAmount = DirectCast(e.Item.FindControl("lblAmount"), Label)
                txtAmount.Text = lblAmount.Text

                txtOvertimeID.Enabled = False
                pnlList.Visible = False
                pnlSearch.Visible = False
            Case "Delete"
                lblOvertimeID = DirectCast(e.Item.FindControl("lblOvertimeID"), Label)
                Try
                    Using con As New SqlConnection(constr)
                        Using cmd As New SqlCommand("spDeleteOvertime")
                            Using sda As New SqlDataAdapter()
                                cmd.CommandType = CommandType.StoredProcedure
                                cmd.Parameters.AddWithValue("@OvertimeID", lblOvertimeID.Text.Trim())
                                cmd.Connection = con
                                con.Open()
                                cmd.ExecuteNonQuery()
                                con.Close()
                            End Using
                        End Using
                    End Using
                    lblMessage.Visible = True
                    lblMessage.Text = "Delete Successfully"
                    pnlSearch.Visible = True
                    pnlDetail.Visible = False
                    pnlList.Visible = True
                    CmdWhere = "All"
                    BindData(CmdWhere)
                Catch ex As Exception
                    lblMessage.Visible = True
                    lblMessage.Text = "Delete Failed !! " & ex.Message
                End Try
        End Select
    End Sub
    Private Sub imbSearch_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imbSearch.Click
        CmdWhere = ""
        Me.SearchBy = ""
        Me.SortBy = ""
        lblMessage.Text = ""

        If txtSearch.Text <> "" Then
            If CBool(InStr(txtSearch.Text, "%")) Then
                CmdWhere = CmdWhere & CmdWhere & ddlSearch.SelectedItem.Value.Trim & " like '" & txtSearch.Text.Trim & "' "
            Else
                CmdWhere = CmdWhere & ddlSearch.SelectedItem.Value.Trim & " = '" & txtSearch.Text.Trim & "' "
            End If
            'If ddlSearch.SelectedItem.Value.Trim = "OvertimeID" Then
            '    If CBool(InStr(txtSearch.Text, "%")) Then
            '        CmdWhere = CmdWhere & CmdWhere & "OvertimeID like '" & txtSearch.Text.Trim & "' "
            '    Else
            '        CmdWhere = CmdWhere & "LeaveID = '" & txtSearch.Text.Trim & "' "
            '    End If
            'ElseIf ddlSearch.SelectedItem.Value.Trim = "OvertimeType" Then
            '    If Right(txtSearch.Text.Trim, 1) = "%" Then
            '        CmdWhere = CmdWhere & "OvertimeType like '" & txtSearch.Text.Trim & "' "
            '    Else
            '        CmdWhere = CmdWhere & "OvertimeType like '" & txtSearch.Text.Trim & "' "
            '    End If

            'ElseIf ddlSearch.SelectedItem.Value.Trim = "Location" Then
            '    If Right(txtSearch.Text.Trim, 1) = "%" Then
            '        CmdWhere = CmdWhere & "Location like '" & txtSearch.Text.Trim & "' "
            '    Else
            '        CmdWhere = CmdWhere & "Location like '" & txtSearch.Text.Trim & "' "
            '    End If
            'End If
        End If

        Me.SearchBy = CmdWhere
        BindData(CmdWhere)
        pnlList.Visible = True
    End Sub

    Protected Sub btnsave_Click(sender As Object, e As EventArgs)
        Try
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("spSaveAddEditOvertime")
                    Using sda As New SqlDataAdapter()
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@OvertimeID", txtOvertimeID.Text.Trim())
                        cmd.Parameters.AddWithValue("@OvertimeType", txtOvertimeType.Text.Trim())
                        cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim())
                        cmd.Parameters.AddWithValue("@GolonganID", ddlGolongan.SelectedValue.Trim())
                        cmd.Parameters.AddWithValue("@Amount", CDec(txtAmount.Text.Trim()))
                        cmd.Parameters.AddWithValue("@Flag", Me.FlagAddEdit)
                        cmd.Connection = con
                        con.Open()
                        cmd.ExecuteScalar()
                        con.Close()
                    End Using
                End Using
            End Using
            lblMessage.Visible = True
            lblMessage.Text = "Save Successfully"
            Reset()
            pnlSearch.Visible = True
            pnlDetail.Visible = False
            pnlList.Visible = False
        Catch ex As Exception
            pnlSearch.Visible = False
            pnlList.Visible = False
            lblMessage.Visible = True
            lblMessage.Text = "Save Failed !! " & ex.Message
        End Try

    End Sub

    Protected Sub btnAdd_Click(sender As Object, e As EventArgs)
        Me.FlagAddEdit = "Add"
        lblMessage.Text = ""
        pnlSearch.Visible = False
        pnlList.Visible = False
        pnlDetail.Visible = True
        GetGolongan()
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        Reset()
        Response.Redirect("Overtime.aspx")
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
        Response.Redirect("Overtime.aspx")
    End Sub
End Class