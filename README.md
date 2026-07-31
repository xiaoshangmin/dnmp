# DNMP (Docker + OpenResty + MySQL + PHP + Redis)

DNMP 是一个基于 Docker 的 PHP 开发和运行环境，包含 OpenResty、PHP、MySQL、Redis 和 Certbot，适合快速搭建本地及生产环境。

---

## 🚀 核心组件

- **OpenResty**: 基于 Nginx 的高性能 Web 平台，预配置了自动重载机制。
- **PHP**: 支持通过环境变量切换 PHP 镜像版本，并预装常用扩展（Swoole、Redis、PDO 等）。
- **MySQL**: 提供 MySQL 8.0 环境，并保留旧版本切换配置。
- **Redis**: 高性能 Key-Value 数据库。
- **Certbot**: 用于申请和自动续期 Let's Encrypt SSL 证书。

---

## 📂 目录结构

```text
├── .env                        # 环境变量配置文件
├── docker-compose.yml          # Docker Compose 核心配置文件
├── services/                   # 服务配置文件及 Dockerfile
│   ├── nginx/                  # OpenResty (Nginx) 配置及证书
│   ├── php7.4/                 # PHP 7.4 配置及扩展安装脚本
│   ├── php8.2/                 # PHP 8.2 配置
│   ├── mysql/                  # MySQL 8.0 配置
│   └── redis/                  # Redis 配置
├── data/                       # 持久化数据目录 (MySQL, Redis, Certbot 等)
├── logs/                       # 日志目录 (OpenResty, PHP 等)
├── www/                        # PHP 项目代码目录
└── docker-compose.sample.yml   # 配置文件示例
```

---

## ⚡ 快速开始

### 1. 克隆项目
```bash
git clone https://github.com/xiaoshangmin/dnmp.git
cd dnmp
```

### 2. 基础配置
```bash
cp .example.env .env                                    # 复制环境变量
cp docker-compose.sample.yml docker-compose.yml       # 复制 Compose 配置
```
> **提示**: 根据需要修改 `.env` 中的版本号和路径。

### 3. 启动环境
```bash
docker-compose up -d                                    # 守护进程模式运行
```

### 4. 访问测试
- **PHP**: `http://localhost` (代码位于 `./www/index.php`)
- **OpenResty**: `http://localhost` 或 `https://localhost`（配置域名和证书后使用）

---

## 🛠️ 服务管理

### PHP 扩展管理
项目预装了大量常用扩展。如果需要新增扩展，可以修改 `services/php[version]/Dockerfile` 并重新构建：
```bash
docker-compose build php
```

### 数据库连接
- **主机**: `mysql` (容器内部互联) 或 `127.0.0.1` (宿主机访问)
- **端口**: `3306`
- **默认帐号**: `root` / `root`

### 进入容器
```bash
docker exec -it php sh      # 进入 PHP 容器
docker exec -it mysql bash  # 进入 MySQL 容器
```

---

## 🔒 证书与自动化

### OpenResty 自动重载
OpenResty 容器会定期执行 `nginx -s reload`，无需重启容器即可加载更新后的证书。

### Certbot 证书申请
项目中包含 `certbot` 服务，可用于申请和续期免费证书。首次申请证书时执行一次：
```bash
# 示例命令
docker-compose exec certbot certbot certonly --webroot -w /var/www/certbot -d yourdomain.com
```
首次申请成功后，Certbot 容器会每 12 小时执行 `certbot renew`。证书续期成功后，OpenResty 会在下一次 reload 时自动加载新证书。

---

## 📖 常用命令

- **查看状态**: `docker-compose ps`
- **查看日志**: `docker-compose logs -f [service]`
- **停止所有服务**: `docker-compose stop`
- **重启特定服务**: `docker-compose restart openresty`
- **更新镜像并重新启动**: `docker-compose pull && docker-compose up -d`
- **查看 Certbot 日志**: `docker-compose logs -f certbot`

---

## 💡 其他说明

- **国内镜像**: 如果下载镜像缓慢，请配置 Docker 镜像加速器。
- **域名访问**: 如果在容器内访问 Nginx 域名，需在 `docker-compose.yml` 中配置 `extra_hosts` 或修改容器内的 `/etc/hosts`。

---

## 🔗 其他作品
- **[QuoteMaker](https://quotemaker.cc)**
- **[Batch Image Compression](https://image.wowyou.cc)**
- **[Next Bconvert](https://nextbconvert.com)**
