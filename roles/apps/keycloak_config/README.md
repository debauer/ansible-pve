# keycloak_config

Manages Keycloak realms and clients declaratively.

You can define clients centrally in this role variables, or directly in application host inventories (for example `inventory/host_vars/git.rackmonkey.de.yml`) using `keycloak_clients`.

## Requirements

- `community.general` collection (already listed in `requirements.yml`)
- reachable Keycloak admin API

## Important Variables

- `keycloak_manage_auth_keycloak_url`: Keycloak base URL (for example `https://sso.example.com`)
- `keycloak_manage_auth_realm`: admin auth realm (default: `master`)
- `keycloak_manage_auth_username`
- `keycloak_manage_auth_password`
- `keycloak_manage_validate_certs`
- `keycloak_manage_realms`: realm/client definitions
- `keycloak_manage_collect_clients_from_hosts`: collect clients from hostvars (default: `true`)
- `keycloak_manage_collect_from_group`: source group for hostvar collection (default: `all`)
- `keycloak_manage_host_client_var`: hostvar name that contains client definitions (default: `keycloak_clients`)

## App-Local Client Definitions

Example in `inventory/host_vars/git.rackmonkey.de.yml`:

```yaml
keycloak_clients:
  - realm: rackmonkey
    client_id: gitlab
    name: GitLab
    state: present
    enabled: true
    public_client: false
    secret: "{{ vault_keycloak_gitlab_client_secret }}"
    redirect_uris:
      - "https://git.rackmonkey.de/users/auth/openid_connect/callback"
    web_origins:
      - "https://git.rackmonkey.de"
```

## Example

```yaml
keycloak_manage_auth_keycloak_url: "https://sso.rackmonkey.de"
keycloak_manage_auth_username: admin
keycloak_manage_auth_password: "{{ vault_keycloak_admin_password }}"

keycloak_manage_realms:
  - name: rackmonkey
    enabled: true
    state: present
```

Optional centrally defined clients (same run, same role):

```yaml
keycloak_manage_realms:
  - name: rackmonkey
    enabled: true
    state: present
    clients:
      - client_id: grafana
        name: Grafana
        state: present
        enabled: true
        public_client: false
        secret: "{{ vault_keycloak_grafana_client_secret }}"
        redirect_uris:
          - "https://grafana.rackmonkey.de/*"
        web_origins:
          - "https://grafana.rackmonkey.de"
```

## Example Playbook

```yaml
- name: Configure Keycloak realms/clients
  hosts: sso.rackmonkey.de
  become: true
  roles:
    - role: roles/apps/keycloak_config
```
