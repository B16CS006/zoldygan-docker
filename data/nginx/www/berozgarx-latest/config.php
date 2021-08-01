<?php
define('DBSERVER', 'localhost');
define('DBUSERNAME', 'root');
define('DBPASSWORD', 'zxcvbnm');
define('DBNAME', 'zoldygan');

$db_zoldygan = mysql_connect(DBSERVER, DBUSERNAME, DBPASSWORD, 'zoldygan');
$db = mysql_connect(DBSERVER, DBUSERNAME, DBPASSWORD, 'DBNAME');

if($db_zoldygan === false || $db){
    die("Error: connection error. " . mysql_connect_error());
}
?>