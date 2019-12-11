DNMP（Docker + Nginx + MySQL + PHP + Redis）

## 1.目录结构

```
/
├── data                        数据库数据目录
│   ├── mysql                   MySQL8 数据目录
│   └── redis                   redis 数据目录
├── logs                        日志目录
│   ├── nginx                   nginx 日志
│   └── php                     php 日志
├── mysql                       mysql配置文件
├── nginx                       nginx配置文件
├── php                         php配置文件
├── redis                       redis配置文件
├── www                         PHP 代码目录
└── docker-compose.yml          Docker 服务配置示例文件
```

## 2.快速使用
```
    git clone https://github.com/xiaoshangmin/dnmp.git      # clone 项目
    cd dnmp                                                 # 进入项目目录
    docker-compose up                                       # 启动项目
```
    在浏览器中访问：`http://localhost`，PHP代码在文件`./www/index.php`。
    ./www/index.php  有简单的示例代码