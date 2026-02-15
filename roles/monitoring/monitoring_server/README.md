# monitoring_server

Installs and configures a full monitoring stack on Debian hosts:
- Prometheus
- Alertmanager
- Loki
- Grafana
- HAProxy

## What This Role Does

- adds the Grafana APT repository
- installs required packages (`haproxy`, `prometheus`, `prometheus-alertmanager`, `loki`, `grafana`)
- creates Prometheus rule directories and deploys alert rules
- renders:
  - `/etc/prometheus/prometheus.yml`
  - `/etc/prometheus/alertmanager-config.yml`
  - `/etc/loki/config.yml`
  - `/etc/haproxy/haproxy.cfg`
- configures Prometheus and Alertmanager runtime args in `/etc/default/*`
- creates Loki storage directories under `/loki`
- reloads/restarts services via handlers when configs change

## Important Variables

From defaults:
- `monitoring_server_loki_all`
- `monitoring_server_alertmanager_all`
- `monitoring_server_prometheus_all`

From inventory (used by templates/config):
- `haproxy_services`

## Example Playbook

```yaml
- name: Monitoring Server
  hosts: monitoring.rackmonkey.de
  become: true
  roles:
    - role: roles/monitoring/monitoring_server
```
