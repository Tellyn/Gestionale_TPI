<?php

namespace Model;
use Util\Connection;

class UserRepository{

    public static function userAuthentication(string $username, string $password){
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM utente WHERE username=:username';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'username' => $username
            ]
        );

        //Non esiste un utente con quello username nel database
        if($stmt->rowCount() == 0)
            return null;
        //Recupera i dati dell'utente
        $row = $stmt->fetch();
        //Verifica che la password corrisponda
        //Se non corrisponde ritorna null
        if (!password_verify($password, $row['password']))
            return null;
        //Altrimenti ritorna il vettore contenente i dati dell'utente

        return $row;
    }
    public static function insertUser(string $username, string $password, string $nome, string $cognome, string $numero, string $data){
        $pdo = Connection::getInstance();
        $sql = 'INSERT INTO utente (username, password,nome,cognome,numero_telefono,data_nascita, ruolo) VALUES (:username, :password, :nome, :cognome, :numero, :data, "dipendente")';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'username' => $username,
            'password' => $password,
            'nome' => $nome,
            'cognome' => $cognome,
            'numero' => $numero,
            'data' => $data
        ]);

    }
    public static function getUser(string $username){
            $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM utente WHERE username=:username';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'username' => $username
            ]
        );
        if($stmt->rowCount() == 0)
            return null;
        else
            return $row = $stmt->fetch();
    }
    

}