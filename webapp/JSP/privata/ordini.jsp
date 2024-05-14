<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.justeam.justbuy.model.Prodotto"%>
<%@page import="com.justeam.justbuy.utils.ChiaviUtente"%>
<%@page import="com.justeam.justbuy.model.Utente"%>
<%@page import="com.justeam.justbuy.model.Ordine"%>
<%@page import="java.util.List"%>
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
	<title>Ordini - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">

	<%
		Utente utenteAttuale = (Utente) session.getAttribute(ChiaviUtente.UTENTE_LOGGATO);
		List<Ordine> listaOrdiniUtente = utenteAttuale.getOrdini();
		NumberFormat euro = NumberFormat.getCurrencyInstance(Locale.US);
	%>

		<%@include file="/JSP/privata/header.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col mt-5">
				<h1>Ordini</h1>
			</div>
		</div>
		<div class="row">
			<div class="col mt-5">
				<table class="display"" id="tabellaOrdini2">
					<thead>
						<tr>
							<th>ID Ordine</th>
							<th>Data dell'ordine</th>
							<th>Prodotti</th>
							<th>Prezzo totale</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (Ordine o : listaOrdiniUtente) {
						%>
						<tr>
							<td><%=o.getId()%></td>
							<td><%=o.getData()%></td>
								<td>
									<ul>
									<%
										List<Prodotto> listaProdotti = o.getProdotti();
									for (Prodotto p : listaProdotti.stream().distinct().collect(Collectors.toList())) {
									%>
										<li><%=p.getNome()%> (<%=Collections.frequency(listaProdotti, p) %>)</li>						
									<%
										}
									%> 
									</ul>
								</td>		
							<td><%=euro.format(o.getPrezzoTotale()).replace("$", "\u20ac ")%></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>

		</div>
	<footer id= "footer"><%@include file="/JSP/pubblica/footer.jsp"%></footer>
	</div>
		
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script src="//cdn.datatables.net/2.0.7/js/dataTables.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	<script>
		$(document).ready( function () {
		    $('#tabellaOrdini2').DataTable();
		} );
	</script>
</body>
</html>