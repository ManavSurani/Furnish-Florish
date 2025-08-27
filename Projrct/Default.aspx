<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
    <link href="App_Themes/Theme1/Login.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form id="form1" runat="server">
            <asp:TextBox ID="Username" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
            <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password"></asp:TextBox>
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn-login" />
        </form>
        <div class="form-link">
            Don't have an account?
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default2.aspx" ForeColor="#004d26">
                Register here
            </asp:HyperLink>
        </div>
    </div>
</body>
</html>
