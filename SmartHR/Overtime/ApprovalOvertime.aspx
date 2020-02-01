<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Overtime/Overtime.Master" CodeBehind="ApprovalOvertime.aspx.vb" Inherits="SmartHR.ApprovalOvertime" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="Form1" action="#" method="post" runat="server">
        <h2>Approval Overtime</h2>
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
                            <asp:ListItem Value="ReqOvertimeNo">Request No</asp:ListItem>
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
                    <td align="center" colspan="3" style="background-color: cadetblue; color: black">OVERTIME LIST</td>
                </tr>
            </table>
            <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                <tr>
                    <td>
                        <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="ReqOvertimeNo" CellSpacing="1"
                            CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
                            <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                            <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                            <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                            <Columns>
                                <asp:TemplateColumn SortExpression="ReqOvertimeNo" HeaderText="Request No">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblReqNo" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ReqOvertimeNo")%>'></asp:Label>
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
                                <asp:TemplateColumn SortExpression="TotalAmount" HeaderText="Total Amount">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalAmount" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.TotalAmount")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="Status" HeaderText="Status">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatus" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Status")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="ACTION">
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:LinkButton CommandName="Approve" ID="lnkbAction" CausesValidation="false" runat="server">Approve</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="Cancel">
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
        <br />
        <asp:Panel runat="server" ID="pnlDetail" Visible="true">
            <table border="0" width="95%">
                <tr>
                    <td></td>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label6">Name</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label7">:</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblName"></asp:Label>
                        <asp:Label runat="server" ID="lblUserRequest" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td></td>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="lbl">Job Position</asp:Label>
                        </h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label1">:</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblDetPositionName"></asp:Label>
                        <asp:Label runat="server" ID="lblPositionID" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td></td>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label4">Total Amount</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label5">:</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblDetTotalAmount"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Panel ID="pnlGrid" runat="server">
                <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                    <tr>
                        <%--<td class="tdtopikiri" width="10" height="20">&nbsp;</td>--%>
                        <td class="tdtopi" align="center" style="color:white">Overtime Detail</td>
                        <%--<td class="tdtopikanan" width="10">&nbsp;</td>--%>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                    <tr>
                        <td>
                            <asp:DataGrid ID="dtgOvertime" runat="server" Width="100%" BorderColor="#CCCCCC" BorderStyle="None"
                                BackColor="White" CellPadding="0" AutoGenerateColumns="False" ShowFooter="True" AlternatingItemStyle-HorizontalAlign="Center">
                                <SelectedItemStyle CssClass="tdgenap"></SelectedItemStyle>
                                <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                                <ItemStyle CssClass="tdganjil"></ItemStyle>
                                <HeaderStyle CssClass="tdjudul" Height="30px"></HeaderStyle>
                                <FooterStyle Font-Bold="True" Height="20px" CssClass="tdjudul"></FooterStyle>
                                <Columns>
                                    <asp:TemplateColumn HeaderText="Overtime No">
                                        <ItemStyle HorizontalAlign="Left" Width="5%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblOvtNo" runat="server" Text='<%#Container.DataItem("No")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Overtime Type">
                                        <HeaderStyle HorizontalAlign="Center" Height="30%"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblOvtType" runat="server" Text='<%#Container.DataItem("OvertimeType")%>'>
                                            </asp:Label>
                                            <asp:Label ID="lblOvtID" runat="server" Text='<%#Container.DataItem("OvertimeID")%>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:BoundColumn DataField="OvertimeDate" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                    </asp:BoundColumn>
                                    <asp:TemplateColumn HeaderText="Hour">
                                        <HeaderStyle HorizontalAlign="Center" Height="25px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="center" Width="10%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblHour" runat="server" Text='<%#FormatNumber(Container.DataItem("Hour"),0)%>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Amount Per Hour">
                                        <HeaderStyle HorizontalAlign="Center" Height="25px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="center" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmount" runat="server" Text='<%#FormatNumber(Container.DataItem("Amount"),2)%>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Notes">
                                        <ItemStyle HorizontalAlign="center" Width="30%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblNotes" runat="server" Text='<%#Container.DataItem("Notes")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                </Columns>
                                <PagerStyle Visible="False" HorizontalAlign="Left" ForeColor="#000066" BackColor="White" Mode="NumericPages"></PagerStyle>
                            </asp:DataGrid>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <table border="0" width="95%">
                <tr runat="server" id="trNextApv">
                    <td></td>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label8">Next Approval</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label9">:</asp:Label></td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlUserApproval">
                        </asp:DropDownList>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator5" runat="server" Display="Dynamic" ControlToValidate="ddlUserApproval"
								ErrorMessage="Please Fill User Approval!" InitialValue="" Validationgroup="UserApv"></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <div>
                &nbsp;
                <asp:Button runat="server" ID="btnsave" Text="Save" ValidationGroup="UserApv" OnClick="btnsave_Click" />
                &nbsp;
                <asp:Button runat="server" ID="btnDecline" Text="Decline" CausesValidation="false" OnClick="btnDecline_Click" />
                &nbsp;
                <asp:Button runat="server" ID="btnCancel" Text="Cancel" CausesValidation="false" OnClick="btnCancel_Click" />
            </div>
        </asp:Panel>
    </form>
</asp:Content>
