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
    justify-content: space-between;
    padding: 10px;
    background-color: #007bff;
    color: white;
    position: relative;
}
.home-icon {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
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
        }
        .logout-button {
            display: flex;
            align-items: center;
        }
        .logout-button i {
            margin-right: 5px;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        button#aggiungi {
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button#aggiungi:hover {
            background-color: #0056b3;
        }
        table {
            width: 70%;
            margin: 0 auto 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .tabellaEntrate {
            text-align: center;
            width: 60%;
            margin: 0 auto 20px auto;
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
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
        .clock {
            font-size: 2rem;
            color: #333;
            text-align: center;
            margin-top: 40px;
        }
        h2 {
            text-align: center;
        }
        .details-container {
            width: 70%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .details-container h3 {
            margin: 10px 0;
            color: #333;
            font-weight: normal;
        }
        .details-container .detail-item {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .details-container .detail-item:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>
<header>
    <h1>Buongiorno <?=$_SESSION['user']['nome']?></h1>
    <a href="index.php">
    <i class="fas fa-home home-icon" onclick=""></i>
    </a>    <div class="logout-button">
        <button onclick='logout()'><i class="fas fa-sign-out-alt"></i>Logout</button>
    </div>
</header>
<div class="button-container">
    <button onclick="back('<?=$back?>')">Torna alla lista</button>
</div>
<h2>Dettagli giorno <?=$titolo?> </h2>
<div class="details-container">
    <div class="detail-item">
        <h3>Giorno:</h3>
        <h3><?=$giorno['giorno']?></h3>
    </div>
    <div class="detail-item">
        <h3>Inizio turno:</h3>
        <h3><?=$giorno['inizio_turno']?></h3>
    </div>
    <div class="detail-item">
        <h3>Fine turno:</h3>
        <h3><?=$giorno['fine_turno']?></h3>
    </div>
    <div class="detail-item">
        <h3>Numero di Uscite:</h3>
        <h3><?=$n_uscite?></h3>
    </div>
</div>
<?php if($n_uscite!=0) : ?>
<table>
<thead>
<tr><th>Uscita</th><th>Entrata</th></tr>
</thead>
<?php foreach($entrate as $entrata) : ?>
<tr>
<td><?=$entrata['orario_uscita']?></td>
<td><?=$entrata['orario_entrata']?></td>
</tr>
<?php endforeach; ?>
</table>
<?php endif; ?>
<script>
    function logout() {
        window.location.href = 'index.php?action=logout';
    }
    function back(back) {
        window.location.href = back
    }
</script>
</body>
</html>
