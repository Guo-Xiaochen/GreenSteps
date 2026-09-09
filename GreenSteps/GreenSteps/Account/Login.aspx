<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GreenSteps.Account.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<section class="auth-section">
    <div class="auth-box">
        <h2>🌱 Login to GreenSteps</h2>

        <asp:Literal ID="litMessage" runat="server" />

        <label for="<%= txtEmailOrName.ClientID %>">Email or Full Name</label>
        <asp:TextBox ID="txtEmailOrName" runat="server" placeholder="you@example.com or Your Full Name" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmailOrName" 
            ErrorMessage="Email or Name is required" CssClass="error-text" Display="Dynamic" />

        <label for="<%= txtPassword.ClientID %>">Password</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" 
            ErrorMessage="Password is required" CssClass="error-text" Display="Dynamic" />

        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-submit" OnClick="btnLogin_Click" />

        <p class="auth-link">
            Don't have an account? <a href="Register.aspx">Register here</a>
        </p>

        <div class="hint-box">
            💡 You can login with your <strong>email</strong> or <strong>full name</strong>!<br />
            Demo Admin: <code>admin@greensteps.com</code> or <code>Admin</code> / <code>admin123</code>
        </div>
    </div>
</section>

</asp:Content>
