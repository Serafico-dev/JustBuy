let modificaBtn = document.querySelectorAll(".modificaBtn");
let divModifica = document.getElementById("divModifica");
let modificaFormValue = document.getElementById("modificaFormBtn")
let titoloModifica = document.getElementById("titoloModificaProdotto");
let divMsgStatus = document.getElementById("divMsgStatus");

modificaBtn.forEach(button => {
    button.addEventListener('click', () => {
 divAggiungi.style.display = "none";
 divModifica.style.display = "block";
 modificaFormValue.value = button.value;   
 titoloModifica.innerText = "Modifica il prodotto con ID " + button.value;
 divMsgStatus.style.display = "none";
 divModifica.scrollIntoView(); 
    });
});

let aggiungiBtn = document.getElementById("aggiungiBtn");
let divAggiungi = document.getElementById("divAggiungi");


aggiungiBtn.addEventListener("click", function(){
 divModifica.style.display = "none";
 divAggiungi.style.display = "block";
 divAggiungi.scrollIntoView();
})