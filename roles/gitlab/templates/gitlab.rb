letsencrypt['enable'] = {{ gitlab_letsencrypt_enable | bool | lower }}

external_url '{{ gitlab_external_url }}'
nginx['listen_port'] = {{ gitlab_nginx_listen_port }}
nginx['listen_https'] = {{ gitlab_nginx_listen_https | bool | lower }}
nginx['ssl_certificate'] = '{{ gitlab_nginx_ssl_certificate }}'
nginx['ssl_certificate_key'] = '{{ gitlab_nginx_ssl_certificate_key }}'

registry['enable'] = {{ gitlab_registry_enable | bool | lower }}
{% if gitlab_registry_enable %}
registry_external_url '{{ gitlab_registry_external_url }}'
gitlab_rails['registry_enabled'] = true
gitlab_rails['registry_host'] = '{{ gitlab_registry_domain }}'
gitlab_rails['registry_path'] = '{{ gitlab_registry_path }}'
registry_nginx['ssl_certificate'] = '{{ gitlab_registry_nginx_ssl_certificate }}'
registry_nginx['ssl_certificate_key'] = '{{ gitlab_registry_nginx_ssl_certificate_key }}'
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
