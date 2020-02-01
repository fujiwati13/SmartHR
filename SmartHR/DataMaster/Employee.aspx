<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Employee.aspx.vb" Inherits="SmartHR.Employee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div>
        <section class="content-header">
            <h1>Employee
       
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
                                                    <asp:ListItem Value="NIK">NIK</asp:ListItem>
                                                    <asp:ListItem Value="EmployeeName">Name</asp:ListItem>
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
                                            <td align="center" colspan="3" style="background-color: cadetblue; color: black">EMPLOYEE LIST</td>
                                        </tr>
                                    </table>
                                    <table cellspacing="0" cellpadding="0" width="95%" align="center" border="0">
                                        <tr>
                                            <td>
                                                <asp:DataGrid ID="dtgList" runat="server" CssClass="tablegrid" DataKeyField="NIK" CellSpacing="1"
                                                    CellPadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
                                                    <AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
                                                    <ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
                                                    <HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
                                                    <Columns>
                                                        <asp:TemplateColumn SortExpression="NIK" HeaderText="NIK">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEmployeeID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeID")%>'></asp:Label>
                                                                <asp:Label ID="lblNIK" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.NIK")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="Name" HeaderText="Name">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeName")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="Username" HeaderText="Username">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblUsername" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Username")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Password" Visible="false">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPassword" Visible="false" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Password")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Birth Place" Visible="false">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblBirthPlace" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.BirthPlace")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Birth Date" Visible="false">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblBirthDate" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.BirthDate")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="Gender" HeaderText="Gender">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGender" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Gender")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Phone" Visible="false">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPhone" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.NoTelp")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Email" Visible="false">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEmail" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Email")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="Address" HeaderText="Address">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAddress" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Address")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="JoinDate" HeaderText="Join Date">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblJoinDate" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.JoinDate")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="PositionName" HeaderText="Job Position">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPosition" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.PositionName")%>'></asp:Label>
                                                                <asp:Label ID="lblPositionID" Visible="false" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.PositionID")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="DeptName" HeaderText="Departement">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDeptName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DeptName")%>'></asp:Label>
                                                                <asp:Label ID="lblDepartementID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.DepartementID")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn SortExpression="GolonganName" HeaderText="Golongan">
                                                            <HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGolonganName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.GolonganName")%>'></asp:Label>
                                                                <asp:Label ID="lblGolonganID" Visible="false" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.GolonganID")%>'></asp:Label>
                                                                <asp:Label ID="lblRole" Visible="false" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Role")%>'></asp:Label>
                                                                <asp:Label ID="lblNoWa" Visible="false" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.NoWhatsapp")%>'></asp:Label>
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
                                                <asp:Label runat="server" ID="lbl">NIK</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label1">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtNIK" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator3" runat="server" Display="Dynamic" ControlToValidate="txtNIK"
								ErrorMessage="Please Fill NIK!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label10">Name</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label11">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtName" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Display="Dynamic" ControlToValidate="txtName"
								ErrorMessage="Please Fill Name!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label12">Username</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label13">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtUsername" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" Display="Dynamic" ControlToValidate="txtUsername"
								ErrorMessage="Please Fill Username!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label14">Password</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label15">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtPassword" TextMode="Password" MaxLength="10" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator4" runat="server" Display="Dynamic" ControlToValidate="txtPassword"
								                ErrorMessage="Please Fill Password!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label16">Birth Place</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label17">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtBirthPlace" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator5" runat="server" Display="Dynamic" ControlToValidate="txtBirthPlace"
								                ErrorMessage="Please Fill Birth Place!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label18">BirthDate</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label19">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtBirthDate" TextMode="Date" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator6" runat="server" Display="Dynamic" ControlToValidate="txtBirthDate"
								ErrorMessage="Please Fill Birth Date!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label20">Gender</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label21">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:DropDownList ID="ddlGender" runat="server">
                                                    <asp:ListItem Value="">Select One</asp:ListItem>
                                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                                </asp:DropDownList>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator7" runat="server" Display="Dynamic" ControlToValidate="ddlGender"
								                ErrorMessage="Please Fill Gender!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label22">Phone</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label23">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtPhone" CssClass="inptype" runat="server" MaxLength="15"></asp:TextBox>
                                                <font color="red">*)<asp:regularexpressionvalidator id="RegularExpressionValidator5" runat="server" ErrorMessage="Invalid Phone Number!"
											ControlToValidate="txtPhone" Display="Dynamic" ValidationExpression="\d*"></asp:regularexpressionvalidator><asp:RequiredFieldValidator id="Requiredfieldvalidator8" runat="server" Display="Dynamic" ControlToValidate="txtPhone"
								            ErrorMessage="Please Fill Phone!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                          <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label4">No Whatsapp</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label5">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtNoWa" CssClass="inptype" runat="server" MaxLength="15"></asp:TextBox>
                                                <font color="red">*)<asp:regularexpressionvalidator id="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Whatsapp Number!"
											ControlToValidate="txtNoWa" Display="Dynamic" ValidationExpression="\d*"></asp:regularexpressionvalidator><asp:RequiredFieldValidator id="Requiredfieldvalidator16" runat="server" Display="Dynamic" ControlToValidate="txtPhone"
								            ErrorMessage="Please Fill No Whatsapp !" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label24">Email</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label25">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtEmail" CssClass="inptype" runat="server" MaxLength="30"></asp:TextBox>
                                                <font color="red">*)<asp:regularexpressionvalidator id="RegularExpressionValidator4" runat="server" ErrorMessage="Invalid Email!" ControlToValidate="txtEmail"
										Display="Dynamic" ValidationExpression="\w+([-+._]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:regularexpressionvalidator><asp:RequiredFieldValidator id="Requiredfieldvalidator9" runat="server" Display="Dynamic" ControlToValidate="txtEmail"
								ErrorMessage="Please Fill Email!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label26">Address</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label27">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtAddress" TextMode="MultiLine" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator10" runat="server" Display="Dynamic" ControlToValidate="txtAddress"
								ErrorMessage="Please Fill Address!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label28">Join Date</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label29">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:TextBox ID="txtJoinDate" TextMode="Date" CssClass="inptype" runat="server"></asp:TextBox>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator11" runat="server" Display="Dynamic" ControlToValidate="txtJoinDate"
								ErrorMessage="Please Fill Join Date!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label30">Position</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label31">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:DropDownList ID="ddlPosition" runat="server">
                                                </asp:DropDownList>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator12" runat="server" Display="Dynamic" ControlToValidate="ddlPosition"
								ErrorMessage="Please Fill Position!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label32">Departement</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label33">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:DropDownList ID="ddlDepartement" runat="server">
                                                </asp:DropDownList>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator13" runat="server" Display="Dynamic" ControlToValidate="ddlDepartement"
								ErrorMessage="Please Fill Departement!" InitialValue=""></asp:RequiredFieldValidator></font>
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
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator14" runat="server" Display="Dynamic" ControlToValidate="ddlGolongan"
								ErrorMessage="Please Fill Golongan!" InitialValue=""></asp:RequiredFieldValidator></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="25%">
                                                <asp:Label runat="server" ID="Label2">Role</asp:Label></td>
                                            <td width="10%">
                                                <asp:Label runat="server" ID="Label3">&nbsp;</asp:Label></td>
                                            <td>
                                                <asp:DropDownList ID="ddlRole" runat="server">
                                                    <asp:ListItem Value="">Select One</asp:ListItem>
                                                    <asp:ListItem Value="Admin">Admin</asp:ListItem>
                                                    <asp:ListItem Value="User">User</asp:ListItem>
                                                    <asp:ListItem Value="Finance">Finance</asp:ListItem>
                                                    <asp:ListItem Value="HRD">HRD</asp:ListItem>
                                                </asp:DropDownList>
                                                <font color="red">*)<asp:RequiredFieldValidator id="Requiredfieldvalidator15" runat="server" Display="Dynamic" ControlToValidate="ddlRole"
								ErrorMessage="Please Fill Role!" InitialValue=""></asp:RequiredFieldValidator></font>
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
        </section>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="InFooter" runat="server">
</asp:Content>
