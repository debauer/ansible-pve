# ansible-pve

Ansible playbooks and roles for a small homelab setup (Proxmox host, LXC guests,
OpenWrt firewall, and supporting services like DNS and nginx).

## Requirements

- Ansible
- Collections and roles in `requirements.yml`

Install dependencies:

```bash
ansible-galaxy install -r requirements.yml -p roles --ignore-errors
```

## Inventory layout

- `inventory/hosts.yml` defines host groups (`pve`, `lxc`, `openwrt`, `meta`).
- `inventory/host_vars/` contains per-host settings.
- `inventory/group_vars/all.yml` provides shared defaults.

## Playbooks

- `playbooks/base.yml`: Baseline setup for non-OpenWrt hosts (packages, users,
  network config, updates).
- `playbooks/pve.yml`: Proxmox host network setup.
- `playbooks/fw.yml`: OpenWrt config render/deploy via the `wrt` role.
- `playbooks/dns.yml`: INWX DNS sync (runs on localhost with secrets).

Example run:

```bash
ansible-playbook -i inventory/hosts.yml playbooks/base.yml
```

## Roles (high level)

- `basic_motd`: MOTD + hostname setup.
- `update`: System updates.
- `packages`: Common packages.
- `network_interfaces`: Interface configuration for non-OpenWrt hosts.
- `ssh_port_resolver`: Computes SSH port when NAT is used.
- `user/*`: User management and shell config.
- `wrt`: OpenWrt configuration templates.
- `dns_inwx`: Sync DNS records in INWX.
- `nginx_proxy`: Reverse proxy (package or docker).
- `certbot`: TLS certificates (via geerlingguy.certbot).

## Secrets

`playbooks/dns.yml` expects `vars/secrets.yml` to provide INWX credentials
(`dns_inwx_user`, `dns_inwx_password`).

## Notes

- OpenWrt configs are rendered locally and copied to `/etc/config/` on the
  firewall host. Check `roles/wrt/tasks/main.yml` to see which files are enabled.
