# user_add Role

Creates and manages local users and their primary groups.

## What it does

- Creates default groups from `user_default_groups`.
- Creates user-specific groups from each user entry.
- Creates/updates users with home directory, shell, and supplementary groups.
- Merges global and host-specific user definitions.

## Variables

Defaults live in `roles/user/user_add/defaults/main.yml`.

- `users` (list of dicts): Global user definitions (typically from `group_vars`).
- `users_host` (list of dicts): Host-specific user definitions (typically from `host_vars`).
- `user_default_groups` (list): Groups that should exist on all hosts.

User fields used by this role:

- `name` (string): Username.
- `groups` (list): Supplementary groups.
- `shell` (string, optional): Login shell, defaults to `/bin/bash`.

## Merge behavior

- Effective user list = `users` + `users_host`.
- Merge key is `name`.
- If the same user exists in both lists, `users_host` overrides `users`.

## Example host vars

```yaml
# inventory/host_vars/git.rackmonkey.de.yml
users_host:
  - name: gitadmin
    shell: /bin/zsh
    groups:
      - wheel
  - name: debauer
    shell: /bin/bash
```
