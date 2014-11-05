<%@ Page Title="Exibições" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Exibicoes.aspx.cs" Inherits="Exibicoes" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2>
        <%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h4>Regiões para exibição das mídias.</h4>
        <hr />

        <div id="complemento" class="form-group">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">                       
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Pesquisa</asp:Label>
                            <div class ="col-md-3 col-md-pull-0 ">
                                <asp:DropDownList ID="Tipo" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="2">Bairro</asp:ListItem>
                                    <asp:ListItem Value="3">Cidade</asp:ListItem>
                                </asp:DropDownList>                   
                            </div>
                            <div class ="col-md-6 col-md-pull-0 ">
                                <asp:TextBox runat="server" ID="Password" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Tipo" CssClass="col-md-2 control-label">Mídia</asp:Label>
                            <div class ="col-md-7 col-md-pull-0 ">
                                <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control" />
                            </div>
                            <a href="#PopupMidias" role="button" class="btn btn-default" data-toggle="modal">Mídias</a>
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MidtalDb %>" SelectCommand="SELECT * FROM [Usuario]"></asp:SqlDataSource>
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="Cidade" DataSourceID="SqlDataSource2" OnSelectedIndexChanged="GridView2_SelectedIndexChanged" AllowPaging="True" CssClass="table table-hover table-striped">
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:BoundField DataField="Cidade" HeaderText="Cidade" InsertVisible="False" ReadOnly="True" SortExpression="Cidade" />
                                </Columns>
                        </asp:GridView>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary">Salvar</button>
                        <button type="button" class="btn btn-info">Estado Exibições</button>
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