# gitlab

Installiert und konfiguriert GitLab Omnibus auf Debian 13 (Trixie) oder neuer.

## Rolle nutzt

- GitLab APT-Repository inkl. GPG-Key
- Installation von `gitlab-ce` oder `gitlab-ee`
- Verwaltung von `/etc/gitlab/gitlab.rb`
- `gitlab-ctl reconfigure` bei Konfigurationsaenderung

## Wichtige Variablen

- `gitlab_domain`: DNS-Name fuer GitLab
- `gitlab_external_url`: Vollstaendige URL (Standard: `https://{{ gitlab_domain }}`)
- `gitlab_edition`: `ce` oder `ee`
- `gitlab_registry_enable`: Container Registry aktivieren
- `gitlab_smtp_enable`: SMTP-Konfiguration aktivieren

Siehe alle Defaults in `defaults/main.yml`.

## Beispiel

```yaml
- name: GitLab
  hosts: git.rackmonkey.de
  become: true
  roles:
    - role: roles/gitlab
      vars:
        gitlab_domain: git.rackmonkey.de
        gitlab_registry_enable: true
        gitlab_registry_domain: registry.rackmonkey.de
```
