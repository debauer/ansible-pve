letsencrypt['enable'] = {{ gitlab_letsencrypt_enable | bool | lower }}

external_url '{{ gitlab_external_url }}'
nginx['listen_port'] = {{ gitlab_nginx_listen_port }}
nginx['listen_https'] = {{ gitlab_nginx_listen_https | bool | lower }}
{% if gitlab_ssl_enable %}
nginx['ssl_certificate'] = '{{ gitlab_nginx_ssl_certificate }}'
nginx['ssl_certificate_key'] = '{{ gitlab_nginx_ssl_certificate_key }}'
{% endif %}

registry['enable'] = {{ gitlab_registry_enable | bool | lower }}
{% if gitlab_registry_enable %}
registry_external_url '{{ gitlab_registry_external_url }}'
gitlab_rails['registry_enabled'] = true
gitlab_rails['registry_host'] = '{{ gitlab_registry_domain }}'
gitlab_rails['registry_path'] = '{{ gitlab_registry_path }}'
registry_nginx['listen_port'] = {{ gitlab_registry_nginx_listen_port }}
registry_nginx['listen_https'] = false
registry_nginx['proxy_set_headers'] = {
    "X-Forwarded-Proto" => "https",
    "X-Forwarded-Ssl" => "on"
}
{% if gitlab_ssl_enable %}
registry_nginx['ssl_certificate'] = '{{ gitlab_registry_nginx_ssl_certificate }}'
registry_nginx['ssl_certificate_key'] = '{{ gitlab_registry_nginx_ssl_certificate_key }}'

{% endif %}
{% else %}
gitlab_rails['registry_enabled'] = false
{% endif %}

gitlab_rails['smtp_enable'] = {{ gitlab_smtp_enable | bool | lower }}
{% if gitlab_smtp_enable %}
gitlab_rails['smtp_address'] = '{{ gitlab_smtp_address }}'
gitlab_rails['smtp_port'] = {{ gitlab_smtp_port | int }}
gitlab_rails['smtp_user_name'] = '{{ gitlab_smtp_user_name }}'
gitlab_rails['smtp_password'] = '{{ gitlab_smtp_password }}'
gitlab_rails['smtp_domain'] = '{{ gitlab_smtp_domain }}'
gitlab_rails['smtp_authentication'] = '{{ gitlab_smtp_authentication }}'
gitlab_rails['smtp_enable_starttls_auto'] = {{ gitlab_smtp_enable_starttls_auto | bool | lower }}
gitlab_rails['smtp_openssl_verify_mode'] = '{{ gitlab_smtp_openssl_verify_mode }}'
gitlab_rails['gitlab_email_from'] = '{{ gitlab_smtp_email_from }}'
gitlab_rails['gitlab_email_reply_to'] = '{{ gitlab_smtp_email_reply_to }}'
{% endif %}

gitlab_rails['omniauth_enabled'] = {{ gitlab_oauth_keycloak_enable | bool | lower }}
{% if gitlab_oauth_keycloak_enable %}
gitlab_rails['omniauth_allow_single_sign_on'] = [{% for provider in gitlab_oauth_keycloak_allow_single_sign_on %}'{{ provider }}'{% if not loop.last %}, {% endif %}{% endfor %}]
gitlab_rails['omniauth_auto_link_user'] = [{% for provider in gitlab_oauth_keycloak_auto_link_user %}'{{ provider }}'{% if not loop.last %}, {% endif %}{% endfor %}]
gitlab_rails['omniauth_block_auto_created_users'] = {{ gitlab_oauth_keycloak_block_auto_created_users | bool | lower }}
gitlab_rails['omniauth_providers'] = [
  {
    name: '{{ gitlab_oauth_keycloak_name }}',
    label: '{{ gitlab_oauth_keycloak_label }}',
    args: {
      name: '{{ gitlab_oauth_keycloak_name }}',
      scope: [{% for scope_item in gitlab_oauth_keycloak_scope %}'{{ scope_item }}'{% if not loop.last %}, {% endif %}{% endfor %}],
      response_type: '{{ gitlab_oauth_keycloak_response_type }}',
      issuer: '{{ gitlab_oauth_keycloak_issuer }}',
      discovery: {{ gitlab_oauth_keycloak_discovery | bool | lower }},
      client_auth_method: '{{ gitlab_oauth_keycloak_client_auth_method }}',
      uid_field: '{{ gitlab_oauth_keycloak_uid_field }}',
      pkce: {{ gitlab_oauth_keycloak_pkce | bool | lower }},
      client_options: {
        identifier: '{{ gitlab_oauth_keycloak_client_id }}',
        secret: '{{ gitlab_oauth_keycloak_client_secret }}',
        redirect_uri: '{{ gitlab_external_url }}/users/auth/openid_connect/callback'
      }
    }
  }
]
{% endif %}

{% if gitlab_unprivileged_lxc %}
package['modify_kernel_parameters'] = false
{% endif %}