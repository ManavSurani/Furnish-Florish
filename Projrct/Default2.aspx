<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="_Default2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Register Page</title>
    <link href="App_Themes/Theme1/Register.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div class="register-container">
        <h1>Register</h1>
        <form id="form1" runat="server">
            
            <asp:TextBox ID="Username" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="Username" ErrorMessage="Username is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            
            <asp:TextBox ID="Email" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="Email" ErrorMessage="Email is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="Email" ErrorMessage="Invalid email format" CssClass="error-message" Display="Dynamic" ValidationExpression="^[^\s@]+@[^\s@]+\.[^\s@]+$"></asp:RegularExpressionValidator>
            
            <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="Password" ErrorMessage="Password is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="Password" ErrorMessage="Password must be 5 to 8 characters long" CssClass="error-message" Display="Dynamic" ValidationExpression="^.{5,8}$"></asp:RegularExpressionValidator>
            
            <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Confirm Password is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvConfirmPassword" runat="server" ControlToValidate="ConfirmPassword" ControlToCompare="Password" ErrorMessage="Passwords do not match" CssClass="error-message" Display="Dynamic"></asp:CompareValidator>
            <asp:TextBox ID="PhoneNumber" runat="server" CssClass="form-control" placeholder="Phone Number"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" ControlToValidate="PhoneNumber" ErrorMessage="Phone number is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" ControlToValidate="PhoneNumber" ErrorMessage="Phone number must be 10 digits" CssClass="error-message" Display="Dynamic" ValidationExpression="^\d{10}$"></asp:RegularExpressionValidator>

            <asp:TextBox ID="Address" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="Address" ErrorMessage="Address is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            
            <asp:TextBox ID="City" runat="server" CssClass="form-control" placeholder="City"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="City" ErrorMessage="City is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            
            <asp:TextBox ID="State" runat="server" CssClass="form-control" placeholder="State"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="State" ErrorMessage="State is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            
            <asp:TextBox ID="Pincode" runat="server" CssClass="form-control" placeholder="Pincode"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPincode" runat="server" ControlToValidate="Pincode" ErrorMessage="Pincode is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revPincode" runat="server" ControlToValidate="Pincode" ErrorMessage="Invalid pincode format" CssClass="error-message" Display="Dynamic" ValidationExpression="^\d{6}$"></asp:RegularExpressionValidator>
            
            <asp:Button ID="btnRegister" runat="server" Text="Submit" OnClick="btnRegister_Click" CssClass="btn-register" />
        </form>
        <div class="form-link">
            Already have an account?
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx" ForeColor="#004d26"> 
            Login here 
            </asp:HyperLink> 
        </div> 
    </div> 
</body> 
</html>
