<?php

require 'vendor/autoload.php';

use Model\AttendanceRepository;
use Model\UserRepository;
use Util\Authenticator;

$template = new \League\Plates\Engine('templates', 'tpl');
$t = false;
if (isset($_GET['action'])) {
    if ($_GET['action'] === 'registration') {
        echo $template->render('registrazione');
        exit(0);
    }

    if ($_GET['action'] === 'logout') {
        \Util\Authenticator::logout();
    }


    if ($_GET['action'] === 'complete_registration') {
        $user = Authenticator::getUser();
        if (\Model\UserRepository::getUser($_POST['username']) != null) {
            echo '<script>alert("email già utilizzata!");</script>';
        echo $template->render('registrazione');
            exit(0);
        }
        $pass = password_hash($_POST['password'], PASSWORD_DEFAULT);
        \Model\UserRepository::insertUser($_POST['username'], $pass, $_POST['nome'], $_POST['cognome'], $_POST['telefono'], $_POST['data']);
        $t = true;
        unset($_POST['username']);
    }
    if ($_GET['action'] === 'erase') {
        AttendanceRepository::deletepresenza($_POST['erase']);
    }
    if ($_GET['action'] === 'uscita') {
        $last = Model\EnterExitRepository::get_last_uscita();
        if ($last != null) {
            if ($last['id_entrata'] == null)
                echo "<script>alert('Prima di inserire un altra uscita devi inserire un entrata')</script>";
            else {
                Model\EnterExitRepository::insert_uscita();
            }
        } else {
            Model\EnterExitRepository::insert_uscita();
        }
    }
    if ($_GET['action'] === 'entrata') {
        Model\EnterExitRepository::insert_entrata();
    }

    if ($_GET['action'] === 'giorno') {
        Model\DayRepository::insert_giorno();
    }
    if ($_GET['action'] === 'all') {
        $user=Authenticator::getUser();
        $giorni = Model\DayRepository::get_giorniutente($user);
        echo $template->render('report', [
            'oggi'=>'ad oggi',
            'giorni' => $giorni,
            'titolo'=>'',
            'azione'=>'giorno_utente',
            'back'=>'index.php'
        ]);
        exit(0);
    }
    if ($_GET['action'] === 'giorno_utente') {
        $info_entrate = Model\EnterExitRepository::get_uscite_entrateByDate($_GET['id'], Authenticator::getUser());
        $info_day = Model\DayRepository::get_giornoById($_GET['id']);
        $numero_uscite = count($info_entrate);
        echo $template->render('day', [
            'entrate' => $info_entrate,
            'giorno' => $info_day,
            'n_uscite' => $numero_uscite,
            'titolo'=> '',
            'back'=>'index.php?action=all'
        ]);
        exit(0);
    }
    if ($_GET['action'] === 'alluser') {
        Authenticator::getUser();
        $utenti = Model\UserRepository::getAlluser();
        echo $template->render('all_user', [
            'utenti' => $utenti
        ]);
        exit(0);
    }
    if ($_GET['action'] === 'user') {
        Authenticator::getUser();
        $user=UserRepository::getUserByid($_GET['id']);
        $giorni = Model\DayRepository::get_giorniutente($user);
        echo $template->render('report', [
            'oggi'=>'agli utenti',
            'giorni' => $giorni,
            'azione'=> 'giorno_admin',
            'titolo'=>'di '. $user['nome'].'  '.$user['cognome'],
            'back'=>'index.php?action=alluser'
        ]);
        exit(0);
    }
    if($_GET['action']==='giorno_admin'){
        Authenticator::getUser();
        $info_day = Model\DayRepository::get_giornoById($_GET['id']);
        $user=UserRepository::getUserByid($info_day['id_utente']);
        $info_entrate = Model\EnterExitRepository::get_uscite_entrateByDate($_GET['id'],$user);
        $numero_uscite = count($info_entrate);
        echo $template->render('day', [
            'entrate' => $info_entrate,
            'giorno' => $info_day,
            'n_uscite' => $numero_uscite,
            'titolo'=> 'di '. $user['nome']. ' '. $user['cognome'],
            'back'=>'index.php?action=user&id='.$info_day['id_utente']
        ]);
        exit(0);
    }
    if($_GET['action']==='giornohome'){
        Authenticator::getUser();
        $user=UserRepository::getUserByid($_GET['id']);
        $info_day = Model\DayRepository::get_giornoUtente($user);
        $info_entrate = Model\EnterExitRepository::get_uscite_entrateByDate($info_day['ID'],$user);
        $numero_uscite = count($info_entrate);
        echo $template->render('day', [
            'entrate' => $info_entrate,
            'giorno' => $info_day,
            'n_uscite' => $numero_uscite,
            'titolo'=> 'di '. $user['nome']. ' '. $user['cognome'],
            'back'=>'index.php'
        ]);
        exit(0);
    }
}
    $user = Authenticator::getUser();

if ($user == null) {
    echo $template->render('index', []);
    exit(0);
}
if ($user['ruolo'] == 'admin') {
    $giorni = Model\DayRepository::get_giorni_today();
    echo $template->render('home_admin', [
        'giorni' => $giorni
    ]);
    exit(0);
}
$last = Model\EnterExitRepository::get_last_uscita();
$entrata = true;
if (($last != null && $last['id_entrata'] != null) || $last == null) {
    $entrata = false;
}
$giorno = Model\DayRepository::get_giornoUtente($user);
$presenze = Model\EnterExitRepository::get_uscite_entrate($user);
echo $template->render('home', [
    'giorno' => $giorno,
    'entrata' => $entrata,
    'presenze' => $presenze
]);
