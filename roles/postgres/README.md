# postgres

Installiert PostgreSQL auf Debian 13 (Trixie) oder neuer und verwaltet generisch:
- Rollen/Benutzer
- Datenbanken
- pg_hba Regeln

## Variablen

- `postgres_users`: Liste von Usern mit Passwort
- `postgres_databases`: Liste von Datenbanken mit Owner
- `postgres_hba_rules`: Liste von Access-Regeln
- `postgres_listen_addresses`, `postgres_port`

Defaults: `roles/postgres/defaults/main.yml`

## Beispiel

```yaml
- name: Postgres VM
  hosts: pg.rackmonkey.de
  become: true
  roles:
    - role: roles/postgres
      vars:
        postgres_users:
          - name: keycloak
            password: "dummy-keycloak-db-password"
        postgres_databases:
          - name: keycloak
            owner: keycloak
        postgres_hba_rules:
          - type: host
            database: keycloak
            user: keycloak
            address: 10.63.13.0/24
            method: scram-sha-256
```
