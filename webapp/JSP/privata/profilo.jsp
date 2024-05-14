<%@page import="com.justeam.justbuy.utils.ChiaviRegistrazione"%>
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
	<title>Profilo - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">

	<% 
		Utente utenteAttuale = (Utente) session.getAttribute(ChiaviUtente.UTENTE_LOGGATO);
	%>
	
		<%@include file="/JSP/privata/header.jsp"%>
		
	<div class="container">
		<div class="row mt-5">
			<div class="col d-flex justify-content-center">
				<h1>Benvenuto <%=utenteAttuale.getNome()%>!</h1>
			</div>
		</div>
		<div class="row my-5 justify-content-center">
			<div class="col-6">
					<h3>I tuoi dati:</h3>
					<p>Nome: <%=utenteAttuale.getNome()%></p>
					<p>Cognome: <%=utenteAttuale.getCognome()%></p>
					<p>Data di nascita: <%=utenteAttuale.getDataNascita()%></p>
					<p>E-mail: <%=utenteAttuale.getEmail()%></p>
					<p>Indirizzo di residenza: <%=utenteAttuale.getIndirizzoResidenza()%></p>
					<p>Indirizzo di spedizione: <%=utenteAttuale.getIndirizzoSpedizione()%></p>
			</div>
		</div>	
	</div>
	
		</div>
	<footer id= "footer"><%@include file="/JSP/pubblica/footer.jsp"%></footer>
	</div>

	<script src="<%=request.getContextPath() + "/JS/scriptUtente.js" %>"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	
</body>
</html>