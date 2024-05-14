let meno = document.getElementById('meno');
let piu = document.getElementById('piu');
let quantita = document.getElementById('quantitaCarrello')


meno.addEventListener("click", function(){
 quantita.value--;
})

piu.addEventListener("click", function(){
 quantita.value++;
})