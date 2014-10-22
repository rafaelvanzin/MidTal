<%@ Page Title="Contato" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" Inherits="Contato" Codebehind="Contato.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <h2>Contato Midtal.</h2>
    <address>
        Rua dos aflitos, nº 100<br />
        Bairro Cinquentenário, Cep 95112-303<br />
        <abbr title="Fone">F:</abbr>
        55.54.3030-1234
    </address>

    <address>
        <strong>Suporte:</strong>   <a href="mailto:midtalcompany@gmail.com">contato@midtal.com.br</a><br />
    </address>

    <div class="form-horizontal">
        <h4>Selecione o assunto e entre em contato.</h4>
        <hr />
        <div class="form-group">
            <asp:Label runat="server" CssClass="col-md-2 control-label">Assunto</asp:Label>
            <div class="col-md-10" style="height:54px">
                <div class="dropdown" >
                  <asp:DropDownList ID="Tipo" runat="server">
                        <asp:ListItem Value="Compra/Locação">1 - Compra/Locação</asp:ListItem>
                        <asp:ListItem Value="Instalação">2 - Instalação</asp:ListItem>
                        <asp:ListItem Value="Contato">3 - Contato Midtal</asp:ListItem>
                    </asp:DropDownList>                   
                </div>
            </div>
        </div>   
        <div class="form-group">
            <asp:Label runat="server" CssClass="col-md-2 control-label">Mensagem</asp:Label>
            <div class="col-md-10" style="height:180px">
                <textarea  runat="server" class="form-control" rows="7" id="txtEmail"></textarea>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10" style="height:54px">
                <asp:Button runat="server" Text="Envia" CssClass="btn btn-primary" OnClick="mail_Send" />
            </div>
        </div>
    </div>

</asp:Content>
