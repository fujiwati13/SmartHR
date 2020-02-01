<%@ Register TagPrefix="cr" Namespace="CrystalDecisions.Web" Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" %>
<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Report/Report.Master" CodeBehind="MonthlyReportViewer.aspx.vb" Inherits="SmartHR.MonthlyReportViewer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="InBody" runat="server">
    	<form id="Form1" method="post" runat="server">
			<table cellspacing="1" cellpadding="2" width="100%" border="0">
				<tr>
					<td><asp:Button id="btnBackReport" runat="server" text="Back" OnClick="btnBackReport_Click"></asp:Button></td>
				</tr>
			</table>
			<table cellspacing="1" cellpadding="2" width="100%" border="0">
				<tr>
					<td>
						<cr:CrystalReportViewer id="CRVARReport" runat="server" HasDrillUpButton="false" HasToggleGroupTreeButton="false"
							HasPrintButton="true" HasExportButton="True" enableddrilldown="false" ToolPanelView="None" hassearchbutton="false"
							Width="350px" Height="50px"></cr:CrystalReportViewer></td>
				</tr>
			</table>
		</form>
</asp:Content>
