<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Leave/Leave.Master" CodeBehind="RequestLeave.aspx.vb" Inherits="SmartHR.RequestLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <form id="Form1" action="#" method="post" runat="server">
        <h2>Request Leave</h2>
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
                            <asp:Label runat="server" ID="Label4">Leave Type</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label5">:</asp:Label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="cblLeaveType">
                        </asp:DropDownList>
                         <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator8" runat="server" Display="Dynamic" ControlToValidate="cblLeaveType"
								ErrorMessage="Please Fill User Leave Type!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label8">Start Date</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label9">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtStartDate" CssClass="inptype" runat="server" TextMode="Date"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator5" runat="server" Display="Dynamic" ControlToValidate="txtStartDate"
								ErrorMessage="Please Fill Start Date !" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label10">End Date</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label11">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtEndDate" CssClass="inptype" runat="server" TextMode="Date"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator6" runat="server" Display="Dynamic" ControlToValidate="txtEndDate"
								ErrorMessage="Please Fill End Date !" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label15">Num Of Days</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label16">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtDuration" CssClass="inptype" runat="server"></asp:TextBox>
                        <font color="red">*)<asp:rangevalidator id="Rangevalidator25" runat="server" ErrorMessage="Invalid Number!" ControlToValidate="txtDuration"
										Display="Dynamic" MinimumValue="0" Type="Integer" MaximumValue="365"></asp:rangevalidator><asp:RequiredFieldValidator id="Requiredfieldvalidator4" runat="server" Display="Dynamic" ControlToValidate="txtDuration"
								ErrorMessage="Please Fill Num Of Days !" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label12">Notes</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label13">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtKeterangan" runat="server" CssClass="inptype" TextMode="MultiLine" MaxLength="100" Width="500px" Height="100px"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator7" runat="server" Display="Dynamic" ControlToValidate="txtKeterangan"
								ErrorMessage="Please Fill Keterangan Cuti!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3">Handphone Number and Address</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label1">Address</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label14">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtAlamat" runat="server" CssClass="inptype" TextMode="MultiLine" MaxLength="100" Width="500px" Height="100px"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator3" runat="server" Display="Dynamic" ControlToValidate="txtAlamat"
								ErrorMessage="Please Fill Alamat!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label6">Handphone Number</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label7">:</asp:Label></td>
                    <td>
                        <asp:TextBox runat="server" ID="txtNotelp" MaxLength="15"></asp:TextBox>
                        <font color="red">*)<asp:regularexpressionvalidator id="RegularExpressionValidator5" runat="server" ErrorMessage="Invalid Phone Number!"
											ControlToValidate="txtNotelp" Display="Dynamic" ValidationExpression="\d*"></asp:regularexpressionvalidator> <asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" Display="Dynamic" ControlToValidate="txtNotelp"
								ErrorMessage="Please Fill No Telp!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label2">User Approval</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label3">:</asp:Label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlUserApproval">
                        </asp:DropDownList>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Display="Dynamic" ControlToValidate="ddlUserApproval"
								ErrorMessage="Please Fill User Approval!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
            </table>

            <br />

            <div>
                <asp:Button runat="server" ID="btnsave" OnClick="btnsave_Click" Text="Save" />
                &nbsp;
                 <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" Text="Cancel" CausesValidation="false" />
            </div>
        </asp:Panel>
    </form>
</asp:Content>
