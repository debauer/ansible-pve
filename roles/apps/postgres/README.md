# postgres

Installs PostgreSQL on Debian 13 (Trixie) or newer and manages:
- roles/users
- databases
- pg_hba rules

## Variables

- `postgres_users`: list of users with passwords
- `postgres_databases`: list of databases with owners
- `postgres_hba_rules`: list of access rules
- `postgres_listen_addresses`, `postgres_port`

Defaults: `roles/apps/postgres/defaults/main.yml`

## Example

```yaml
- name: Postgres VM
  hosts: pg.rackmonkey.de
  become: true
  roles:
    - role: roles/apps/postgres
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
