<%@page import="com.justeam.justbuy.utils.ChiaviRicerca"%>
<%@page import="com.justeam.justbuy.utils.Categoria"%>
<%@page import="com.justeam.justbuy.utils.ChiaviUtente"%>
<%@page import="com.justeam.justbuy.model.Carrello"%>
<%@page import="com.justeam.justbuy.model.Utente"%>
<%@page import="com.justeam.justbuy.utils.ChiaviProdotto"%>
<%
	Utente utente = (Utente) session.getAttribute(ChiaviUtente.UTENTE_LOGGATO);	
%>
<header class="cssHeader py-3">
    <div class="container-fluid d-flex no-wrap gap-3 align-items-center justify-content-between" style="grid-template-columns: 1fr 2fr;">
	    <div>
			<a href="<%=request.getContextPath() + "/JSP/pubblica/index.jsp"%>" class="nav-link px-2 mx-3"><img style="width: 128px" src="<%=request.getContextPath() + "/MEDIA/justbuy_logo_home.png"%>"></a>
		</div>
		<div class="d-flex align-items-center">
			<div class="dropdown categorie">
 				<button data-mdb-button-init data-mdb-ripple-init data-mdb-dropdown-init class="btn btnHeader dropdown-toggle categorie-toggle" type="button" id="dropdownMenuButton" data-mdb-toggle="dropdown" aria-expanded="false">
    				Categorie
 				</button>
  				<ul class="dropdown-menu categorie-menu" aria-labelledby="dropdownMenuButton">
	    			<li><a class="dropdown-item" href="<%=request.getContextPath() + "/ricercaCategoria"%>">TUTTE LE CATEGORIE</a></li>
	    			<%
						for (Categoria c : Categoria.values()) {
							String ric = request.getContextPath() + "/ricercaCategoria?" + ChiaviRicerca.CATEGORIA + "=" + c;
					%>
					<li><a class="dropdown-item" href="<%=ric%>"><%=c%></a></li>
					<%
						}
					%>
 	 			</ul>
			</div>
			<form class="d-flex" role="search" action="<%=request.getContextPath() + "/risultati"%>" method="get" id="risultati">
				<input class="form-control mx-2" type="search" placeholder="Cerca un prodotto" aria-label="Search" name="<%=ChiaviProdotto.RICERCA_PRODOTTI%>">
				<button class="btn btnHeader" type="submit" form="risultati">Ricerca</button>
			</form>
		</div>
		<div class="d-flex align-items-center no-wrap">
			<a href="<%=request.getContextPath() + "/JSP/privata/carrello.jsp"%>" class="nav-link px-2">
				 <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#5CE1E6" class="bi bi-cart4" viewBox="0 0 16 16">
				 	<path d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5M3.14 5l.5 2H5V5zM6 5v2h2V5zm3 0v2h2V5zm3 0v2h1.36l.5-2zm1.11 3H12v2h.61zM11 8H9v2h2zM8 8H6v2h2zM5 8H3.89l.5 2H5zm0 5a1 1 0 1 0 0 2 1 1 0 0 0 0-2m-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0m9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2m-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0"/>
				</svg>
				<%=utente.getCarrello().getProdotti().size()%>
			 </a> 
		    	<div class="flex-shrink-0 dropdown mx-3">
			        <a href="#" class="d-block link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
			            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#5CE1E6" class="bi bi-person-circle" viewBox="0 0 16 16">
						  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
						  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
						</svg>
					</a>
			          <ul class="dropdown-menu text-small shadow">
			            <li><a class="dropdown-item" href="<%=request.getContextPath() + "/JSP/privata/profilo.jsp"%>">Profilo</a></li>
						<li><a class="dropdown-item" href ="<%=request.getContextPath() + "/JSP/privata/carrello.jsp"%>">Carrello</a></li>
						<li><a class="dropdown-item" href ="<%=request.getContextPath() + "/JSP/privata/ordini.jsp"%>">Ordini</a></li>
						<%
							if(utente.getRuolo().getNome().equals("admin")){
						%>
						<li><a class="dropdown-item" href ="<%=request.getContextPath() + "/JSP/admin/prodotti.jsp"%>">Gestione prodotti</a></li>
						<li><a class="dropdown-item" href ="<%=request.getContextPath() + "/JSP/admin/utenti.jsp"%>">Gestione utenti</a></li>
						<li><a class="dropdown-item" href ="<%=request.getContextPath() + "/JSP/admin/ordini.jsp"%>">Gestione ordini</a></li>
						<li><a class="dropdown-item" href ="<%=request.getContextPath() + "/JSP/admin/statistiche.jsp"%>">Statistiche</a></li>
						<%
							}
						%>
			            <li><hr class="dropdown-divider"></li>
			            <li><a class="dropdown-item" href="<%=request.getContextPath() + "/logout"%>">Logout</a></li>
			         </ul>
		      	</div>
		</div>
    </div>
</header>