<%@page import="java.util.Collections"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.justeam.justbuy.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@page import="com.justeam.justbuy.businesslogic.BusinessLogic"%>
<%@page import="com.justeam.justbuy.model.Utente"%>
<%@ page import="com.justeam.justbuy.utils.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
		<link rel="stylesheet" href="<%=request.getContextPath() + "/CSS/style.css"%>">
	<title>Home - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">

	<%
		BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
		Utente privata = (Utente) session.getAttribute(ChiaviUtente.UTENTE_LOGGATO);
		List<Prodotto> ultimiArrivi = businessLogic.prodottoRetrieveByDesc(8);
		NumberFormat euro = NumberFormat.getCurrencyInstance(Locale.US);

		if (privata != null) {
	%>
		<%@include file="/JSP/privata/header.jsp"%>
	<%
		} else {
	%>
		<%@include file="/JSP/pubblica/header.jsp"%>
	<%
		}
	%>
	
	<div id="carosello" class="carousel slide" data-bs-ride="false">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carosello" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carosello" data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carosello" data-bs-slide-to="2" aria-label="Slide 3"></button>
			<button type="button" data-bs-target="#carosello" data-bs-slide-to="3" aria-label="Slide 4"></button>
			<button type="button" data-bs-target="#carosello" data-bs-slide-to="4" aria-label="Slide 5"></button>
			<button type="button" data-bs-target="#carosello" data-bs-slide-to="5" aria-label="Slide 6"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="<%=request.getContextPath() + "/MEDIA/Slider/Foto6.png"%>" class="img d-block w-100" alt="...">
					<div class="carousel-caption d-none d-md-block">
					</div>
			</div>
			<div class="carousel-item">
				<img src="<%=request.getContextPath() + "/MEDIA/Slider/Foto2.png"%>" class="img d-block w-100" alt="...">
					<div class="carousel-caption d-none d-md-block">
					</div>
			</div>
			<div class="carousel-item">
				<img src="<%=request.getContextPath() + "/MEDIA/Slider/Foto1.png"%>" class="img d-block w-100" alt="...">
					<div class="carousel-caption d-none d-md-block">
					</div>	
			</div>
			<div class="carousel-item">
				<img src="<%=request.getContextPath() + "/MEDIA/Slider/Foto3.png"%>" class="img d-block w-100" alt="...">
					<div class="carousel-caption d-none d-md-block">
					</div>
			</div>
			<div class="carousel-item">
				<img src="<%=request.getContextPath() + "/MEDIA/Slider/Foto4.png"%>" class="img d-block w-100" alt="...">
					<div class="carousel-caption d-none d-md-block">
					</div>
			</div>
			<div class="carousel-item">
				<img src="<%=request.getContextPath() + "/MEDIA/Slider/Foto5.png"%>" class="img d-block w-100" alt="...">
					<div class="carousel-caption d-none d-md-block">
					</div>
			</div>
				<button class="carousel-control-prev" type="button" data-bs-target="#carosello" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button" data-bs-target="#carosello" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
		</div>	
	</div>

	<div class="container">
	
		<div class="row">
			<div class="col p-5 m-3 d-flex justify-content-center">
				<h2>Categorie</h2>
			</div>
		</div>
		
		<div class="row mb-3">
			<div class="col-4">
				<div class="card" style="width: 25rem;">
		 			 <img src="<%=request.getContextPath() + "/MEDIA/Categorie/pc.jpg"%>" class="card-img-top" alt="...">
		 			 <div class="card-body">
		 			   <p class="card-text m-0">COMPUTER</p>
						 <%
							 String link = request.getContextPath() + "/ricercaCategoria?" + ChiaviRicerca.CATEGORIA + "=" + Categoria.COMPUTER;
						 %>
						 <a href="<%=link%>" class="stretched-link"></a>
					</div>
				</div>
			</div>
			<div class="col-4">
				<div class="card" style="width: 25rem;">
		 			 <img src="<%=request.getContextPath() + "/MEDIA/Categorie/console.jpg"%>" class="card-img-top" alt="...">
		 			 <div class="card-body">
			 			 <p class="card-text m-0">CONSOLE</p>
						 <%
							 link = request.getContextPath() + "/ricercaCategoria?" + ChiaviRicerca.CATEGORIA + "=" + Categoria.CONSOLE;
						 %>
						 <a href="<%=link%>" class="stretched-link"></a>
					 </div>
				</div>
			</div>
			<div class="col-4">
				<div class="card" style="width: 25rem;">
		 			 <img src="<%=request.getContextPath() + "/MEDIA/Categorie/smartphone.jpg"%>" class="card-img-top" alt="...">
		 			 <div class="card-body">
			 			 <p class="card-text m-0">SMARTPHONE</p>
						 <%
							 link = request.getContextPath() + "/ricercaCategoria?" + ChiaviRicerca.CATEGORIA + "=" + Categoria.SMARTPHONE;
						 %>
						 <a href="<%=link%>" class="stretched-link"></a>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-4">
				<div class="card" style="width: 25rem;">
		 			 <img src="<%=request.getContextPath() + "/MEDIA/Categorie/tablet.jpg"%>" class="card-img-top" alt="...">
		 			 <div class="card-body">
		 			   <p class="card-text m-0">TABLET</p>
						 <%
							 link = request.getContextPath() + "/ricercaCategoria?" + ChiaviRicerca.CATEGORIA + "=" + Categoria.TABLET;
						 %>
						 <a href="<%=link%>" class="stretched-link"></a>
					 </div>
				</div>
			</div>
			<div class="col-4">
				<div class="card" style="width: 25rem;">
		 			 <img src="<%=request.getContextPath() + "/MEDIA/Categorie/tv.jpg"%>" class="card-img-top" alt="...">
		 			 <div class="card-body">
		 			   <p class="card-text m-0">TELEVISORI</p>
						 <%
							 link = request.getContextPath() + "/ricercaCategoria?" + ChiaviRicerca.CATEGORIA + "=" + Categoria.TELEVISORI;
						 %>
						 <a href="<%=link%>" class="stretched-link"></a>
		 			 </div>
				</div>
			</div>
			<div class="col-4">
				<div class="card" style="width: 25rem;">
		 			 <img src="<%=request.getContextPath() + "/MEDIA/Categorie/videogiochi.jpg"%>" class="card-img-top" alt="...">
		 			 <div class="card-body">
		 			   <p class="card-text m-0">VIDEOGIOCHI</p>
						 <%
							 link = request.getContextPath() + "/ricercaCategoria?" + ChiaviRicerca.CATEGORIA + "=" + Categoria.VIDEOGIOCHI;
						 %>
						 <a href="<%=link%>" class="stretched-link"></a>
		 			 </div>
				</div>
			</div>
		</div>	
	</div>
			
	<div class="container m-auto">
		<div class="row">
			<div class="col p-5 m-3 d-flex justify-content-center">
				<h2>Ultimi Arrivi</h2>
			</div>
		</div>
		
		<div class="row">
		<%
			for (Prodotto p : ultimiArrivi){
		%>
		<div class="col-3 mb-4">
			<div class="card" id="<%="card-" + p.getId()%>" style="width: 19rem;">
				<img src="<%=request.getContextPath() + "/MEDIA" + p.getImmagine()%>" class="card-img-top card-prodotto" alt="...">
					<div class="card-body">
						<form action="<%=request.getContextPath() + "/paginaProdotto"%>" method="post" id="paginaProdotto">
							<button class="stretched-link pulitoBtn" type="submit" form="paginaProdotto" value="<%=p.getId()%>" name="<%=ChiaviProdotto.ID_PRODOTTO%>"><h3 class="limiteTitolo"><%=p.getNome()%></h3></button>
						</form>
						<p><%=euro.format(p.getPrezzo()).replace("$", "\u20ac ")%></p>
						<p><%=p.getCategoria()%></p>
						<%
							if (privata == null) {
								if (p.getQuantita() > 0) {
									
						%>
							<p class="text-success">Disponibile</p>
						<%
							
							} else {
						%>
							<p class="text-danger">Non disponibile</p>
						<% 
							}
								
						%>		
							<button type="button" class="pulitoBtn zBtn" data-bs-toggle="modal" data-bs-target="#loginModal">
								<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#011033" class="bi bi-cart4" viewBox="0 0 16 16">
									<path d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5M3.14 5l.5 2H5V5zM6 5v2h2V5zm3 0v2h2V5zm3 0v2h1.36l.5-2zm1.11 3H12v2h.61zM11 8H9v2h2zM8 8H6v2h2zM5 8H3.89l.5 2H5zm0 5a1 1 0 1 0 0 2 1 1 0 0 0 0-2m-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0m9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2m-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0"/>
								</svg>
							</button>
						<%
							} else if (p.getQuantita() > 0) {
								if (p.getQuantita() == (Collections.frequency(privata.getCarrello().getProdotti(), p))){
						%>
							<p class="text-warning">Disponibilità massima raggiunta</p>
						<%
							} else {
						%>
							<p class="text-success">Disponibile</p>
						<%
							}
						%>
							<form action="<%=request.getContextPath() + "/aggiungiCarrelloHome"%>" method="post" id="aggiungiCarrelloHome">
								<button type="submit" class="pulitoBtn zBtn" form="aggiungiCarrelloHome" value="<%=p.getId()%>" name="<%=ChiaviProdotto.ID_PRODOTTO%>">
									<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#011033" class="bi bi-cart4" viewBox="0 0 16 16">
									 	<path d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5M3.14 5l.5 2H5V5zM6 5v2h2V5zm3 0v2h2V5zm3 0v2h1.36l.5-2zm1.11 3H12v2h.61zM11 8H9v2h2zM8 8H6v2h2zM5 8H3.89l.5 2H5zm0 5a1 1 0 1 0 0 2 1 1 0 0 0 0-2m-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0m9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2m-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0"/>
									</svg>
								</button>
							</form>
						<%
							} else{
						%>
							<p class="text-danger">Non disponibile</p>
							<button type="button" class="pulitoBtn zBtn" disabled>
								<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#011033" class="bi bi-cart-x" viewBox="0 0 16 16">
						  			<path d="M7.354 5.646a.5.5 0 1 0-.708.708L7.793 7.5 6.646 8.646a.5.5 0 1 0 .708.708L8.5 8.207l1.146 1.147a.5.5 0 0 0 .708-.708L9.207 7.5l1.147-1.146a.5.5 0 0 0-.708-.708L8.5 6.793z"/>
								 	<path d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zm3.915 10L3.102 4h10.796l-1.313 7zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
								</svg>
							</button>
						<%
							}
						%>
					</div>
			</div>
		</div>
		<%
			}
		%>
		</div>
	</div>
	
		</div>
	<footer id= "footer"><%@include file="/JSP/pubblica/footer.jsp"%></footer>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath() + "/JS/script.js" %>"></script>
	
</body>
</html>
</html>