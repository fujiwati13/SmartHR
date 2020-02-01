Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Public Class ApprovalSchemeLeveling
    Inherits System.Web.UI.Page
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
#Region "Properties"
    Private ReadOnly Property SchemeID() As String
        Get
            Return Request.QueryString("scheme")
        End Get
    End Property
    Protected Property ListData() As DataTable
        Get
            Return DirectCast(ViewState("ListData"), DataTable)
        End Get
        Set(ByVal Value As DataTable)
            ViewState("ListData") = Value
        End Set
    End Property
    Private Property SequenceNo() As Integer
        Get
            Return DirectCast(ViewState("SequenceNo"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("SequenceNo") = Value
        End Set
    End Property
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Role") <> "Admin" Then
            Response.Redirect("Notauthorized.aspx")
            Exit Sub
        End If
        If Not Page.IsPostBack Then
            lblScheme.Text = Me.SchemeID
            lblName.Text = Me.SchemeID
            pnlApprovalPathTree.Visible = True
            pnlAddPath.Visible = False
            pnlAddMember.Visible = False
            pnlMember.Visible = False
            btnAddPath.Visible = True
        End If
        BindData()
    End Sub
    Protected Sub BindData()
        Dim dvEntity As DataView
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spApprovalLeveling")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add(New SqlParameter("@ApprovalSchemeID", Me.SchemeID))
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData
                    dvEntity = dtEntity.DefaultView
                    If dvEntity.Count <= 0 Then
                        lblMessage.Text = "Data Not Found"
                        lblMessage.Visible = True
                    End If

                    dtgLevelingPath.DataSource = dvEntity
                    Try
                        dtgLevelingPath.DataBind()
                    Catch
                        dtgLevelingPath.CurrentPageIndex = 0
                        dtgLevelingPath.DataBind()
                    End Try
                End Using
            End Using
        End Using


    End Sub
    Protected Sub BindSpesificPath(ByVal LevelID As Integer)
        Dim dvEntity As DataView
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spApprovalLeveling")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add(New SqlParameter("@ApprovalSchemeID", Me.SchemeID))
                cmd.Parameters.Add(New SqlParameter("@LevelID", LevelID))
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData
                    dvEntity = dtEntity.DefaultView
                    If dvEntity.Count <= 0 Then
                        lblMessage.Text = "Data Not Found"
                        lblMessage.Visible = True
                    End If

                    dtgLevelingPath.DataSource = dvEntity
                    Try
                        dtgLevelingPath.DataBind()
                    Catch
                        dtgLevelingPath.CurrentPageIndex = 0
                        dtgLevelingPath.DataBind()
                    End Try
                End Using
            End Using
        End Using


    End Sub
#Region "Bind Data Grid Member"
    Public Sub BindMember()

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spApprovalMember")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ApprovalSchemeID", Me.SchemeID)
                cmd.Parameters.AddWithValue("@ApprovalSeqNum", Me.SequenceNo)
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    dtgList.DataSource = dt.DefaultView
                    dtgList.DataBind()

                    If dtgList.Items.Count > 0 Then
                        pnlMember.Visible = True
                    Else
                        lblMessage.Text = "Data Member Not Found"
                        pnlMember.Visible = False
                    End If
                End Using
            End Using
        End Using
    End Sub
#End Region
    Private Sub dtgLevelingPath_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dtgLevelingPath.ItemCommand
        Dim lblLevelId As Label
        

        Select Case e.CommandName
            Case "Path"
                lblLevelId = DirectCast(e.Item.FindControl("lblLevelId"), Label)
                Me.SequenceNo = lblLevelId.Text
                BindSpesificPath(Me.SequenceNo)
                BindMember()
                btnMember.Visible = True
                btnDelete.Visible = True
                'btnUpdate.Visible = True
                btnCancel.Visible = True
                pnlAddPath.Visible = False
        End Select
    End Sub
    Private Sub dtgList_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dtgList.ItemCommand
        Dim lblEmployeeID As Label
        Select Case e.CommandName
            Case "DeleteMember"
                lblEmployeeID = DirectCast(e.Item.FindControl("lblEmployeeID"), Label)
                Try
                    Using con As New SqlConnection(constr)
                        Using cmd As New SqlCommand("spApprovalMemberDelete")
                            Using sda As New SqlDataAdapter()
                                cmd.CommandType = CommandType.StoredProcedure
                                cmd.Parameters.AddWithValue("@ApprovalSchemeID", Me.SchemeID)
                                cmd.Parameters.AddWithValue("@LevelID", Me.SequenceNo)
                                cmd.Parameters.AddWithValue("@EmployeeID", lblEmployeeID.Text.Trim)
                                cmd.Connection = con
                                con.Open()
                                cmd.ExecuteScalar()
                                con.Close()
                            End Using
                        End Using
                    End Using
                    pnlAddPath.Visible = False
                    pnlAddMember.Visible = False
                    BindSpesificPath(Me.SequenceNo)
                    BindMember()
                    btnMember.Visible = True
                    btnDelete.Visible = True
                    'btnUpdate.Visible = True
                    btnCancel.Visible = True
                    lblMessage.Text = "Delete Successfully !! "
                Catch ex As Exception
                    lblMessage.Visible = True
                    lblMessage.Text = "Delete Failed !! " & ex.Message
                    Exit Sub
                End Try
               
        End Select
    End Sub
    Private Sub btnAddPath_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddPath.Click
        pnlAddPath.Visible = True
        pnlAddMember.Visible = False
        pnlMember.Visible = False
    End Sub
    Private Sub btnSavePath_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSavePath.Click
        Try
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("spApprovalPathAdd")
                    Using sda As New SqlDataAdapter()
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@ApprovalSchemeID", Me.SchemeID)
                        cmd.Parameters.AddWithValue("@Pathname", txtScheme.Text.Trim())

                        cmd.Parameters.Add("@MessageError", SqlDbType.Char, 500)
                        cmd.Parameters("@MessageError").Direction = ParameterDirection.Output
                        cmd.Connection = con
                        con.Open()
                        cmd.ExecuteScalar()

                        Dim MessageError As String = CStr(cmd.Parameters("@MessageError").Value)
                        con.Close()

                        If MessageError.Trim <> "" Then
                            lblMessage.Visible = True
                            lblMessage.Text = "Save Failed !! " & MessageError
                            Return
                        End If
                    End Using
                End Using
            End Using
            pnlAddPath.Visible = False
            pnlAddMember.Visible = False
            btnDelete.Visible = False
            'btnUpdate.Visible = False
            btnMember.Visible = False
            BindData()
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "Save Failed !! " & ex.Message
        End Try
    End Sub
    Private Sub btnCancelPath_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancelPath.Click
        lblScheme.Text = Me.SchemeID
        lblName.Text = Me.SchemeID
        pnlApprovalPathTree.Visible = True
        pnlAddPath.Visible = False
        pnlAddMember.Visible = False
        pnlMember.Visible = False
        btnAddPath.Visible = True
        btnDelete.Visible = False
        'btnUpdate.Visible = False
        BindData()
    End Sub
    Private Sub btnSaveMember_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveMember.Click
        Try
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("spApprovalMemberAdd")
                    Using sda As New SqlDataAdapter()
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@ApprovalSchemeID", Me.SchemeID)
                        cmd.Parameters.AddWithValue("@ApprovalSeqNum", Me.SequenceNo)
                        cmd.Parameters.AddWithValue("@EmployeeID", ddlUserApproval.SelectedValue)
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text)
                        cmd.Connection = con
                        con.Open()
                        cmd.ExecuteScalar()
                        con.Close()
                    End Using
                End Using
            End Using
            pnlAddPath.Visible = False
            pnlAddMember.Visible = False
            BindMember()
            BindSpesificPath(Me.SequenceNo)
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "Save Failed !! " & ex.Message
        End Try
    End Sub
    Protected Sub GetEmployee()
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetEmployeeApv")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add(New SqlParameter("@ApprovalSchemeID", Me.SchemeID))
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
    Private Sub btnMember_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnMember.Click
        pnlAddMember.Visible = True
        pnlAddPath.Visible = False
        pnlMember.Visible = False
        BindSpesificPath(Me.SequenceNo)
        GetEmployee()
    End Sub
    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        lblScheme.Text = Me.SchemeID
        lblName.Text = Me.SchemeID
        pnlApprovalPathTree.Visible = True
        pnlAddPath.Visible = False
        pnlAddMember.Visible = False
        pnlMember.Visible = False
        btnAddPath.Visible = True
        btnDelete.Visible = False
        'btnUpdate.Visible = False
        btnMember.Visible = False
        btnCancel.Visible = False
        BindData()
    End Sub
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDelete.Click
        Try
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("spApprovalPathDelete")
                    Using sda As New SqlDataAdapter()
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@ApprovalSchemeID", Me.SchemeID)
                        cmd.Parameters.AddWithValue("@LevelID", Me.SequenceNo)
                        cmd.Connection = con
                        con.Open()
                        cmd.ExecuteScalar()
                        con.Close()
                    End Using
                End Using
            End Using
            pnlAddPath.Visible = False
            pnlAddMember.Visible = False
            lblScheme.Text = Me.SchemeID
            lblName.Text = Me.SchemeID
            pnlApprovalPathTree.Visible = True
            pnlAddPath.Visible = False
            pnlAddMember.Visible = False
            pnlMember.Visible = False
            btnAddPath.Visible = True
            btnDelete.Visible = False
            'btnUpdate.Visible = False
            BindData()
            lblMessage.Text = "Delete Successfully !! "
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "Delete Failed !! " & ex.Message
            Exit Sub
        End Try
        
    End Sub
End Class