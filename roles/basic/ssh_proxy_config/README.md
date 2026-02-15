# ssh_proxy_config

Generates a local SSH config file for hosts that require a proxy command.

## Behavior

- ensures local directory `~/.ssh/config.d` exists
- renders `~/.ssh/config.d/rackmonkey`
- includes only hosts where `ansible_ssh_common_args` is defined
- writes `HostKeyAlias` and `CheckHostIP no` to keep host key checks tied to the target host

## Important Variables

- `rackmonkey_ssh_config_dir` (default: `~/.ssh/config.d`)
- `rackmonkey_ssh_config_file` (default: `~/.ssh/config.d/rackmonkey`)

Defaults: `roles/basic/ssh_proxy_config/defaults/main.yml`

## Example

```yaml
- name: Build local SSH proxy config
  hosts: localhost
  connection: local
  gather_facts: false
  tasks:
    - ansible.builtin.include_role:
        name: roles/basic/ssh_proxy_config
```
