<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ReimbursementLimit.aspx.vb" Inherits="SmartHR.ReimbursementLimit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
 <div >
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Reimbursement Limit
                <small>Master Data</small>
            </h1>
        </section>

        <!-- Main content -->
        <section class="content">

            <!-- Main row -->
            <div class="row">
                <!-- Left col -->
                <section>

                    <!-- quick email widget -->
                    <div class="box box-info">
                        <div class="box-body">
                            <form id="Form1" action="#" method="post" runat="server">
                                <table border="0" cellspacing="0" cellpadding="0" width="95%" align="center">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblMessage" runat="server" ForeColor="red" font-name="Verdana" Font-Size="11px"></asp:Label>
                                            <%--<asp:rangevalidator id="rgvGo" runat="server" ErrorMessage="Page No. is not valid!" MinimumValue="1"
						Type="integer" ControlToValidate="txtGoPage" maximumvalue="999999999"></asp:rangevalidator>--%>
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
                                                    <asp:ListItem Value="LimitID">LimitID</asp:ListItem>
                                                    <asp:ListItem Value="Notes">Notes</asp:ListItem>
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
                                                <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="LimitID" CellSpacing="1"
                                                    CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
                                                    <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                                                    <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                                                    <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                                                    <Columns>
                                                        <asp:TemplateColumn SortExpression="LimitID" HeaderText="Limit ID">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLimitID" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.LimitID")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="GolonganDesc" HeaderText="Golongan">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGolonganDesc" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.GolonganDesc")%>'></asp:Label>
                                                                <asp:Label ID="lblGolonganID" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.GolonganID")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="MaximumAmount" HeaderText="MaximumAmount">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblMaximumAmount" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MaximumAmount")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="RaimburseDesc" HeaderText="Raimburse Type">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRaimburseDesc" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.RaimburseDesc")%>'></asp:Label>
                                                                <asp:Label ID="lblRaimburseID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.RaimburseID")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="Notes" HeaderText="Notes">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblNotes" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Notes")%>'></asp:Label>
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
                                                <asp:Label runat="server" ID="lbl">Limit ID</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label1">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtLimitID" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator3" runat="server" Display="Dynamic" ControlToValidate="txtLimitID"
								ErrorMessage="Please Fill Limit ID!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label6">Golongan</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label7">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:DropDownList ID="ddlGolongan" runat="server">
                                                </asp:DropDownList>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Display="Dynamic" ControlToValidate="ddlGolongan"
								ErrorMessage="Please Fill Golongan!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label8">Maximum Amount</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label9">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtMaxAmount" runat="server" CssClass="inptype"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" Display="Dynamic" ControlToValidate="txtMaxAmount"
								                ErrorMessage="Please Fill Maximum Amount!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label4">Raimburse Type</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label5">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:DropDownList ID="ddlRaimburseType" runat="server">
                                                </asp:DropDownList>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator4" runat="server" Display="Dynamic" ControlToValidate="ddlRaimburseType"
								                ErrorMessage="Please Fill Raimburse Type!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label2">Notes</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label3">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtNotes" runat="server" CssClass="inptype" TextMode="MultiLine" MaxLength="50"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator5" runat="server" Display="Dynamic" ControlToValidate="txtNotes"
								                ErrorMessage="Please Fill Notes!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>

                                    </table>

                                    <br />
                                    <div class="box-footer clearfix">
                                        <asp:Button runat="server" ID="btnsave" OnClick="btnsave_Click" Text="Save" />
                                        &nbsp;
                                        <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" Text="Cancel" CausesValidation="false"/>
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
