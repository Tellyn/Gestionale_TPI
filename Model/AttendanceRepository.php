<?php

namespace Model;
use Util\Connection;
use Util\Authenticator;
class AttendanceRepository
{
    public static function insertpresenza(string $inizio, string $fine,string $entrata, string $uscita,string $descrizione,string $giorno){
        $pdo = Connection::getInstance();
        $user=Authenticator::getUser();
        $sql = 'Insert into presenza (inizio_turno,fine_turno,entrata,uscita,id_Utente,descrizione,giorno) values (:inizio,:fine,:entrata,:uscita,:id_utente,:descrizione_lavoro,:giorno)';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'inizio' => $inizio,
            'fine' => $fine,
            'entrata' => $entrata,
            'uscita' => $uscita,
            'id_utente' => $_SESSION['user']['ID'],
            'descrizione_lavoro' => $descrizione,
            'giorno' => $giorno

        ]);

    }
    public static function updatepresenza(string $inizio, string $fine,string $entrata, string $uscita,string $descrizione,string $giorno,string $id){
        $pdo = Connection::getInstance();
        $sql = 'UPDATE presenza SET inizio_turno= :inizio, fine_turno= :fine,entrata= :entrata,uscita= :uscita,descrizione= :descrizione,giorno= :giorno WHERE ID=:id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'inizio' => $inizio,
            'fine' => $fine,
            'entrata' => $entrata,
            'uscita' => $uscita,
            'descrizione' => $descrizione,
            'giorno' => $giorno,
            'id'=> $id
        ]);
    }
    public static function deletepresenza(string $id){
        $pdo = Connection::getInstance();
        $sql = 'DELETE FROM presenza WHERE ID = :id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'id' => $id
        ]);
    }
    public static function getpresenza_utente(){
        Authenticator::getUser();
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM presenza WHERE id_utente = :id_utente';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'id_utente' => $_SESSION['user']['ID']
        ]);
        if($stmt->rowCount() <= 0){
            return null;
        }
        $result=$stmt->fetchAll();
        return $result;
    }
    public static function getpresenze(){
        $pdo = Connection::getInstance();
        $sql = 'SELECT presenza.ID,nome,cognome,inizio_turno, fine_turno,entrata,uscita,giorno,descrizione FROM presenza INNER JOIN utente ON id_Utente = utente.ID';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([]);
        if($stmt->rowCount() <= 0){
            return null;
        }
        $result=$stmt->fetchAll();
        return $result;
    }
    public static function getpresenza(string $id){
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM presenza WHERE ID = :id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'id' => $id
        ]);

        $result=$stmt->fetchAll();
        return $result;
    }
}