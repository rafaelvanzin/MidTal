<%@ Page Title="Compras" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Compras.aspx.cs" Inherits="Midtal.Compras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .modal-dialog-center { /* Edited classname 10/03/2014 */
            margin: 0;
            position: absolute;
            top: 30%;
            left: 30%;
            height: 300px;
        }
    </style>

    <script type="text/javascript">

        $('#PopupHistorico').modal();

    </script>

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
                    </div>
                    <div class="modal-body">
                        <asp:RadioButtonList ID="radioCompra" runat="server" Enabled="true">
                            <asp:ListItem Value="0" Text="100 exibições por R$ 50,00" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="1" Text="500 exibições por R$ 200,00"></asp:ListItem>
                            <asp:ListItem Value="2" Text="1000 exibições por R$ 400,00"></asp:ListItem>
                            <asp:ListItem Value="3" Text="3000 exibições por R$ 1.000,00"></asp:ListItem>
                        </asp:RadioButtonList>
                        <br />
                        <p>
                            Escolha um dos pacotes de exibição e confirme sua compra.
                        </p>
                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" class="btn btn-primary" Text="Confirma" OnClick="compra_Click"></asp:Button>
                        <button type="button" class="btn btn-default" data-dismiss="PopupHistorico" onclick="$('#PopupHistorico').show();">Histórico</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
    </div>

    <div class="modal dialog " id="PopupHistorico" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-center">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" onclick="$('#PopupHistorico').hide();">×</button>
                    <h4 class="modal-title" id="myModalLabel">Histórico de compra</h4>
                </div>
                <div class="modal-body">

                    <asp:GridView ID="grdHistorico" runat="server" DataKeyNames="cod_midia" Width="100%"
                        ShowHeaderWhenEmpty="false" AutoGenerateColumns="False" CellPadding="6" ForeColor="#333333" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="Data_Hora" HeaderText="Data/Hora" ReadOnly="true" />
                            <asp:BoundField DataField="Qtde_Exibicoes" HeaderText="Qtde Exibições" ReadOnly="true" DataFormatString="{0:0}" />
                            <asp:BoundField DataField="Valor" HeaderText="Valor Pago" ReadOnly="true" DataFormatString="{0:#,##0.00}" />
                            <asp:BoundField DataField="situacao" HeaderText="Status" ReadOnly="true" />
                        </Columns>
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <EditRowStyle BackColor="#999999" />

                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    </asp:GridView>
                </div>
                <br />
                <br />
                <br />
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="PopupHistorico" onclick="$('#PopupHistorico').hide();">Fechar</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
