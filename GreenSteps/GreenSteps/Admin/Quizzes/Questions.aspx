<%@ Page Title="Manage Questions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Questions.aspx.cs" Inherits="GreenSteps.Admin_Quizzes_Questions" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="admin-container">
    <a href="Index.aspx" class="back-link">← Back to Quiz List</a>

    <div style="background: linear-gradient(135deg, #a8e6a3 0%, #4caf50 100%); color: white; padding: 2rem; border-radius: 12px; margin-bottom: 2rem;">
        <h1 style="font-size:1.8rem; margin-bottom: 0.5rem;">🧠 <asp:Literal ID="litQuizTitle" runat="server" /></h1>
        <p>📝 <strong><asp:Literal ID="litCount" runat="server" /></strong> question(s) in this quiz</p>
    </div>

    <asp:Literal ID="litMessage" runat="server" />

    <h2 style="color:#2e7d32; margin: 2rem 0 1rem;">➕ Add a New Question</h2>

    <div style="background:white; padding:2rem; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.06); margin-bottom:2rem;">
        <div class="form-group">
            <label for="<%= txtQuestion.ClientID %>">Question</label>
            <asp:TextBox ID="txtQuestion" runat="server" TextMode="MultiLine" 
                placeholder="What is..." />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtQuestion"
                ErrorMessage="Question is required" CssClass="error-text" Display="Dynamic" />
        </div>

        <div style="display:grid; grid-template-columns:1fr 1fr; gap:1rem;">
            <div class="form-group">
                <label>Option A</label>
                <asp:TextBox ID="txtA" runat="server" placeholder="First answer" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtA"
                    ErrorMessage="Required" CssClass="error-text" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label>Option B</label>
                <asp:TextBox ID="txtB" runat="server" placeholder="Second answer" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtB"
                    ErrorMessage="Required" CssClass="error-text" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label>Option C</label>
                <asp:TextBox ID="txtC" runat="server" placeholder="Third answer" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtC"
                    ErrorMessage="Required" CssClass="error-text" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label>Option D</label>
                <asp:TextBox ID="txtD" runat="server" placeholder="Fourth answer" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtD"
                    ErrorMessage="Required" CssClass="error-text" Display="Dynamic" />
            </div>
        </div>

        <div style="background:#fffde7; padding:1rem; border-radius:8px; margin-top:1rem; border-left:4px solid #fbc02d;">
            <label>⭐ Which option is correct?</label>
            <asp:DropDownList ID="ddlCorrect" runat="server">
                <asp:ListItem Value="A">A - First option</asp:ListItem>
                <asp:ListItem Value="B">B - Second option</asp:ListItem>
                <asp:ListItem Value="C">C - Third option</asp:ListItem>
                <asp:ListItem Value="D">D - Fourth option</asp:ListItem>
            </asp:DropDownList>
        </div>

        <asp:Button ID="btnAdd" runat="server" Text="💾 Save Question" CssClass="btn-save" 
            OnClick="btnAdd_Click" style="margin-top:1rem;" />
    </div>

    <h2 style="color:#2e7d32; margin: 2rem 0 1rem;">📋 Existing Questions</h2>

    <asp:Repeater ID="rptQuestions" runat="server" OnItemCommand="rptQuestions_ItemCommand">
        <ItemTemplate>
            <div style="background:white; padding:1.5rem; border-radius:10px; margin-bottom:1rem; box-shadow:0 2px 8px rgba(0,0,0,0.05); border-left:4px solid #4caf50;">
                <div style="display:flex; justify-content:space-between; align-items:flex-start; gap:1rem; margin-bottom:1rem;">
                    <span style="background:#2e7d32; color:white; padding:0.25rem 0.7rem; border-radius:4px; font-size:0.85rem;">
                        Q<%# Container.ItemIndex + 1 %>
                    </span>
                    <div style="font-weight:500; flex-grow:1;"><%# Eval("QuestionText") %></div>
                </div>

                <div style="display:grid; grid-template-columns:1fr 1fr; gap:0.5rem; margin-bottom:1rem;">
                    <div style='padding:0.5rem 0.8rem; border-radius:6px; <%# ((string)Eval("CorrectAnswer") == "A") ? "background:#e8f5e9;color:#2e7d32;font-weight:500;border:2px solid #4caf50;" : "background:#f9f9f9;" %>'>
                        <strong>A.</strong> <%# Eval("OptionA") %> <%# ((string)Eval("CorrectAnswer") == "A") ? "✓" : "" %>
                    </div>
                    <div style='padding:0.5rem 0.8rem; border-radius:6px; <%# ((string)Eval("CorrectAnswer") == "B") ? "background:#e8f5e9;color:#2e7d32;font-weight:500;border:2px solid #4caf50;" : "background:#f9f9f9;" %>'>
                        <strong>B.</strong> <%# Eval("OptionB") %> <%# ((string)Eval("CorrectAnswer") == "B") ? "✓" : "" %>
                    </div>
                    <div style='padding:0.5rem 0.8rem; border-radius:6px; <%# ((string)Eval("CorrectAnswer") == "C") ? "background:#e8f5e9;color:#2e7d32;font-weight:500;border:2px solid #4caf50;" : "background:#f9f9f9;" %>'>
                        <strong>C.</strong> <%# Eval("OptionC") %> <%# ((string)Eval("CorrectAnswer") == "C") ? "✓" : "" %>
                    </div>
                    <div style='padding:0.5rem 0.8rem; border-radius:6px; <%# ((string)Eval("CorrectAnswer") == "D") ? "background:#e8f5e9;color:#2e7d32;font-weight:500;border:2px solid #4caf50;" : "background:#f9f9f9;" %>'>
                        <strong>D.</strong> <%# Eval("OptionD") %> <%# ((string)Eval("CorrectAnswer") == "D") ? "✓" : "" %>
                    </div>
                </div>

                <div style="text-align:right;">
                    <asp:LinkButton runat="server" CssClass="btn-delete" CommandName="DeleteQuestion"
                        CommandArgument='<%# Eval("QuestionId") %>'
                        OnClientClick="return confirm('Delete this question?');">
                        🗑️ Delete
                    </asp:LinkButton>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

</div>

</asp:Content>
