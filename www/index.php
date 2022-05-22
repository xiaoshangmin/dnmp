<?php
// 连接Redis
// $redis = new Redis();
// $redis->connect('redis', 6379);
// $uid = "uid:1";
// $check = $redis->exists($uid);
// $redis->incr($uid);
// if($check){
//     $count = $redis->get($uid);
//     if($count > 5){
//         echo '太频繁';
//         exit();
//     }
// }else{
//     $redis->expire($uid,60);
// }
// $count = $redis->get($uid);
// echo "第{$count}次请求";
// sleep(10);
// phpinfo(); 

echo 1%10;

//链接数据库
// try{
//     $pdo = new PDO("mysql:host=mysql;dbname=mysql",'root','123456');
//     print_r($pdo);
// }catch(Exception $e){
//     echo $e->getMessage();
// }