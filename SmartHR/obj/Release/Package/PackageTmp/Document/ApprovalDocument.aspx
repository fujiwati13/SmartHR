<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Document/Document.Master" CodeBehind="ApprovalDocument.aspx.vb" Inherits="SmartHR.ApprovalDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div>
    <section>
      <h2>
        Approval Document
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
                            <asp:ListItem Value="ReqDocNo">Request No</asp:ListItem>
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
                        <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="ReqDocNo" CellSpacing="1"
                            CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
                            <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                            <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                            <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                            <Columns>
                                <asp:TemplateColumn SortExpression="ReqDocNo" HeaderText="Request No">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblReqNo" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ReqDocNo")%>'></asp:Label>
                                        </a>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="DueDate" HeaderText="Due Date">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblDueDate" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DueDate")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="Notes" HeaderText="Notes">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblNotes" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Notes")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="EmployeeName" HeaderText="EmployeeName">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmployeeName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeName")%>'></asp:Label>
                                        <asp:Label ID="lblEmployeeID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeID")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="DocumentDesc" HeaderText="DocumentDesc">
                                    <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocumentDesc" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DocumentDesc")%>'></asp:Label>
                                        <asp:Label ID="lblDocumentID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.DocumentID")%>'></asp:Label>
                                        <asp:Label ID="lblData" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.Data")%>'></asp:Label>
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
                                <asp:TemplateColumn HeaderText="DELETE">
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
                        <asp:Label runat="server" ID="Label6">Employee</asp:Label></td>
                    <td width="10%">
                        <asp:Label runat="server" ID="Label7">&nbsp;</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblDetEmployee"></asp:Label>
                        <asp:Label runat="server" ID="lblDetReqNo" Visible="false"></asp:Label>
                        <asp:Label runat="server" ID="lblDetEmployeeID" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="25%">
                        <asp:Label runat="server" ID="Label4">Document Type</asp:Label></td>
                    <td width="10%">
                        <asp:Label runat="server" ID="Label5">&nbsp;</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblDetDocType"></asp:Label>
                        <asp:Label runat="server" ID="lblDetDocID" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="25%">
                        <asp:Label runat="server" ID="lbl">Due Date</asp:Label></td>
                    <td width="10%">
                        <asp:Label runat="server" ID="Label1">&nbsp;</asp:Label></td>
                    <td>
                        <asp:Label runat="server" ID="lblDetDueDate"></asp:Label>
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
                        <asp:Label runat="server" ID="lblDetNotes"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td width="25%">
                        <asp:Label runat="server" ID="Label8">Document</asp:Label></td>
                    <td width="10%">
                        <asp:Label runat="server" ID="Label9">&nbsp;</asp:Label></td>
                    <td>
                        <input class="inptype" id="inpBrowse" style="WIDTH: 373px; HEIGHT: auto" type="file" size="43"
                            runat="server">&nbsp;<font color="red">*)
									<asp:Label id="lblFileConfirmation" runat="server"></asp:Label></font>
                    </td>
                </tr>
            </table>

            <br />


            <div class="box-footer clearfix">
                <asp:Button runat="server" ID="btnsave" OnClick="btnsave_Click" Text="Save" />
            </div>
        </asp:Panel>
    </form>
        </div>
</asp:Content>
