<%@ Page Title="Recupera Senha" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="RecuperaSenha.aspx.cs" Inherits="WebApplication4.RecuperaSenha" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>
    <asp:ValidationSummary runat="server" CssClass="text-danger" />

    <div class="form-horizontal">
        <h4>Processo de recuperação de senha. Uma nova senha será enviada para o seu e-mail.</h4>
        <hr />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">E-mail</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="O E-mail deve ser preenchido"  />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Digite os caracteres</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Captcha" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Captcha"
                    CssClass="text-danger" ErrorMessage="O E-mail deve ser preenchido"  />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">  
                <IMG height="60" alt="" src="Captcha.aspx" width="150">
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Envia" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
</asp:Content>
