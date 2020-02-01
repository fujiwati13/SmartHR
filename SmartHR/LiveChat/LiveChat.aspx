<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/LiveChat/LiveChat.Master" CodeBehind="LiveChat.aspx.vb" Inherits="SmartHR.LiveChat1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
     <form id="Form1" action="#" method="post" runat="server">
        <h2>Live Chat</h2>
        <br />
        <asp:Panel runat="server" ID="pnlDetail" Visible="true">
            <table border="0" width="95%">
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label4">Departement</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label5">:</asp:Label></td>
                    <td align="left">
                        <asp:DropDownList runat="server" ID="ddlDeptID" OnSelectedIndexChanged="ddlDeptID_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label1">User</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label6">:</asp:Label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlUser"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label12">Message</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label10">:</asp:Label></td>
                    <td>
                        <asp:TextBox runat="server" ID="txtMessage" TextMode="MultiLine" Width="400px" Height="250px"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <div>
                <asp:Button runat="server" ID="btnSend" OnClick="btnSend_Click" Text="Send" />
            </div>
        </asp:Panel>
    </form>
</asp:Content>
