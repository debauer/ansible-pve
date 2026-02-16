# keycloak

Installs Keycloak on Debian 13 (Trixie) or newer.

This role expects an external PostgreSQL instance (separate VM). No local PostgreSQL installation is performed on the Keycloak host.

## Behavior

- Checks the installed Keycloak version with `kc.sh --version`
- Installs only when Keycloak is not installed yet
- Performs upgrades only when `keycloak_upgrade: true`
- Uses only DB credentials and DB host for the connection

## Important Variables

- `keycloak_version`: `latest` (default) or a fixed version (for example `26.0.7`)
- `keycloak_upgrade`: `false` (default); set to `true` to force an upgrade to `keycloak_version`
- `keycloak_hostname`: external hostname
- `keycloak_db_host`: hostname/IP of the separate PostgreSQL VM
- `keycloak_db_user`, `keycloak_db_password`, `keycloak_db_name`
- `keycloak_initial_admin_password`: bootstrap admin password

All defaults: `roles/apps/keycloak/defaults/main.yml`
