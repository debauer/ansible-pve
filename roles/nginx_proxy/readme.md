# Ansible Role: nginx_proxy

Role to deploy nginx as package


## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

## vars
```yaml
nginx_proxy_dns_resolver: optional - ip of reachable dns server
nginx_proxy:
    target_fqdn: domain.tld
    src_address: ip or hostname
    src_port: port
    proxy_ssl: if defined -> src_address uses https
    client_max_body_size: optional - default 10M
```