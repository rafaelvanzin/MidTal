<%@ Page Title="Página Inicial" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" Inherits="_Default" Codebehind="Default.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
        <div class="item active">
          <img src="Assets/imagemCarousel1.jpg"  class="img-responsive">
          <div class="container">
            <div class="carousel-caption">
              <h1>Tecnologia de ponta para seu anúncio</h1>
                <p>Desenvolvido buscando a praticidade, com comandos intuitivos, tudo para facilitar a vida de quem anuncia</p>
                <p><a class="btn btn-large btn-primary" href="#">Saiba mais</a></p>
            </div>
          </div>
        </div>
        <div class="item">
          <img src="Assets/imagemCarousel2.jpg" class="img-responsive">
          <div class="container">
            <div class="carousel-caption">
              <h1>Fácil de usar</h1>
              <p>Com o Midtal e a ajuda da equipe Midtal Company®, não há tempo a perder, venha trabalhar 
                 conosco e descubra a facilidade do digital signage </p>
              <p><a class="btn btn-large btn-primary" href="#">Saiba mais</a></p>
            </div>
          </div>
        </div>
        <div class="item">
          <img src="Assets/imagemCarousel3.jpg" class="img-responsive">
          <div class="container">
            <div class="carousel-caption">
              <h1>Acessibilidade</h1>
              <p>Acesse e controle seus anúncios de qualquer lugar do mundo</p>
              <p><a class="btn btn-large btn-primary" href="#">Saiba mais</a></p>
            </div>
          </div>
        </div>
      </div>
      <!-- Controls -->
      <a class="left carousel-control" href="#myCarousel" data-slide="prev">
        <span class="icon-prev"></span>
      </a>
      <a class="right carousel-control" href="#myCarousel" data-slide="next">
        <span class="icon-next"></span>
      </a>  
    </div>
    <!-- /.carousel -->

<%--    <div class="jumbotron">
        <h1>MIDTAL  </h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Saiba mais &raquo;</a></p>
    </div>--%>

    <div class="row">
        <div class="col-md-4">
            <h2>Anunciantes</h2>
            <p>
              Leve seu anúncio para onde nunca esteve antes, com a ajuda do Midtal, 
              você poderá exibir seus anúncios em estabelecimentos por toda sua região,
              com preços acessíveis e sem complicações.
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301948">Saiba mais &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Exibidores</h2>
            <p>
                Para você que deseja ter em seu estabelecimento uma forma de anunciar seus produtos,
                sem complicações, com uma equipe treinada e disposta a ajudar com preços assessíveis
                para qualquer tamanho de negócio.
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301949">Saiba mais &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Ainda não está convencido?</h2>
            <p>
               Saiba como usar o nosso sistema e sair ganhando.
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301950">Saiba mais &raquo;</a>
            </p>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $('.carousel').carousel({
                interval: 7000
            });
        });
    </script>
</asp:Content>
