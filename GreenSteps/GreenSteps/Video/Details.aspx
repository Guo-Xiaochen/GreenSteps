<%@ Page Title="Watch Video" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="GreenSteps.Videos_Details" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="video-container" style="max-width:1000px; margin:3rem auto; padding:2rem;">

    <a href="../Videos.aspx" class="back-link" style="display:inline-block; color:#2e7d32; margin-bottom:1.5rem; font-weight:500;">← Back to all videos</a>

    <asp:PlaceHolder ID="phNotFound" runat="server" Visible="false">
        <div class="alert alert-error" style="background:#ffebee; color:#c62828; padding:2rem; border-radius:12px; text-align:center;">
            <h2>❌ Video Not Found</h2>
            <p>The video you're looking for doesn't exist.</p>
        </div>
    </asp:PlaceHolder>

    <asp:PlaceHolder ID="phVideo" runat="server">

        <!-- Large video player -->
        <div style="background:white; padding:1rem; border-radius:12px; box-shadow:0 4px 16px rgba(0,0,0,0.08); margin-bottom:2rem;">
            <div style="position:relative; width:100%; padding-bottom:56.25%; height:0; background:#000; border-radius:8px; overflow:hidden;">
                <iframe src='https://www.youtube.com/embed/<%= YouTubeId %>?autoplay=1'
                        title="Video Player"
                        style="position:absolute; top:0; left:0; width:100%; height:100%; border:none;"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowfullscreen></iframe>
            </div>
        </div>

        <!-- Video details -->
        <div style="background:white; padding:2.5rem; border-radius:12px; box-shadow:0 4px 16px rgba(0,0,0,0.06); border-top:6px solid #4caf50;">
            <span class="category-pill" style="background:#4caf50; color:white; padding:0.3rem 1rem; border-radius:6px; font-size:0.9rem; font-weight:500; display:inline-block; margin-bottom:1.2rem;">
                <asp:Literal ID="litCategory" runat="server" />
            </span>

            <h1 style="color:#2e7d32; font-size:2.2rem; margin-bottom:1rem; line-height:1.3;">
                <asp:Literal ID="litTitle" runat="server" />
            </h1>

            <div style="color:#777; font-size:0.95rem; padding-bottom:1.5rem; margin-bottom:1.5rem; border-bottom:1px solid #eee; display:flex; gap:1.5rem; flex-wrap:wrap;">
                <span>⏱️ <strong><asp:Literal ID="litDuration" runat="server" /></strong> min</span>
                <span>📅 <asp:Literal ID="litDate" runat="server" /></span>
                <span>🆔 Video #<asp:Literal ID="litId" runat="server" /></span>
            </div>

            <div style="color:#333; font-size:1.05rem; line-height:1.8;">
                <asp:Literal ID="litDescription" runat="server" />
            </div>

            <div style="margin-top:2rem; padding-top:1.5rem; border-top:1px solid #eee; display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:1rem;">
                <span>🌱 Enjoyed this video? Explore more learning resources!</span>
                <a href="../Videos.aspx" style="padding:0.7rem 1.5rem; background:#2e7d32; color:white; border-radius:6px; text-decoration:none; font-weight:500;">
                    🎬 More Videos
                </a>
            </div>
        </div>

    </asp:PlaceHolder>

</div>

</asp:Content>