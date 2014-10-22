<%@ Page Title="Compras" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Compras.aspx.cs" Inherits="Midtal.Compras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server"  >

    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h4>Compra de Exibições .</h4>
        <hr />

        <div id="complemento" class="form-group">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">                       
                        <h3 class="text-primary">Compra de pacotes de exibição</h3>                         
                        <h4>100 exibições por R$ 50,00</h4>
                        <h4>500 exibições por R$ 200,00</h4>
                        <h4>1000 exibições por R$ 400,00</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <asp:Label runat="server" CssClass="col-md-2 control-label">Quantidade</asp:Label>
                            <input runat="server" id="spnQuantidade" type="number" min="1" max="9999" value="5"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:button runat="server" class="btn btn-primary" Text="Confirma" OnClick="compra_Click"> </asp:button>
                        <button  runat="server" type="button" class="btn btn-Default">Histórico</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
    </div>

</asp:Content>
