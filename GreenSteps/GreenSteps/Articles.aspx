<%@ Page Title="Articles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Articles.aspx.cs" Inherits="GreenSteps.Articles" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header">
    <h1>📚 Sustainable Living Articles</h1>
    <p>Explore our collection of eco-friendly guides and tips</p>
</div>

<div class="article-grid">
    <asp:Repeater ID="rptArticles" runat="server">
        <ItemTemplate>
            <a href='Articles/Details.aspx?id=<%# Eval("ArticleId") %>' class="article-card">
                <span class="category-tag"><%# Eval("Category") %></span>
                <h3><%# Eval("Title") %></h3>
                <p class="article-content-preview">
                    <%# TrimContent(Eval("Content").ToString()) %>
                </p>
                <div class="article-meta">
                    ✍️ <%# Eval("Author") ?? "Anonymous" %> •
                    📅 <%# ((DateTime)Eval("PublishedDate")).ToString("dd MMM yyyy") %>
                </div>
            </a>
        </ItemTemplate>
    </asp:Repeater>
</div>

</asp:Content>
