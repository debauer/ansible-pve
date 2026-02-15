# prometheus

Installs Prometheus as a binary from GitHub Releases.

## Behavior

On every run the role compares:
- installed version on the target host (`prometheus --version`)
- target version (`latest` via GitHub API or an explicit version)

It downloads and installs a release archive only when versions differ.

## Important Variables

- `prometheus_version`: `latest` (default) or explicit version (for example `2.55.1`)
- `prometheus_web_listen_address`: default `0.0.0.0:9090`
- `prometheus_storage_retention_time`: default `15d`
- `prometheus_extra_args`: additional CLI args list

Defaults: `roles/monitoring/prometheus/defaults/main.yml`

## Example

```yaml
- name: Install Prometheus
  hosts: monitoring
  become: true
  roles:
    - role: roles/monitoring/prometheus
```
