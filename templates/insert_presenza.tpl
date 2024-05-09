<!doctype html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>
    </title>
</head>
<body>
<form method="post" action="index.php" onsubmit='return controlloore()'>
        <input type="time" id=inizio_turno name="inizio_turno" required>
        <input type="time" id=fine_turno name="fine_turno" required>
        <input type="date" name="giorno" required>
        <input type="text" name="descrizione" required>
        <input type="checkbox" id="entrata" onclick="myentrata()">
            <input type="time" name="entrata"  id="input_entrata" disabled>
        <input type="checkbox" id="uscita" onclick="myuscita()">
            <input type="time" name="uscita" id="input_uscita" disabled>
    <br>
    <input type="submit" >
    <button onclick="prova()">prova</button>
</form>
<button onclick='back()'>indietro</button>

</body>
<script>
function myentrata(){
    var entrata=document.getElementById('entrata')
    if(entrata.checked){
        var input= document.getElementById('input_entrata')
        input.disabled=false
    }
    else{
        var input= document.getElementById('input_entrata')
        input.disabled=true
        input.value='';
    }
}
function myuscita(){
    var entrata=document.getElementById('uscita')
    if(entrata.checked){
        var input= document.getElementById('input_uscita')
        input.disabled=false
        console.log(input)
    }
    else{
        var input= document.getElementById('input_uscita')
        input.disabled=true
        input.value='';
    }
}
function controlloore(){
        var inizio=document.getElementById('inizio_turno').value;
        var fine=document.getElementById('fine_turno').value;

        // Converti le stringhe in oggetti Date
        var dataInizio = new Date("01/01/2024 " + inizio);
        var dataFine = new Date("01/01/2024 " + fine);

        // Controllo ore di inizio e fine turno
        if (dataInizio >= dataFine) {
            alert("L'ora di inizio del turno deve essere precedente all'ora di fine.");
            return false;
        }

        // Controllo se presente l'orario di entrata
        if(document.getElementById('entrata').checked){
            var entrata = document.getElementById('input_entrata').value;
            var dataEntrata = new Date("01/01/2024 " + entrata);
            if (dataEntrata <= dataInizio) {
                alert("L'orario di entrata deve essere successivo all'orario di inizio del turno.");
                return false;
            }
        }

        // Controllo se presente l'orario di uscita
        if(document.getElementById('uscita').checked){
            var uscita = document.getElementById('input_uscita').value;
            var dataUscita = new Date("01/01/2024 " + uscita);
            console.log(dataUscita)
            if (dataUscita >= dataFine) {
                alert("L'orario di uscita deve essere precedente all'orario di fine del turno.");
                return false;
            }
        }

        // Se tutti i controlli passano, il modulo può essere inviato
        return true;
    }
   
   function back(){
    window.location.href='index.php'
   }
</script>
</html>