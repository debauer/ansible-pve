# gitlab

Installs and configures GitLab Omnibus on Debian 13 (Trixie) or newer.

## What This Role Uses

- GitLab APT repository including GPG key
- installation of `gitlab-ce` or `gitlab-ee`
- management of `/etc/gitlab/gitlab.rb`
- `gitlab-ctl reconfigure` when configuration changes

## Important Variables

- `gitlab_domain`: DNS name for GitLab
- `gitlab_external_url`: full URL (default: `https://{{ gitlab_domain }}`)
- `gitlab_edition`: `ce` or `ee`
- `gitlab_registry_enable`: enable container registry
- `gitlab_smtp_enable`: enable SMTP configuration
- `gitlab_oauth_keycloak_enable`: enable Keycloak via OIDC/Omniauth
- `gitlab_oauth_keycloak_issuer`: Keycloak issuer URL, e.g. `https://sso.example.com/realms/main`
- `gitlab_oauth_keycloak_client_id`: OIDC client ID
- `gitlab_oauth_keycloak_client_secret`: OIDC client secret

See all defaults in `roles/apps/gitlab/defaults/main.yml`.

## Example

```yaml
- name: GitLab
  hosts: git.rackmonkey.de
  become: true
  roles:
    - role: roles/apps/gitlab
      vars:
        gitlab_domain: git.rackmonkey.de
        gitlab_registry_enable: true
        gitlab_registry_domain: registry.rackmonkey.de
        gitlab_oauth_keycloak_enable: true
        gitlab_oauth_keycloak_issuer: https://sso.rackmonkey.de/realms/rackmonkey
        gitlab_oauth_keycloak_client_id: gitlab
        gitlab_oauth_keycloak_client_secret: supersecret
```
