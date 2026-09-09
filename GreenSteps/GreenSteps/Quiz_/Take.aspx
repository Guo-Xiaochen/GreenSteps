<%@ Page Title="Take Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Take.aspx.cs" Inherits="GreenSteps.Quiz_Take" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="quiz-container">

    <asp:PlaceHolder ID="phQuizForm" runat="server">
        <div class="quiz-header">
            <h1>🧠 <asp:Literal ID="litQuizTitle" runat="server" /></h1>
            <p><asp:Literal ID="litQuizDescription" runat="server" /></p>
        </div>

        <asp:Repeater ID="rptQuestions" runat="server">
            <ItemTemplate>
                <div class="question-card">
                    <div class="question-number">Question <%# Container.ItemIndex + 1 %></div>
                    <div class="question-text"><%# Eval("QuestionText") %></div>

                    <div class="options-list">
                        <label class="option-label">
                            <input type="radio" name='answer_<%# Eval("QuestionId") %>' value="A" required />
                            <span class="option-letter">A.</span> <span><%# Eval("OptionA") %></span>
                        </label>
                        <label class="option-label">
                            <input type="radio" name='answer_<%# Eval("QuestionId") %>' value="B" />
                            <span class="option-letter">B.</span> <span><%# Eval("OptionB") %></span>
                        </label>
                        <label class="option-label">
                            <input type="radio" name='answer_<%# Eval("QuestionId") %>' value="C" />
                            <span class="option-letter">C.</span> <span><%# Eval("OptionC") %></span>
                        </label>
                        <label class="option-label">
                            <input type="radio" name='answer_<%# Eval("QuestionId") %>' value="D" />
                            <span class="option-letter">D.</span> <span><%# Eval("OptionD") %></span>
                        </label>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <div class="submit-section">
            <asp:Button ID="btnSubmit" runat="server" Text="🎯 Submit Answers" CssClass="btn-submit-quiz" OnClick="btnSubmit_Click" />
        </div>
    </asp:PlaceHolder>

    <asp:PlaceHolder ID="phResult" runat="server" Visible="false">
        <div class="result-card">
            <div id="scoreCircle" runat="server" class="score-circle">
                <asp:Literal ID="litPercent" runat="server" />%
            </div>
            <p class="result-message"><asp:Literal ID="litMessage" runat="server" /></p>
            <p class="result-stats">
                You got <strong><asp:Literal ID="litScore" runat="server" /></strong> questions correct
            </p>

            <div class="action-buttons">
                <asp:HyperLink ID="lnkTryAgain" runat="server" CssClass="btn-action primary" Text="🔄 Try Again" />
                <a href="../Quiz.aspx" class="btn-action secondary">← Back to Quizzes</a>
            </div>
        </div>
    </asp:PlaceHolder>

</div>

</asp:Content>
