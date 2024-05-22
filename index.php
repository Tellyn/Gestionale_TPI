<?php

require 'vendor/autoload.php';

use Model\AttendanceRepository;
use Util\Authenticator;

$template = new \League\Plates\Engine('templates', 'tpl');
$last = Model\EnterExitRepository::get_last_uscita();
$t = false;
if (isset($_GET['action'])) {
    if ($_GET['action'] == 'registration') {
        echo $template->render('registrazione');
        exit(0);
    }

    if ($_GET['action'] == 'logout') {
        \Util\Authenticator::logout();
    }


    if ($_GET['action'] == 'complete_registration') {
        $user = Authenticator::getUser();
        if (\Model\UserRepository::getUser($_POST['username']) != null) {
            echo '<script>alert("email già utilizzata!");</script>';
            echo $template->render('registrazione');
            exit(0);
        }
        $pass = password_hash($_POST['password'], PASSWORD_DEFAULT);
        \Model\UserRepository::insertUser($_POST['username'], $pass, $_POST['nome'], $_POST['cognome'], $_POST['telefono'], $_POST['data']);
        $t = true;
    }
    if ($_GET['action'] == 'erase') {
        AttendanceRepository::deletepresenza($_POST['erase']);
    }
    if ($_GET['action'] == 'uscita') {
        if ($last != null) {
            if ($last['id_entrata'] == null)
                echo "<script>alert('Prima di inserire un altra uscita devi inserire un entrata')</script>";
            else {
                    Model\EnterExitRepository::insert_uscita();
            } 
        }else{
            Model\EnterExitRepository::insert_uscita();
        }
    }
    if($_GET['action']== 'entrata' ){
        Model\EnterExitRepository::insert_entrata();
    }

    if ($_GET['action'] == 'giorno') {
        Model\DayRepository::insert_giorno();
    }
    if($_GET['action'] === 'all'){
        $giorni=Model\DayRepository::get_giorni();
        echo $template->render('report',[
            'giorni'=>$giorni,
        ]);
        exit(0);
    }
    if($_GET['action']==='open'){
        $info_entrate=Model\EnterExitRepository::get_uscite_entrateByDate($_GET['id']);
        $info_day=Model\DayRepository::get_giornoById($_GET['id']);
        $numero_uscite=count($info_entrate);
        var_dump($numero_uscite);
        echo $template->render('day',[
            'entrate'=>$info_entrate,
            'giorno'=>$info_day,
            'n_uscite'=>$numero_uscite
        ]);
        exit(0);
    }
}
if (!$t) {
    $user = Authenticator::getUser();
}

if ($user == null) {
    echo $template->render('index', []);
    exit(0);
}
if ($user['ruolo'] == 'admin') {
    $presenze = AttendanceRepository::getpresenze();

    echo $template->render('home_admin', [
        'presenze' => $presenze
    ]);
    exit(0);
}
$last = Model\EnterExitRepository::get_last_uscita();
$entrata=true;
if(($last!=null && $last['id_entrata']!=null)|| $last==null ){
    $entrata=false;
}

$giorno = Model\DayRepository::get_giorno();
$presenze = Model\EnterExitRepository::get_uscite_entrate();
echo $template->render('home', [
    'giorno' => $giorno,
    'entrata'=>$entrata,
    'presenze'=>$presenze
]);
