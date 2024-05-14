<%@page import="com.justeam.justbuy.utils.ChiaviRicerca"%>
<%@page import="com.justeam.justbuy.utils.Categoria"%>
<%@page import="com.justeam.justbuy.utils.ChiaviErrore"%>
<%@page import="com.justeam.justbuy.utils.ChiaviRegistrazione"%>
<%@page import="com.justeam.justbuy.utils.ChiaviProdotto"%>
<header class="cssHeader py-3">
	<div class="container-fluid d-flex no-wrap gap-3 align-items-center justify-content-between" style="grid-template-columns: 1fr 2fr;">
		<div>
			<a href="<%=request.getContextPath() + "/JSP/pubblica/index.jsp"%>" class="nav-link px-2"><img style="width: 128px" src="<%=request.getContextPath() + "/MEDIA/justbuy_logo_home.png"%>"></a>
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
		<div class="d-flex no-wrap">
			<button type="button" id="modalBtn" class="loginBtn" data-bs-toggle="modal"
              data-bs-target="#loginModal">Login</button>
			<a href="<%=request.getContextPath() + "/JSP/pubblica/registrati.jsp"%>" class="nav-link px-2">Registrati</a>
		</div>
	</div>
</header>

	<%
		String erroreLogin = (String) request.getAttribute(ChiaviErrore.CHIAVE_LOGIN_ERROR);
		String msgErroreLogin = erroreLogin != null ? erroreLogin : "";
	%>
	
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="loginModalLabel">Login</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="<%=request.getContextPath() + "/login" %>" method="POST">
			<div class="form-group">
				<label for="<%=ChiaviRegistrazione.EMAIL%>">E-mail: </label>
				<input type="email" name="<%=ChiaviRegistrazione.EMAIL%>" >
			</div>
			<div class="form-group">
				<label for="<%=ChiaviRegistrazione.PASSWORD%>">Password: </label>
				<input type="password" name="<%=ChiaviRegistrazione.PASSWORD%>" >
			</div>
			<div class="form-group">
				<input type="submit" class="submitInput px-3" value="Login">
			</div>
		</form>
		<p id="errMsg" class="m-0" style="color: red;"><%=msgErroreLogin%></p>
     </div>
     <div class="modal-footer">
     	<a class="loginLink" href="<%=request.getContextPath() + "/JSP/pubblica/registrati.jsp" %>">Non sei registrato? Registrati ora</a>
     </div>
    </div>
  </div>
</div>