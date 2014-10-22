<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Midtal.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <a href="#" class="btn btn-lg btn-success"
   data-toggle="modal"
   data-target="#basicModal">Click to open Modal</a>


    <div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&amp;times;</button>
            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="Usuarios">

                    <Columns>
                        <asp:BoundField DataField="Exibicoes_Restantes" HeaderText="Exibicoes Restantes" SortExpression="Exibicoes_Restantes" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="Usuarios" runat="server" ConnectionString="<%$ ConnectionStrings:MidtalDb %>" SelectCommand="SELECT [Exibicoes_Restantes] FROM [Usuario]"></asp:SqlDataSource>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
        </div>
    </div>
  </div>
</div>
     
</asp:Content>
