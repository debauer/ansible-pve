# WRT Role

Generates and deploys OpenWrt configuration files on the target host.

## What it does

- Renders templates in `roles/wrt/templates/config/*.j2`.
- Copies rendered files to `/etc/config/` on the OpenWrt host.
- Installs `/etc/banner` from `roles/wrt/templates/banner.j2`.

## Variables

Defaults are in `roles/wrt/default/main.yml`.

- `wrt_ssh_on_wan` (bool): Allow SSH on WAN in firewall template.
- `wrt_http_on_wan` (bool): Allow LuCI HTTP/HTTPS on WAN in firewall template.
- `wrt_dropbear_port` (string): SSH port for dropbear config.
- `wrt_ntp_server` (list of strings): NTP servers for `system` config.
- `wrt_lan_ipaddr` (string): Fallback LAN IP when `wrt_interface` is not set.
- `wrt_interface` (list of dicts): Fully defines `config interface` blocks in
  `network.j2`. Each dict must include `name` and can include any OpenWrt network
  options. List values are rendered as `list <key>`.
- Inventory host vars (examples):
  - `proxmox_vmid` (int): Used by `firewall.j2` to generate SSH DNAT port forwards.
  - `network_interfaces_interfaces` (list): Used by `firewall.j2` for dest IPs
    when building SSH DNAT rules.

## Example host vars

```yaml
# inventory/host_vars/fw.rackmonkey.de.yml
wrt_interface:
  - name: wan
    proto: dhcp
    device: eth1
  - name: lan
    proto: static
    device: eth0
    ipaddr: 10.63.10.1
    netmask: 255.255.255.0

wrt_dropbear_port: "22"
wrt_ntp_server:
  - 0.openwrt.pool.ntp.org
  - 1.openwrt.pool.ntp.org
```

## Firewall SSH forwarding

`firewall.j2` creates a DNAT rule for every inventory host that defines
`proxmox_vmid` and `network_interfaces_interfaces`. The external SSH port is
computed as `30000 + proxmox_vmid`, and the destination IP is taken from each
interface entry's `address`.
