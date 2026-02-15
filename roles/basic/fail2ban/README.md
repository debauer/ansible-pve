# fail2ban

Installs and configures Fail2Ban.

## Behavior

- controlled by `fail2ban_enable` (default: `false`)
- installs `fail2ban` package when enabled
- ensures service is enabled and running
- renders `/etc/fail2ban/jail.local` from template
- restarts Fail2Ban when jail config changes

## Important Variables

- `fail2ban_enable`
- `fail2ban_jails`

Defaults: `roles/basic/fail2ban/defaults/main.yml`

## Example

```yaml
- name: Fail2Ban
  hosts: all
  become: true
  roles:
    - role: roles/basic/fail2ban
      vars:
        fail2ban_enable: true
```
