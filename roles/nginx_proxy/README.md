# nginx_proxy Role

Deploys nginx as a reverse proxy, either as a system package or via Docker, and
manages vhost configuration with optional TLS via certbot.

## What it does

- Installs nginx as a package or starts it via docker-compose.
- Renders `nginx.conf` and per-vhost configs in `sites-enabled/`.
- Optionally creates htpasswd files per vhost.
- Runs the configured certbot role to obtain certificates.
- Switches vhost configs to HTTPS once certs exist.

## Variables

Defaults live in `roles/nginx_proxy/defaults/main.yml`.

- `nginx_proxy_deployment` (string): `package`, `docker`, or `no` to disable.
- `nginx_proxy_docker_deployment_path` (string): Target path for docker deploys.
- `nginx_proxy_docker_user` (string): Owner for docker files.
- `nginx_proxy_docker_filemode` (int/string): File mode for docker files.
- `nginx_proxy_docker_role` (string): Role name used to install Docker.
- `nginx_proxy_certbot_role` (string): Role name used to obtain certs.
- `nginx_proxy_dns_resolver` (string): DNS resolver used in `nginx.conf`.
- `nginx_proxy` (list of dicts): Proxy vhost definitions.
  - `target_fqdn` (string): Server name and cert name.
  - `src_address` (string): Upstream address.
  - `src_port` (int/string): Upstream port.
  - `proxy_ssl` (bool): If true, proxy to upstream via HTTPS.
  - `htpasswd` (string, optional): When defined, enables basic auth.

## Example host vars

```yaml
# inventory/host_vars/proxy.rackmonkey.de.yml
nginx_proxy_deployment: "package"
nginx_proxy_dns_resolver: 192.168.1.2
nginx_proxy:
  - target_fqdn: fw.rackmonkey.de
    src_address: 10.63.10.1
    src_port: 80
    proxy_ssl: false
  - target_fqdn: git.rackmonkey.de
    src_address: 10.63.10.3
    src_port: 80
    proxy_ssl: false
```

## Notes

- If the certificate for a vhost does not exist yet, an HTTP-only config is
  rendered. After certs are issued, the role re-renders HTTPS configs.
