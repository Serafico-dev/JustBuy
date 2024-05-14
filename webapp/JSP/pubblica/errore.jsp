<%@page import="com.justeam.justbuy.utils.ChiaveBL"%>
<%@page import="java.util.Locale"%>
<%@page import="com.justeam.justbuy.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.justeam.justbuy.businesslogic.BusinessLogic"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
		<link rel="stylesheet" href="<%=request.getContextPath() + "/CSS/style.css"%>">
	<title>Errore - JustBuy</title>
	<link rel="icon" type="image/x-icon"
		  href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>

	<%
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

	<main class="px-3">
		<div id="divError">
			<div id="titleError">
				<h1 id="titoloErrore"><b>Errore inaspettato!</b></h1>
			</div>
			<div id="contentError">
				<img src="<%=request.getContextPath() + "/MEDIA/Sonny.png"%>"
					 alt="Immagine Errore!" id="sonny">
				<div id="messaggioIronicoError">
					<h3>Ops... Qualcosa è andato storto!</h3>
					<p>
						Forse hai aperto la pagina sbagliata... <br> Perché non sono
						riuscito a trovare la pagina che cercavi
					</p>
					<a class="linkHome" href="<%=request.getContextPath() + "/JSP/pubblica/index.jsp"%>"><b>Torna alla home</b></a>
				</div>
			</div>
		</div>
	</main>

	<%@include file="/JSP/pubblica/footer.jsp"%>
	
	<script src="<%=request.getContextPath() + "/JS/script.js"%>"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	
</body>
</html>