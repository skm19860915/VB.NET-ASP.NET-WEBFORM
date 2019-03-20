<%@ Page Title="About" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.vb" Inherits="rmxaffiliatewebapp.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container body-content">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"><% Response.WriteFile(_pathUrl) %></div>
        </div>
    </div>
</asp:Content>
