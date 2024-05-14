<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.justeam.justbuy.model.Carrello"%>
<%@page import="com.justeam.justbuy.model.Prodotto"%>
<%@page import="java.util.List"%>
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
	<title>Carrello - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">

	<% 
		Utente utenteAttuale = (Utente) session.getAttribute(ChiaviUtente.UTENTE_LOGGATO);
		Carrello carrello = utenteAttuale.getCarrello();
		NumberFormat euro = NumberFormat.getCurrencyInstance(Locale.US);
	%>
	
		<%@include file="/JSP/privata/header.jsp"%>
	
	<div class="container">
		<div class="row mt-5">
			<div class="col">
				<h1>Il tuo carrello:</h1>
			</div>
		</div>		
	
	<%
		Double prezzoTotale = 0.0;
		if (carrello.getProdotti().isEmpty()) {
	%>
		<div class="row mb-5">
			<div class="col">
				<h3>Il tuo carrello è vuoto</h3>
			</div>
		</div>		
	<%
		} else {
			List <Prodotto> listaProdotti = carrello.getProdotti();
	%>
		<div class="row mb-5">
			<div class="col">
				<h3><%=listaProdotti.size()%> prodotti presenti</h3>
			</div>
		</div>	
	<%
		for (Prodotto p : listaProdotti) {
			prezzoTotale += p.getPrezzo();
		}
		for (Prodotto p : listaProdotti.stream().distinct().collect(Collectors.toList())) {
	%>
		<div class="row p-3 bordoCarrello">
			<div class="col">		
				<img src="<%=request.getContextPath() + "/MEDIA" + p.getImmagine()%>" style="width: 8vw;">
			</div>
			<div class="col d-flex flex-column justify-content-center">	
				<h3><%=p.getNome()%></h3>
			</div>
			<div class="col d-flex flex-column justify-content-center">	
				<p class="m-0"><%=euro.format(p.getPrezzo()).replace("$", "\u20ac ")%></p>	
			</div>
			<div class="col d-flex flex-column justify-content-center">
				<p class="m-0">Quantità: <%=Collections.frequency(listaProdotti, p) %> </p>
			</div>
			<div class="col d-flex flex-column justify-content-center">
				<form action="<%=request.getContextPath() + "/rimuoviProdotto"%>" method="POST" id="rimuoviProdotto">
					<button type="submit" class="submitInput" form="rimuoviProdotto" value="<%=p.getId()%>" name="<%=ChiaviProdotto.ID_PRODOTTO%>">Rimuovi</button>
				</form>
			</div>
		</div>	
	<%
				}
	%>
		<div class="row mt-5">
			<div class="col">
				<h3>Totale: <%=euro.format(prezzoTotale).replace("$", "\u20ac ")%></h3>
			</div>
			<div class="col-3 d-flex justify-content-around">
				<form action="<%=request.getContextPath() + "/svuotaCarrello" %>" method="POST">
					<input type="submit" class="submitInput" value="Svuota carrello">
				</form>
				<a href="<%=request.getContextPath() + "/JSP/privata/acquisto.jsp" %>">
					<button type="button" class="submitInput">Procedi all'acquisto</button>
				</a>
			</div>
		</div>
	<%
			}
	%>
	</div>
	
		</div>
	<footer id= "footer"><%@include file="/JSP/pubblica/footer.jsp"%></footer>
	</div>
		
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
			

</body>
</html>