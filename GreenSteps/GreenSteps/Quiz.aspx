<%@ Page Title="Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="GreenSteps.Quiz" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header">
    <h1>🧠 Test Your Knowledge</h1>
    <p>Take a quiz and learn about sustainable living!</p>
</div>

<div class="quiz-grid">
    <asp:Repeater ID="rptQuizzes" runat="server">
        <ItemTemplate>
            <a href='Quiz/Take.aspx?id=<%# Eval("QuizId") %>' class="quiz-card">
                <div class="quiz-icon">🧠</div>
                <span class="category-pill"><%# Eval("Category") %></span>
                <h3><%# Eval("Title") %></h3>
                <p class="quiz-description"><%# Eval("Description") %></p>
                <div class="quiz-meta">
                    <span class="question-count">📝 <%# Eval("QuestionCount") %> questions</span>
                    <span class="start-btn">Start Quiz →</span>
                </div>
            </a>
        </ItemTemplate>
    </asp:Repeater>
</div>

</asp:Content>
