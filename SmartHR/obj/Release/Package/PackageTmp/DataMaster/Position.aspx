<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Position.aspx.vb" Inherits="SmartHR.Position1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div>
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Position
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
                                                    <asp:ListItem Value="PositionID">Position ID</asp:ListItem>
                                                    <asp:ListItem Value="PositionName">Position Name</asp:ListItem>
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
                                            <td align="center" colspan="3" style="background-color: cadetblue; color: black">POSITION LIST</td>
                                        </tr>
                                    </table>
                                    <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                                        <tr>
                                            <td>
                                                <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="PositionID" CellSpacing="1"
                                                    CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
                                                    <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                                                    <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                                                    <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                                                    <Columns>
                                                        <asp:TemplateColumn SortExpression="PositionID" HeaderText="POSITION ID">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPositionID" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.PositionID")%>'></asp:Label>
                                                                </a>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="PositionName" HeaderText="Description">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDescription" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.PositionName")%>'></asp:Label>
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
                                                <asp:Label runat="server" ID="lblnik">PositionID</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label1">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtPositionID" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="rfvPositionid" runat="server" Display="Dynamic" ControlToValidate="txtPositionID"
								ErrorMessage="Please Fill Position ID!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label2">Description</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label3">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtDescription" runat="server" CssClass="inptype"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtDescription"
								ErrorMessage="Please Fill Description!" InitialValue=""></asp:RequiredFieldValidator></font>
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
