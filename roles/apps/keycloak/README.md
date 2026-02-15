# keycloak

Installiert Keycloak auf Debian 13 (Trixie) oder neuer.

Die Rolle erwartet eine externe PostgreSQL-Instanz (separate VM). Auf dem Keycloak-Host wird keine lokale PostgreSQL-Installation vorgenommen.

## Verhalten

- Prueft installierte Keycloak-Version mit `kc.sh --version`
- Installiert/updated nur wenn `keycloak_version` noch nicht installiert ist
- Nutzt nur DB-Credentials und DB-Host fuer die Verbindung

## Wichtige Variablen

- `keycloak_version`: Keycloak Version (z. B. `26.0.7`)
- `keycloak_hostname`: externer Hostname
- `keycloak_db_host`: Hostname/IP der separaten PostgreSQL-VM
- `keycloak_db_user`, `keycloak_db_password`, `keycloak_db_name`
- `keycloak_admin_password`: Bootstrap Admin Passwort

Alle Defaults: `roles/keycloak/defaults/main.yml`
