<%@ Page Title="Edit Video" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="GreenSteps.Admin_Videos_Edit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="form-container">
    <h1>✏️ Edit Video</h1>
    <p class="subtitle">Update this video's information</p>

    <div class="form-group">
        <label for="<%= txtTitle.ClientID %>">Title</label>
        <asp:TextBox ID="txtTitle" runat="server" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle"
            ErrorMessage="Title is required" CssClass="error-text" Display="Dynamic" />
    </div>

    <div class="form-group">
        <label for="<%= txtYouTubeId.ClientID %>">YouTube ID</label>
        <asp:TextBox ID="txtYouTubeId" runat="server" />
    </div>

    <div class="form-group">
        <label for="<%= ddlCategory.ClientID %>">Category</label>
        <asp:DropDownList ID="ddlCategory" runat="server">
            <asp:ListItem Value="General">General</asp:ListItem>
            <asp:ListItem Value="Energy">Energy</asp:ListItem>
            <asp:ListItem Value="Lifestyle">Lifestyle</asp:ListItem>
            <asp:ListItem Value="Education">Education</asp:ListItem>
            <asp:ListItem Value="Waste Reduction">Waste Reduction</asp:ListItem>
        </asp:DropDownList>
    </div>

    <div class="form-group">
        <label for="<%= txtDuration.ClientID %>">Duration (minutes)</label>
        <asp:TextBox ID="txtDuration" runat="server" TextMode="Number" />
    </div>

    <div class="form-group">
        <label for="<%= txtDescription.ClientID %>">Description</label>
        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" />
    </div>

    <div class="form-actions">
        <asp:Button ID="btnUpdate" runat="server" Text="💾 Update Video" CssClass="btn-save" OnClick="btnUpdate_Click" />
        <a href="Index.aspx" class="btn-cancel">Cancel</a>
    </div>
</div>

</asp:Content>
