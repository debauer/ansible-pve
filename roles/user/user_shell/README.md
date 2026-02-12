# user_shell Role

Deploys shell defaults for root and users, and installs `atuin`.

## What it does

- Installs `zsh` and `cargo`.
- Copies shell config files to `/root` and `/etc/skel`.
- Installs `atuin` if it is not present.
- Applies shell config files to all directories in `/home`.
- Imports root shell history into `atuin` once and creates a marker file.

## Variables

Defaults live in `roles/user/user_shell/defaults/main.yml`.

- `user_shell_copy_files_to_root` (list of dicts): Files copied to `/root`.
- `user_shell_copy_files_to_user` (list of dicts): Files copied to `/etc/skel` and `/home/<user>`.

Each item has:

- `file` (string): Source file under `roles/user/user_shell/files/`.
- `target` (string): Target path relative to destination home.

## Notes

- Existing users are discovered from `ls -1 /home`.
- This role does not create users; run `roles/user/user_add` first.
