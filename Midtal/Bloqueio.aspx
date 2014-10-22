<%@ Page Title="Bloqueio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" Inherits="Bloqueio" Codebehind="Bloqueio.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>Sistema de bloqueio </h1>
        <p class="lead">Este cadastro está bloqueado até a confirmação de instalação do sistema.
        </p>
        <p class="lead">
            Caso seja necessário refazer o download do setup 
            <a runat="server" href="/Download/Setup.exe">clique aqui</a>,
             ou se você deseja acessar novamente as informações de instalação
            <a runat="server" href="ClienteComplemento.aspx">clique aqui</a>
        </p>
        <p><a href="/Logout.aspx" class="btn btn-primary btn-lg">Sair &raquo;</a></p>
    </div>
</asp:Content>
