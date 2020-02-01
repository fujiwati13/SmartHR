﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ApprovalLeveling.aspx.vb" Inherits="SmartHR.ApprovalLeveling" %>
<%@ Register TagPrefix="cc1" Namespace="squishyWARERF.WebComponents.squishyTREE" Assembly="squishyWAREReflection" %>
<%@ Register TagPrefix="radg" Namespace="Telerik.WebControls" Assembly="RadGrid" %>
<%@ Register TagPrefix="radc" Namespace="Telerik.WebControls" Assembly="RadComboBox" %>
<%@ Register TagPrefix="rada" Namespace="Telerik.WebControls" Assembly="RadAjax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <form id="frmPath" method="post" runat="server">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" EnableViewState="False"></asp:Label><br>
        <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
            <tr class="trtopi">
                <td class="tdtopikiri" width="10" height="20">&nbsp;</td>
                <td class="tdtopi" align="center">APPROVAL SCHEME
						<asp:Label ID="lblScheme" runat="server"></asp:Label></td>
                <td class="tdtopikanan" width="10">&nbsp;</td>
            </tr>
        </table>
        <br />
        <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
            <tr>
                <td valign="top" width="25%">
                    <cc1:treeview id="trvPath" runat="server" borderwidth="1px" nonfolderimage="../Images/leaf.gif"
                        scrolling="True" expandedimage="../Images/expand.gif" collapsedimage="../Images/collapse.gif" width="100%" height="500px">&nbsp;</cc1:treeview>
                </td>
                <td valign="top">
                    <br>
                    <asp:Panel ID="pnlApprovalPathTree" runat="server">
                        <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                            <tr class="trtopi">
                                <td class="tdtopikiri" width="10" height="20">&nbsp;</td>
                                <td class="tdtopi" align="center">
                                    <asp:Label ID="lblName" runat="server"></asp:Label></td>
                                <td class="tdtopikanan" width="10">&nbsp;</td>
                            </tr>
                        </table>
                        <br>
                        <asp:Panel ID="pnlButton" runat="server">
                            <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                                <tr class="tdganjil">
                                    <td>
                                        <asp:ImageButton ID="btnUpdate" runat="server" CausesValidation="False" Visible="False" ImageUrl="../Images/ButtonEdit.gif"></asp:ImageButton>
                                        <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" Visible="False" ImageUrl="../Images/ButtonDelete.gif"></asp:ImageButton>
                                        <asp:ImageButton ID="btnAddPath" runat="server" CausesValidation="False" Visible="False" ImageUrl="../Images/ButtonAddPath.gif"></asp:ImageButton>
                                        <asp:ImageButton ID="btnMember" runat="server" CausesValidation="False" Visible="False" ImageUrl="../Images/ButtonAddMember.gif"></asp:ImageButton></td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="pnlAddPath" runat="server">
                        <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                            <tr class="trtopi">
                                <td class="tdtopikiri" width="10" height="20">&nbsp;</td>
                                <td class="tdtopi" align="center">ADD/EDIT PATH</td>
                                <td class="tdtopikanan" width="10">&nbsp;</td>
                            </tr>
                        </table>
                        <table class="tablegrid" cellspacing="1" cellpadding="3" width="95%" align="center" border="0">
                            <tr>
                                <td class="tdgenap" width="20%">Path Name</td>
                                <td class="tdganjil" width="80%">
                                    <asp:TextBox ID="txtScheme" runat="server" Columns="40" MaxLength="50" CssClass="inptype"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvScheme" runat="server" ControlToValidate="txtScheme" ErrorMessage="You have to fill Scheme"></asp:RequiredFieldValidator></td>
                            </tr>

                        </table>
                        <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                            <tr>
                                <td align="right">
                                    <asp:ImageButton ID="btnSavePath" runat="server" ImageUrl="../Images/ButtonSave.gif"></asp:ImageButton>&nbsp;
										<asp:ImageButton ID="btnCancelPath" runat="server" CausesValidation="False" ImageUrl="../Images/ButtonCancel.gif"></asp:ImageButton></td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="pnlAddMember" runat="server">
                        <br />
                        <table class="tablegrid" cellspacing="1" cellpadding="3" width="95%" align="center" border="0">
                            <tr>
                                <td class="tdgenap" width="20%">User Approval</td>
                                <td class="tdganjil" width="80%">
                                    <asp:Label ID="lblLogin" runat="server"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddlUserApproval"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvLogin" runat="server" ControlToValidate="ddlUserApproval" ErrorMessage="You have to select user approval"
                                        InitialValue=""></asp:RequiredFieldValidator>
                            </tr>
                            <tr>
                                <td class="tdgenap" width="20%">E-Mail</td>
                                <td class="tdganjil" width="80%">
                                    <asp:TextBox ID="txtEmail" runat="server" Width="280px" Columns="18" MaxLength="30" CssClass="inptype"></asp:TextBox>
                                      <font color="red">*)<asp:regularexpressionvalidator id="RegularExpressionValidator4" runat="server" ErrorMessage="Invalid Email!" ControlToValidate="txtEmail"
										Display="Dynamic" ValidationExpression="\w+([-+._]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:regularexpressionvalidator><asp:RequiredFieldValidator id="Requiredfieldvalidator9" runat="server" Display="Dynamic" ControlToValidate="txtEmail"
								ErrorMessage="Please Fill Email!" InitialValue=""></asp:RequiredFieldValidator></font>
                                </td>
                            </tr>
                        </table>
                        <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                            <tr>
                                <td align="right">
                                    <asp:ImageButton ID="btnSaveMember" runat="server" ImageUrl="../Images/ButtonSave.gif"></asp:ImageButton>&nbsp;
											<asp:ImageButton ID="btnCancelMember" runat="server" CausesValidation="False" ImageUrl="../Images/ButtonCancel.gif"></asp:ImageButton></td>
                            </tr>
                        </table>
                    </asp:Panel>

                    <asp:Panel ID="pnlMember" runat="server">
                        <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                            <tr class="trtopi">
                                <td class="tdtopikiri" width="10" height="20">&nbsp;</td>
                                <td class="tdtopi" align="center">MEMBER</td>
                                <td class="tdtopikanan" width="10">&nbsp;</td>
                            </tr>
                        </table>
                        <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                            <tr>
                                <td>
                                    <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="EmployeeID" CellSpacing="1"
                                        CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="97%" align="center">
                                        <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                                        <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                                        <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                                        <Columns>
                                            <asp:TemplateColumn SortExpression="EmployeeID" HeaderText="EmployeeID">
                                                <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployeeID" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeID")%>'></asp:Label>
                                                    </a>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn SortExpression="Email" HeaderText="Email">
                                                <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmail" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Email")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="ACTION">
                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                                <ItemTemplate>
                                                    <%--<asp:LinkButton CommandName="Member" ID="lnkbAction" CausesValidation="false" Runat="server">Member</asp:LinkButton>--%>
                                                    <asp:HyperLink ID="imbMember" runat="server" ForeColor="Blue" causesvalidation="False" commandname="EditMember"
                                                        Text="Member">Edit Member</asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                            </tr>
                        </table>

                    </asp:Panel>
                </td>
            </tr>
        </table>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="InFooter" runat="server">
</asp:Content>
