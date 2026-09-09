<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="GreenSteps.Admin_Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="dashboard-container">

    <div class="welcome-section">
        <h1>👋 Welcome back, <asp:Literal ID="litName" runat="server" />!</h1>
        <p>Here's what's happening at GreenSteps today</p>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">📚</div>
            <div class="stat-value"><asp:Literal ID="litArticles" runat="server" /></div>
            <div class="stat-label">Articles</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🎬</div>
            <div class="stat-value"><asp:Literal ID="litVideos" runat="server" /></div>
            <div class="stat-label">Videos</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🧠</div>
            <div class="stat-value"><asp:Literal ID="litQuizzes" runat="server" /></div>
            <div class="stat-label">Quizzes</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">❓</div>
            <div class="stat-value"><asp:Literal ID="litQuestions" runat="server" /></div>
            <div class="stat-label">Quiz Questions</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">👤</div>
            <div class="stat-value"><asp:Literal ID="litUsers" runat="server" /></div>
            <div class="stat-label">Total Users</div>
        </div>
    </div>

    <h2 class="section-title" style="text-align:left; margin: 2rem 0 1rem;">⚡ Quick Actions</h2>

    <div class="features">
        <a href="Articles/Create.aspx" class="feature-card">
            <div class="icon">➕</div>
            <h3>Add Article</h3>
            <p>Publish a new sustainable living article</p>
        </a>
        <a href="Videos/Create.aspx" class="feature-card">
            <div class="icon">🎬</div>
            <h3>Add Video</h3>
            <p>Add a new YouTube video resource</p>
        </a>
        <a href="Quizzes/Create.aspx" class="feature-card">
            <div class="icon">🧠</div>
            <h3>Create Quiz</h3>
            <p>Build a new interactive quiz</p>
        </a>
    </div>

</div>

</asp:Content>
