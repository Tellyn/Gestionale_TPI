<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title></title>
    <style>
    .title {
    text-align: center;
    margin-top: 50px;
    color: #007bff;
}
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        form {
            width: 60%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .input-row {
            display: flex;
            flex-direction: column;
            margin-bottom: 10px;
        }
        .input-row label {
            margin-bottom: 5px;
        }
        input[type="time"],
        input[type="date"],
        input[type="text"],
        input[type="submit"],
        button {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            flex-grow: 1;
            flex-shrink: 0;
        }
        input[type="submit"],
        button {
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        input[type="submit"]:hover,
        button:hover {
            background-color: #0056b3;
        }
        input[type="checkbox"] {
            margin-right: 5px;
            transform: scale(0.8);
        }
        .input-row-inline {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .button-row {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }
        .button-row button {
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <h1 class="title">Aggiunta Presenza   </h1>


<form method="post" action="index.php?" onsubmit='return controlloore()'>
    <div class="input-row">
        <label for="inizio_turno">Orario inizio turno:</label>
        <input type="time" name="inizio_turno" id="inizio_turno" required>
    </div>
    <div class="input-row">
        <label for="fine_turno">Orario fine turno:</label>
        <input type="time" name="fine_turno" id="fine_turno" required>
    </div>
    <div class="input-row">
        <label for="giorno">Data:</label>
        <input type="date" name="giorno" id="giorno" required>
    </div>
    <div class="input-row">
        <label for="descrizione">Descrizione:</label>
        <input type="text" name="descrizione" id="descrizione" required >
    </div>
    <div class="input-row-inline">
        <input type="checkbox" id="entrata" onclick="myentrata()">
        <label for="entrata">Entrata:</label>
        <input type="time" name="entrata" id="input_entrata"  disabled>
    </div>
    <div class="input-row-inline">
        <input type="checkbox" id="uscita" onclick="myuscita()">
        <label for="uscita"> Uscita : </label>
        <input type="time" name="uscita" id="input_uscita"  disabled>
    </div>
    <div class="button-row">
        <input type="submit" value="Invia">
        <button onclick='back()'>Indietro</button>
    </div>
</form>

<script>
    function myentrata() {
        var entrata = document.getElementById('entrata');
        if (entrata.checked) {
            document.getElementById('input_entrata').disabled = false;
        } else {
            document.getElementById('input_entrata').disabled = true;
            document.getElementById('input_entrata').value = '';
        }
    }

    function myuscita() {
        var uscita = document.getElementById('uscita');
        if (uscita.checked) {
            document.getElementById('input_uscita').disabled = false;
        } else {
            document.getElementById('input_uscita').disabled = true;
            document.getElementById('input_uscita').value = '';
        }
    }

    function controlloore() {
        var inizio = document.getElementById('inizio_turno').value;
        var fine = document.getElementById('fine_turno').value;

        var dataInizio = new Date("01/01/2024 " + inizio);
        var dataFine = new Date("01/01/2024 " + fine);

        if (dataInizio >= dataFine) {
            alert("L'ora di inizio del turno deve essere precedente all'ora di fine.");
            return false;
        }

        if (document.getElementById('entrata').checked) {
            var entrata = document.getElementById('input_entrata').value;
            var dataEntrata = new Date("01/01/2024 " + entrata);
            if (dataEntrata <= dataInizio) {
                alert("L'orario di entrata deve essere successivo all'orario di inizio del turno.");
                return false;
            }
        }

        if (document.getElementById('uscita').checked) {
            var uscita = document.getElementById('input_uscita').value;
            var dataUscita = new Date("01/01/2024 " + uscita);
            if (dataUscita >= dataFine) {
                alert("L'orario di uscita deve essere precedente all'orario di fine del turno.");
                return false;
            }
        }

        return true;
    }

    function back() {
        window.location.href = 'index.php';
    }
</script>
</body>
</html>
