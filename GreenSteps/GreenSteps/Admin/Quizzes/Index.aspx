<%@ Page Title="Manage Quizzes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="GreenSteps.Admin_Quizzes_Index" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="admin-container">
    <div class="admin-header">
        <h1>🧠 Manage Quizzes</h1>
        <a href="Create.aspx" class="btn-primary">➕ Add New Quiz</a>
    </div>

    <asp:Literal ID="litMessage" runat="server" />

    <asp:GridView ID="gvQuizzes" runat="server" AutoGenerateColumns="False" CssClass="data-table"
        DataKeyNames="QuizId" OnRowCommand="gvQuizzes_RowCommand" GridLines="None">
        <Columns>
            <asp:BoundField DataField="QuizId" HeaderText="ID" />
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:BoundField DataField="Category" HeaderText="Category" />
            <asp:TemplateField HeaderText="Questions">
                <ItemTemplate>
                    <span style="background:#fff3e0;color:#e65100;padding:0.2rem 0.7rem;border-radius:4px;font-weight:500;">
                        📝 <%# Eval("QuestionCount") %>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CreatedAt" HeaderText="Created" DataFormatString="{0:dd MMM yyyy}" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <div class="actions">
                        <a href='Questions.aspx?quizId=<%# Eval("QuizId") %>' class="btn-view">📝 Questions</a>
                        <a href='Edit.aspx?id=<%# Eval("QuizId") %>' class="btn-edit">✏️ Edit</a>
                        <asp:LinkButton runat="server" CssClass="btn-delete" CommandName="DeleteQuiz"
                            CommandArgument='<%# Eval("QuizId") %>'
                            OnClientClick="return confirm('Delete this quiz and all its questions?');">
                            🗑️ Delete
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <div class="empty-state">
                <p>No quizzes yet. Click "Add New Quiz" to create one! 🧠</p>
            </div>
        </EmptyDataTemplate>
    </asp:GridView>
</div>

</asp:Content>
