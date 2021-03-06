﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Reimburse/Reimburse.Master" CodeBehind="PaymentReimburse.aspx.vb" Inherits="SmartHR.PaymentReimburse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script language="JavaScript">
        function OpenAttachment(EmployeeName, RaimburseType, AttachmentID, EmployeeID) {
            var AppInfo = '<%= Request.servervariables("PATH_INFO")%>';
            var App = AppInfo.substr(1, AppInfo.indexOf('/', 1) - 1); //
            window.open('http://localhost:54786/' + App + '/FileAttachment.aspx?EmployeeName=' + EmployeeName + '&ReimburseType=' + RaimburseType + '&AttachmentID=' + AttachmentID + '&EmployeeID=' + EmployeeID, 'UserLookup', 'left=0, top=0, width=700, height=600, menubar=0, scrollbars=yes');
        }
    </script>
    <style type="text/css">
        .auto-style1
        {
            width: 27%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <form id="Form1" action="#" method="post" runat="server">
        <h2>Payment Reimburse</h2>
        <br />
        <table border="0" cellspacing="0" cellpadding="0" width="95%" align="center">
            <tr>
                <td>
                    <asp:Label ID="lblMessage" runat="server" ForeColor="red" font-name="Verdana" Font-Size="11px"></asp:Label>
                    <font color="red"><asp:RangeValidator ID="rgvGo" runat="server" ControlToValidate="txtGoPage" Type="Integer" MinimumValue="1"
                                    MaximumValue="1" ErrorMessage="Page No. is not valid!"></asp:RangeValidator></font>
                </td>
            </tr>
        </table>
        <br />
        <asp:Panel ID="pnlSearch" runat="server">
            <table border="0" cellspacing="1" cellpadding="2" width="95%" align="center">
                <tr>
                    <td width="30%">Search By</td>
                    <td width="60%">
                        <asp:DropDownList ID="ddlSearch" runat="server">
                            <asp:ListItem Value="RaimburseNo">Raimburse No</asp:ListItem>
                            <asp:ListItem Value="EmployeeName">Employee Name</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="inptype"></asp:TextBox>
                        <font color="red"><asp:RequiredFieldValidator ID="rfvSearch" Runat="server" ControlToValidate="txtSearch" ErrorMessage="Please Fill Search Criteria" Display=Dynamic></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="2" width="95%" align="center">
                <tr>
                    <td colspan="2" align="right">
                        <asp:ImageButton ID="imbSearch" runat="server" CausesValidation="True" ImageUrl="../Images/ButtonSearch.gif"></asp:ImageButton>
                        <asp:ImageButton ID="imbReset" runat="server" CausesValidation="False" ImageUrl="../Images/ButtonReset.gif"></asp:ImageButton>
                    </td>
                </tr>
            </table>
            <br>
        </asp:Panel>
        <asp:Panel ID="pnlList" runat="server">
            <table border="1" cellspacing="0" cellpadding="0" width="95%" align="center">
                <tr>
                    <td align="center" colspan="3" style="background-color: cadetblue; color: black">REIMBURSE LIST</td>
                </tr>
            </table>
            <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                <tr>
                    <td>
                        <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="RaimburseNo" CellSpacing="1"
                            CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
                            <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                            <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                            <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                            <Columns>
                                <asp:TemplateColumn SortExpression="RaimburseNo" HeaderText="Raimburse No">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblReqNo" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RaimburseNo")%>'></asp:Label>
                                        </a>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="EmployeeName" HeaderText="Name">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmployeeName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeName")%>'></asp:Label>
                                        <asp:Label ID="lblEmployeeID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeID")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="ReimburseType" HeaderText="Reimburse Type">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblRaimburseType" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ReimburseType")%>'></asp:Label>
                                        <asp:Label ID="lblRaimburseID" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RaimburseID")%>'></asp:Label>
                                        <asp:Label ID="lblGolonganID" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.GolonganID")%>'></asp:Label>
                                        <asp:Label ID="lblAttachmentID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.AttachmentID")%>'></asp:Label>
                                        <asp:Label ID="lblPositionID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.PositionID")%>'></asp:Label>
                                        <asp:Label ID="lblPositionName" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.PositionName")%>'></asp:Label>
                                        <asp:Label ID="lblNotes" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.Keterangan")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="Golongan Name">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblGolonganName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.GolonganName")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="AmountRaimburse" HeaderText="Total Amount">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblAmountRaimburse" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.AmountRaimburse")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="Action">
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:LinkButton CommandName="Payment" ID="lnkPayment" CausesValidation="false" runat="server">Payment</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </td>
                </tr>
            </table>
            <br />
            <table height="25" cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                    <tr>
                        <td align="center" width="30">
                            <asp:ImageButton ID="imbFirstPage" runat="server" CausesValidation="False" ImageUrl="../Images/butkiri1.gif"
                                CommandName="First" OnCommand="NavigationLink_Click"></asp:ImageButton></td>
                        <td align="center" width="30">
                            <asp:ImageButton ID="imbPrevPage" runat="server" CausesValidation="False" ImageUrl="../Images/butkiri.gif"
                                CommandName="Prev" OnCommand="NavigationLink_Click"></asp:ImageButton></td>
                        <td align="center" width="30">
                            <asp:ImageButton ID="imbNextPage" runat="server" CausesValidation="False" ImageUrl="../Images/butkanan.gif"
                                CommandName="Next" OnCommand="NavigationLink_Click"></asp:ImageButton></td>
                        <td align="center" width="30">
                            <asp:ImageButton ID="imbLastPage" runat="server" CausesValidation="False" ImageUrl="../Images/butkanan1.gif"
                                CommandName="Last" OnCommand="NavigationLink_Click"></asp:ImageButton></td>
                        <td style="WIDTH: 163px" align="center" width="163">Page&nbsp;
									<asp:TextBox ID="txtGoPage" runat="server" Width="54px" CssClass="inptype" MaxLength="7"></asp:TextBox>
                            <asp:ImageButton ID="imbGoPage" runat="server" ImageUrl="../Images/butgo.gif" ImageAlign="AbsBottom"
                                EnableViewState="False"></asp:ImageButton></td>
                        <td align="right"><font color="#999999">Page
										<asp:label id="lblPage" runat="server"></asp:label>&nbsp;of
										<asp:label id="lblTotPage" runat="server"></asp:label>, Total&nbsp;
										<asp:label id="lblTotRec" runat="server"></asp:label>&nbsp;record(s)</font>
                        </td>
                    </tr>
                </table>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnlDetail" Visible="true">
            <table border="0" width="95%">
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label4">Nama</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label5">:</asp:Label></td>
                    <td align="left">
                        <asp:Label runat="server" ID="lblDetNama"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label1">Jabatan</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label6">:</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblDetJabatan"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label12">Reimburse Type</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label10">:</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblDetReimburseType"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label15">Golongan</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label16">:</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblDetGolongan"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label17">Outstanding Limit Reimburse</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label18">:</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblOsReimburse"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label7">Amount Reimburse</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label11">:</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblDetAmountReimburse"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label8">Keterangan</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label13">:</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblDetKeterangan"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label9">Bukti Reimburse</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label14">:</asp:Label></td>
                    <td>
                        <asp:HyperLink runat="server" ID="hplView" Text="View File Attachment"></asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label2">Bukti Transfer</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label3">:</asp:Label></td>
                    <td>
                        <input class="inptype" id="inpBrowse" style="WIDTH: 373px; HEIGHT: auto" type="file" size="43"
                            runat="server">&nbsp;<font color="red">*)
						<asp:Label id="lblFileConfirmation" runat="server"></asp:Label></font>
                    </td>
                </tr>
            </table>
            <br />
            <div>
                <asp:Button runat="server" ID="btnsave" OnClick="btnsave_Click" Text="Save" />
                &nbsp;
                <asp:Button runat="server" ID="btnDecline" OnClick="btnDecline_Click" Text="Decline" CausesValidation="false" />
                &nbsp;
                 <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" Text="Cancel" CausesValidation="false" />
            </div>
        </asp:Panel>
    </form>
</asp:Content>
