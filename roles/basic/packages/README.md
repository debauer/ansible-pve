# packages

Installs baseline packages for Linux hosts.

## Behavior

- supports Debian and Archlinux families
- updates package repositories
- installs `packages_common`
- installs `packages_additional`

## Important Variables

- `packages_common`
- `packages_additional`

Defaults: `roles/basic/packages/defaults/main.yml`

## Example

```yaml
- name: Base packages
  hosts: all
  become: true
  roles:
    - role: roles/basic/packages
      vars:
        packages_additional:
          - jq
          - tcpdump
```
