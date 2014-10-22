<%@ Page Title="Estado Servidor" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EstadoServidor.aspx.cs" Inherits="EstadoServidor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>
        <%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h4>Estado dos servidores dos exibidores.</h4>
        <hr />

        <div id="complemento" class="form-group">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">                       
                       
                       
                    </div>
                    <div class="modal-body">
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MidtalDb %>" SelectCommand="SELECT * FROM [Usuario]"></asp:SqlDataSource>
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Cidade" DataSourceID="SqlDataSource2" OnSelectedIndexChanged="GridView2_SelectedIndexChanged" AllowPaging="True" CssClass="table table-hover table-striped">
                                <Columns>
                                    <asp:BoundField DataField="Nome_Razao_Social" HeaderText="Nome/Companhia" InsertVisible="False" ReadOnly="True" />
                                    <asp:ButtonField Text="Mídias" HeaderText="Fila de exibição" />
                                    <asp:ButtonField Text="Status" HeaderText="Estado do servidor" />
                                   
                                </Columns>
                        </asp:GridView>
                    </div>
                    <div class="modal-footer">                      
                        <%--<button type="button" class="btn btn-primary">Sair</button>--%>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MidtalDb %>" SelectCommand="SELECT * FROM [Midia]"></asp:SqlDataSource>
    <div class="modal fade" id="PopupMidias" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
   	            <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                </div>
                <div class="modal-body">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Cod_Midia" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowPaging="True" CssClass="table table-hover table-striped">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="Cod_Midia" HeaderText="Cod_Midia" InsertVisible="False" ReadOnly="True" SortExpression="Cod_Midia" />
                                <asp:BoundField DataField="Exibicao_Propria" HeaderText="Exibicao_Propria" SortExpression="Exibicao_Propria" />
                                <asp:BoundField DataField="Tipo_Arquivo" HeaderText="Tipo_Arquivo" SortExpression="Tipo_Arquivo" />
                                <asp:BoundField DataField="Tempo_Execucao" HeaderText="Tempo_Execucao" SortExpression="Tempo_Execucao" />
                            </Columns>
                    </asp:GridView>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Sair</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

