Public Class HomePage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Session("EmployeeID") Is Nothing Then
                lblLoginLogout.Text = "Login"
            Else
                lblLoginLogout.Text = "Welcome " & Session("Username") & " - LogOut"
            End If
        End If
    End Sub

End Class