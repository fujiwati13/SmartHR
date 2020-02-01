<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ApprovalScheme.aspx.vb" Inherits="SmartHR.ApprovalScheme" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div>
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>Approval Scheme
       
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
                                                    <asp:ListItem Value="ApprovalSchemeID">ApprovalSchemeID</asp:ListItem>
                                                    <asp:ListItem Value="Description">Description</asp:ListItem>
                                                </asp:DropDownList>
                                                <font color="red"><asp:textbox id="txtSearch" runat="server" CssClass="inptype"></asp:textbox></font>
                                                <asp:RequiredFieldValidator ID="rfvSearch" runat="server" ControlToValidate="txtSearch" ErrorMessage="Please Fill Search Criteria" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                            <td align="center" colspan="3" style="background-color: cadetblue; color: black">APPROVAL SCHEME LIST</td>
                                        </tr>
                                    </table>
                                    <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                                        <tr>
                                            <td>
                                                <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="ApprovalSchemeID" CellSpacing="1"
                                                    CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
                                                    <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                                                    <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                                                    <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                                                    <Columns>
                                                        <asp:TemplateColumn SortExpression="ApprovalSchemeID" HeaderText="Approval Scheme ID">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblApprovalSchemeID" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ApprovalSchemeID")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="Description" HeaderText="Description">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDescription" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Description")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="ApprovalLevel" HeaderText="ApprovalLevel">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblApprovalLevel" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ApprovalLevel")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="ApprovalTypeDesc" HeaderText="Approval Type">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblApprovalTypeDesc" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ApprovalTypeDesc")%>'></asp:Label>
                                                                <asp:Label ID="lblApprovalType" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.ApprovalType")%>'></asp:Label>
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
                                                <asp:Label runat="server" ID="lbl">Approval Scheme ID</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label1">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtApprovalSchemeID" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" Display="Dynamic" ControlToValidate="txtApprovalSchemeID"
								ErrorMessage="Please Fill Approval Scheme ID!" InitialValue=""></asp:RequiredFieldValidator></font></td>
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
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator3" runat="server" Display="Dynamic" ControlToValidate="txtDescription"
								ErrorMessage="Please Fill Description!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label6">Approval Type</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label7">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:DropDownList ID="ddlApprovalType" runat="server">
                                                    <asp:ListItem Value="">Select One</asp:ListItem>
                                                    <asp:ListItem Value="DOC">Document</asp:ListItem>
                                                    <asp:ListItem Value="RMB">Reimburse</asp:ListItem>
                                                    <asp:ListItem Value="OVT">Overtime</asp:ListItem>
                                                    <asp:ListItem Value="CUTI">Leave</asp:ListItem>
                                                </asp:DropDownList>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Display="Dynamic" ControlToValidate="ddlApprovalType"
								ErrorMessage="Please Fill Approval Type!" InitialValue=""></asp:RequiredFieldValidator></font></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label4">ApprovalLevel</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label5">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtApprovalLevel" runat="server" CssClass="inptype"></asp:TextBox>
                                                <font color="red">*)<asp:rangevalidator id="Rangevalidator25" runat="server" ErrorMessage="Invalid Number!" ControlToValidate="txtApprovalLevel"
										Display="Dynamic" MinimumValue="0" Type="Integer" MaximumValue="365"></asp:rangevalidator><asp:RequiredFieldValidator id="Requiredfieldvalidator4" runat="server" Display="Dynamic" ControlToValidate="txtApprovalLevel"
								ErrorMessage="Please Fill Approval Level!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <div class="box-footer clearfix">
                                        <asp:Button runat="server" ID="btnsave" OnClick="btnsave_Click" Text="Save" />
                                        <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" Text="Cancel" />
                                    </div>
                                </asp:Panel>
                            </form>
                        </div>
                </section>
            </div>
        </section>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="InFooter" runat="server">
</asp:Content>
