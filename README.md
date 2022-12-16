DNMP（Docker + Openresty + MySQL + PHP + Redis）  
RabbitMQ  
ELK + FILEBEAT
## 1.目录结构

```
├── data                        数据库数据目录
│   ├── composer                composer 数据目录
│   ├── esdata                  elasticsearch 数据目录
│   ├── mysql                   MySQL8 数据目录
│   ├── mysql5                  MySQL5 数据目录
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
│   └── nacos                   nacos 日志
├── services
│   ├── mysql                   mysql8配置文件
│   ├── mysql5                  mysql5配置文件
│   ├── nacos                   nacos配置文件
│   ├── nginx                   nginx配置文件
│   ├── php7.2                  php7.2配置文件
│   ├── php7.3                  php7.3配置文件
│   ├── php7.4                  php7.4配置文件
│   ├── php8                    php8配置文件
│   ├── rabbitmq                rabbitmq配置文件
│   └── redis                   redis配置文件
├── www                         PHP 代码目录
└── docker-compose.sample.yml         docker-compose 配置示例文件

```

## 1.1 php -m
```
bcmath       
Core
ctype        
curl
date
dom
exif
fileinfo
filter
ftp
hash
iconv
json
libxml
mbstring
mysqli
mysqlnd
openssl
protobuf
pcntl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
readline
redis
Reflection
session
SimpleXML
sockets
sodium
SPL
sqlite3
standard
swoole
tokenizer
yac
xml
xmlreader
xmlwriter
Zend OPcache
zlib
```

## 2.快速使用
```
    git clone https://github.com/xiaoshangmin/dnmp.git      # clone 项目
    cd dnmp                                                 # 进入项目目录
    cp .example.env .env                                    # 复制环境变量文件
    cp  docker-compose.sample.yml  docker-compose.yml       # docker-compose配置文件
    docker-compose up                                       # 启动项目
    docker-compose up -d                                    # 守护进程模式运行
    国内下载替换docker源
    {
        "registry-mirrors": [
                "https://ustc-edu-cn.mirror.aliyuncs.com/",
                "https://hub-mirror.c.163.com",
                "https://mirror.baidubce.com"
        ]
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
    在容器访问nginx 需要在hosts里面添加 nginx容器的IP:你的域名，或者在docker-copmose.yml里面用extra_hosts配置


## 2.3 rabbitmq
    在浏览器中访问：`http://localhost:15672`，帐号密码：admin:admin

## 2.4 kibana
    在浏览器中访问：`http://localhost:5601`

## 2.5 nacos
    https://raw.githubusercontent.com/alibaba/nacos/develop/distribution/conf/mysql-schema.sql
    配置nacos持久化，修改conf/application.properties文件，增加支持mysql数据源配置
    在浏览器中访问：http://localhost:8848/nacos/index.html#/login   nacos/nacos