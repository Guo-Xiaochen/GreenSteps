<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="GreenSteps.Account.Register" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<section class="auth-section">
    <div class="auth-box">
        <h2>🌱 Create Your Account</h2>

        <asp:Literal ID="litMessage" runat="server" />

        <label for="<%= txtFullName.ClientID %>">Full Name</label>
        <asp:TextBox ID="txtFullName" runat="server" placeholder="William Tan" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFullName" 
            ErrorMessage="Full name is required" CssClass="error-text" Display="Dynamic" />

        <label for="<%= txtEmail.ClientID %>">Email</label>
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="you@example.com" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" 
            ErrorMessage="Email is required" CssClass="error-text" Display="Dynamic" />
        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
            ValidationExpression="^[^\s@]+@[^\s@]+\.[^\s@]+$"
            ErrorMessage="Please enter a valid email" CssClass="error-text" Display="Dynamic" />

        <label for="<%= txtPassword.ClientID %>">Password</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="At least 6 characters" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" 
            ErrorMessage="Password is required" CssClass="error-text" Display="Dynamic" />
        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPassword"
            ValidationExpression="^.{6,}$"
            ErrorMessage="Password must be at least 6 characters" CssClass="error-text" Display="Dynamic" />

        <label for="<%= txtConfirmPassword.ClientID %>">Confirm Password</label>
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Re-enter password" />
        <asp:CompareValidator runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword"
            ErrorMessage="Passwords do not match" CssClass="error-text" Display="Dynamic" />

        <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-submit" OnClick="btnRegister_Click" />

        <p class="auth-link">
            Already have an account? <a href="Login.aspx">Login here</a>
        </p>
    </div>
</section>

</asp:Content>
