<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Overtime/Overtime.Master" CodeBehind="RequestOvertime.aspx.vb" Inherits="SmartHR.RequestOvertime" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="Form1" action="#" method="post" runat="server">
        <br />
        <h2>Request Overtime</h2>
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
                    <td></td>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label6">Overtime Type</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label7">:</asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlOvertimeType" runat="server">
                        </asp:DropDownList>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" Display="Dynamic" ControlToValidate="ddlOvertimeType"
								ErrorMessage="Please Fill Overtime Type!" InitialValue="" Validationgroup="AddGrid"></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td></td>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="lbl">Date</asp:Label>
                        </h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label1">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtDate" CssClass="inptype" runat="server" TextMode="Date"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator3" runat="server" Display="Dynamic" ControlToValidate="txtDate"
								ErrorMessage="Please Fill Date !" InitialValue="" Validationgroup="AddGrid"></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td></td>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label4">Hour</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label5">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtHour" runat="server" CssClass="inptype" TextMode="Number"></asp:TextBox>
                        <font color="red">*)<asp:rangevalidator id="Rangevalidator25" runat="server" ErrorMessage="Insert numeric!" ControlToValidate="txtHour"
										Display="Dynamic" MinimumValue="0" Type="Double"></asp:rangevalidator><asp:RequiredFieldValidator id="Requiredfieldvalidator4" runat="server" Validationgroup="AddGrid" Display="Dynamic" ControlToValidate="txtHour"
								ErrorMessage="Please Fill Hour!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td></td>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label2">Notes</asp:Label></h5>
                    </td>
                    <td width="2%">
                        <asp:Label runat="server" ID="Label3">:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtNotes" runat="server" CssClass="inptype" TextMode="MultiLine" MaxLength="100" Width="500px" Height="100px"></asp:TextBox>
                        <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Validationgroup="AddGrid" Display="Dynamic" ControlToValidate="txtNotes"
								ErrorMessage="Please Fill Notes!" InitialValue=""></asp:RequiredFieldValidator></font>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="tdganjil" colspan="4">
                        <div align="right">
                            <asp:Button runat="server" ID="btnAdd" CausesValidation="true" ValidationGroup="AddGrid" Text="Add" OnClick="btnAdd_Click" />
                            &nbsp;
                            <asp:Button runat="server" ID="btnCancelAdd" CausesValidation="false" OnClick="btnCancelAdd_Click" Text="Cancel" />
                        </div>
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
                                            <asp:Label ID="lblOvtNo" runat="server"></asp:Label>
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
                                        <ItemStyle HorizontalAlign="Center" Width="15%"></ItemStyle>
                                    </asp:BoundColumn>
                                    <asp:TemplateColumn HeaderText="Hour">
                                        <HeaderStyle HorizontalAlign="Center" Height="25px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="center" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblHour" runat="server" Text='<%#FormatNumber(Container.DataItem("Hour"),0)%>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Notes">
                                        <ItemStyle HorizontalAlign="center" Width="30%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblNotes" runat="server" Text='<%#Container.DataItem("Notes")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="ACTION">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imbDelete" runat="server" ImageUrl="../../Images/IconDelete.gif" CausesValidation="False"
                                                CommandName="DELETE"></asp:ImageButton>
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
                <tr>
                    <td></td>
                    <td width="30%">
                        <h5>
                            <asp:Label runat="server" ID="Label8">User Approval</asp:Label></h5>
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

            <div>
                &nbsp;
                <asp:Button runat="server" ID="btnsave" Text="Save" ValidationGroup="UserApv" OnClick="btnsave_Click" />
                &nbsp;
                 <asp:Button runat="server" ID="btnCancel" Text="Cancel" CausesValidation="false" OnClick="btnCancel_Click" />
            </div>
        </asp:Panel>
    </form>
</asp:Content>
