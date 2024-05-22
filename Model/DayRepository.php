<?php
namespace Model;

use Util\Connection;
use Util\Authenticator;
class DayRepository 
{
    public static function insert_giorno(){
        date_default_timezone_set('Europe/Rome');
        if(self::get_giorno()){
        $pdo = Connection::getInstance();
        $user=Authenticator::getUser();
        $giorno=date("Y-m-d");
        $sql = 'INSERT INTO Giorno (giorno,id_utente,inizio_turno,fine_turno) VALUES ( :giorno, :id , :inizio , :fine )  ';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'giorno'=>$giorno,
            'id'=>$user['ID'],
            'inizio'=> "08:00:00",
            'fine'=> "17:00:00"
            ]
        );
        }
    }
    public static function get_giorno(){
        date_default_timezone_set('Europe/Rome');
        $user=Authenticator::getUser();
        $pdo = Connection::getInstance();
        $giorno=date("Y-m-d");
        $sql = 'SELECT * FROM Giorno WHERE giorno=:giorno  AND id_utente= :utente';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'giorno'=>$giorno,
            'utente'=>$user['ID']
            ]
        );
        if($stmt->rowCount() == 0)
            return true;

        return $stmt->fetch();
    }
public static function get_giorni() {
    $user=Authenticator::getUser();
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM giorno WHERE id_utente = :id_utente ORDER BY giorno DESC';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'id_utente' => $user['ID']
        ]);
        if($stmt->rowCount() <= 0){
            return null;
        }
        $result=$stmt->fetchAll();
        return $result;
}
public static function get_giornoById(string $giorno){
        $user=Authenticator::getUser();
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM Giorno WHERE ID=:giorno  AND id_utente= :utente';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'giorno'=>$giorno,
            'utente'=>$user['ID']
            ]
        );
    
        return $stmt->fetch();
}
}
