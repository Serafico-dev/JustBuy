<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.justeam.justbuy.utils.ChiaveBL"%>
<%@page import="com.justeam.justbuy.businesslogic.BusinessLogic"%>
<%@page import="com.justeam.justbuy.utils.ChiaviUtente"%>
<%@page import="com.justeam.justbuy.model.Utente"%>
<%@page import="java.util.List"%>
<%@page import="com.justeam.justbuy.model.Prodotto"%>
<%@page import="com.justeam.justbuy.utils.Categoria"%>
<%@page import="com.justeam.justbuy.utils.ChiaviProdotto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">		
		<link rel="stylesheet" href="//cdn.datatables.net/2.0.7/css/dataTables.dataTables.min.css">	
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
		<link rel="stylesheet" href="<%=request.getContextPath() + "/CSS/style.css"%>">
	<title>Gestione Prodotti - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">

	<%
		Utente utenteAttuale = (Utente) session.getAttribute(ChiaviUtente.UTENTE_LOGGATO);
		String status = (String) request.getAttribute(ChiaviProdotto.STATUS_OPERAZIONE);
		String msgStatus = status != null ? status : "";
		BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
		List<Prodotto> prodotti = businessLogic.prodottoRetrieveAll();
		NumberFormat euro = NumberFormat.getCurrencyInstance(Locale.US);
	%>	
		<%@include file="/JSP/privata/header.jsp"%>
	
	<div class="container">
		<div class="row">
			<div class="col mt-5">
				<h1>Gestione Prodotti</h1>
				<button type="button" class="submitInput" id="aggiungiBtn">Aggiungi un prodotto</button>
			</div>
		</div>
		<div class="row">
			<div class="col mt-5">
				<table class="display" id="tabellaProdotti">
					<thead>
						<tr>
							<th>ID</th>
							<th>Nome</th>
							<th>Descrizione</th>
							<th>Immagine</th>
							<th>Prezzo</th>
							<th>Quantità</th>
							<th>Categoria</th>
							<th>Azione</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (Prodotto p : prodotti) {
						%>
						<tr>
							<td><%=p.getId()%></td>
							<td><%=p.getNome()%></td>
							<td><div class="limiteDesc"><%=p.getDescrizione()%></div></td>
							<td><%=p.getImmagine()%></td>
							<td><%=euro.format(p.getPrezzo()).replace("$", "\u20ac ")%></td>
							<td><%=p.getQuantita()%></td>
							<td><%=p.getCategoria()%></td>
							<td>
								<div class="d-flex justify-content-between gap-1">
									<button type="submit" class="modificaBtn submitInput" value="<%=p.getId()%>" name="<%=ChiaviProdotto.OPERAZIONI_PRODOTTI%>">Modifica</button>
									<form action="<%=request.getContextPath() + "/eliminaProdotti" %>" method="POST" id="elimina">
										<button type="submit" class="submitInput" form="elimina" value="<%=p.getId()%>" name="<%=ChiaviProdotto.OPERAZIONI_PRODOTTI%>">Elimina</button>
									</form>
								</div>
							</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">	
			<div class="col d-flex justify-content-center my-3" id="divMsgStatus">
				<p class="m-0 fst-italic fw-bold"><%=msgStatus%></p>
			</div>
		</div>	
	</div>
	

	
	<div class="container mt-3" id="divAggiungi" style="display: none;">
		<div class="row">
			<div class="col-5">
				<div>
					<h1>Aggiungi un prodotto</h1>
				</div>	
				<form action="<%=request.getContextPath() + "/inserimentoProdotti" %>" method="POST" enctype="multipart/form-data">
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.NOME_PRODOTTO%>">Nome del prodotto</label>
						<input type="text" name="<%=ChiaviProdotto.NOME_PRODOTTO%>" >	
					</div>	
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.DESCRIZIONE%>">Descrizione del prodotto</label>
						<textarea name="<%=ChiaviProdotto.DESCRIZIONE%>" rows="5" cols="10"></textarea>	
					</div>	
					<div class="d-flex flex-column">	
						<label for="<%=ChiaviProdotto.PERCORSO_IMMAGINE%>">Immagine</label>
						<input type="file" name="<%=ChiaviProdotto.PERCORSO_IMMAGINE%>" >
					</div>
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.PREZZO%>">Prezzo</label>
						<input type="number" min="0" step="0.01" name="<%=ChiaviProdotto.PREZZO%>" >
					</div>
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.QUANTITA%>">Quantità</label>
						<input type="number" min="0" step="1" name="<%=ChiaviProdotto.QUANTITA%>" >
					</div>
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.CATEGORIA%>">Categoria</label>
						<select name="<%=ChiaviProdotto.CATEGORIA%>" >
					
						<%
							for (Categoria c : Categoria.values()) {
						%>
								<option value="<%=c%>"><%=c%></option>
						<%
							}
						%>
						</select>
					</div>
					<div class="my-3 d-flex justify-content-start">
						<input type="submit" class="submitInput" value="Aggiungi">
					</div>
				</form>			
			</div>
		</div>
	</div>	
		
	<div class="container mt-3" id="divModifica" style="display: none;">
		<div class="row">			
			<div class="col-5">
				<div>
					<h1 id="titoloModificaProdotto"></h1>
				</div>
				<form action="<%=request.getContextPath() + "/modificaProdotti" %>" method="POST" id="modifica" enctype="multipart/form-data">
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.NOME_PRODOTTO%>">Nome del prodotto</label>
						<input type="text" name="<%=ChiaviProdotto.NOME_PRODOTTO%>" >
					</div>
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.DESCRIZIONE%>">Descrizione del prodotto</label>
						<textarea name="<%=ChiaviProdotto.DESCRIZIONE%>" rows="5" cols="10"></textarea>
					</div>
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.PERCORSO_IMMAGINE%>">Sfoglia file</label>
						<input type="file" name="<%=ChiaviProdotto.PERCORSO_IMMAGINE%>" >
					</div>
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.PREZZO%>">Prezzo</label>
						<input type="number" min="0" step="0.01" name="<%=ChiaviProdotto.PREZZO%>" >
					</div>
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.QUANTITA%>">Quantità</label>
						<input type="number" min="0" step="1" name="<%=ChiaviProdotto.QUANTITA%>" >
					</div>
					<div class="d-flex flex-column">
						<label for="<%=ChiaviProdotto.CATEGORIA%>">Categoria</label>
						<select name="<%=ChiaviProdotto.CATEGORIA%>" >
							<option value="" disabled selected>Seleziona:</option>
						<%
							for (Categoria c : Categoria.values()) {
						%>
								<option value="<%=c%>"><%=c%></option>
						<%
							}
						%>
					</select>	
					</div>
					<div class="my-3 d-flex justify-content-start">
						<button type="submit" class="submitInput" form="modifica" value="" id="modificaFormBtn" name="<%=ChiaviProdotto.OPERAZIONI_PRODOTTI%>">Modifica</button>	
					</div>
				</form>		
			</div>
		</div>
	</div>		

		</div>
	<footer id= "footer"><%@include file="/JSP/pubblica/footer.jsp"%></footer>
	</div>

	<script src="<%=request.getContextPath() + "/JS/script.js" %>"></script>
	<script src="<%=request.getContextPath() + "/JS/scriptProdotti.js" %>"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script src="//cdn.datatables.net/2.0.7/js/dataTables.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	<script>
		$(document).ready(function() {
			$('#tabellaProdotti').DataTable();
		});
	</script>
</body>
</html>