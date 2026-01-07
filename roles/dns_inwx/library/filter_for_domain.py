#!/usr/bin/python
from __future__ import annotations
from dataclasses import dataclass

from ansible.module_utils.basic import AnsibleModule


@dataclass
class dns_record:
    domain: str
    type: str
    record: str
    value: str
    ttl: str = 300

    def __str__(self):
        return f"{self.domain}, {self.type}, {self.record}, {self.value}, {self.ttl}"

    def equal(self, other):
        return str(self) == str(other)

    def to_dict(self):
        return {
            "domain": self.domain,
            "type": self.type,
            "record": self.record,
            "value": self.value,
            "ttl": self.ttl,
        }


def main():
    module_args = dict(
        hostvars=dict(type="dict", required=True),
        inwx_zone=dict(type="dict", required=True),
        update=dict(type="bool", required=False, default=False),
    )
    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)

    hostvars = module.params["hostvars"]
    inwx_zone = module.params["inwx_zone"]
    update = module.params["update"]
    ignored_subdomains = hostvars['inwx']["dns_inwx_zone_ignore_subdomains"]

    new_dns_records: list[dns_record] = []
    old_dns_records: list[dns_record] = []

    for host in hostvars:
        if "dns_inwx" in hostvars[host]:
            for e in hostvars[host]["dns_inwx"]:
                new_dns_records.append(
                    dns_record(e["domain"], e["type"], e["record"], e["value"])
                )
        if "dns_inwx_cname" in hostvars[host]:
            for e in hostvars[host]["dns_inwx_cname"]:
                for r in e["records"]:
                    new_dns_records.append(
                        dns_record(e["domain"], e["type"], r, e["value"])
                    )

    for domain in inwx_zone["zones"]:
        for e in inwx_zone["zones"][domain]:
            if e[1] == "A":
                old_dns_records.append(dns_record(domain, "A", e[0].replace(f".{domain}", ""), e[2], str(e[3])))
            if e[1] == "AAAA":
                old_dns_records.append(dns_record(domain, "AAAA", e[0].replace(f".{domain}", ""), e[2], str(e[3])))
            if e[1] == "CNAME":
                old_dns_records.append(dns_record(domain, "CNAME", e[0].replace(f".{domain}", ""), e[2], e[3]))

    delete = []
    create = []

    for new in new_dns_records:
        if new.record in ignored_subdomains:
            continue
        found = False
        for old in old_dns_records:
            if old.equal(new):
                found = True
        if not found:
            create.append(new.to_dict())

    for old in old_dns_records:
        if old.record in ignored_subdomains:
            continue
        found = False
        for new in new_dns_records:
            if new.equal(old):
                found = True
        if not found:
            delete.append(old.to_dict())

    module.exit_json(changed=True, delete=delete, create=create)



if __name__ == "__main__":
    main()
