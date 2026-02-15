# basic_ssh_port

Resolves `ansible_host` and `ansible_port` for Proxmox guests.

Rules:

- If a guest is attached to any network marked as public in `pve_bridge`, SSH stays on direct host/port (`ansible_port`, default `22`).
- If a guest is only attached to internal networks, SSH is routed via proxy host and port `10000 + <last IPv4 octet>`.

The role is intended to run in a local resolver play (`connection: local`) before remote plays.

## Variables

- `basic_ssh_port_base_port` (default: `10000`)
- `basic_ssh_port_default_port` (default: `22`)
- `basic_ssh_port_proxy_host_default` (default: `proxy.rackmonkey.de`)
- `basic_ssh_port_debug` (default: `false`) enables debug output for decision inputs and resolved SSH target.

`pve_bridge` is expected in group vars, example:

```yaml
pve_bridge:
  br-uplink:
    public: true
    networks:
      - 138.201.133.94/32
  br-internal:
    public: false
    proxy: proxy.rackmonkey.de
    networks:
      - 10.63.13.0/24
```
