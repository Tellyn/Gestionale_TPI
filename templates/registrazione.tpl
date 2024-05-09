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
<form method="post" action="index.php?action=complete_registration">
    <input name="username" type="email" placeholder="Email" required>
    <input name="password" type="password" placeholder="Password" required>
    <input name="nome" type="text" placeholder="Nome" required>
    <input name="cognome" type="text" placeholder="Cognome" required>
    <input name="telefono" type="text" placeholder="Numero Telefonico" required>
    <input name="data" type="date" placeholder="" required>
    <br>
    <input type="submit">
</form>
</body>
</html>