<?php

require 'vendor/autoload.php';

use Model\AttendanceRepository;
use Util\Authenticator;
$template = new \League\Plates\Engine('templates', 'tpl');

$t=false;
if(isset($_GET['action'])){
    if($_GET['action'] == 'registration') {
        echo $template->render('registrazione');
        exit(0);
    }

    if($_GET['action'] == 'insert') {
        echo $template->render('insert_presenza');
        exit(0);
    }

    if($_GET['action'] == 'logout') {
        \Util\Authenticator::logout();
    }


    if($_GET['action'] == 'complete_registration') {
        $user=Authenticator::getUser();
        $pass=password_hash($_POST['password'], PASSWORD_DEFAULT);
       \Model\UserRepository::insertUser($_POST['username'], $pass, $_POST['nome'], $_POST['cognome'], $_POST['telefono'],$_POST['data']);
       $t=true;
    }
    if($_GET['action'] == 'erase') {
        AttendanceRepository::deletepresenza($_POST['erase']);
    }
    if($_GET['action'] == 'change') {
        $change=AttendanceRepository::getpresenza($_POST['change']);
        var_dump($change);
        echo $template->render('modifica', [
            'change' => $change[0]
        ]);
        exit(0);
    }
    if($_GET['action']== 'modifica'){
        if(!isset($_POST['entrata'])){
            $entrata='';
        }else{
            $entrata=$_POST['entrata'];
        }
        if(!isset($_POST['uscita'])){
            $uscita='';
        }else{
            $uscita=$_POST['uscita'];
        }
    \Model\AttendanceRepository::updatepresenza($_POST['inizio_turno'],$_POST['fine_turno'],$entrata,$uscita,$_POST['descrizione'],$_POST['giorno'],$_POST['id']);
    unset($_POST['inizio_turno']);
    }

}
if(isset($_POST['inizio_turno'])){

    if(!isset($_POST['entrata'])){
        $entrata='';
    }else{
        $entrata=$_POST['entrata'];
    }
    if(!isset($_POST['uscita'])){
        $uscita='';
    }else{
        $uscita=$_POST['uscita'];
    }
    \Model\AttendanceRepository::insertpresenza($_POST['inizio_turno'],$_POST['fine_turno'],$entrata,$uscita,$_POST['descrizione'],$_POST['giorno']);
    unset($_POST['inizio_turno']);
}
if(!$t){
    $user=Authenticator::getUser();
}

if($user == null){
    echo $template->render('index');
    exit(0);
}
if($user['ruolo']=='Admin'){
    //mail('nicolasmantelli05@gmail.com','hello','sei loggato','From:gestionale@try.com');
        $presenze=AttendanceRepository::getpresenze();

    echo $template->render('home_admin',[
        'presenze'=>$presenze
    ]);
    exit(0);
}
$presenze = AttendanceRepository::getpresenza_utente();

echo $template->render('home', [
'presenze' => $presenze,

]);
