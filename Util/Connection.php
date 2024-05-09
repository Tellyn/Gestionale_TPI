<?php

namespace Util;

require_once("conf\config.php");
use PDO;


class Connection{
    private static PDO $pdo;
    private function __construct()
    {
    }

    /**
     * @return PDO
     */
    public static function getInstance(): PDO
    {


        if (!isset(Connection::$pdo))
        {
            $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8';

            Connection::$pdo = new PDO($dsn, DB_USER, DB_PASSWORD);
        }
        return Connection::$pdo;
    }

}