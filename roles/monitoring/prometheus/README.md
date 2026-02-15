# prometheus

Installiert Prometheus als Binary von GitHub Releases.

Die Rolle vergleicht bei jedem Lauf:
- installierte Version auf dem Zielhost (`prometheus --version`)
- Zielversion (`latest` via GitHub API oder explizite Version)

Nur wenn sich die Version unterscheidet, wird das Release-Archiv heruntergeladen und installiert.

## Wichtige Variablen

- `prometheus_version`: `latest` (Default) oder z. B. `2.55.1`
- `prometheus_web_listen_address`: Default `0.0.0.0:9090`
- `prometheus_storage_retention_time`: Default `15d`
- `prometheus_extra_args`: zusätzliche CLI-Args als Liste

## Beispiel

```yaml
- name: Install Prometheus
  hosts: monitoring
  become: true
  roles:
    - role: roles/prometheus
```
