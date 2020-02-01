<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Document/Document.Master" CodeBehind="RequestDocument.aspx.vb" Inherits="SmartHR.RequestDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
     <form id="Form1" action="#" method="post" runat="server">
         <h2>Request Document</h2>
        <br />
        <table border="0" cellspacing="0" cellpadding="0" width="95%" align="center">
            <tr>
                <td>
                    <asp:Label ID="lblMessage" runat="server" ForeColor="red" font-name="Verdana" Font-Size="11px"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <asp:Panel runat="server" ID="pnlDetail" Visible="true">
            <table border="0" width="95%">
                <tr>
                    <td width="30%">
                        <h5><asp:Label runat="server" ID="Label6">Document</asp:Label></h5>
                     </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label7">:</asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlDocument" runat="server">
                        </asp:DropDownList>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" Display="Dynamic" ControlToValidate="ddlDocument"
								ErrorMessage="Please Fill Document Type!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5><asp:Label runat="server" ID="lbl">Due Date</asp:Label></h5></td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label1">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtDueDate" CssClass="inptype" runat="server" TextMode="Date"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator3" runat="server" Display="Dynamic" ControlToValidate="txtDueDate"
								ErrorMessage="Please Fill Due Date !" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5><asp:Label runat="server" ID="Label2">Notes</asp:Label></h5></td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label3">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtNotes" runat="server" CssClass="inptype" TextMode="MultiLine"  MaxLength="100" Width="500px" Height="100px"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Display="Dynamic" ControlToValidate="txtNotes"
								ErrorMessage="Please Fill Notes!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5><asp:Label runat="server" ID="Label4">User Approval</asp:Label></h5></td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label5">:</asp:Label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlUserApproval">
                        </asp:DropDownList>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator4" runat="server" Display="Dynamic" ControlToValidate="ddlUserApproval"
								ErrorMessage="Please Fill User Approval!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
            </table>

            <br />

            <div>
                <asp:Button runat="server" ID="btnsave" OnClick="btnsave_Click" Text="Save" />
                &nbsp;
                 <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" Text="Cancel"  CausesValidation="false"/>
            </div>
        </asp:Panel>
    </form>
</asp:Content>
