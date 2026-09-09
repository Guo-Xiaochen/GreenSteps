<%@ Page Title="Article" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="GreenSteps.Articles_Details" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="article-container">
    <a href="../Articles.aspx" class="back-link">← Back to all articles</a>

    <asp:PlaceHolder ID="phNotFound" runat="server" Visible="false">
        <div class="alert alert-error">
            <h2>❌ Article Not Found</h2>
            <p>The article you're looking for doesn't exist.</p>
        </div>
    </asp:PlaceHolder>

    <asp:PlaceHolder ID="phArticle" runat="server">
        <article class="article-page">
            <span class="category-tag"><asp:Literal ID="litCategory" runat="server" /></span>
            <h1 class="article-title"><asp:Literal ID="litTitle" runat="server" /></h1>

            <div class="article-meta" style="padding-bottom: 1.5rem; border-bottom: 1px solid #eee; margin-bottom: 2rem; display: flex; gap: 1.5rem; flex-wrap: wrap;">
                <span>✍️ <strong><asp:Literal ID="litAuthor" runat="server" /></strong></span>
                <span>📅 <asp:Literal ID="litDate" runat="server" /></span>
            </div>

            <div class="article-content">
                <asp:Literal ID="litContent" runat="server" />
            </div>
        </article>
    </asp:PlaceHolder>
</div>

</asp:Content>
