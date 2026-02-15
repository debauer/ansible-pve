# haproxy

Installs and configures HAProxy on Debian-based hosts.

This role:
- installs `haproxy`, `lego`, and `python3-cryptography`
- aggregates `haproxy_services` from all inventory hosts
- renders `/etc/haproxy/haproxy.cfg`
- creates a fallback self-signed certificate
- creates `lego-<domain>.service` and `lego-<domain>.timer` per service
- starts and enables HAProxy and all lego timers

## Important Variables

- `haproxy_services`: list of backends (typically defined in `host_vars`)
- `haproxy_cert_email`: email for Let's Encrypt (default: `admin@example.com`)
- `haproxy_lego_path`: working directory for lego (default: `/etc/lego`)
- `haproxy_cert_path`: destination path for PEM files (default: `/etc/haproxy/certs`)
- `haproxy_lego_http_port`: local HTTP challenge port (default: `8888`)
- `haproxy_stats_enable`: enable/disable HAProxy stats
- `haproxy_stats_admin_user`: optional stats user
- `haproxy_stats_admin_user_password`: optional stats password

## Example `haproxy_services`

```yaml
haproxy_services:
  - name: monitoring.rackmonkey.de
    IP: 10.63.13.3
    Port: 8000
  - name: sso.rackmonkey.de
    IP: 10.63.13.10
    Port: 8080
```

## Example Playbook

```yaml
- name: Proxy
  hosts: proxy.rackmonkey.de
  become: true
  roles:
    - role: roles/network/haproxy
```
