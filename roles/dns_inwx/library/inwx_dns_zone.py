from __future__ import annotations

from ansible.module_utils.basic import AnsibleModule
#from ansible.errors import AnsibleError
from INWX.Domrobot import ApiClient
import csv

def main() -> None:
    module_args = dict(
        domains=dict(type="list", required=True),
        username=dict(type="str", required=True),
        password=dict(type="str", required=True),
    )
    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)

    domains = module.params["domains"]
    username = module.params["username"]
    password = module.params["password"]

    api_client = ApiClient(api_url=ApiClient.API_LIVE_URL, debug_mode=True)

    login_result = api_client.login(
        username=username,
        password=password,
    )
    #module.warn(str("asdf"))
    zone = {}
    file = ""
    count = 0

    if login_result['code'] == 1000:
        for domain in domains:
            #module.warn(str(domain))
            zone[domain] = []
            domain_check_result = api_client.call_api(api_method='nameserver.exportrecords', method_params={'name': f"*.{domain}"})
            if domain_check_result['code'] == 1000:
                file = domain_check_result['resData']['data']
                count = domain_check_result['resData']['count']
                # module.warn(str(count))
                # module.warn(file)
                reader = csv.reader(file.splitlines(),delimiter=',')

                for row in reader:
                    zone[domain].append(row)
                    #module.warn(f"{', '.join(row)}")

            else:
                raise AnsibleError('Api error while checking domain status. Code: ' + str(domain_check_result['code'])
                                + '  Message: ' + domain_check_result['msg'])
        api_client.logout()
    else:
        raise AnsibleError('Api login error. Code: ' + str(login_result['code']) + '  Message: ' + login_result['msg'])
    module.exit_json(zones=zone)


if __name__ == "__main__":
    main()
