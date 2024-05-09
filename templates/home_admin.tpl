<!doctype html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
<h1>Home admin</h1>
<table>
    <tr><th>Utente</th><th>Giorno</th><th>Inizio_turno</th><th> Fine_turno</th><th> Entrata </th> <th> Uscita </th> <th> descrizione </th></tr>
    <?php if($presenze==null) :?>
    <tr> <td> <h3> Nessun Risultato</h3></td></tr>
    <?php else : ?>
    <?php foreach($presenze as $presenza) : ?>
    <tr>
        <td>
            <?=$presenza['nome']?>
            <?=$presenza['cognome']?>
        </td>
        <td>
            <?=$presenza['giorno']?>
        </td>
        <td>
            <?=$presenza['inizio_turno']?>
        </td>
        <td>
            <?=$presenza['fine_turno']?>
        </td>
        <td>
            <?php if($presenza['entrata']=='00:00:00') : ?>
            Nessuna entrata
            <?php else: ?>
            <?= $presenza['entrata']?>
            <?php endif; ?>

        </td>
        <td>
            <?php if($presenza['uscita']=='00:00:00') : ?>
            Nessuna uscita
            <?php else: ?>
            <?= $presenza['uscita']?>
            <?php endif; ?>
        </td>
        <td>
            <?= $presenza['descrizione']?>
        </td>
        <td>
            <form method="post" action="index.php?action=erase" style="display: inline-block">
            <button>cancella</button>
                <input type="hidden" value="<?=$presenza['ID']?>" name="erase">
            </form>
            <form method="post" action="index.php?action=change" style="display: inline-block;">
                <button>modifica</button>
                <input type="hidden" value="<?=$presenza['ID']?>" name="change">
            </form>
        </td>
    </tr>
    <?php endforeach; ?>
    <?php endif; ?>
</table>
<a href="index.php?action=logout">Logout</a>
<button  onclick="registrazione()">Registrati</button>
<script>
    function registrazione(){
        window.location.href= "index.php?action=registration"
    }
</script>
</body>
</html>