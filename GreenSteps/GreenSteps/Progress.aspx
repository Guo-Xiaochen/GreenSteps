<%@ Page Title="My Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Progress.aspx.cs" Inherits="GreenSteps.Progress" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="admin-container" style="max-width:1100px;">

    <div style="background: linear-gradient(135deg, #a8e6a3 0%, #4caf50 100%); color: white; padding: 3rem 2rem; border-radius: 12px; margin-bottom: 2rem; text-align: center;">
        <h1 style="font-size:2.4rem; margin-bottom:0.5rem;">📈 My Learning Progress</h1>
        <p style="font-size:1.1rem;">Hi <asp:Literal ID="litName" runat="server" />, here's your eco-learning journey!</p>
    </div>

    <!-- ===== STATS ===== -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">🎯</div>
            <div class="stat-value"><asp:Literal ID="litTotal" runat="server" /></div>
            <div class="stat-label">Quizzes Taken</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">📊</div>
            <div class="stat-value"><asp:Literal ID="litAvg" runat="server" />%</div>
            <div class="stat-label">Average Score</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🏆</div>
            <div class="stat-value"><asp:Literal ID="litBest" runat="server" />%</div>
            <div class="stat-label">Best Score</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🌟</div>
            <div class="stat-value"><asp:Literal ID="litBadges" runat="server" /></div>
            <div class="stat-label">Badges Earned</div>
        </div>
    </div>

    <!-- ===== BADGES ===== -->
    <h2 style="color:#2e7d32; margin: 2rem 0 1rem; font-size: 1.5rem;">🏅 Your Badges</h2>

    <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(180px, 1fr)); gap:1rem; margin-bottom:2rem;">
        <div runat="server" id="badge1" class="badge-card">
            <div style="font-size:3rem;">🌱</div>
            <div style="font-weight:600; color:#2e7d32;">First Steps</div>
            <div style="font-size:0.8rem; color:#777;">Complete your first quiz</div>
        </div>
        <div runat="server" id="badge2" class="badge-card">
            <div style="font-size:3rem;">📚</div>
            <div style="font-weight:600; color:#2e7d32;">Eager Learner</div>
            <div style="font-size:0.8rem; color:#777;">Complete 3 quizzes</div>
        </div>
        <div runat="server" id="badge3" class="badge-card">
            <div style="font-size:3rem;">🎓</div>
            <div style="font-weight:600; color:#2e7d32;">High Achiever</div>
            <div style="font-size:0.8rem; color:#777;">Score 80%+ on a quiz</div>
        </div>
        <div runat="server" id="badge4" class="badge-card">
            <div style="font-size:3rem;">💯</div>
            <div style="font-weight:600; color:#2e7d32;">Perfectionist</div>
            <div style="font-size:0.8rem; color:#777;">Get 100% on a quiz</div>
        </div>
    </div>

    <style>
        .badge-card {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            text-align: center;
            transition: transform 0.2s;
        }
        .badge-card.earned { border: 2px solid #4caf50; }
        .badge-card.locked { opacity: 0.5; filter: grayscale(0.7); }
    </style>

    <!-- ===== HISTORY ===== -->
    <h2 style="color:#2e7d32; margin: 2rem 0 1rem; font-size: 1.5rem;">📋 Quiz History & Feedback</h2>

    <asp:PlaceHolder ID="phEmpty" runat="server" Visible="false">
        <div style="text-align:center; padding:3rem; background:white; border-radius:12px; color:#777;">
            <p>You haven't taken any quizzes yet! 🌱</p>
            <a href="Quiz.aspx" style="display:inline-block; margin-top:1rem; padding:0.7rem 1.5rem; background:#2e7d32; color:white; border-radius:6px; text-decoration:none; font-weight:500;">
                Take Your First Quiz →
            </a>
        </div>
    </asp:PlaceHolder>

    <asp:Repeater ID="rptAttempts" runat="server">
        <ItemTemplate>
            <div style="background:white; padding:1.5rem; border-radius:10px; margin-bottom:1rem; box-shadow:0 2px 8px rgba(0,0,0,0.05); border-left:4px solid <%# GetColor(Eval("Score"), Eval("TotalQuestions")) %>;">
                <div style="display:flex; justify-content:space-between; flex-wrap:wrap; gap:1rem;">
                    <div>
                        <strong style="color:#2e7d32; font-size:1.1rem;"><%# Eval("QuizTitle") %></strong><br />
                        <small style="color:#777;">📅 <%# ((DateTime)Eval("AttemptedAt")).ToString("dd MMM yyyy, HH:mm") %></small>
                    </div>
                    <div style="text-align:right;">
                        <div style="font-size:1.5rem; font-weight:700; color:<%# GetColor(Eval("Score"), Eval("TotalQuestions")) %>;">
                            <%# GetPercent(Eval("Score"), Eval("TotalQuestions")) %>%
                        </div>
                        <div style="color:#666; font-size:0.9rem;">
                            <%# Eval("Score") %> / <%# Eval("TotalQuestions") %> correct
                        </div>
                    </div>
                </div>
                <%# ShowFeedback(Eval("AdminFeedback"), Eval("FeedbackDate")) %>
            </div>
        </ItemTemplate>
    </asp:Repeater>

</div>

</asp:Content>