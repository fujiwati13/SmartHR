<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Document/Document.Master" CodeBehind="InquiryDocument.aspx.vb" Inherits="SmartHR.InquiryDocument" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    <div>
    <section>
      <h2>
        Inquiry Document
      </h2>
    </section>
    <br />
    <form id="Form1" action="#" method="post" runat="server">
            
			<table border="0" cellSpacing="0" cellPadding="0" width="95%" align="center">
			<tr>
				<td>
					<asp:label id="lblMessage" runat="server" forecolor="red" font-name="Verdana" font-size="11px"></asp:label>
				</td>
			</tr>
		    </table>
            <br />
           <asp:Label runat="server" ID="Label1"></asp:Label>
           <asp:panel id="pnlSearch" runat="server">
			<TABLE border="0" cellSpacing="1" cellPadding="2" width="95%" align="center" >
				<TR>
					<TD  width="20%">Search By</TD>
					<TD width="80%">
						<asp:dropdownlist id="ddlSearch" runat="server">
							<asp:listitem value="ReqDocNo">Request No</asp:listitem>
							<asp:listitem value="EmployeeName">Requester</asp:listitem>
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
					<TD align="right">
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
					<TD align="center" style="background-color:cadetblue;color:black">REIMBURSE LIST</TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="95%" align="center" border="0">
				<TR>
					<TD>
						<asp:DataGrid id="dtgList" runat="server" CssClass="tablegrid" DataKeyField="ReqDocNo" cellspacing="1"
							cellpadding="3" BorderWidth="0px" AutoGenerateColumns="False" AllowSorting="True" Width="100%">
							<AlternatingItemStyle CssClass="tdgenap"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="tdganjil"></ItemStyle>
							<HeaderStyle HorizontalAlign="Center" Height="30px" CssClass="tdjudul"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn SortExpression="ReqDocNo" HeaderText="Request No">
									<HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center" Width="20%"></ItemStyle>
									<ItemTemplate>
									    <asp:Label ID="lblReqNo" Runat="server" text='<%# DataBinder.Eval(Container, "DataItem.ReqDocNo")%>'></asp:Label>
                                        </a>
                                    </ItemTemplate>
								</asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="EmployeeName" HeaderText="Requester">
									<HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
									<ItemTemplate>
										<asp:Label id="lblEmployeeName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeName")%>'></asp:Label>
                                        <asp:Label id="lblEmployeeID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeID")%>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="UserApproval" HeaderText="User Approval">
									<HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
									<ItemTemplate>
										<asp:Label id="lblUserApproval" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.UserApproval")%>'></asp:Label>
									</ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="Status" HeaderText="Status">
									<HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
									<ItemTemplate>
										<asp:Label id="lblStatus" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Status")%>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
                                <asp:TemplateColumn SortExpression="DocumentDesc" HeaderText="Document Type">
									<HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
									<ItemTemplate>
										<asp:Label id="lblDocumentDesc" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DocumentDesc")%>'></asp:Label>
                                        <asp:Label id="lblDocumentID" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.DocumentID")%>'></asp:Label>
                                         <asp:Label id="lblData" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container, "DataItem.Data")%>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn SortExpression="DueDate" HeaderText="Due Date">
									<HeaderStyle Font-Underline="True" HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
									<ItemTemplate>
										<asp:Label id="lblDueDate" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DueDate")%>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="ACTION">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
									<ItemTemplate>
										<asp:LinkButton CommandName="Print" ID="lnkbAction" CausesValidation="false" Runat="server" Visible ='<%# IIf(DataBinder.Eval(Container, "DataItem.Status") = "DONE", "True", "False")%>'>Print</asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid>
					</TD>
				</TR>
			</TABLE>
            <br />
		</asp:Panel> 
            </form>
    </div>
</asp:Content>
