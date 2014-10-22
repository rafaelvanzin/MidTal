<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="MidiasUsuario.aspx.cs" Inherits="WebApplication4.MidiasUsuario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <a href="#PopupMidias" role="button" class="btn btn-default" data-toggle="modal">rrLaunch demo modal</a>


        <div id="PopupMidias" style="display:none">
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
        </div>

<%--    <div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
    <div class="modal-content">
	    <div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			    <h3 id="myModalLabel">Modal header</h3>
	    </div>
	    <div class="modal-body">
		    <p>One fine body…</p>
	    </div>
        <div id="PopupMidias" style="display:none">
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
        </div>
	    <div class="modal-footer">
		    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
		    <button class="btn btn-primary">Save changes</button>
	    </div>
    </div>
    </div>
    </div>--%>

</asp:Content>
