# keycloak

Installiert Keycloak auf Debian 13 (Trixie) oder neuer.

Die Rolle erwartet eine externe PostgreSQL-Instanz (separate VM). Auf dem Keycloak-Host wird keine lokale PostgreSQL-Installation vorgenommen.

## Verhalten

- Prueft installierte Keycloak-Version mit `kc.sh --version`
- Installiert nur, wenn Keycloak noch nicht installiert ist
- Upgrades erfolgen nur bei `keycloak_upgrade: true`
- Nutzt nur DB-Credentials und DB-Host fuer die Verbindung

## Wichtige Variablen

- `keycloak_version`: `latest` (Default) oder feste Version (z. B. `26.0.7`)
- `keycloak_upgrade`: `false` (Default), auf `true` setzen um ein Upgrade auf `keycloak_version` zu erzwingen
- `keycloak_hostname`: externer Hostname
- `keycloak_db_host`: Hostname/IP der separaten PostgreSQL-VM
- `keycloak_db_user`, `keycloak_db_password`, `keycloak_db_name`
- `keycloak_admin_password`: Bootstrap Admin Passwort

Alle Defaults: `roles/apps/keycloak/defaults/main.yml`
