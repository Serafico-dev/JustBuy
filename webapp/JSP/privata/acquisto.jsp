<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
		<link rel="stylesheet" href="<%=request.getContextPath() + "/CSS/style.css"%>">
	<title>Just... Buy! - JustBuy</title>
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath() + "/MEDIA/favicon.png"%>">
</head>
<body>
	<div id="page-container">
		<div id="content-wrap">

	<%@include file="/JSP/privata/header.jsp"%>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-8">
				<div class="tabs mt-3"> 
			    	<ul class="nav nav-tabs" id="myTab" role="tablist"> 
				        <li class="nav-item" role="presentation"> 
				            <a class="nav-link active" id="visa-tab" data-toggle="tab" href="#visa" role="tab" aria-controls="visa" aria-selected="true"> 
				                <img src="https://i.imgur.com/sB4jftM.png" width="80"> 
				            </a> 
				        </li> 
				        <li class="nav-item" role="presentation"> 
				            <a class="nav-link" id="paypal-tab" data-toggle="tab" href="#paypal" role="tab" aria-controls="paypal" aria-selected="false">
				                <img src="https://i.imgur.com/yK7EDD1.png" width="80"> 
				            </a> 
				        </li> 
			    	</ul> 
				    <div class="tab-content" id="myTabContent"> 
				        <div class="tab-pane fade show active" id="visa" role="tabpanel" aria-labelledby="visa-tab"> 
				            <div class="mt-4 mx-4"> 
				                <div class="text-center"> 
				                    <h5>Dati ordine</h5> 
								</div> 
			                	<div class="form mt-3">
									<div class="inputbox"> 
				                        <span>Nome</span> 
				                        <input type="text" name="name" class="form-control my-1" required="required"> 
				                    </div> 
				                    <div class="inputbox"> 
				                        <span>Cognome</span> 
				                        <input type="text" name="name" min="1" max="999" class="form-control my-1" required="required"> 
				                    </div> 
				                    <div class="inputbox"> 
				                        <span>Indirizzo di spedizione</span> 
				                        <input type="text" name="name" min="1" max="999" class="form-control my-1" required="required"> 
				                    </div> 
				                    <div class="inputbox"> 
				                        <span>Spedizione</span> 
				                        <select name="spedizione" class="form-control my-1">
											<option value="Standard" selected>Standard</option>
											<option value="Express">Express</option>
											<option value="Premium">Premium</option>
										</select>
				                    </div> 
								</div> 
			   				</div> 
				            <div class="mt-4 mx-4"> 
				                <div class="text-center"> 
				                    <h5>Carta di credito</h5> 
								</div> 
			                	<div class="form mt-3">
									<div class="inputbox"> 
				                        <span>Nome intestatario</span> 
				                        <input type="text" name="name" class="form-control my-1" required="required"> 
				                    </div> 
				                    <div class="inputbox"> 
				                        <span>Numero carta</span> 
				                        <input type="text" name="name" min="1" max="999" class="form-control my-1" required="required"> 
				                    </div> 
				                    <div class="d-flex flex-row justify-content-between"> 
				                    	<div class="d-flex gap-3">
					                        <div class="inputbox"> 
					                            <span>Data di scadenza</span>
					                            <input type="text" name="name" min="1" max="999" class="form-control my-1" required="required"> 
					                        </div> 
					                        <div class="inputbox">
					                            <span>CVV</span>
												<input type="text" name="name" min="1" max="999" class="form-control my-1" required="required"> 
					                        </div> 
					                     </div>   
					                    <div class="d-flex align-items-end mb-2 pay"> 
						                    <form action="<%=request.getContextPath() + "/acquisto" %>" method="POST" id="formAcquisto">
						           				<button class="submitInput px-5" form="formAcquisto">Acquista</button> 
						           			</form>
					            		</div> 
				                    </div> 
								</div> 
			   				</div>
			   			</div> 
						<div id="paypal" class="tab-pane fade" role="tabpanel" aria-labelledby="paypal-tab">
							<div class="mt-4 mx-4"> 
				                <div class="text-center"> 
				                    <h5>Dati ordine</h5> 
								</div> 
			                	<div class="form mt-3">
									<div class="inputbox"> 
				                        <span>Nome</span> 
				                        <input type="text" name="name" class="form-control my-1" required="required"> 
				                    </div> 
				                    <div class="inputbox"> 
				                        <span>Cognome</span> 
				                        <input type="text" name="name" min="1" max="999" class="form-control my-1" required="required"> 
				                    </div> 
				                    <div class="inputbox"> 
				                        <span>Indirizzo di spedizione</span> 
				                        <input type="text" name="name" min="1" max="999" class="form-control my-1" required="required"> 
				                    </div> 
				                    <div class="inputbox"> 
				                        <span>Spedizione</span> 
				                        <select name="spedizione" class="form-control my-1">
											<option value="Standard" selected>Standard</option>
											<option value="Express">Express</option>
											<option value="Premium">Premium</option>
										</select>
				                    </div> 
								</div>
			    				<div class="mt-4"> 
					                <div class="text-center"> 
					                    <h5>PayPal</h5> 
									</div> 
				                	<div class="form mt-3">
					                    <div class="d-flex flex-row justify-content-between"> 
						                	<div class="inputbox w-50"> 
					                            <span>Indirizzo Email PayPal</span>
					                            <input type="text" name="name" min="1" max="999" class="form-control my-1" required="required"> 
						                    </div>    
						                    <div class="d-flex align-items-end mb-2 pay"> 
							                    <form action="<%=request.getContextPath() + "/acquisto" %>" method="POST" id="formAcquisto">
							           				<button class="submitInput px-5" form="formAcquisto">Acquista</button> 
							           			</form>
						            		</div> 
					                    </div> 
									</div> 
			   					</div>
			            	</div> 
						</div> 
					</div>
				</div>
			</div>
		</div>
	</div>
	
		</div>
	<footer id= "footer"><%@include file="/JSP/pubblica/footer.jsp"%></footer>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	
</body>
</html>