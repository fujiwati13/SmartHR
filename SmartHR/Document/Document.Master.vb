Public Class Document
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblUsername.InnerText = Session("Username")
        End If
    End Sub

    'Protected Sub btnLogout_Click(sender As Object, e As EventArgs)
    '    Session("EmployeeID") = Nothing
    '    Session("Role") = Nothing
    '    Session("Username") = Nothing
    '    Response.Redirect("../HomePage.aspx")
    'End Sub
End Class