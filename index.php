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

    if($_GET['action'] == 'logout') {
        \Util\Authenticator::logout();
    }


    if($_GET['action'] == 'complete_registration') {
        $user=Authenticator::getUser();
        if(\Model\UserRepository::getUser($_POST['username'])!=null){
                echo '<script>alert("email già utilizzata!");</script>';
                echo $template->render('registrazione');
                exit(0);
        }
        $pass=password_hash($_POST['password'], PASSWORD_DEFAULT);
        \Model\UserRepository::insertUser($_POST['username'], $pass, $_POST['nome'], $_POST['cognome'], $_POST['telefono'],$_POST['data']);
       $t=true;
    }
    if($_GET['action'] == 'erase') {
        AttendanceRepository::deletepresenza($_POST['erase']);
    }
    if($_GET['action']=='uscita'){
        Model\EnterExitRepository::insert_uscita();
        var_dump(Model\EnterExitRepository::get_last_uscita());
    }
    
    if( $_GET['action']=='giorno'){
        Model\DayRepository::insert_giorno();    
    }

}
if(!$t){
    $user=Authenticator::getUser();
}

if($user == null){
    echo $template->render('index',[
    ]);
    exit(0);
}
if($user['ruolo']=='admin'){
        $presenze=AttendanceRepository::getpresenze();

    echo $template->render('home_admin',[
        'presenze'=>$presenze
    ]);
    exit(0);
}
$giorno=Model\DayRepository::get_giorno();
$giorni=Model\DayRepository::get_giorni();
echo $template->render('home', [
    'giorno'=>$giorno
]);
