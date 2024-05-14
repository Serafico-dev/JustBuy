<%@page import="java.util.Collections"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.justeam.justbuy.model.Prodotto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
		<link rel="stylesheet" href="<%=request.getContextPath() + "/CSS/style.css"%>">
		<%
			Prodotto prodottoAttuale = (Prodotto) session.getAttribute(ChiaviProdotto.PRODOTTO_CERCATO);
		%>
	<title><%=prodottoAttuale.getNome()%> - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">
		
	<%
		NumberFormat euro = NumberFormat.getCurrencyInstance(Locale.US);
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
	%>
	
	<div class="container">
		<div class="row p-5">
			<div class="col-6">
				<img src="<%=request.getContextPath() + "/MEDIA" + prodottoAttuale.getImmagine()%>" alt="..." style="width: 25vw;">	
			</div>
			<div class="col-6 d-flex flex-column justify-content-between">
				<div>
					<h1><%=prodottoAttuale.getNome()%></h1>
					<h5 class="fst-italic"><%=prodottoAttuale.getCategoria()%></h5>
					<h5 class="fw-bold"><%=euro.format(prodottoAttuale.getPrezzo()).replace("$", "\u20ac ")%></h5>
				</div>
				<div>							
					<p><%=prodottoAttuale.getDescrizione()%></p>
				</div>
				<div>	
					<%
						if (privata == null) {
					%>
							<button type="button" class="submitInput zBtn py-1 px-3" data-bs-toggle="modal" data-bs-target="#loginModal">Aggiungi al carrello</button>					
					<%
						} else if (prodottoAttuale.getQuantita() > 0) {
							if(prodottoAttuale.getQuantita() == (Collections.frequency(privata.getCarrello().getProdotti(), prodottoAttuale))) {
					%>
						<p class="text-warning">Disponibilità massima raggiunta</p>
					<%
							} else {
					%>
							<p class="text-success">Disponibile</p>
					<% 
							}
					%>
						<form action="<%=request.getContextPath() + "/aggiungiCarrelloProdotto"%>" method="POST" id="aggiungiCarrelloProdotto">
							<div>
								<button type="button" class="submitInput px-2" id="meno">-</button>
								<input type="number" id="quantitaCarrello" min="1" max="<%=(prodottoAttuale.getQuantita() - Collections.frequency(privata.getCarrello().getProdotti(), prodottoAttuale))%>" name="<%=ChiaviProdotto.QUANTITA_AGGIUNTI%>" value="1">
								<button type="button" class="submitInput" id="piu">+</button>
							</div>
							<div class="mt-2">
								<button type="submit" class="submitInput zBtn py-1 px-3" form="aggiungiCarrelloProdotto" value="<%=prodottoAttuale.getId()%>" name="<%=ChiaviProdotto.ID_PRODOTTO%>">Aggiungi al carrello</button>
							</div>
						</form>
					<%
						} else {
					%>
						<p class="text-danger">Non disponibile</p>
							<button class="submitInput zBtn py-1 px-3" type="button" disabled>Aggiungi al carrello</button>		
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	
		</div>
	<footer id= "footer"><%@include file="/JSP/pubblica/footer.jsp"%></footer>
	</div>
	
	<script src="<%=request.getContextPath() + "/JS/script.js" %>"></script>
	<script src="<%=request.getContextPath() + "/JS/scriptCarrello.js" %>"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	
</body>
</html>