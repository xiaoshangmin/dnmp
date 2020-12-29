DNMP（Docker + Openresty + MySQL + PHP + Redis）  
RabbitMQ  
ELK + FILEBEAT
## 1.目录结构

```
├── data                        数据库数据目录
│   ├── esdata                  elasticsearch 数据目录
│   ├── mysql                   MySQL8 数据目录
│   ├── rabbitmq                rabbitmq 数据目录
│   └── redis                   redis 数据目录
├── elk                         elk+filebeat 配置文件
│   ├── es                      elasticsearch 配置文件
│   ├── filebeat                filebeat 配置文件
│   ├── kibana                  kibana 配置文件
│   └── logstash                logstash 配置文件
├── logs                        日志目录
│   ├── nginx                   nginx 日志
│   └── php                     php 日志
│   └── rabbitmq                rabbitmq 日志
├── mysql                       mysql配置文件
├── nginx                       nginx配置文件
├── php                         php配置文件
├── rabbitmq                    rabbitmq配置文件
├── redis                       redis配置文件
├── www                         PHP 代码目录
└── docker-compose.yml          docker-compose 配置示例文件
```

## 1.1 PHP已安装扩展
```
bcmath
curl  
exif  
gd
gettext  
intl 
mbstring
mysqli
mysqlnd
openssl
pcntl
PDO
pdo_mysql
pdo_sqlite  
redis 
soap
sockets
swoole
opcache
```

## 2.快速使用
```
    git clone https://github.com/xiaoshangmin/dnmp.git      # clone 项目
    cd dnmp                                                 # 进入项目目录
    docker-compose up                                       # 启动项目
    docker-compose up -d                                    # 守护进程模式运行
    国内下载替换docker源
    {
        "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
    }
```
    在浏览器中访问：`http://localhost`，PHP代码在文件`./www/index.php`。
    ./www/index.php  有简单的示例代码

## 2.1 数据库
```
    root:root
```

### 2.2 phpfpm容器
    docker exec -it php sh #进入容器
    # 修改composer 源
    composer config -g secure-http false 
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ 
    cd /var/www/html  #网站目录

## 2.3 rabbitmq
    在浏览器中访问：`http://localhost:15672`，帐号密码：admin:admin

## 2.4 kibana
    在浏览器中访问：`http://localhost:5601`