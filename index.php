<?php

require 'vendor/autoload.php';

$template = new \League\Plates\Engine('templates', 'tpl');





echo $template->render('index', [


]);
