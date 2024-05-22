<?php
namespace Model;

use Util\Connection;
use Util\Authenticator;
use Model\DayRepository;
class EnterExitRepository 
{
    
    public static function insert_entrata(){
        date_default_timezone_set('Europe/Rome');
        $user=Authenticator::getUser();
        $giorno=DayRepository::get_giorno();
        $pdo = Connection::getInstance();
        $ora=date("H:i:s");
        $sql = 'INSERT INTO Entrata (orario_entrata) VALUES (:entrata)';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'entrata'=>$ora
            ]
        );
        $entrata=$stmt->fetch();
        $uscita=self::get_last_uscita();
        $sql='UPDATE Uscita SET id_entrata=:entrata WHERE ID=:ID';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'entrata'=>$entrata['ID'],
            'ID'=>$uscita['ID']
            ]
        );
    }


    public static function insert_uscita(){
        date_default_timezone_set('Europe/Rome');
        $user=Authenticator::getUser();
        $giorno=DayRepository::get_giorno();
        $pdo = Connection::getInstance();
        $ora=date("H:i:s");
        var_dump($ora);
        $sql = 'INSERT INTO Uscita (orario_uscita, id_giorno, motivo) VALUES ( :ora , :id , :motivo)';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'ora'=>$ora,
            'id'=>$giorno['ID'],
            'motivo'=>'si',
            ]
        );
    }


    public static function get_last_uscita(){
        $user=Authenticator::getUser();
        $pdo = Connection::getInstance();
        $sql = 'SELECT Uscita.ID ,orario_uscita,id_entrata FROM Uscita INNER JOIN Giorno WHERE id_giorno=Giorno.ID AND Giorno.id_utente=:utente ORDER BY Uscita.ID DESC LIMIT 1 ';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'utente'=> $user['ID']]
        );
        if($stmt->rowCount()==0)
            return null;
        return $stmt->fetch();
    }

    public static function is_entrata_presente(){
        $uscita=self::get_last_uscita();
        if($uscita['id_entrata']==null){
            return false;
        }
        return true;
    }
}
