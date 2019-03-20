<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Result.aspx.vb" Inherits="rmxaffiliatewebapp.Result" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Styles/common.css" rel="stylesheet" />
    <div class="container body-content">
        <div class="row">
            <div class="col-md-12" style="height:570px;">
                <% If _success = 1 Then%>
                    <h2 style="color:#022a3b; padding-bottom:10px;">
                        Your email has been successfully sent
                    </h2>
                <% ElseIf _success = 0 Then %>
                    <h2 style="color:#022a3b; padding-bottom:10px;">
                        Opps, there was a problem sending your email. <br />Please call our office at <%= _primaryPhone %>
                    </h2>
                <% Else %>
                    <h2 style="color:#022a3b; padding-bottom:10px;">Failed to Post Data</h2>
                <% End If %>
            </div>
        </div>
    </div>
</asp:Content>
