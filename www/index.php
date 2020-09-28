<?php
echo $_SERVER['SERVER_ADDR'];
//phpinfo();
sleep(10);
// phpinfo();
// 连接Redis
//$redis = new Redis();
//$redis->connect('redis', 6379);
//链接数据库
// try{
//     $pdo = new PDO("mysql:host=mysql;dbname=mysql",'root','123456');
//     print_r($pdo);
// }catch(Exception $e){
//     echo $e->getMessage();
// }