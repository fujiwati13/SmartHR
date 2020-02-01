<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="DocumentType.aspx.vb" Inherits="SmartHR.DocumentType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
<div>
    <section class="content-header">
      <h1>
        Document Type
        <small>Master Data</small>
      </h1>
    </section>
    <section class="content">
      <div class="row">
        <section>
          <div class="box box-info">
            <div class="box-body">
           <form id="Form1" action="#" method="post" runat="server">
           
			<table border="0" cellSpacing="0" cellPadding="0" width="95%" align="center">
			<tr>
				<td>
					<asp:label id="lblMessage" runat="server" forecolor="red" font-name="Verdana" font-size="11px"></asp:label>
                    <font color="red"><asp:RangeValidator ID="rgvGo" runat="server" ControlToValidate="txtGoPage" Type="Integer" MinimumValue="1"
                                    MaximumValue="1" ErrorMessage="Page No. is not valid!"></asp:RangeValidator></font>
				</td>
			</tr>
		    </table>
               <br />
             <asp:panel id="pnlSearch" runat="server">
			<TABLE border="0" cellSpacing="1" cellPadding="2" width="95%" align="center">
				<TR>
					<TD  width="20%">Search By</TD>
					<TD width="80%">
						<asp:dropdownlist id="ddlSearch" runat="server">
							<asp:listitem value="DocumentID">DocumentID</asp:listitem>
							<asp:listitem value="DocumentDesc">Document Description</asp:listitem>
						</asp:dropdownlist>
						<asp:textbox id="txtSearch" runat="server" CssClass="inptype"></asp:textbox>
						<font color="red"><asp:RequiredFieldValidator ID="rfvSearch" Runat="server" ControlToValidate="txtSearch" ErrorMessage="Please Fill Search Criteria" Display=Dynamic></asp:RequiredFieldValidator></font>
					</TD>
				</TR>
			</TABLE>
                <br />
                <br />
			<TABLE border="0" cellSpacing="1" cellPadding="2" width="95%" align="center">
				<TR>
					<TD colSpan="2" align="right">
						<asp:imagebutton id="imbSearch" runat="server" CausesValidation="True" imageurl="../Images/ButtonSearch.gif"></asp:imagebutton>
						<asp:imagebutton id="imbReset" runat="server" CausesValidation="False" imageurl="../Images/ButtonReset.gif"></asp:imagebutton>
					</TD>
				</TR>
			</TABLE>
			<BR>
		</asp:panel>
		<asp:panel id="pnlList" runat="server">
			<TABLE border="1" cellSpacing="0" cellPadding="0" width="95%"  align="center">
				<TR>
					<TD align="center" colspan="3" style="background-color:cadetblue;color:black">DOCUMENT TYPE LIST</TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="95%" align="center" border="0">
				<TR>
					<TD>
						<asp:DataGrid id="dtgList" runat="server" CssClass="tablegrid" DataKeyField="DocumentID" cellspacing="1"
							cellpadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
							<AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
							<HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn SortExpression="DocumentID" HeaderText="Document ID">
									<HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
									<ItemTemplate>
									    <asp:Label ID="lblDocumentID" Runat="server" text='<%# DataBinder.Eval(Container, "DataItem.DocumentID")%>'></asp:Label>
                                        </a>
                                    </ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn SortExpression="DocumentDesc" HeaderText="Description">
									<HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
									<ItemTemplate>
										<asp:Label id="lblDescription" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DocumentDesc")%>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="ACTION">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
									<ItemTemplate>
										<asp:LinkButton CommandName="Edit" ID="lnkbAction" CausesValidation="false" Runat="server">Edit</asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="DELETE">
									<HeaderStyle Width="5%"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" ImageUrl="../Images/icondelete.gif"
											CommandName="Delete"></asp:ImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid>
					</TD>
				</TR>
			</TABLE>
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
            <TABLE border="0" cellSpacing="1" cellPadding="2" width="95%" align="center">
				<TR>
					<TD colSpan="2" align="right">
						<asp:Button id="btnAdd" runat="server" CausesValidation="True" OnClick="btnAdd_Click" Text="Add"></asp:Button>
					</TD>
				</TR>
			</TABLE>
		</asp:Panel>
          
         <asp:Panel runat="server" ID="pnlDetail" Visible="false">
                <table border="0">
                    <tr>
                        <td width="25%"><asp:Label runat="server" ID="lbl">Document ID</asp:Label></td>
                        <td width="10%"><asp:Label runat="server" ID="Label1">&nbsp;</asp:Label></td>
                        <td><asp:TextBox ID="txtDocumentID" CssClass="inptype" runat="server" MaxLength="10"></asp:TextBox>
                            <font color="red">*)
							<asp:RequiredFieldValidator id="Requiredfieldvalidator3" runat="server" Display="Dynamic" ControlToValidate="txtDocumentID"
								ErrorMessage="Please Fill Document ID!" InitialValue=""></asp:RequiredFieldValidator></font>
                        </td>
                    </tr>
                    <tr><td colspan="3">&nbsp;</td></tr>
                     <tr>
                        <td width="25%"><asp:Label runat="server" ID="Label2">Description</asp:Label></td>
                        <td width="10%"><asp:Label runat="server" ID="Label3">&nbsp;</asp:Label></td>
                        <td><asp:TextBox ID="txtDescription" runat="server" CssClass="inptype" ></asp:TextBox>
                            <font color="red">*)
							<asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" Display="Dynamic" ControlToValidate="txtDescription"
								ErrorMessage="Please Fill Description!" InitialValue=""></asp:RequiredFieldValidator></font>
                        </td>
                    </tr>

                </table>

                 <br />
              
            <div class="box-footer clearfix">
              <asp:Button runat="server" ID="btnsave" OnClick="btnsave_Click" Text="Save"/>
                &nbsp;
              <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" Text="Cancel" CausesValidation="false"/>
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
