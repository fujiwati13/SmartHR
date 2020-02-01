<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ApprovalSchemeDetail.aspx.vb" Inherits="SmartHR.ApprovalSchemeDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div>
        <section class="content-header">
            <h1>Approval Scheme Detail
       
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
                                                    <asp:ListItem Value="ApprovalType">ApprovalType</asp:ListItem>
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
                                                                </a>
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
                                                                <asp:HyperLink ID="imbMember" runat="server" ForeColor="Blue" causesvalidation="False" commandname="Member"
                                                                    Text="Member">Member</asp:HyperLink>
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
                            </form>
                        </div>
                </section>
            </div>
        </section>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="InFooter" runat="server">
</asp:Content>
