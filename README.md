# ansible-pve

Ansible playbooks and roles for a Proxmox-based dedicated server setup in a datacenter.

## Setup

### 1. Install Python dependencies with `uv`

```bash
uv sync
```

Alternative: use `direnv` to automatically load the project environment when entering the repository.

### 2. Install Ansible Galaxy requirements

```bash
uv run ansible-galaxy install -r requirements.yml -p roles --ignore-errors
```

## Inventory Layout

- `inventory/hosts.yml`: static inventory groups.
- `inventory/pve.proxmox.yml`: dynamic Proxmox inventory plugin config.
- `inventory/host_vars/`: per-host settings.
- `inventory/group_vars/all/vars.yml`: shared defaults.
- `inventory/group_vars/all/vars.vault.yml`: encrypted/shared secrets.

## Main Playbooks

- `playbooks/base.yml`: baseline host setup (basic, user, network, and app roles).
- `playbooks/pve.yml`: Proxmox host configuration.
- `playbooks/proxy.yml`: proxy stack deployment.
- `playbooks/monitoring.yaml`: monitoring stack deployment.
- `playbooks/dns.yml`: INWX DNS synchronization.
- `playbooks/ssh_config.yml`: generates local SSH config at `~/.ssh/config.d/rackmonkey`.

Example:

```bash
uv run ansible-playbook playbooks/base.yml
```

## Role Groups

- `roles/basic/*`: base OS setup (`apt`, `packages`, `update`, `fail2ban`, SSH proxy handling).
- `roles/user/*`: user accounts, hardening, shell, SSH keys.
- `roles/network/*`: interfaces, DNS (INWX), HAProxy.
- `roles/apps/*`: application roles (`postgres`, `keycloak`, `gitlab`).
- `roles/monitoring/*`: monitoring server/client components (`prometheus`, `loki`, etc.).

## Testing

The `ssh_proxy_config` role has Molecule tests:

```bash
cd roles/basic/ssh_proxy_config
uv run molecule test -s default
```

## Notes

- SSH proxy resolution is executed through `playbooks/include/ssh.yml` and tagged `always`.
