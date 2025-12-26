# Ansible Role: network_config_opnsense

## Requirements

This role requires the `community.general` collection to be installed.

```bash
ansible-galaxy collection install community.general
```

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

```yaml
network_config_opnsense_lan_ip: 10.68.0.1
network_config_opnsense_lan_netmask: 24
network_config_opnsense_wan_ip: 138.201.133.113
network_config_opnsense_wan_netmask: 26
network_config_opnsense_additional_ips:
  - 138.201.133.94
  - 138.201.133.98
  - 138.201.133.99
```

## Example Playbook

```yaml
- hosts: opnsense_servers
  become: yes
  roles:
    - network_config_opnsense
```

## License

MIT