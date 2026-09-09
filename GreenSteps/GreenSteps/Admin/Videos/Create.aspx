<%@ Page Title="Add Video" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="GreenSteps.Admin_Videos_Create" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="form-container">
    <h1>➕ Add New Video</h1>
    <p class="subtitle">Add a YouTube video to the library</p>

    <div class="form-group">
        <label for="<%= txtTitle.ClientID %>">Title</label>
        <asp:TextBox ID="txtTitle" runat="server" placeholder="e.g. How Solar Panels Work" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle"
            ErrorMessage="Title is required" CssClass="error-text" Display="Dynamic" />
    </div>

    <div class="form-group">
        <label for="<%= txtYouTubeId.ClientID %>">YouTube Video ID</label>
        <asp:TextBox ID="txtYouTubeId" runat="server" placeholder="e.g. dQw4w9WgXcQ" />
        <div style="font-size:0.85rem;color:#666;margin-top:0.3rem;">
            💡 From URL: youtube.com/watch?v=<strong>dQw4w9WgXcQ</strong> — just the ID part!
        </div>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtYouTubeId"
            ErrorMessage="YouTube ID is required" CssClass="error-text" Display="Dynamic" />
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
        <asp:TextBox ID="txtDuration" runat="server" TextMode="Number" Text="5" />
    </div>

    <div class="form-group">
        <label for="<%= txtDescription.ClientID %>">Description</label>
        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" 
            placeholder="What is this video about?" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription"
            ErrorMessage="Description is required" CssClass="error-text" Display="Dynamic" />
    </div>

    <div class="form-actions">
        <asp:Button ID="btnSave" runat="server" Text="💾 Save Video" CssClass="btn-save" OnClick="btnSave_Click" />
        <a href="Index.aspx" class="btn-cancel">Cancel</a>
    </div>
</div>

</asp:Content>
