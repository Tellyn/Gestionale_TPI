<?php

namespace Util;

use Model\UserRepository;
class Authenticator
{
    private function __construct()
    {
    }

    /**

     */
    private static function start()
    {
        if (session_id() == "")
            session_start();
    }

    public static function getUser(){
        self::start();

        if (isset($_POST['username'])){
            $username = $_POST['username'];
            $password = $_POST['password'];
            //Verifica se le credenziali sono corrette
            $row = UserRepository::userAuthentication($username, $password);
            if ($row != null) {

                $_SESSION['user'] = $row;
            }
        }
        if (!isset($_SESSION['user']))
            return null;
        return $_SESSION['user'];
    }

    public static function logout()
    {
        self::start();
        $_SESSION = [];
        session_destroy();

    }

}