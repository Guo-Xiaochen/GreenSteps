<%@ Page Title="Edit Article" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="GreenSteps.Admin_Articles_Edit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="form-container">
    <h1>✏️ Edit Article</h1>
    <p class="subtitle">Update this article's information</p>

    <div class="form-group">
        <label for="<%= txtTitle.ClientID %>">Title</label>
        <asp:TextBox ID="txtTitle" runat="server" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle"
            ErrorMessage="Title is required" CssClass="error-text" Display="Dynamic" />
    </div>

    <div class="form-group">
        <label for="<%= ddlCategory.ClientID %>">Category</label>
        <asp:DropDownList ID="ddlCategory" runat="server">
            <asp:ListItem Value="General">General</asp:ListItem>
            <asp:ListItem Value="Waste Reduction">Waste Reduction</asp:ListItem>
            <asp:ListItem Value="Energy">Energy</asp:ListItem>
            <asp:ListItem Value="Lifestyle">Lifestyle</asp:ListItem>
            <asp:ListItem Value="Transportation">Transportation</asp:ListItem>
            <asp:ListItem Value="Food">Food</asp:ListItem>
            <asp:ListItem Value="Water">Water</asp:ListItem>
        </asp:DropDownList>
    </div>

    <div class="form-group">
        <label for="<%= txtAuthor.ClientID %>">Author</label>
        <asp:TextBox ID="txtAuthor" runat="server" />
    </div>

    <div class="form-group">
        <label for="<%= txtContent.ClientID %>">Content</label>
        <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtContent"
            ErrorMessage="Content is required" CssClass="error-text" Display="Dynamic" />
    </div>

    <div class="form-actions">
        <asp:Button ID="btnUpdate" runat="server" Text="💾 Update Article" CssClass="btn-save" OnClick="btnUpdate_Click" />
        <a href="Index.aspx" class="btn-cancel">Cancel</a>
    </div>
</div>

</asp:Content>
