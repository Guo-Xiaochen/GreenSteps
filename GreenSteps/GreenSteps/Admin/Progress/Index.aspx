<%@ Page Title="User Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="GreenSteps.Admin_Progress_Index" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="admin-container" style="max-width:1300px;">

    <div class="admin-header">
        <h1>📊 User Progress Overview</h1>
    </div>

    <asp:Literal ID="litMessage" runat="server" />

    <!-- ===== STATS ===== -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">🎯</div>
            <div class="stat-value"><asp:Literal ID="litTotalAttempts" runat="server" /></div>
            <div class="stat-label">Total Attempts</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-value"><asp:Literal ID="litActiveLearners" runat="server" /></div>
            <div class="stat-label">Active Learners</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">📊</div>
            <div class="stat-value"><asp:Literal ID="litAvgPlatform" runat="server" />%</div>
            <div class="stat-label">Platform Average</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">💯</div>
            <div class="stat-value"><asp:Literal ID="litPerfect" runat="server" /></div>
            <div class="stat-label">Perfect Scores</div>
        </div>
    </div>

    <!-- ===== LEADERBOARD ===== -->
    <h2 style="color:#2e7d32; margin: 2rem 0 1rem; font-size: 1.5rem;">🏆 Top Performers</h2>

    <asp:PlaceHolder ID="phEmptyLeaders" runat="server" Visible="false">
        <div style="text-align:center; padding:2rem; background:white; border-radius:12px; color:#777; margin-bottom:2rem;">
            <p>No quiz attempts yet. Users will appear here once they take quizzes! 🌱</p>
        </div>
    </asp:PlaceHolder>

    <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(280px, 1fr)); gap:1rem; margin-bottom:2rem;">
        <asp:Repeater ID="rptLeaders" runat="server">
            <ItemTemplate>
                <div style="background:white; padding:1.5rem; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.06); display:flex; align-items:center; gap:1rem;">
                    <div style="font-size:2.2rem;"><%# GetMedal(Container.ItemIndex + 1) %></div>
                    <div style="flex-grow:1;">
                        <div style="font-weight:600; color:#2e7d32;"><%# Eval("FullName") %></div>
                        <div style="font-size:0.85rem; color:#666;">
                            <%# Eval("AttemptCount") %> attempts • Avg <strong><%# Eval("AverageScore") %>%</strong> • Best <strong><%# Eval("BestScore") %>%</strong>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- ===== USER TABLE ===== -->
    <h2 style="color:#2e7d32; margin: 2rem 0 1rem; font-size: 1.5rem;">👥 All Users' Progress</h2>

    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="data-table" GridLines="None">
        <Columns>
            <asp:TemplateField HeaderText="User">
                <ItemTemplate>
                    <strong><%# Eval("FullName") %></strong><br />
                    <small style="color:#777;"><%# Eval("Email") %></small>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Attempts">
                <ItemTemplate>
                    <span style="background:#e8f5e9; color:#2e7d32; padding:0.25rem 0.7rem; border-radius:4px; font-weight:600;">
                        <%# Eval("AttemptCount") %>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Average">
                <ItemTemplate>
                    <%# ShowScore(Eval("AttemptCount"), Eval("AverageScore")) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Best">
                <ItemTemplate>
                    <%# ShowScore(Eval("AttemptCount"), Eval("BestScore")) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <%# ShowActionButton(Eval("UserId"), Eval("AttemptCount")) %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <div class="empty-state">No registered users yet.</div>
        </EmptyDataTemplate>
    </asp:GridView>

</div>

</asp:Content>