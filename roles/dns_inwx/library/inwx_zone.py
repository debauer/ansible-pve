#!/usr/bin/python
from __future__ import annotations

from ansible.module_utils.basic import AnsibleModule

ZONE = []


def add_entry(domain, type, record, value):
    global ZONE
    ZONE.append({
        "domain": domain,
        "type": type,
        "record": record,
        "value": value,
    })

def add_cnames(records) -> None:


def main():
    module_args = dict(
        records_cname=dict(type="dict", required=True),
        records=dict(type="dict", required=True),
        inwx_zone=dict(type="list", required=True), # current zone from inwx
    )
    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)


    records_cname = module.params["records_cname"]
    records = module.params["records"]
    inwx_zone = module.params["inwx_zone"]

    add_cnames(records_cname)

    for mac, ip in dhcp_export.items():
        if mac not in dhcp_new.keys():
            debug_msgs.append(f"mac not in new leases: {ip}, {mac}")
            remove_entry(mac)
        else:
            if ip != dhcp_new[mac]:
                debug_msgs.append(f"ip differs: {ip}, {dhcp_new[mac]}, {mac}")
                remove_entry(mac)
                add_entry(mac, dhcp_new[mac], dhcp_name)
    for mac, ip in dhcp_new.items():
        if mac not in dhcp_export.keys():
            add_entry(mac, ip, dhcp_name)

    module.exit_json(
        changed=True, zone=ZONE
    )


if __name__ == "__main__":
    main()
