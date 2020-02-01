<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Reimburse/Reimburse.Master" CodeBehind="FileAttachment.aspx.vb" Inherits="SmartHR.FileAttachment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script language="javascript">
        function Close() {
            window.close();
        }

		</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div>
        <section>
            <h2 style="align-content:center">File Attachment</h2>
        </section>
        <br />
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
            <asp:Panel ID="pnlData" runat="server">
                <table border="0" cellspacing="1" cellpadding="2" width="100%" align="center">
                    <tr>
                        <td width="40%">Employee Name</td>
                        <td width="10%">:</td>
                        <td width="50%">
                            <asp:Label runat="server" ID="lblDetEmployeeName"></asp:Label>
                        </td>
                    </tr>
                     <tr>
                       <td width="40%">Reimburse Type</td>
                         <td width="10%">:</td>
                        <td width="50%">
                            <asp:Label runat="server" ID="lblDetReimburseType"></asp:Label>
                        </td>
                    </tr>
                </table>
                <br />
            </asp:Panel>
            <asp:Panel ID="pnlList" runat="server">
                <table border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
                    <tr>
                        <td align="center" colspan="3" style="background-color: cadetblue; color: black">File Attachment List</td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
                    <tr>
                        <td>
                            <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="DocumentNo" CellSpacing="1"
                                CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
                                <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                                <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                                <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                                <Columns>
                                    <asp:TemplateColumn SortExpression="DocumentNo" HeaderText="Document No">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:LinkButton CommandName="Print" ID="lblDocumentNo" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DocumentNo")%>'></asp:LinkButton>
                                            </a>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                       <asp:TemplateColumn SortExpression="DocumentName" HeaderText="Document Name">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocumentName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DocumentName")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn SortExpression="UserUpload" HeaderText="User Upload">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblUserUpload" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserUpload")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn SortExpression="UploadDate" HeaderText="Upload Date">
                                        <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:Label ID="lblUploadDate" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UploadDate")%>'></asp:Label>
                                            <asp:Label ID="lblFilePath" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.FILEPATH")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="DELETE">
                                        <HeaderStyle Width="5%"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:LinkButton CommandName="Delete" ID="lnkbActionCancel" CausesValidation="false" runat="server">Delete</asp:LinkButton>
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
                <table border="0" cellspacing="1" cellpadding="2" width="95%" align="center">
                <tr>
                    <td colspan="2" align="right">
                        <asp:Button ID="btnAdd" runat="server" CausesValidation="True" OnClick="btnAdd_Click" Text="Add"></asp:Button>
                        &nbsp;
                        <asp:Button ID="btnClose" EnableViewState="False" runat="server" CausesValidation="false" Text="Close" OnClick="btnClose_Click"></asp:Button>
                    </td>
                </tr>
            </table>
            <br />
            </asp:Panel>

            <asp:Panel runat="server" ID="pnlDetail" Visible="true">
                <table border="0"
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label2">Keterangan</asp:Label></td>
                        <td width="10%">
                            <asp:Label runat="server" ID="Label3">&nbsp;</asp:Label></td>
                        <td>
                            <asp:TextBox runat="server" ID="txtKeterangan" TextMode="MultiLine" Height="50px" Width="400px"></asp:TextBox>
                            <font color="red"><asp:RequiredFieldValidator ID="rfvKet" Runat="server" ControlToValidate="txtKeterangan" ErrorMessage="Please Fill Keterangan" Display=Dynamic></asp:RequiredFieldValidator></font>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="25%">
                            <asp:Label runat="server" ID="Label8">Attachment</asp:Label></td>
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
                    <asp:Button runat="server" ID="btnsave" Text="Save" OnClick="btnsave_Click" />
                    &nbsp;
                    <asp:Button runat="server" ID="btnCancel" Text="Cancel" OnClick="btnCancel_Click" />
                </div>
            </asp:Panel>
        </form>
    </div>
</asp:Content>
