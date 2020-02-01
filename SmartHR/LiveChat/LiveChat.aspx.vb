Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Security.Cryptography
Imports System.IO
Public Class LiveChat1
    Inherits System.Web.UI.Page

#Region "PrivateConstanta"
    Dim constr As String = System.Configuration.ConfigurationManager.AppSettings("constr")
#End Region
#Region "Property"
    Protected Property ListData() As DataTable
        Get
            Return DirectCast(ViewState("ListData"), DataTable)
        End Get
        Set(ByVal Value As DataTable)
            ViewState("ListData") = Value
        End Set
    End Property
    Protected Property WAApi() As String
        Get
            Return DirectCast(ViewState("WAApi"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("WAApi") = Value
        End Set
    End Property
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Session("EmployeeID") Is Nothing Then
                Response.Redirect("../Login/Login.aspx?Page=LiveChat")
            Else
                GetDepartement()
            End If
        End If
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


                    With ddlDeptID
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
    Protected Sub GetUser(DeptID As String)
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        'Using con As New SqlConnection(constr)
        '    Using cmd As New SqlCommand("spGetEmployee")
        '        cmd.Connection = con
        '        Using sda As New SqlDataAdapter(cmd)
        '            cmd.Parameters.Add(New SqlParameter("@DepartementID", DeptID))
        '            Dim dt As New DataTable()
        '            sda.Fill(dt)
        '            Me.ListData = dt
        '            dtEntity = Me.ListData


        '            With ddlUser
        '                .DataSource = dtEntity.DefaultView
        '                .DataTextField = "EmployeeName"
        '                .DataValueField = "NoWhatsApp"
        '                .DataBind()
        '                .Items.Insert(0, "Select One")
        '                .Items(0).Value = ""
        '            End With
        '        End Using
        '    End Using
        'End Using
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetEmployee")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add(New SqlParameter("@DepartementID", DeptID))
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    Me.ListData = dt
                    dtEntity = Me.ListData

                    With ddlUser
                        .DataSource = dtEntity.DefaultView
                        .DataTextField = "EmployeeName"
                        .DataValueField = "NoWhatsApp"
                        .DataBind()
                        .Items.Insert(0, "Select One")
                        .Items(0).Value = ""
                    End With
                End Using
            End Using
        End Using
    End Sub
    Protected Sub btnSend_Click(sender As Object, e As EventArgs)
        Me.WAApi = "https://api.whatsapp.com/send?phone=" & ddlUser.SelectedValue.Trim & "&text=Halo " & ddlUser.SelectedItem.ToString & " Saya " & Session("Username") & "," & Replace(txtMessage.Text, Chr(13), " ")
        'Response.Redirect(Me.WAApi)
        ClientScript.RegisterStartupScript(Me.GetType(), "script", "window.open('" & Me.WAApi + "', 'popup_window', 'width=600,height=400,left=350,top=100,scrollbars=yes');", True)
        txtMessage.Text = ""
        GetDepartement()
    End Sub

    Protected Sub ddlDeptID_SelectedIndexChanged(sender As Object, e As EventArgs)
        GetUser(ddlDeptID.SelectedValue)
    End Sub
End Class