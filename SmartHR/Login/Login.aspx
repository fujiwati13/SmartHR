<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="SmartHR.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>SMART HR - Log-in</title>

    <link rel='stylesheet' href='http://codepen.io/assets/libs/fullpage/jquery-ui.css'>

    <link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />

</head>

<body>

    <div class="login-card">
        <h1>Log-in</h1>
        <br>
        <form runat="server" method="post">
            <asp:Label runat="server" ID="lblmessage" Visible="false"></asp:Label>
            <asp:TextBox runat="server" ID="txtUsername" Placeholder="Username"></asp:TextBox>
            <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" placeholder="Password"></asp:TextBox>
            <asp:Button Text="Login" ID="btLogin" class="login login-submit" runat="server" OnClick="btLogin_Click"></asp:Button>
        </form>

        <div class="login-help">
            <a href="../HomePage.aspx">Go To HomePage</a>
        </div>
    </div>

    <script src='http://codepen.io/assets/libs/fullpage/jquery_and_jqueryui.js'></script>

</body>

</html>
