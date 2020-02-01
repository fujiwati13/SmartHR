<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Leave/Leave.Master" CodeBehind="InquiryLeave.aspx.vb" Inherits="SmartHR.InquiryLeave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div>
        <section>
            <h2>Inquiry Leave
      </h2>
        </section>
        <br />
        <form id="Form1" action="#" method="post" runat="server">

            <table border="0" cellspacing="0" cellpadding="0" width="95%" align="center">
                <tr>
                    <td>
                        <asp:Label ID="lblMessage" runat="server" ForeColor="red" font-name="Verdana" Font-Size="11px"></asp:Label>
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
                                <asp:ListItem Value="ReqCutiNo">Request No</asp:ListItem>
                                <asp:ListItem Value="E.EmployeeName">Employee Name</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="inptype"></asp:TextBox>
                            <font color="red"><asp:RequiredFieldValidator ID="rfvSearch" Runat="server" ControlToValidate="txtSearch" ErrorMessage="Please Fill Search Criteria" Display=Dynamic></asp:RequiredFieldValidator></font>
                        </td>
                    </tr>
                </table>
                <br />
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
                            <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="ReqCutiNo" CellSpacing="1"
                                CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
                                <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                                <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                                <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                                <Columns>
                                    <asp:TemplateColumn SortExpression="ReqCutiNo" HeaderText="Request No">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblReqNo" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ReqCutiNo")%>'></asp:Label>
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
                                    <asp:TemplateColumn SortExpression="PositionName" HeaderText="Jabatan">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblPositionName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.PositionName")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn SortExpression="StartDate" HeaderText="Mulai Tanggal">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblStartDate" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StartDate")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn SortExpression="EndDate" HeaderText="Masuk Kembali">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEndDate" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EndDate")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn SortExpression="NumOfDays" HeaderText="Duration(In Days)">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblNumOfDays" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.NumOfDays")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn SortExpression="LeaveType" HeaderText="Leave Type">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblLeaveType" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LeaveType")%>'></asp:Label>
                                            <asp:Label ID="lblLeaveID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.LeaveID")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn SortExpression="RequestDate" HeaderText="Request Date">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblRequestDate" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RequestDate")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn SortExpression="Status" HeaderText="Status">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Status")%>'></asp:Label>
                                            <asp:Label ID="lblNotes" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.Notes")%>'></asp:Label>
                                            <asp:Label ID="lblAlamatCuti" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.AlamatCuti")%>'></asp:Label>
                                            <asp:Label ID="lblTelpCuti" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.TelpCuti")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                      <asp:TemplateColumn SortExpression="UserApproval" HeaderText="Approved By">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblUserApproval" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserApproval")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                </Columns>
                            </asp:DataGrid>
                        </td>
                    </tr>
                </table>
                <br />
            </asp:Panel>

            
        </form>
    </div>
</asp:Content>
