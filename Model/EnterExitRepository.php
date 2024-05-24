<?php

namespace Model;

use Util\Connection;
use Util\Authenticator;
use Model\DayRepository;

class EnterExitRepository
{

    public static function insert_entrata()
    {
        date_default_timezone_set('Europe/Rome');
        $user = Authenticator::getUser();
        $giorno = DayRepository::get_giornoUtente($user);
        $pdo = Connection::getInstance();
        $ora = date("H:i:s");
        $sql = 'INSERT INTO Entrata (orario_entrata) VALUES (:entrata)';
        $stmt = $pdo->prepare($sql);
        $stmt->execute(
            [
                'entrata' => $ora
            ]
        );
        $sql = 'SELECT ID FROM Entrata ORDER BY ID DESC LIMIT 1 ';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([]);
        $entrata=$stmt->fetch();
        $uscita = self::get_last_uscita();
        $sql = 'UPDATE Uscita SET id_entrata=:entrata WHERE ID=:ID';
        $stmt = $pdo->prepare($sql);
        $stmt->execute(
            [
                'entrata' => $entrata['ID'],
                'ID' => $uscita['ID']
            ]
        );
    }


    public static function insert_uscita()
    {
        date_default_timezone_set('Europe/Rome');
        $user = Authenticator::getUser();
        $giorno = DayRepository::get_giornoUtente($user);
        $pdo = Connection::getInstance();
        $ora = date("H:i:s");
        $sql = 'INSERT INTO Uscita (orario_uscita, id_giorno, motivo) VALUES ( :ora , :id , :motivo)';
        $stmt = $pdo->prepare($sql);
        $stmt->execute(
            [
                'ora' => $ora,
                'id' => $giorno['ID'],
                'motivo' => 'si',
            ]
        );
    }


    public static function get_last_uscita()
    {
        $user = Authenticator::getUser();
        $giorno=DayRepository::get_giornoUtente($user);
        $pdo = Connection::getInstance();
        $sql = 'SELECT Uscita.ID ,orario_uscita,id_entrata, Giorno.ID as Day FROM Uscita INNER JOIN Giorno ON id_giorno=Giorno.ID WHERE Giorno.id_utente=:utente ORDER BY Uscita.ID DESC LIMIT 1 ';
        $stmt = $pdo->prepare($sql);
        $stmt->execute(
            [
                'utente' => $user['ID']
            ]
        );
        if ($stmt->rowCount() == 0)
            return null;

        $last=$stmt->fetch();
        if($giorno===  true){
            return null;
        }
        if($giorno['ID']!=$last['Day']){
            return null;
        }
        return $last;
    }

    public static function get_uscite_entrate( $user){
        $giorno = DayRepository::get_giornoUtente($user);
        if($giorno!==true){
        
        $pdo = Connection::getInstance();
        $sql = 'SELECT Uscita.ID ,orario_uscita, orario_entrata FROM Uscita 
        INNER JOIN Giorno ON id_giorno=Giorno.ID 
        INNER JOIN Entrata ON Uscita.id_entrata = Entrata.ID 
        WHERE Giorno.id_utente=:utente AND Giorno.giorno=:giorno ';
        $stmt = $pdo->prepare($sql);
        $stmt->execute(
            [
                'utente' => $user['ID'],
                'giorno'=> $giorno['giorno']
            ]
        );
        if ($stmt->rowCount() == 0)
            return null;
        return $stmt->fetchAll();
    }
    }
    public static function get_uscite_entrateByDate(string $giorno,  $user){        
        $pdo = Connection::getInstance();
        $sql = 'SELECT orario_uscita, orario_entrata FROM Uscita 
        INNER JOIN Giorno ON id_giorno=Giorno.ID 
        INNER JOIN Entrata ON Uscita.id_entrata = Entrata.ID 
        WHERE Giorno.id_utente=:utente AND Giorno.Id=:giorno ';
        $stmt = $pdo->prepare($sql);
        $stmt->execute(
            [
                'utente' => $user['ID'],
                'giorno'=>$giorno
            ]
        );
        return $stmt->fetchAll();
    }
}
