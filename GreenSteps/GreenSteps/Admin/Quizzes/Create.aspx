<%@ Page Title="Add Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="GreenSteps.Admin_Quizzes_Create" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="form-container">
    <h1>➕ Add New Quiz</h1>
    <p class="subtitle">Create a quiz first, then add questions to it</p>

    <div class="alert alert-info" style="margin-bottom:1.5rem;">
        💡 After saving, you'll be able to add questions to this quiz.
    </div>

    <div class="form-group">
        <label for="<%= txtTitle.ClientID %>">Title</label>
        <asp:TextBox ID="txtTitle" runat="server" placeholder="e.g. Climate Change Quiz" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle"
            ErrorMessage="Title is required" CssClass="error-text" Display="Dynamic" />
    </div>

    <div class="form-group">
        <label for="<%= txtDescription.ClientID %>">Description</label>
        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" 
            placeholder="What is this quiz about?" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription"
            ErrorMessage="Description is required" CssClass="error-text" Display="Dynamic" />
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

    <div class="form-actions">
        <asp:Button ID="btnSave" runat="server" Text="💾 Save & Add Questions" CssClass="btn-save" OnClick="btnSave_Click" />
        <a href="Index.aspx" class="btn-cancel">Cancel</a>
    </div>
</div>

</asp:Content>
