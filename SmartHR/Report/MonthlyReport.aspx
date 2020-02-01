<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Report/Report.Master" CodeBehind="MonthlyReport.aspx.vb" Inherits="SmartHR.MonthlyReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <form id="Form1" action="#" method="post" runat="server">
        <h2>Monthly Report</h2>
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
                        <h5>
                            <asp:Label runat="server" ID="Label6">Report Type</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label7">:</asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlReportType" runat="server">
                            <asp:ListItem Value="">Select One</asp:ListItem>
                            <asp:ListItem Value="L">Leave Report</asp:ListItem>
                            <asp:ListItem Value="R">Reimburse Report</asp:ListItem>
                            <asp:ListItem Value="O">Overtime Report</asp:ListItem>
                            <asp:ListItem Value="D">Document Report</asp:ListItem>
                        </asp:DropDownList>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" Display="Dynamic" ControlToValidate="ddlReportType"
								ErrorMessage="Please Fill Document Type!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label2">Employee Name</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label3">:</asp:Label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlEmployee"></asp:DropDownList>
                       <%-- <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="inptype" Width="400px" Height="20px"></asp:TextBox>--%>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Display="Dynamic" ControlToValidate="ddlEmployee"
								ErrorMessage="Please Fill Employee Name!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label4">Date From</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label5">:</asp:Label></td>
                    <td>
                        <asp:TextBox runat="server" ID="txtDateFrom" TextMode="Date"></asp:TextBox>
                         <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator4" runat="server" Display="Dynamic" ControlToValidate="txtDateFrom"
								ErrorMessage="Please Fill Date From!" InitialValue=""></asp:RequiredFieldValidator></font>
                        <b>DATE TO</b>
                        <asp:TextBox runat="server" ID="txtDateTo" TextMode="Date"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator3" runat="server" Display="Dynamic" ControlToValidate="txtDateTo"
								ErrorMessage="Please Fill Date To!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
            </table>

            <br />

            <div align="right" width="95%">
                <asp:Button runat="server" ID="btnPrint" OnClick="btnPrint_Click" Text="Print" />
                &nbsp;
                 <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" Text="Cancel" CausesValidation="false" />
            </div>
        </asp:Panel>
    </form>
</asp:Content>
