<%@ Page Title="User Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="GreenSteps.Admin_Progress_Details" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="admin-container" style="max-width:1200px;">

    <a href="Index.aspx" style="display:inline-block; color:#2e7d32; margin-bottom:1rem; font-weight:500; text-decoration:none;">← Back to all users</a>

    <asp:Literal ID="litMessage" runat="server" />

    <asp:PlaceHolder ID="phUser" runat="server">

        <div style="background: linear-gradient(135deg, #a8e6a3 0%, #4caf50 100%); color: white; padding: 2rem; border-radius: 12px; margin-bottom: 2rem;">
            <h1 style="font-size:2rem; margin-bottom: 0.3rem;">👤 <asp:Literal ID="litName" runat="server" /></h1>
            <div style="opacity:0.9; font-size:1rem;">📧 <asp:Literal ID="litEmail" runat="server" /></div>
        </div>

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
                <div class="stat-icon">📅</div>
                <div class="stat-value" style="font-size:1.1rem;"><asp:Literal ID="litLastActive" runat="server" /></div>
                <div class="stat-label">Last Active</div>
            </div>
        </div>

        <h2 style="color:#2e7d32; margin: 2rem 0 1rem; font-size: 1.5rem;">📋 All Quiz Attempts</h2>

        <asp:Repeater ID="rptAttempts" runat="server" OnItemCommand="rptAttempts_ItemCommand">
            <ItemTemplate>
                <div style="background:white; padding:1.5rem; border-radius:10px; margin-bottom:1rem; box-shadow:0 2px 8px rgba(0,0,0,0.05); border-left:4px solid <%# GetColor(Eval("Score"), Eval("TotalQuestions")) %>;">
                    <div style="display:flex; justify-content:space-between; flex-wrap:wrap; gap:1rem; margin-bottom:1rem;">
                        <div>
                            <strong style="color:#2e7d32; font-size:1.1rem;"><%# Eval("QuizTitle") %></strong><br />
                            <small style="color:#777;">
                                🆔 Attempt #<%# Eval("AttemptId") %> •
                                📅 <%# ((DateTime)Eval("AttemptedAt")).ToString("dd MMM yyyy, HH:mm") %>
                            </small>
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

                    <!-- FEEDBACK SECTION -->
                    <div style="background:#fffde7; padding:1rem; border-radius:6px; margin-top:1rem; border-left:3px solid #fbc02d;">
                        <label style="font-weight:600; color:#e65100; display:block; margin-bottom:0.5rem;">
                            💬 Admin Feedback:
                        </label>
                        <asp:TextBox runat="server" ID="txtFeedback" TextMode="MultiLine" Rows="2"
                            Text='<%# Eval("AdminFeedback") %>'
                            style="width:100%; padding:0.5rem; border:1px solid #ccc; border-radius:6px; font-family:inherit;" />
                        <div style="display:flex; gap:0.5rem; margin-top:0.5rem; align-items:center;">
                            <asp:LinkButton runat="server" CssClass="btn-save" CommandName="SaveFeedback"
                                CommandArgument='<%# Eval("AttemptId") %>' style="padding:0.4rem 0.9rem; font-size:0.85rem;">
                                💾 Save Feedback
                            </asp:LinkButton>
                            <asp:LinkButton runat="server" CssClass="btn-delete" CommandName="DeleteAttempt"
                                CommandArgument='<%# Eval("AttemptId") %>'
                                OnClientClick="return confirm('Delete this attempt permanently?');"
                                style="padding:0.4rem 0.9rem; font-size:0.85rem;">
                                🗑️ Delete Attempt
                            </asp:LinkButton>
                            <%# ShowLastEdited(Eval("FeedbackDate")) %>
                        </div>
                    </div>

                </div>
            </ItemTemplate>
        </asp:Repeater>

        <asp:PlaceHolder ID="phEmpty" runat="server" Visible="false">
            <div style="text-align:center; padding:2rem; background:white; border-radius:12px; color:#777;">
                This user hasn't taken any quizzes yet.
            </div>
        </asp:PlaceHolder>

    </asp:PlaceHolder>

</div>

</asp:Content>