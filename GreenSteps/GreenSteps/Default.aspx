<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GreenSteps._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="hero">
        <h1>🌱 Welcome to <span class="highlight">GreenSteps</span></h1>
        <p>Your sustainable living learning platform. Discover articles, videos, and quizzes to start your eco-journey today!</p>
        <a href="Articles.aspx" class="btn-cta">Start Learning</a>
    </div>

    <h2 class="section-title">What You'll Learn</h2>
    <p class="section-subtitle">Click any card below to explore</p>

    <div class="features">
        <a href="Articles.aspx" class="feature-card">
            <div class="icon">📚</div>
            <h3>Articles</h3>
            <p>Read guides on sustainable living and eco-friendly habits.</p>
            <span class="learn-more">Explore Articles →</span>
        </a>

        <a href="Videos.aspx" class="feature-card">
            <div class="icon">🎥</div>
            <h3>Video Lessons</h3>
            <p>Watch expert-led videos on renewable energy.</p>
            <span class="learn-more">Watch Now →</span>
        </a>

        <a href="Quiz.aspx" class="feature-card">
            <div class="icon">🧠</div>
            <h3>Quizzes</h3>
            <p>Test your knowledge and track your progress.</p>
            <span class="learn-more">Take a Quiz →</span>
        </a>

        <% if (IsAdminUser) { %>
        <a href="Admin/Dashboard.aspx" class="feature-card">
            <div class="icon">📊</div>
            <h3>Admin Dashboard</h3>
            <p>View platform stats, manage content, and oversee users.</p>
            <span class="learn-more">Open Dashboard →</span>
        </a>
        <% } else { %>
        <a href="About.aspx" class="feature-card">
            <div class="icon">🌍</div>
            <h3>About Us</h3>
            <p>Learn more about our mission and how you can help.</p>
            <span class="learn-more">Learn More →</span>
        </a>
        <% } %>
    </div>

</asp:Content>
