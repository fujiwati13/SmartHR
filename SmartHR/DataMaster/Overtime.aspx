<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Overtime.aspx.vb" Inherits="SmartHR.Overtime" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div>
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Overtime
                <small>Master Data</small>
            </h1>
        </section>

        <section class="content">
            <div class="row">
                <section>
                    <div class="box box-info">
                        <div class="box-body">
                            <form id="Form1" action="#" method="post" runat="server">
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
                                            <td width="20%">Search By</td>
                                            <td width="80%">
                                                <asp:DropDownList ID="ddlSearch" runat="server">
                                                    <asp:ListItem Value="OvertimeID">OvertimeID</asp:ListItem>
                                                    <asp:ListItem Value="OvertimeType">OvertimeType</asp:ListItem>
                                                    <asp:ListItem Value="Location">Location</asp:ListItem>
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
                                                <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="OvertimeID" CellSpacing="1"
                                                    CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
                                                    <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                                                    <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                                                    <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                                                    <Columns>
                                                        <asp:TemplateColumn SortExpression="OvertimeID" HeaderText="Overtime ID">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblOvertimeID" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OvertimeID")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="OvertimeType" HeaderText="Overtime Type">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblOvertimeType" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OvertimeType")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="Location" HeaderText="Location">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLocation" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Location")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="GolonganID" HeaderText="Golongan">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGolongan" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.GolonganDesc")%>'></asp:Label>
                                                                <asp:Label ID="lblGolonganID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.GolonganID")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="Amount" HeaderText="Amount">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAmount" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Amount")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="ACTION">
                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:LinkButton CommandName="Edit" ID="lnkbAction" CausesValidation="false" runat="server">Edit</asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="DELETE">
                                                            <HeaderStyle Width="5%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imgDelete" runat="server" CausesValidation="False" ImageUrl="../Images/icondelete.gif"
                                                                    CommandName="Delete"></asp:ImageButton>
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
                                    <br />
                                    <table border="0" cellspacing="1" cellpadding="2" width="95%" align="center">
                                        <tr>
                                            <td colspan="2" align="right">
                                                <asp:Button ID="btnAdd" runat="server" CausesValidation="True" OnClick="btnAdd_Click" Text="Add"></asp:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>

                                <asp:Panel runat="server" ID="pnlDetail" Visible="false">
                                    <table border="0">
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="lbl">Overtime ID</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label1">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtOvertimeID" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator3" runat="server" Display="Dynamic" ControlToValidate="txtOvertimeID"
								ErrorMessage="Please Fill Overtime ID!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label6">Overtime Type</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label7">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtOvertimeType" CssClass="inptype" TextMode="MultiLine" Height="50px" Width="400px" runat="server" MaxLength="50"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Display="Dynamic" ControlToValidate="txtOvertimeType"
								ErrorMessage="Please Fill Overtime Type!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label8">Location</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label9">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtLocation" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" Display="Dynamic" ControlToValidate="txtLocation"
								ErrorMessage="Please Fill Location!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label4">Golongan</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label5">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:DropDownList ID="ddlGolongan" runat="server">
                                                </asp:DropDownList>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator4" runat="server" Display="Dynamic" ControlToValidate="ddlGolongan"
								ErrorMessage="Please Fill Golongan!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label2">Amount</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label3">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtAmount" runat="server" CssClass="inptype"></asp:TextBox>
                                                <font color="red">*)<asp:rangevalidator id="Rangevalidator25" runat="server" ErrorMessage="Insert numeric!" ControlToValidate="txtAmount"
										Display="Dynamic" MinimumValue="0" Type="Double" MaximumValue="999999999999999.99"></asp:rangevalidator><asp:RequiredFieldValidator id="Requiredfieldvalidator5" runat="server" Display="Dynamic" ControlToValidate="txtAmount"
								ErrorMessage="Please Fill Amount!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />

                                    <div class="box-footer clearfix">
                                        <asp:Button runat="server" ID="btnsave" OnClick="btnsave_Click" Text="Save" />
                                        &nbsp;
                                        <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" Text="Cancel" CausesValidation="false" />
                                    </div>
                                </asp:Panel>
                            </form>
                        </div>
                    </div>
                </section>

            </div>
            <!-- /.row (main row) -->

        </section>
        <!-- /.content -->
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="InFooter" runat="server">
</asp:Content>
