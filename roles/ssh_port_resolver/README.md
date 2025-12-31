# Ansible Role: ssh_port_resolver

This role determines `ansible_port` based on host variables.

## Role Variables

```yaml
ssh_port_default: 22
ssh_offset: 30000
```

If any entry in `network_interfaces_interfaces` has a truthy `nat_subnet` value, the role sets `ansible_port` to `proxmox_vmid + ssh_offset`. Otherwise it uses `ssh_port_default`.

## Notes

- The tasks run on `localhost` with `delegate_facts: true` so the port is set before remote connections.
