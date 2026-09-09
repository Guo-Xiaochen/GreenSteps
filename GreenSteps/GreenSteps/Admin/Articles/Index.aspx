<%@ Page Title="Manage Articles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="GreenSteps.Admin_Articles_Index" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="admin-container">
    <div class="admin-header">
        <h1>📚 Manage Articles</h1>
        <a href="Create.aspx" class="btn-primary">➕ Add New Article</a>
    </div>

    <asp:Literal ID="litMessage" runat="server" />

    <asp:GridView ID="gvArticles" runat="server" AutoGenerateColumns="False" CssClass="data-table"
        DataKeyNames="ArticleId" OnRowCommand="gvArticles_RowCommand" GridLines="None">
        <Columns>
            <asp:BoundField DataField="ArticleId" HeaderText="ID" />
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:TemplateField HeaderText="Category">
                <ItemTemplate>
                    <span class="category-pill" style="background:#e8f5e9;color:#2e7d32;">
                        <%# Eval("Category") %>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Author" HeaderText="Author" />
            <asp:BoundField DataField="PublishedDate" HeaderText="Published" DataFormatString="{0:dd MMM yyyy}" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <div class="actions">
                        <a href='Edit.aspx?id=<%# Eval("ArticleId") %>' class="btn-edit">✏️ Edit</a>
                        <asp:LinkButton runat="server" CssClass="btn-delete" CommandName="DeleteArticle"
                            CommandArgument='<%# Eval("ArticleId") %>'
                            OnClientClick="return confirm('Are you sure you want to delete this article?');">
                            🗑️ Delete
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <div class="empty-state">
                <p>No articles yet. Click "Add New Article" to create one! 🌱</p>
            </div>
        </EmptyDataTemplate>
    </asp:GridView>
</div>

</asp:Content>
