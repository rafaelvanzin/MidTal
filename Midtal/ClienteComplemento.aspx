<%@ Page Title="Registro" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="Account_ClienteComplemento" Codebehind="ClienteComplemento.aspx.cs" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h4>Complemento cliente.</h4>
        <hr />

        <div id="complemento" class="form-group">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">                       
                        <h3 class="text-primary">Requisitos Mínimos</h3>                         
                        <h4>Um computador com sistema operacional Windows e um monitor.</h4>
                        <hr />
                        <h4>Nestas condiçoes de cadastramento só poderá acessar o site, após a instalação do sistema,
                             caso queira apenas anunciar <a href="/Download/Setup.exe">clique aqui</a>.</h4>
                    </div>
                    <div class="modal-body">
                        Opções de instalação:
                        <label class="radio">
                          <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked="">
                          1 Não possuo hardware
                        </label>
                        <label class="radio">
                          <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                          2 Quero contatar um suporte externo para a instalação
                        </label>
                        <label class="radio">
                          <input type="radio" name="optionsRadios" id="optionsRadios3" value="option2">
                          3 Possuo hardware e eu mesmo farei a instalação
                        </label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary">Confirma</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
    </div>
</asp:Content>

