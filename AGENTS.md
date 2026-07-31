# Repository Guidelines

## Project Structure & Module Organization

This repository defines a Docker-based PHP runtime environment. The root
Compose files are `docker-compose.yml` (active configuration) and
`docker-compose.sample.yml` (bootstrap template). Service-specific Dockerfiles
and configuration live under `services/`:

- `services/nginx/`: OpenResty configuration, virtual hosts, and SSL files.
- `services/php*/`: PHP images, PHP-FPM settings, extensions, and `php.ini`.
- `services/mysql*` and `services/redis/`: database and cache configuration.
- `www/`: mounted PHP applications and frontend assets.
- `data/` and `logs/`: persistent runtime data and service logs; avoid adding
  generated contents to commits.

## Build, Test, and Development Commands

```bash
cp .example.env .env
cp docker-compose.sample.yml docker-compose.yml
docker-compose config                 # Validate interpolated Compose config
docker-compose up -d                  # Start the environment
docker-compose build php              # Rebuild the PHP image after Dockerfile changes
docker-compose ps                     # Check service status
docker-compose logs -f <service>      # Follow service logs
docker-compose exec certbot certbot certonly --webroot -w /var/www/certbot -d example.com
```

There is no repository-level test runner or coverage requirement. For changes
inside an application under `www/`, run that application's own checks when
available. At minimum, validate Compose syntax and inspect relevant container
logs after configuration changes.

## Coding Style & Naming Conventions

Use two-space indentation in YAML and keep Compose service names lowercase
(`openresty`, `mysql`, `redis`). Use shell syntax compatible with `/bin/sh` in
container commands and scripts. Preserve the existing formatting and comments
in service configuration files; make focused edits rather than reformatting
whole files. No repository-wide formatter or linter is configured.

## Security & Configuration Tips

Keep secrets and machine-specific paths in `.env`; never commit credentials,
private keys, or generated certificates. Treat `services/nginx/cert/` and
runtime data as deployment state. When changing ports, mounts, or SSL settings,
document the operational impact and verify the resulting Compose configuration.

## Commit & Pull Request Guidelines

Existing history is terse (`update`, `u`), but new commits should use a clear,
imperative subject, for example `更新 Certbot 续期配置` or `Add PHP 8.2 image
settings`. Keep commits focused. Pull requests should explain the affected
services, list validation commands and results, call out configuration or
security changes, and include screenshots only when a web-facing change needs
visual verification.
