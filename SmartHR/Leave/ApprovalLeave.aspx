<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Leave/Leave.Master" CodeBehind="ApprovalLeave.aspx.vb" Inherits="SmartHR.ApprovalLeave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div>
        <section>
            <h2>Approval leave
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
                                <asp:ListItem Value="EmployeeName">Employee Name</asp:ListItem>
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
                                    <asp:TemplateColumn SortExpression="PositionName" HeaderText="Position">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblPositionName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.PositionName")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn SortExpression="StartDate" HeaderText="Start Date">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblStartDate" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.StartDate")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn SortExpression="EndDate" HeaderText="End Date">
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
                                    <asp:TemplateColumn HeaderText="ACTION">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:LinkButton CommandName="Approve" ID="lnkbAction" CausesValidation="false" runat="server">Approve</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="CANCEL">
                                        <HeaderStyle Width="5%"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:LinkButton CommandName="Cancel" ID="lnkbActionCancel" CausesValidation="false" runat="server">Cancel</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                </Columns>
                            </asp:DataGrid>
                        </td>
                    </tr>
                </table>
                <br />
            </asp:Panel>

            <asp:Panel runat="server" ID="pnlDetail" Visible="true">
                <table border="0">
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label6">Nama</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label7">:</asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblDetNama"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label4">Jabatan</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label5">:</asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblDetJabatan"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="lbl">Jenis Leave</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label1">:</asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblDetJenisCuti"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label2">Start Date</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label3">:</asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblDetMulai"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label10">End Date</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label11">:</asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblDetMasuk"></asp:Label>
                        </td>
                    </tr>
                     <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label20">Outstanding Leave</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label21">:</asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblSisaCuti"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label18">Duration Leave</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label19">:</asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblLamaCuti"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label8">Notes</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label9">:</asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblDetKet"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="3">Handphone Number and Address</td>
                    </tr>
                     <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label12">Address</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label13">:</asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblDetAlamat"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label14">Handphone Number</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label15">:</asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblDetNotelp"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                     <tr runat="server" id="trUserApv" visible="true">
                        <td width="25%">
                            <asp:Label runat="server" ID="Label16">User Approval</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label17">:</asp:Label></td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlUserApproval"></asp:DropDownList>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Display="Dynamic" ControlToValidate="ddlUserApproval"
								ErrorMessage="Please Fill User Approval!" InitialValue=""></asp:RequiredFieldValidator></font>
                        </td>
                    </tr>
                </table>

                <br />


                <div class="box-footer clearfix">
                    <asp:Button runat="server" ID="btnsave" OnClick="btnsave_Click" Text="Save" />
                    <asp:Button runat="server" ID="btnDecline" OnClick="btnDecline_Click" Text="Decline" CausesValidation="false"/>
                    <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" Text="Cancel" CausesValidation="false"/>
                    
                </div>
            </asp:Panel>
        </form>
    </div>
</asp:Content>
