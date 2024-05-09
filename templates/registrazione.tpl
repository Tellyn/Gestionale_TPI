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
<form method="post" action="index.php?action=complete_registration" onsubmit='return controllo()'> 
    <input name="username" type="email" placeholder="Email" required>
    <input name="password" id='password' type="password" placeholder="Password" required>
    <input type="password" id='confirm_password' placeholder="Conferma Password" required>
    <input name="nome" type="text" placeholder="Nome" required>
    <input name="cognome" type="text" placeholder="Cognome" required>
    <input name="telefono" id="telefono" type="text" placeholder="Numero Telefonico" required>
    <input name="data" type="date" placeholder="" required>
    <br>
    <input type="submit">
</form>
<button onclick='back()'>indietro</button>

</body>
<script>
function controllo(){
        var password=document.getElementById('password')
        var confirm_password=document.getElementById('confirm_password')
        var numero_telefono=document.getElementById('telefono')
        if(password.value!=confirm_password.value){
            password.value=''
            confirm_password.value=''
            alert('Le credenziali password e conferma password sono differenti riprova')
            return false
        }
        var regex = /^[0-9]+$/;
        console.log(regex.test(telefono.value))
        if(!regex.test(telefono.value)){
                alert('numero di telefono non conforme')
                telefono.value='';
                return false;
        }
        return true
}
function back(){
    window.location.href='index.php'
   }
</script>
</html>