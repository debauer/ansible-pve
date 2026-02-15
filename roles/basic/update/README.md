# update

Runs full system package updates.

## Behavior

- Archlinux: `pacman` full upgrade
- Debian: `apt` upgrade using `name: "*"` and `state: latest`

## Example

```yaml
- name: System update
  hosts: all
  become: true
  roles:
    - role: roles/basic/update
```
