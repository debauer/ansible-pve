# apt

Configures APT basics on Debian hosts.

## What This Role Does

- installs APT prerequisites (`apt-transport-https`, `gpg`, `gpg-agent`)
- deploys APT config snippets:
  - `/etc/apt/apt.conf.d/05recommends`
  - `/etc/apt/apt.conf.d/20auto-upgrades`
  - `/etc/apt/listchanges.conf`
- enables Debian backports repository
- installs APT helper tools (`apt-listchanges`, `debian-goodies`, `unattended-upgrades`, ...)

## Example Playbook

```yaml
- name: APT baseline
  hosts: all
  become: true
  roles:
    - role: roles/basic/apt
```
