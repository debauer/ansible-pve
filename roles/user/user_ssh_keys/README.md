# user_ssh_keys Role

Manages `authorized_keys` for configured users.

## What it does

- Merges global and host-specific user definitions.
- Creates `~/.ssh` for each target user.
- Adds all configured `authorized_keys` entries via `ansible.posix.authorized_key`.

## Variables

Defaults live in `roles/user/user_ssh_keys/defaults/main.yml`.

- `users` (list of dicts): Global user definitions.
- `users_host` (list of dicts): Host-specific user definitions.

User fields used by this role:

- `name` (string): Username.
- `ssh` (bool): Enables SSH key setup for that user.
- `authorized_keys` (list of strings): Public keys to install.

## Merge behavior

- Effective user list = `users` + `users_host`.
- Merge key is `name`.
- If the same user exists in both lists, `users_host` overrides `users`.

## Example host vars

```yaml
# inventory/host_vars/git.rackmonkey.de.yml
users_host:
  - name: gitadmin
    ssh: true
    authorized_keys:
      - ssh-ed25519 AAAA... user@example
```

## Notes

- This role assumes users already exist (for example via `roles/user/user_add`).
