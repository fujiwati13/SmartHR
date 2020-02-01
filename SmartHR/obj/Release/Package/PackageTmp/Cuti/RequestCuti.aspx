<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Cuti/Cuti.Master" CodeBehind="RequestCuti.aspx.vb" Inherits="SmartHR.RequestCuti" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
         <form id="Form1" action="#" method="post" runat="server">
         <h2>Request Cuti</h2>
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
                        <h5><asp:Label runat="server" ID="Label4">Jenis Cuti</asp:Label></h5>
                     </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label5">:</asp:Label></td>
                    <td>
                        <asp:CheckBoxList runat="server" ID="cblJenisCuti" RepeatDirection="Vertical">
                        </asp:CheckBoxList>
                        <font color="red">*)
                        </font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5><asp:Label runat="server" ID="Label8">Mulai Tanggal</asp:Label></h5></td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label9">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtStartDate" CssClass="inptype" runat="server" TextMode="Date"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator5" runat="server" Display="Dynamic" ControlToValidate="txtStartDate"
								ErrorMessage="Please Fill Tanggal Mulai Cuti !" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5><asp:Label runat="server" ID="Label10">Mulai Kembali</asp:Label></h5></td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label11">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtEndDate" CssClass="inptype" runat="server" TextMode="Date"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator6" runat="server" Display="Dynamic" ControlToValidate="txtEndDate"
								ErrorMessage="Please Fill Tanggal Akhir Cuti !" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5><asp:Label runat="server" ID="Label12">Keterangan</asp:Label></h5></td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label13">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtKeterangan" runat="server" CssClass="inptype" TextMode="MultiLine"  MaxLength="100" Width="500px" Height="100px"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator7" runat="server" Display="Dynamic" ControlToValidate="txtKeterangan"
								ErrorMessage="Please Fill Keterangan Cuti!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3">No Telp dan Alamat yang bisa di hubungi saat Cuti</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5><asp:Label runat="server" ID="Label1">Alamat</asp:Label></h5></td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label14">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtAlamat" runat="server" CssClass="inptype" TextMode="MultiLine"  MaxLength="100" Width="500px" Height="100px"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator3" runat="server" Display="Dynamic" ControlToValidate="txtAlamat"
								ErrorMessage="Please Fill Alamat!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5><asp:Label runat="server" ID="Label6">No.Telp</asp:Label></h5>
                     </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label7">:</asp:Label></td>
                    <td>
                        <asp:TextBox runat="server" ID="txtNotelp"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" Display="Dynamic" ControlToValidate="txtNotelp"
								ErrorMessage="Please Fill No Telp!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5><asp:Label runat="server" ID="Label2">User Approval</asp:Label></h5></td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label3">:</asp:Label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlUserApproval"></asp:DropDownList>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Display="Dynamic" ControlToValidate="ddlUserApproval"
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
