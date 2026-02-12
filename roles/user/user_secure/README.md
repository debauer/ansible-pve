# user_secure Role

Applies SSH and sudo hardening defaults for user access.

## What it does

- Disables SSH password authentication in `/etc/ssh/sshd_config`.
- Restarts SSH service after config changes (`ssh` on Debian, `sshd` on Archlinux).
- Optionally creates `/etc/sudoers.d/nopasswd` to allow passwordless sudo.

## Variables

Defaults live in `roles/user/user_secure/defaults/main.yml`.

- `user_sudo_without_password` (bool): If `true`, deploys passwordless sudo policy.

## Notes

- Password authentication is disabled unconditionally for Debian and Archlinux hosts.
