#Region "Imports"
Imports System.Data
Imports System.Data.SqlClient
Imports System.Xml
Imports squishyWARERF.WebComponents.squishyTREE
Imports System.Threading
Imports Telerik.WebControls
#End Region
Public Class ApprovalLeveling
    Inherits System.Web.UI.Page
#Region "Properties"
    Private ReadOnly Property SchemeID() As String
        Get
            Return Request.QueryString("scheme")
        End Get
    End Property
    Private Property AlternateAdd() As Boolean
        Get
            Return CBool(ViewState("AlternateMode"))
        End Get
        Set(ByVal Value As Boolean)
            ViewState("AlternateMode") = Value
        End Set
    End Property
    Private ReadOnly Property Limit() As Boolean
        Get
            Return CBool(Request.QueryString("limit"))
        End Get
    End Property
    Private ReadOnly Property ApprovalTypeID() As String
        Get
            Return Request.QueryString("ApprovalTypeID")
        End Get
    End Property
    Private Property ApprovalMember() As String
        Get
            Return DirectCast(ViewState("Member"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("Member") = Value
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

    Private Property ParentNumber() As Integer
        Get
            Return DirectCast(ViewState("ParentNumber"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("ParentNumber") = Value
        End Set
    End Property
    Private Property Level() As Integer
        Get
            Return DirectCast(ViewState("Level"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("Level") = Value
        End Set
    End Property

    Private Property Path() As String
        Get
            Return DirectCast(ViewState("Path"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("Path") = Value
        End Set
    End Property

    Private Property MemberID() As String
        Get
            Return DirectCast(ViewState("MemberID"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("MemberID") = Value
        End Set
    End Property

    Private Property AltSeqNum() As Integer
        Get
            Return DirectCast(ViewState("AltSeqNum"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("AltSeqNum") = Value
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
#End Region

    Dim constr As String = System.Configuration.ConfigurationManager.AppSettings("constr")
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            lblScheme.Text = Me.SchemeID
            lblName.Text = Me.SchemeID
            pnlApprovalPathTree.Visible = True
            pnlAddPath.Visible = False
            pnlAddMember.Visible = False
            pnlMember.Visible = False

        End If
        Create_Tree(Me.SchemeID)
    End Sub
    Private Sub Create_Tree(ByVal pStrSchemeID As String)

        Dim lObjDAPath As SqlDataAdapter
        Dim lObjDTPath As DataTable
        Dim lObjDRPath As DataRow()
        Dim lObjXML As XmlDocument
        Dim lStrXML As String = "<?xml version=""1.0"" encoding=""utf-8"" ?><MainPath><Scheme text=""" & pStrSchemeID & """ value=""1|0|0"">"
        Dim lStrSQL As String


        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spApprovalLeveling")
                cmd.Connection = con
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ApprovalSchemeID", Me.SchemeID)
                Using sda As New SqlDataAdapter(cmd)
                    Dim dt As New DataTable()
                    sda.Fill(dt)
                    lObjDTPath = dt
                    lObjDRPath = lObjDTPath.Select("ParentApprovalSeqNum='0'")
                    CreateNodeXML(lObjDTPath, lObjDRPath, lObjDRPath.Length - 1, lStrXML)
                    lStrXML &= "</Scheme></MainPath>"
                    lObjXML = New XmlDocument
                    lObjXML.LoadXml(lStrXML)
                    trvPath.XmlBind(lObjXML, "text", "value")
                End Using
            End Using
        End Using
    End Sub

    Private Sub CreateNodeXML(ByVal pObjDTPath As DataTable, _
                      ByVal pObjDRPath As DataRow(), _
                      ByVal pIntEnd As Integer, _
                      ByRef pStrXML As String)

        Dim lObjDRPath As DataRow()
        Dim lStrSeqNo As String
        Dim lStrLevel As String
        Dim lIntIndex As Integer = 0

        While lIntIndex <= pIntEnd
            lStrSeqNo = CStr(pObjDRPath(lIntIndex)("ApprovalSeqNum"))
            lStrLevel = CStr(pObjDRPath(lIntIndex)("Level_"))
            pStrXML &= "<Path text=""" & CStr(pObjDRPath(lIntIndex)("Description")) & """ value=""" & lStrLevel & "|" & lStrSeqNo & "|" & CStr(pObjDRPath(lIntIndex)("ParentApprovalSeqNum")) & """>"
            lObjDRPath = pObjDTPath.Select("ParentApprovalSeqNum='" & lStrSeqNo & "'")
            If lObjDRPath.Length > 0 Then
                CreateNodeXML(pObjDTPath, lObjDRPath, lObjDRPath.Length - 1, pStrXML)
            End If
            pStrXML &= "</Path>"
            lIntIndex += 1


        End While
    End Sub
    Private Function Is_ParentHasMember(ByVal pStrSchemeID As String, _
                                     ByVal pStrParentSeqNum As String) As Boolean

        Dim lObjDAMember As SqlDataAdapter
        Dim lObjDTMember As DataTable
        Dim lStrSQL As String
        Dim lBlnParentHasMember As Boolean

        lStrSQL = "select EmployeeID from ApprovalSchemeDetail where " _
                                & "ApprovalSchemeID = '" & pStrSchemeID & "' and " _
                & "LevelID = " & pStrParentSeqNum

        Try
            lObjDAMember = New SqlDataAdapter(lStrSQL, constr)
            lObjDTMember = New DataTable
            lObjDAMember.Fill(lObjDTMember)

            lBlnParentHasMember = CBool(CStr(IIf(lObjDTMember.Rows.Count > 0, True, False)))
            lObjDTMember.Dispose()
            lObjDAMember.Dispose()
        Catch e As Exception
            lblMessage.Text = e.Message

        Finally
            lObjDTMember = Nothing
            lObjDAMember = Nothing
        End Try

        Return lBlnParentHasMember

    End Function
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

                    If dtgList.Items.Count >= 0 Then
                        pnlMember.Visible = True
                    Else
                        pnlMember.Visible = False
                    End If
                End Using
            End Using
        End Using
    End Sub
#End Region
    Private Sub trvPath_SelectedNodeChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles trvPath.SelectedNodeChanged
        Dim lObjTree As TreeViewNodeClickEventArgs
        Dim lObjDTMember As DataTable
        Dim lStrValue As String
        Dim lArrValue() As String

        lObjTree = CType(e, TreeViewNodeClickEventArgs)
        lblName.Text = lObjTree.Node.Text
        lStrValue = CStr(lObjTree.Node.Key)
        lArrValue = Split(lStrValue, "|")

        Me.Level = CInt(lArrValue(0))
        Me.SequenceNo = CInt(lArrValue(1))
        Me.ParentNumber = CInt(lArrValue(2))

        'btnAddPath.Visible = True
        btnAddPath.Visible = CBool(IIf(lStrValue = "1|0|0" And lObjTree.Node.Controls.Count <> 0, False, True))
        btnDelete.Visible = CBool(IIf(lStrValue = "1|0|0" Or lObjTree.Node.Controls.Count <> 0, False, True))
        btnUpdate.Visible = CBool(IIf(lStrValue = "1|0|0", False, True))
        btnMember.Visible = CBool(IIf(lStrValue = "1|0|0", False, IIf(CStr(Me.Level).Trim = "2" Or Is_ParentHasMember(Me.SchemeID, lArrValue(2)), True, False)))

        pnlAddPath.Visible = False
        pnlMember.Visible = False
        pnlAddMember.Visible = False
        pnlButton.Visible = True

        If lStrValue = "1|0|0" Then
            pnlAddMember.Visible = False
            pnlMember.Visible = False
        Else
            BindMember()
        End If

        lObjTree = Nothing

    End Sub
    Private Sub btnMember_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnMember.Click
        pnlAddMember.Visible = True
        pnlAddPath.Visible = False
        pnlMember.Visible = False

        GetEmployee()
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
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "Save Failed !! " & ex.Message
        End Try
    End Sub
    Protected Sub GetEmployee()
        Dim dtEntity As DataTable
        Dim conn As New SqlConnection(constr)

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("spGetEmployee")
                cmd.Connection = con
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
        Catch ex As Exception
            lblMessage.Visible = True
            lblMessage.Text = "Save Failed !! " & ex.Message
        End Try
    End Sub
End Class