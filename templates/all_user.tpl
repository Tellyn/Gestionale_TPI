<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Presenze Utente</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }
        header {
            display: flex;
            align-items: center;
            justify-content: space-between; /* Spazio tra gli elementi */
            padding: 10px;
            background-color: #007bff; /* Blu */
            color: white;
        }
        header a {
            text-decoration: none;
            color: white;
        }
        header button {
            background-color: transparent;
            border: none;
            cursor: pointer;
            color: white;
        }
        h1 {
            margin: 0;
            color: white; /* Blu */
        }
        .logout-button {
            display: flex;
            align-items: center;
        }
        .logout-button i {
            margin-right: 5px;
        }
        .button-container {
            text-align: center; /* Centra il pulsante "Aggiungi" */
            margin-top: 20px;
            margin-bottom: 20px;
        }
        button#aggiungi {
            padding: 8px 16px;
            background-color: #007bff; /* Blu */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button#aggiungi:hover {
            background-color: #0056b3; /* Tonalità più scura di blu al passaggio del mouse */
        }
        table {
            width: 80%;
            margin: 0 auto 20px auto; /* Centra la tabella orizzontalmente */
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .tabellaEntrate{
            text-align: center;
            width: 60%;
            margin: 0 auto 20px auto; /* Centra la tabella orizzontalmente */
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        button {
            padding: 8px 16px;
            background-color: #007bff; /* Blu */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3; /* Tonalità più scura di blu al passaggio del mouse */
        }
        a {
            text-decoration: none;
            color: #007bff; /* Blu */
        }
        a:hover {
            text-decoration: underline;
        }

        /* Stile per l'orologio digitale */
        .clock {
            font-size: 2rem;
            color: #333;
            text-align: center;
            margin-top: 40px;
            margin-top: 40px;
        }
        h2{
            align-items: center;
            justify-content: center;
            text-align: center;
        }
    </style>
</head>
<body>
<header>
    <h1> Buongiorno <?=$_SESSION['user']['nome']?></h1>
    <div class="logout-button">
        <button onclick='logout()'><i class="fas fa-sign-out-alt"></i>Logout</button>
    </div>
</header>


<div class="button-container">
    <button onclick="back()">torna indietro</button>
</div>
<h2>Lista di tutti gli utenti:</h2>
<h3 style="text-align: center;">Premi la riga della tabella per visualizzare le informazioni degli utenti</h3>
<table>
<thead>
<?php if($utenti===null) :?>
    <h2>Nessun Utente</h2>
<?php else : ?>
<tr><th>Utente</th><th>Email</th><th>Numero di telefono</th><th>Ruolo</th></tr>
</thead>
<?php foreach($utenti as $utente) : ?>

<tr onclick="change(<?=$utente['ID']?>)" >
    <td><?=$utente['nome']?><?=$utente['cognome']?></td>
    <td><?=$utente['username']?></td>
    <td><?=$utente['numero_telefono']?></td>
    <td><?=$utente['ruolo']?></td>

    <!-- <td>
         <form method="post" action="index.php?action=erase" style="display: inline-block">
            <button>cancella</button>
            <input type="hidden" value="" name="erase">
        </form>
    </td> -->
</tr>
<?php endforeach; ?>
</table>
<?php endif; ?>

<script>
function logout(){
window.location.href='index.php?action=logout'
}
function back(){
    window.location.href='index.php'
}
function change(value){
    window.location.href='index.php?action=user&id='+value

}
</script>

</body>
</html>
