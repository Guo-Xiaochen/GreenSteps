<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="GreenSteps.Admin_Users_Index" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="admin-container" style="max-width:1200px;">

    <div class="admin-header">
        <h1>👥 Manage Users</h1>
        <div style="display:flex; gap:1rem; flex-wrap:wrap;">
            <span style="background:#e8f5e9; color:#2e7d32; padding:0.5rem 1rem; border-radius:6px; font-weight:500;">
                👤 <asp:Literal ID="litTotal" runat="server" /> Total
            </span>
            <span style="background:#ffebee; color:#c62828; padding:0.5rem 1rem; border-radius:6px; font-weight:500;">
                👑 <asp:Literal ID="litAdmins" runat="server" /> Admins
            </span>
            <span style="background:#e8f5e9; color:#2e7d32; padding:0.5rem 1rem; border-radius:6px; font-weight:500;">
                🌱 <asp:Literal ID="litUsers" runat="server" /> Users
            </span>
        </div>
    </div>

    <asp:Literal ID="litMessage" runat="server" />

    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="data-table"
        DataKeyNames="UserId" OnRowCommand="gvUsers_RowCommand" GridLines="None">
        <Columns>
            <asp:BoundField DataField="UserId" HeaderText="ID" />
            <asp:TemplateField HeaderText="Name">
                <ItemTemplate>
                    <strong><%# Eval("FullName") %></strong>
                    <%# ShowYouBadge(Eval("UserId")) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:TemplateField HeaderText="Role">
                <ItemTemplate>
                    <%# ShowRolePill(Eval("Role")) %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CreatedAt" HeaderText="Joined" DataFormatString="{0:dd MMM yyyy}" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <div class="actions">
                        <%# ShowActionButtons(Eval("UserId"), Eval("Role")) %>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <div class="empty-state">No users yet.</div>
        </EmptyDataTemplate>
    </asp:GridView>
</div>

</asp:Content>