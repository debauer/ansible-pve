# dns_inwx Role

Syncs DNS records in INWX with the desired state defined in inventory host vars.

## What it does

- Fetches current DNS zones from INWX.
- Builds desired records from host vars (`dns_inwx` and `dns_inwx_cname`).
- Deletes records that are not desired.
- Creates missing records.

## Requirements

- INWX credentials (`dns_inwx_user`, `dns_inwx_password`).
- `inwx.collection` Ansible collection.
- Custom module `inwx_dns_zone` in `roles/dns_inwx/library/`.

## Variables

Defaults live in `roles/dns_inwx/defaults/main.yml`.

- `dns_inwx_managed_domains` (list): Domains to manage in INWX.
- `dns_inwx_ttl_default` (int): Default TTL for new records.
- `dns_inwx_zone_ignore_subdomains` (list): Records to ignore when diffing.
- `dns_inwx_user` (string): INWX username for API auth.
- `dns_inwx_password` (string): INWX password for API auth.

Host vars used by the role:

- `dns_inwx` (list of dicts): Direct record definitions.
- `dns_inwx_cname` (list of dicts): CNAME definitions with multiple records.

## Example host vars

```yaml
# inventory/host_vars/fw.rackmonkey.de.yml
dns_inwx:
  - domain: rackmonkey.de
    type: A
    record: fw
    value: 138.201.133.94

# inventory/host_vars/proxy.rackmonkey.de.yml
dns_inwx_cname:
  - domain: rackmonkey.de
    type: CNAME
    records:
      - proxy
    value: fw.rackmonkey.de
```

## Notes

- The module reads ignored subdomains from the `inwx` host vars (e.g.
  `inventory/host_vars/inwx.yml`) via `dns_inwx_zone_ignore_subdomains`.
