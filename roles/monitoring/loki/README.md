# loki

Deploys Loki via Docker Compose on a target host.

## What This Role Does

- creates `/opt/loki`
- renders:
  - `/opt/loki/docker-compose.yml`
  - `/opt/loki/loki-config.yaml`
- creates `/opt/loki/loki-data/`
- ensures `docker-compose@loki` is enabled and started

## Requirements

- Docker and docker-compose systemd integration must already be available
- handler `Restart loki` should exist in the calling play/role chain if config changes should trigger restart

## Example Playbook

```yaml
- name: Loki
  hosts: loki
  become: true
  roles:
    - role: roles/monitoring/loki
```
