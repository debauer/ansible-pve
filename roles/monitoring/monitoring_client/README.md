# monitoring_client

Installs and configures Grafana Alloy on monitored client hosts.

## What This Role Does

- adds the Grafana APT repository (Debian)
- installs `alloy` and `prometheus-node-exporter-collectors`
- creates `/etc/alloy`
- deploys Alloy config files:
  - `/etc/alloy/config.alloy`
  - optional `/etc/alloy/tailscale.alloy`
- adjusts `/etc/default/alloy` so Alloy reads config from `/etc/alloy/`
- enables and starts the Alloy service
- reloads/restarts Alloy when config changes

## Important Variables

- `headscale_install`: if `true`, deploys `tailscale.alloy`
- additional scrape/forwarding values are expected from inventory and consumed by the templates

## Example Playbook

```yaml
- name: Monitoring Client
  hosts: all
  become: true
  roles:
    - role: roles/monitoring/monitoring_client
```
