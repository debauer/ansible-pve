# Molecule tests for ssh_proxy_overwrite

Run:

```bash
cd roles/basic/ssh_proxy_overwrite
molecule test -s default
```

What is validated:
- internal-only Proxmox guests get `ansible_host` override to proxy host
- internal-only Proxmox guests get `ansible_ssh_common_args` with ProxyCommand
- public Proxmox guests do not get proxy SSH args
- non-Proxmox hosts remain unchanged
