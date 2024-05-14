<%@page import="com.justeam.justbuy.utils.ChiaveBL"%>
<%@page import="com.justeam.justbuy.businesslogic.BusinessLogic"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.justeam.justbuy.utils.ChiaviUtente"%>
<%@page import="com.justeam.justbuy.model.Ordine"%>
<%@page import="com.justeam.justbuy.model.Utente"%>
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
	<title>Gestione Ordini - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">

	<%
		BusinessLogic bl = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
		List<Ordine> ordini = bl.ordineRetrieveAll();
		Utente utenteAttuale = (Utente) session.getAttribute(ChiaviUtente.UTENTE_LOGGATO);
		NumberFormat euro = NumberFormat.getCurrencyInstance(Locale.US);
	%>
	
		<%@include file ="/JSP/privata/header.jsp" %>

	<div class="container">
		<div class="row">
			<div class="col mt-5">
				<h1>Gestione Ordini</h1>
			</div>
		</div>
		<div class="row">
			<div class="col mt-5">
				<table class="display" id="tabellaOrdini">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Utente</th>
							<th scope="col">Data dell'ordine</th>
							<th scope="col">Prezzo totale</th>
						</tr>
					</thead>
					<tbody>
					<%
						for (Ordine o : ordini) {
					%>
					
					<tr>
						<td><%=o.getId()%></td>
						<td><%=o.getUtente().getEmail()%></td>
						<td><%=o.getData()%></td>
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
		    $('#tabellaOrdini').DataTable();
		} );
	</script>

</body>
</html>