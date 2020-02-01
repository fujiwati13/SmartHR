Public Class Site
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblUsername.Text = Session("Username")
    End Sub


    'Protected Sub btnLogOut_Click(sender As Object, e As EventArgs)
    '    Session("EmployeeID") = Nothing
    '    Session("Role") = Nothing
    '    Session("Username") = Nothing
    '    Response.Redirect("../HomePage.aspx")
    'End Sub
End Class