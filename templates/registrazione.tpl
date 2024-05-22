<!doctype html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Registrazione</title>
    <style>
    body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f2f2f2;
}
label{
    font-family: Arial, sans-serif;
    color: #aeacac;  
}
h1 {
    text-align: center;
    margin-top: 20px;
    color: #007bff;
}

form {
    width: 300px; /* larghezza desiderata del modulo */
    margin: 0 auto; /* centra il modulo orizzontalmente */
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

input[type="email"],
input[type="password"],
input[type="text"] {
    width: calc(100% - 16px);
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
input[type='date']{
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
input[type="submit"],
button {
    width: 40%;
    padding: 8px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type="submit"]:hover,
button:hover {
    background-color: #0056b3;
}

button {
    margin-top: 10px;
}

    </style>
</head>
<body>
<h1>Registrazione</h1>
<form method="post" action="index.php?action=complete_registration" onsubmit='return controllo()'> 
    <input name="username" type="email" placeholder="Email" required>
    <input name="password" id='password' type="password" placeholder="Password" required>
    <input type="password" id='confirm_password' placeholder="Conferma Password" required>
    <input name="nome" type="text" placeholder="Nome" required>
    <input name="cognome" type="text" placeholder="Cognome" required>
    <input name="telefono" id="telefono" type="text" placeholder="Numero Telefonico" required>
    <label for="data"> Data di nascita</label>
    <input name="data" type="date" placeholder="" required>
    <br>
    <input type="submit">
    <button onclick='back()'>indietro</button>

</form>

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