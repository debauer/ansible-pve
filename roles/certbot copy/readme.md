# Ansible Role: cerbot

## Requirements

`geerlingguy.cerbot`

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

```yaml
certbot_install_method: pip
certbot_certs:
```

### ROUTE53
```yaml
certbot_route53_install_plugin: true
certbot_route53_access_key_id:
certbot_route53_secret_access_key:
```

### INWX

```yaml
certbot_inwx_install_plugin: true
certbot_inwx_username:
certbot_inwx_password:
```