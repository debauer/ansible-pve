# Ansible Role: network_config_proxmox

## Requirements

This role requires the `ansible.builtin` collection which is included with Ansible.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

```yaml
network_config_file: /etc/network/interfaces
network_config_primary_interface: enp0s31f6
network_config_primary_ip: 138.201.133.113
network_config_primary_netmask: 255.255.255.192
network_config_primary_gateway: 138.201.133.126
network_config_dns_servers: ["1.1.1.1", "1.0.0.1"]
network_config_bridges:
  - name: vmbr0
    ip: 10.67.0.2
    netmask: 255.255.255.0
    ports: enp0s31f6
    additional_ips:
      - 138.201.133.94
      - 138.201.133.98
      - 138.201.133.99
  - name: vmbr1
    ip: 10.68.0.2
    netmask: 255.255.255.0
    ports: none
    additional_ips: []
```

## Example Playbook

```yaml
- hosts: proxmox_servers
  become: yes
  roles:
    - network_config_proxmox
```

## License

MIT