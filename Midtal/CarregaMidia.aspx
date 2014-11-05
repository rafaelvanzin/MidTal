<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="CarregaMidia" CodeBehind="CarregaMidia.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <script src="Scripts/bootbox.min.js"> </script>
    <script type="text/javascript">
        //$(function () {
        //    $("#PopupMidias").dialog();
        //});

        $('#PopupMidias').modal();

        function uploadCompleted() {
            bootbox.dialog({
                message: "Completado com sucesso",
                title: "Carregamento da mídia",
                buttons: {
                    success: {
                        label: "Ok",
                        className: "btn-success",
                        callback: function () {
                            bootbox.hideAll()

                        }
                    }
                }
            });
        }
        function uploadError() {
            bootbox.dialog({
                message: "Falhou",
                title: "Carregamento da mídia",
                buttons: {
                    success: {
                        label: "Ok",
                        className: "btn-danger",
                        callback: function () {
                            bootbox.hideAll()

                        }
                    }
                }
            });
        }
    </script>
    <div class="form-horizontal">
        <h4>Mídias.</h4>
        <hr />
        <div class="form-group">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="text-primary">Tipos de mídias</h3>
                        <h4 class="text-danger">Podem ser adicionados arquivos de: Texto, PowerPoint, Vídeos, Imagens estáticas
                                e Gifs animados. Publicações inadequadas acarretará na não divulgação do conteúdo
                            e aviso ao cliente !
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="form-group">
                            <div class="col-md-10" style="height: 54px">
                                <div>
                                    <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload1" OnClientUploadComplete="uploadCompleted" OnClientUploadError="uploadError" OnUploadedComplete="fileUploadCompleted" runat="server"></ajaxToolkit:AsyncFileUpload>

                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-7 col-md-pull-0 ">
                                <asp:DropDownList ID="TipoDeMidia" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="Tipo_SelectedIndexChanged">
                                    <asp:ListItem Value="1">Anúncio para outro estabelecimento</asp:ListItem>
                                    <asp:ListItem Value="2">Anúncio para estabelecimento próprio</asp:ListItem>
                                </asp:DropDownList>

                                <asp:CheckBox ID="exibPropria" Checked="false" runat="server" />
                                <asp:Label runat="server" Text="Exibição própria" />
                                <br />
                                <br />
                                <br />
                                <asp:UpdatePanel runat="server" UpdateMode="Always">
                                    <%--ChildrenAsTriggers="False"--%>
                                    <ContentTemplate>
                                        <div style="width: 550px;">
                                            <asp:GridView ID="GridViewMidias" runat="server" DataKeyNames="cod_midia" Width="100%" OnSelectedIndexChanged="GridViewMidias_SelectedIndexChanged" OnRowDataBound="GridViewMidias_RowDataBound" ShowHeaderWhenEmpty="false" AutoGenerateColumns="False" CellPadding="6" ForeColor="#333333" GridLines="None">
                                                <Columns>
                                                    <asp:BoundField DataField="Desc_Midia" HeaderText="Descrição" ReadOnly="true" />
                                                    <asp:BoundField DataField="Tempo_Execucao" HeaderText="Tempo" ReadOnly="true" />
                                                    <asp:BoundField DataField="Tipo_Arquivo" HeaderText="Extensão" ReadOnly="true" />

                                                </Columns>
                                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                <EditRowStyle BackColor="#999999" />

                                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                            </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                    <%--                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="TipoDeMidia" EventName="TextChanged" />
                                </Triggers>--%>
                                </asp:UpdatePanel>
                            </div>

                        </div>
                        <br />

                        <asp:Button ID="visualizar" runat="server" Text="Visualizar" OnClick="visualizar_Click" CssClass="btn btn-primary" />
                        <%--  <a href="#PopupMidias" role="button" class="btn btn-primary" data-toggle="modal">Visualizar</a>   html5-main-video --%>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal dialog" id="PopupMidias" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" onclick="$('#PopupMidias').hide();">×</button>
                        <h4 class="modal-title" id="myModalLabel">Visualizador</h4>
                    </div>
                    <div class="modal-body">

                        <video runat="server" id="vidControl" class="video-stream" width="750" height="500" controls autoplay visible="false">
                            
                                Your browser does not support the video tag.
                        </video>

                        <img class="image" runat="server" id="imgControl" style="max-height: 600px; max-width:870px;" visible="false" />

                    </div>
                </div>
            </div>
        </div>
        <asp:TextBox ID="hdnMidia" runat="server" ClientIDMode="Static" />
            
    </div>
    <script type="text/javascript">

        $(function () {

            $('#<%=GridViewMidias.ClientID%> tr[id]').click(function () {
                $('#<%=GridViewMidias.ClientID%> tr[id]').css({ "background-color": "White", "color": "Black" });
                $(this).css({ "background-color": "Black", "color": "White" });
                $('#hdnMidia').val($(this).attr("id"));
            });

            $('#<%=GridViewMidias.ClientID%> tr[id]').mouseover(function () {
                $(this).css({ cursor: "hand", cursor: "pointer" });
            });


        });
        function selecionaGrid() {
            $('#<%=GridViewMidias.ClientID%> tr[id]').click(function () {

            $('#<%=GridViewMidias.ClientID%> tr[id]').css({ "background-color": "White", "color": "Black" });
            $(this).css({ "background-color": "Black", "color": "White" });

            $('#hdnMidia').val($(this).attr("id"));

        });

        $('#<%=GridViewMidias.ClientID%> tr[id]').mouseover(function () {
            $(this).css({ cursor: "hand", cursor: "pointer" });
        });
    }
    </script>
</asp:Content>

