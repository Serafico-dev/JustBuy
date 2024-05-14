<%@page import="com.justeam.justbuy.utils.ChiaviRegistrazione"%>
<%@page import="com.justeam.justbuy.utils.ChiaviErrore"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
		<link rel="stylesheet" href="<%=request.getContextPath() + "/CSS/style.css"%>">
	<title>Registrati - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">

	<%
		String errore = (String) request.getAttribute(ChiaviErrore.CHIAVE_NPE);
		String msgErrore = errore != null ? errore : "";
	%>
	
	<%@include file="/JSP/pubblica/header.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col d-flex justify-content-center align-items-center">
				<form action="<%=request.getContextPath() + "/registrati" %>" method="POST" class="normaliForm">
					<div class="form-group">
						<h2 class="pb-1">Registrati</h2>
					</div>
					<div class="form-group">
						<label for="<%=ChiaviRegistrazione.NOME%>">Nome: </label>
						<input type="text" name="<%=ChiaviRegistrazione.NOME%>" required>
					</div>
					<div class="form-group">			
						<label for="<%=ChiaviRegistrazione.COGNOME%>">Cognome: </label>
						<input type="text" name="<%=ChiaviRegistrazione.COGNOME%>" required>
					</div>
					<div class="form-group">		
						<label for="<%=ChiaviRegistrazione.DATA_NASCITA%>">Data di nascita: </label>
						<input type="date" name="<%=ChiaviRegistrazione.DATA_NASCITA%>" required>
					</div>
					<div class="form-group">		
						<label for="<%=ChiaviRegistrazione.INDIRIZZO%>">Indirizzo di residenza: </label>
						<input type="text" name="<%=ChiaviRegistrazione.INDIRIZZO%>" required>
					</div>
					<div class="form-group">
						<label for="<%=ChiaviRegistrazione.EMAIL%>">E-mail: </label>
						<input type="email" name="<%=ChiaviRegistrazione.EMAIL%>" required>
					</div>
					<div class="form-group">		
						<label for="<%=ChiaviRegistrazione.PASSWORD%>">Password: </label>
						<input type="password" name="<%=ChiaviRegistrazione.PASSWORD%>" required>
					</div>
					<div class="form-group">	
						<input type="submit" class="submitInput p-2" value="Registrati">
					</div>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-center">
				<p style="color: red;"><%=msgErrore%></p>
			</div>
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