Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Security.Cryptography
Imports System.IO
Public Class Employee
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
    Protected Property EmployeeID() As String
        Get
            Return DirectCast(ViewState("EmployeeID"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("EmployeeID") = Value
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
            'lblUsername.Text = Session("Username")
            GetGolongan()
            GetPosition()
            GetDepartement()
        End If
    End Sub
    Public Function Encrypt(str As String) As String
        Dim EncrptKey As String = "2013;[pnuLIT)WebCodeExpert"
        Dim byKey As Byte() = {}
        Dim IV As Byte() = {18, 52, 86, 120, 144, 171, _
         205, 239}
        byKey = System.Text.Encoding.UTF8.GetBytes(EncrptKey.Substring(0, 8))
        Dim des As New DESCryptoServiceProvider()
        Dim inputByteArray As Byte() = Encoding.UTF8.GetBytes(str)
        Dim ms As New MemoryStream()
        Dim cs As New CryptoStream(ms, des.CreateEncryptor(byKey, IV), CryptoStreamMode.Write)
        cs.Write(inputByteArray, 0, inputByteArray.Length)
        cs.FlushFinalBlock()
        Return Convert.ToBase64String(ms.ToArray())
    End Function

    Public Function Decrypt(str As String) As String
        str = str.Replace(" ", "+")
        Dim DecryptKey As String = "2013;[pnuLIT)WebCodeExpert"
        Dim byKey As Byte() = {}
        Dim IV As Byte() = {18, 52, 86, 120, 144, 171, _
         205, 239}
        Dim inputByteArray As Byte() = New Byte(str.Length - 1) {}

        byKey = System.Text.Encoding.UTF8.GetBytes(DecryptKey.Substring(0, 8))
        Dim des As New DESCryptoServiceProvider()
        inputByteArray = Convert.FromBase64String(str.Replace(" ", "+"))
        Dim ms As New MemoryStream()
        Dim cs As New CryptoStream(ms, des.CreateDecryptor(byKey, IV), CryptoStreamMode.Write)
        cs.Write(inputByteArray, 0, inputByteArray.Length)
        cs.FlushFinalBlock()
        Dim encoding As System.Text.Encoding = System.Text.Encoding.UTF8
        Return encoding.GetString(ms.ToArray())
    End Function

    Sub Reset()
        txtNIK.Text = ""
        ddlGolongan.SelectedValue = ""
        txtName.Text = ""
        txtUsername.Text = ""
        txtPassword.Text = ""
        txtBirthPlace.Text = ""
        txtBirthDate.Text = ""
        ddlGender.SelectedValue = ""
        txtPhone.Text = ""
        txtEmail.Text = ""
        txtAddress.Text = ""
        txtJoinDate.Text = ""
        ddlPosition.SelectedValue = ""
        ddlDepartement.SelectedValue = ""
        ddlGolongan.SelectedValue = ""
    End Sub
    Protected Sub BindData(ByVal CmdWhere As String)
        Dim dvEntity As DataView
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spPagingEmployee")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add(New SqlParameter("@CurrentPage", currentPage))
                cmd.Parameters.Add(New SqlParameter("@PageSize", pageSize))
                cmd.Parameters.Add(New SqlParameter("@WhereCond", Me.CmdWhere))
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
    Protected Sub GetPosition()
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetPosition")
                cmd.Connection = con
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData


                    With ddlPosition
                        .DataSource = dtEntity.DefaultView
                        .DataTextField = "PositionName"
                        .DataValueField = "PositionID"
                        .DataBind()
                        .Items.Insert(0, "Select One")
                        .Items(0).Value = ""
                    End With
                End Using
            End Using
        End Using
    End Sub
    Protected Sub GetDepartement()
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetDepartement")
                cmd.Connection = con
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData


                    With ddlDepartement
                        .DataSource = dtEntity.DefaultView
                        .DataTextField = "DeptName"
                        .DataValueField = "DepartementID"
                        .DataBind()
                        .Items.Insert(0, "Select One")
                        .Items(0).Value = ""
                    End With
                End Using
            End Using
        End Using
    End Sub
    Private Sub dtgList_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dtgList.ItemCommand
        Dim lblEmployeeID As Label
        Dim lblNIK As Label
        Dim lblName As Label
        Dim lblUsername As Label
        Dim lblPassword As Label
        Dim lblBirthPlace As Label
        Dim lblBirthDate As Label
        Dim lblGender As Label
        Dim lblPhone As Label
        Dim lblEmail As Label
        Dim lblAddress As Label
        Dim lblJoinDate As Label
        Dim lblPositionID As Label
        Dim lblDepartementID As Label
        Dim lblGolonganID As Label
        Dim lblRole As Label
        Dim lblNoWa As Label

        Select Case e.CommandName
            Case "Edit"
                FlagAddEdit = "Edit"
                pnlDetail.Visible = True
                lblMessage.Text = ""

                lblEmployeeID = DirectCast(e.Item.FindControl("lblEmployeeID"), Label)
                Me.EmployeeID = lblEmployeeID.Text

                lblNIK = DirectCast(e.Item.FindControl("lblNIK"), Label)
                txtNIK.Text = lblNIK.Text

                lblName = DirectCast(e.Item.FindControl("lblName"), Label)
                txtName.Text = lblName.Text

                lblUsername = DirectCast(e.Item.FindControl("lblUsername"), Label)
                txtUsername.Text = lblUsername.Text

                Dim pass As String
                lblPassword = DirectCast(e.Item.FindControl("lblPassword"), Label)
                pass = Decrypt(lblPassword.Text)
                txtPassword.Text = pass

                lblBirthPlace = DirectCast(e.Item.FindControl("lblBirthPlace"), Label)
                txtBirthPlace.Text = lblBirthPlace.Text


                lblBirthDate = DirectCast(e.Item.FindControl("lblBirthDate"), Label)
                Dim bd As DateTime = DateTime.Parse(lblBirthDate.Text)
                txtBirthDate.Text = String.Format("{0:yyyy-MM-dd}", bd) 'x.ToString("MM/dd/yyyy") 'lblBirthDate.Text

                lblGender = DirectCast(e.Item.FindControl("lblGender"), Label)
                ddlGender.SelectedValue = lblGender.Text

                lblPhone = DirectCast(e.Item.FindControl("lblPhone"), Label)
                txtPhone.Text = lblPhone.Text

                lblEmail = DirectCast(e.Item.FindControl("lblEmail"), Label)
                txtEmail.Text = lblEmail.Text

                lblAddress = DirectCast(e.Item.FindControl("lblAddress"), Label)
                txtAddress.Text = lblAddress.Text

                lblJoinDate = DirectCast(e.Item.FindControl("lblJoinDate"), Label)
                Dim jd As DateTime = DateTime.Parse(lblJoinDate.Text)
                txtJoinDate.Text = String.Format("{0:yyyy-MM-dd}", jd)

                lblPositionID = DirectCast(e.Item.FindControl("lblPositionID"), Label)
                ddlPosition.SelectedValue = lblPositionID.Text

                lblDepartementID = DirectCast(e.Item.FindControl("lblDepartementID"), Label)
                ddlDepartement.SelectedValue = lblDepartementID.Text

                lblGolonganID = DirectCast(e.Item.FindControl("lblGolonganID"), Label)
                ddlGolongan.SelectedValue = lblGolonganID.Text

                lblNoWa = DirectCast(e.Item.FindControl("lblNoWa"), Label)
                txtNoWa.Text = lblNoWa.Text

                lblRole = DirectCast(e.Item.FindControl("lblRole"), Label)
                ddlRole.SelectedValue = lblRole.Text

                txtNIK.Enabled = False
                pnlList.Visible = False
                pnlSearch.Visible = False
            Case "Delete"
                lblEmployeeID = DirectCast(e.Item.FindControl("lblEmployeeID"), Label)
                Try
                    Using con As New SqlConnection(constr)
                        Using cmd As New SqlCommand("spDeleteEmployee")
                            Using sda As New SqlDataAdapter()
                                cmd.CommandType = CommandType.StoredProcedure
                                cmd.Parameters.AddWithValue("@EmployeeID", lblEmployeeID.Text.Trim())
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
                    lblMessage.Text = ex.Message
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
                CmdWhere = CmdWhere & ddlSearch.SelectedItem.Value.Trim & "= '" & txtSearch.Text.Trim & "' "
            End If
            'If ddlSearch.SelectedItem.Value.Trim = "NIK" Then
            '    If CBool(InStr(txtSearch.Text, "%")) Then
            '        CmdWhere = CmdWhere & CmdWhere & "NIK like '" & txtSearch.Text.Trim & "' "
            '    Else
            '        CmdWhere = CmdWhere & "NIK = '" & txtSearch.Text.Trim & "' "
            '    End If
            'ElseIf ddlSearch.SelectedItem.Value.Trim = "EmployeeName" Then
            '    If Right(txtSearch.Text.Trim, 1) = "%" Then
            '        CmdWhere = CmdWhere & "EmployeeName like '" & txtSearch.Text.Trim & "' "
            '    Else
            '        CmdWhere = CmdWhere & "EmployeeName like '" & txtSearch.Text.Trim & "' "
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
                Using cmd As New SqlCommand("spSaveAddEditEmployee")
                    Using sda As New SqlDataAdapter()
                        cmd.CommandType = CommandType.StoredProcedure
                        cmd.Parameters.AddWithValue("@NIK", txtNIK.Text.Trim())
                        cmd.Parameters.AddWithValue("@EmployeeName", txtName.Text.Trim())
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim())
                        cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue.Trim())
                        cmd.Parameters.AddWithValue("@BirthPlace", txtBirthPlace.Text.Trim())
                        cmd.Parameters.AddWithValue("@BirthDate", txtBirthDate.Text.Trim())
                        cmd.Parameters.AddWithValue("@NoTelp", txtPhone.Text.Trim())
                        cmd.Parameters.AddWithValue("@PositionID", ddlPosition.SelectedValue.Trim())
                        cmd.Parameters.AddWithValue("@DepartementID", ddlDepartement.SelectedValue.Trim())
                        cmd.Parameters.AddWithValue("@GolonganID", ddlGolongan.SelectedValue.Trim())
                        cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim())
                        cmd.Parameters.AddWithValue("@PASSWORD", Encrypt(txtPassword.Text.Trim()))
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim())
                        cmd.Parameters.AddWithValue("@JoinDate", txtJoinDate.Text.Trim())
                        cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue.Trim())
                        cmd.Parameters.AddWithValue("@Flag", Me.FlagAddEdit)
                        cmd.Parameters.AddWithValue("@NoWhatsApp", txtNoWa.Text.Trim())
                        If Me.FlagAddEdit = "Edit" Then
                            cmd.Parameters.AddWithValue("@EmployeeID", Me.EmployeeID)
                        End If
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
            lblMessage.Text = ex.Message
        End Try

    End Sub

    Protected Sub btnAdd_Click(sender As Object, e As EventArgs)
        FlagAddEdit = "Add"
        lblMessage.Text = ""
        pnlSearch.Visible = False
        pnlList.Visible = False
        pnlDetail.Visible = True
        GetGolongan()
        GetPosition()
        GetDepartement()
    End Sub


    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        Reset()
        Response.Redirect("Employee.aspx")
    End Sub
End Class