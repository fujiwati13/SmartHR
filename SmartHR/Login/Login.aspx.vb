Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Web.Security
Imports System.Security.Cryptography
Imports System.IO

Public Class Login
    Inherits System.Web.UI.Page
    Dim constr As String = System.Configuration.ConfigurationManager.AppSettings("constr")
    Protected Property EmployeeID() As String
        Get
            Return DirectCast(ViewState("EmployeeID"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("EmployeeID") = Value
        End Set
    End Property
    Private ReadOnly Property Page() As String
        Get
            If Request.QueryString("Page") Is Nothing Or Request.QueryString("Page") = "" Then
                Return ""
            Else
                Return Request.QueryString("Page")
            End If
        End Get
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Session("EmployeeID") = Nothing
            Session("Username") = Nothing
            Session("Role") = Nothing
        End If
    End Sub

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
    Protected Sub btLogin_Click(sender As Object, e As EventArgs)
        Dim Password As String
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SPValidateUser")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim)

                cmd.Connection = con
                con.Open()
                Password = cmd.ExecuteScalar()
                If Password = "0" Then
                    lblmessage.Visible = True
                    lblmessage.Text = "Username is incorrect."
                    Exit Sub
                Else
                    Password = Decrypt(Convert.ToString(cmd.ExecuteScalar()))
                End If
                con.Close()
            End Using

            If Password = "0" Then
                lblmessage.Visible = True
                lblmessage.Text = "Username is incorrect."
                Exit Sub
            ElseIf txtPassword.Text <> Password Then
                lblmessage.Visible = True
                lblmessage.Text = "Password is incorrect."
                Exit Sub
            Else
                Session("Username") = txtUsername.Text.Trim
                GetEmployeeID()
                GetRole()

                If Me.Session("Role") = "Admin" And Me.Page <> "Doc" Then
                    Response.Redirect("../DataMaster/HomeAdmin.aspx")
                ElseIf Me.Page = "Doc" Then
                    Response.Redirect("../Document/HomeDoc.aspx")
                ElseIf Me.Page = "Cuti" Then
                    Response.Redirect("../Leave/HomeLeave.aspx")
                ElseIf Me.Page = "Reimburse" Then
                    Response.Redirect("../Reimburse/HomeReimburse.aspx")
                ElseIf Me.Page = "Overtime" Then
                    Response.Redirect("../Overtime/HomeOvertime.aspx")
                ElseIf Me.Page = "Report" Then
                    Response.Redirect("../Report/HomeReport.aspx")
                ElseIf Me.Page = "LiveChat" Then
                    Response.Redirect("../LiveChat/LiveChat.aspx")
                Else
                    Response.Redirect("../HomePage.aspx")
                End If
            End If

        End Using
    End Sub
    Protected Sub GetEmployeeID()
        Dim EmployeeID As String
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetEmployeeID")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim)
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim)
                cmd.Connection = con
                con.Open()
                EmployeeID = Convert.ToString(cmd.ExecuteScalar())
                Session("EmployeeID") = EmployeeID
                Me.EmployeeID = Session("EmployeeID")
                con.Close()
            End Using

        End Using
    End Sub
    Protected Sub GetRole()
        Dim RoleEmpl As String
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetRole")
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim)
                cmd.Connection = con
                con.Open()
                RoleEmpl = Convert.ToString(cmd.ExecuteScalar())
                Session("Role") = RoleEmpl
                con.Close()
            End Using

        End Using
    End Sub

End Class