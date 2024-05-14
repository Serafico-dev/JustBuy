<%@page import="com.justeam.justbuy.businesslogic.BusinessLogic"%>
<%@page import="com.justeam.justbuy.utils.ChiaveBL"%>
<%@page import="com.justeam.justbuy.utils.ChiaviUtente"%>
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
	<title>Gestione Utenti - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">

	<%
		BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(ChiaveBL.BUSINESS_LOGIC);
		List<Utente> utenti = businessLogic.utenteRetrieveAll();
		Utente utenteAttuale = (Utente) session.getAttribute(ChiaviUtente.UTENTE_LOGGATO);
		String status = (String) request.getAttribute(ChiaviUtente.STATUS_OPERAZIONE);
		String msgStatus = status != null ? status : "";
	%>

		<%@include file="/JSP/privata/header.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col mt-5">
				<h1>Gestione Utenti</h1>
			</div>
		</div>
		<div class="row">
			<div class="col mt-5">
				<table class="display" id="tabellaUtenti">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Nome</th>
							<th scope="col">Cognome</th>
							<th scope="col">Data di nascita</th>
							<th scope="col">Email</th>
							<th scope="col">Indirizzo di residenza</th>
							<th scope="col">Indirizzo di spedizione</th>
							<th scope="col">Admin</th>
							<th scope="col">Azione</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (Utente u : utenti) {
						%>
						<tr>
							<td><%=u.getId()%></td>
							<td><%=u.getNome()%></td>
							<td><%=u.getCognome()%></td>
							<td><%=u.getDataNascita()%></td>
							<td><%=u.getEmail()%></td>
							<td><%=u.getIndirizzoResidenza()%></td>
							<td><%=u.getIndirizzoSpedizione()%></td>
							<td><%String admin = u.getRuolo().getNome().equals("admin") ? "Sì" : "No";%><%=admin %></td>
							<td>
							<%
								if (!u.getEmail().equals("justbuy@justmail.com") && !u.getEmail().contains("disabled") && !utenteAttuale.getEmail().equals(u.getEmail())) {
							%>	
								<div class="d-flex justify-content-between gap-1">
								<%
									if (u.getRuolo().getNome().equals("admin")) {
								%>
									<form action="<%=request.getContextPath() + "/retrocediUtenti" %>" method="POST" id="retrocedi">
										<button type="submit" class="submitInput" form="retrocedi" value="<%=u.getId()%>" name="<%=ChiaviUtente.OPERAZIONI_UTENTI%>">Rendi user</button>
									</form>
								<%
									} else {
								%>
									<form action="<%=request.getContextPath() + "/promuoviUtenti" %>" method="POST" id="promuovi">
										<button type="submit" class="submitInput" form="promuovi" value="<%=u.getId()%>" name="<%=ChiaviUtente.OPERAZIONI_UTENTI%>">Rendi admin</button>
									</form>
								<%
									}
								%>
									<form action="<%=request.getContextPath() + "/eliminaUtenti" %>" method="POST" id="elimina">
										<button type="submit" class="submitInput" form="elimina" value="<%=u.getId()%>" name="<%=ChiaviUtente.OPERAZIONI_UTENTI%>">Elimina utente</button>
									</form>
								</div>	
								<%	
									}
								%>	
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
	
		</div>
	<footer id= "footer"><%@include file="/JSP/pubblica/footer.jsp"%></footer>
	</div>
		
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script src="//cdn.datatables.net/2.0.7/js/dataTables.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	<script>
		$(document).ready( function () {
		    $('#tabellaUtenti').DataTable();
		} );
	</script>

</body>
</html>