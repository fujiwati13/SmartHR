<%@ Register TagPrefix="cr" Namespace="CrystalDecisions.Web" Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ReportViewer.aspx.vb" Inherits="SmartHR.ReportViewer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Monthly Report</title>
</head>
<body>
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
							Width="100%" Height="50px"></cr:CrystalReportViewer></td>
				</tr>
			</table>
		</form>
</body>
</html>
