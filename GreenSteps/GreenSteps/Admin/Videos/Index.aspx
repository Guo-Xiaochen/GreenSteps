<%@ Page Title="Manage Videos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="GreenSteps.Admin_Videos_Index" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="admin-container">
    <div class="admin-header">
        <h1>🎬 Manage Videos</h1>
        <a href="Create.aspx" class="btn-primary">➕ Add New Video</a>
    </div>

    <asp:Literal ID="litMessage" runat="server" />

    <asp:GridView ID="gvVideos" runat="server" AutoGenerateColumns="False" CssClass="data-table"
        DataKeyNames="VideoId" OnRowCommand="gvVideos_RowCommand" GridLines="None">
        <Columns>
            <asp:BoundField DataField="VideoId" HeaderText="ID" />
            <asp:TemplateField HeaderText="Thumbnail">
                <ItemTemplate>
                    <img src='https://img.youtube.com/vi/<%# Eval("YouTubeId") %>/default.jpg' 
                         style="width:100px;height:60px;border-radius:6px;" alt="thumbnail" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:BoundField DataField="Category" HeaderText="Category" />
            <asp:BoundField DataField="DurationMinutes" HeaderText="Duration (min)" />
            <asp:BoundField DataField="UploadedDate" HeaderText="Uploaded" DataFormatString="{0:dd MMM yyyy}" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <div class="actions">
                        <a href='Edit.aspx?id=<%# Eval("VideoId") %>' class="btn-edit">✏️ Edit</a>
                        <asp:LinkButton runat="server" CssClass="btn-delete" CommandName="DeleteVideo"
                            CommandArgument='<%# Eval("VideoId") %>'
                            OnClientClick="return confirm('Delete this video?');">
                            🗑️ Delete
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <div class="empty-state">
                <p>No videos yet. Click "Add New Video" to add one! 🎬</p>
            </div>
        </EmptyDataTemplate>
    </asp:GridView>
</div>

</asp:Content>
