<%@ Page Title="Videos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Videos.aspx.cs" Inherits="GreenSteps.Videos" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="page-header">
    <h1>🎬 Video Learning Library</h1>
    <p>Watch educational videos about sustainable living</p>
</div>

<div class="video-grid">
    <asp:Repeater ID="rptVideos" runat="server">
    <ItemTemplate>
        <div class="video-card">
            <div class="video-embed">
                <iframe src='https://www.youtube.com/embed/<%# Eval("YouTubeId") %>'
                        title='<%# Eval("Title") %>'
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowfullscreen></iframe>
            </div>
            <a href='Videos/Details.aspx?id=<%# Eval("VideoId") %>' style="text-decoration:none; color:inherit; display:block;">
                <div class="video-info">
                    <h3><%# Eval("Title") %></h3>
                    <div class="video-meta">
                        <span class="category-pill"><%# Eval("Category") %></span>
                        <span class="duration">⏱️ <%# Eval("DurationMinutes") %> min</span>
                    </div>
                    <p class="video-description"><%# Eval("Description") %></p>
                    <div class="video-date">📅 Uploaded: <%# ((DateTime)Eval("UploadedDate")).ToString("dd MMM yyyy") %></div>
                    <div style="color:#2e7d32; font-weight:600; margin-top:0.8rem; padding-top:0.8rem; border-top:1px solid #eee; font-size:0.95rem;">
                        Watch in full →
                    </div>
                </div>
            </a>
        </div>
    </ItemTemplate>
</asp:Repeater>
</div>

</asp:Content>
