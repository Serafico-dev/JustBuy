<%@page import="com.justeam.justbuy.utils.Categoria"%>
<%@page import="com.justeam.justbuy.utils.ChiaviFiltro"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="com.justeam.justbuy.model.Prodotto"%>
<%@page import="com.justeam.justbuy.utils.ChiaviUtente"%>
<%@page import="com.justeam.justbuy.model.Utente"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
		<link rel="stylesheet" href="<%=request.getContextPath() + "/CSS/style.css"%>">
	<title>Risultati Ricerca - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">

	<%
		NumberFormat euro = NumberFormat.getCurrencyInstance(Locale.US);
		List<Prodotto> listaProdotti = (List<Prodotto>) session.getAttribute(ChiaviProdotto.RISULTATI_RICERCA);
		Utente privata = (Utente) session.getAttribute(ChiaviUtente.UTENTE_LOGGATO);
		if (privata != null) {
	%>
		<%@include file="/JSP/privata/header.jsp"%>
	<%
		} else {
	%>
		<%@include file="/JSP/pubblica/header.jsp"%>
	<%
		}
		
		if (listaProdotti == null || listaProdotti.isEmpty()) {
	%>
		<div class="row">
				<div class="col p-5 m-3 d-flex justify-content-center">
					<h2>La ricerca non ha prodotto risultati</h2>
				</div>
			</div>
	<%
		} else {
			
	%>
		<div class="container m-auto">
			<div class="row">
				<div class="col p-5 m-3 d-flex justify-content-center">
					<h2>La ricerca ha prodotto questi risultati</h2>
				</div>
				<div class="flex-shrink-0 dropdown ms-1">
					<a href="#" class="loginLink d-block link-body-emphasis text-decoration-none dropdown-toggle pb-2" data-bs-toggle="dropdown" aria-expanded="false">Filtro</a>
			            <div class="dropdown-menu text.small shadow p-2">
	  						<form class="d-flex flex-column gap-2 p-4" action="<%=request.getContextPath() + "/filtroRicerca" %>" method="POST" id="filtro">
		  						<div class="form-group">
		  						    <label for="<%=ChiaviFiltro.PREZZO_MIN%>">Prezzo min</label>
		  						    <input type="number" class="form-control" min="0" name="<%=ChiaviFiltro.PREZZO_MIN%>">
		  						   	<label for="<%=ChiaviFiltro.PREZZO_MAX%>">Prezzo max</label>
		  						    <input type="number" class="form-control" min="0" name="<%=ChiaviFiltro.PREZZO_MAX%>">		
		  						</div>
								<div class="form-group">
	      							<label for="<%=ChiaviFiltro.CATEGORIA_FILTRO%>">Categoria
									<select name="<%=ChiaviFiltro.CATEGORIA_FILTRO%>">
   								<option value="" disabled selected>Seleziona:</option>
  								<%
									for (Categoria c : Categoria.values()) {
								%>
									<option value="<%=c%>"><%=c%></option>
								<%
									}
								%>
									</select>
									</label>	
	    						</div>
								<div class="form-group">
	      							<div class="form-check">
		      							<input type="checkbox" class="form-check-input" name="<%=ChiaviFiltro.DISPONIBILE%>">
										<label class="form-check-label" for="<%=ChiaviFiltro.DISPONIBILE%>">Visualizza solo disponibili</label>
									</div>
								</div>
								<div class="d-flex justify-content-center pt-3">
									<button type="submit" class="submitInput px-5" form="filtro" value="" id="modificaFormBtn" name="<%=ChiaviProdotto.OPERAZIONI_PRODOTTI%>">Filtra</button>	
	  							</div>
	  						</form>
						</div>
					</div>
		      	</div>
		      	<article class="paginaRisultati">
			<div class="row">
		<%
			for (Prodotto p : listaProdotti) {
		%>
			
				<div class="col-3">
				<section id="card-<%=p.getId()%>">
					<div class="card mb-4" style="width: 19rem;">
						<img src="<%=request.getContextPath() + "/MEDIA" + p.getImmagine()%>" class="card-img-top card-prodotto" alt="...">
							<div class="card-body">
								<form action="<%=request.getContextPath() + "/paginaProdotto"%>" method="post" id="<%="paginaProdotto" + p.getId()%>">
									<button class="stretched-link pulitoBtn" type="submit" form="<%="paginaProdotto" + p.getId()%>" value="<%=p.getId()%>" name="<%=ChiaviProdotto.ID_PRODOTTO%>"><h3 class="limiteTitolo"><%=p.getNome()%></h3></button>
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
									<form action="<%=request.getContextPath() + "/aggiungiCarrello"%>" method="post" id="<%="aggiungiCarrello" + p.getId()%>">
										<button type="submit" class="pulitoBtn zBtn" form="<%="aggiungiCarrello" + p.getId()%>" value="<%=p.getId()%>" name="<%=ChiaviProdotto.ID_PRODOTTO%>">
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
					</section>
				</div>
			
		<%
				}
		%>
			
			</div>
			</article>
		</div>	
	<%
			}
	%>
		
		</div>
	<footer id= "footer"><%@include file="/JSP/pubblica/footer.jsp"%></footer>
	</div>
	
	<script src="<%=request.getContextPath() + "/JS/script.js" %>"></script>
	<script src="<%=request.getContextPath() + "/JS/scriptPaginazione.js" %>"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	
</body>
</html>