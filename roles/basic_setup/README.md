# basic_setup Role

Sets up a customized MOTD on Debian hosts and ensures a clean baseline for login
messages.

## What it does

- Installs `figlet` for ASCII banners.
- Rebuilds `/etc/update-motd.d/` from role templates.
- Clears `/etc/motd` and renders new scripts.
- Installs custom figlet fonts into `/root/font/`.
- Updates MOTD via `run-parts` on Debian.
- Sets the hostname based on `inventory_hostname`.

## Templates

Located in `roles/basic_setup/templates/`:

- `20-header`
- `30-sysinfo`
- `40-footer`
- `doom.flf`
- `poison.flf`

## Notes

- The role removes any existing files in `/etc/update-motd.d/` before copying new
  templates. If you have custom scripts there, they will be deleted.
