letsencrypt['enable'] = false

external_url 'https://{{ gitlab_domain }}'
nginx['listen_port'] = 443
nginx['listen_https'] = true


registry['enable'] = true
registry_external_url 'https://{{ gitlab_registry_domain }}'

### Settings used by GitLab application
gitlab_rails['registry_enabled'] = true
gitlab_rails['registry_host'] = "{{ gitlab_registry_domain }}"
#gitlab_rails['registry_port'] = "5000"
gitlab_rails['registry_path'] = "/var/opt/gitlab/gitlab-rails/shared/registry"


nginx['ssl_certificate'] = "/etc/letsencrypt/live/{{ gitlab_domain }}/fullchain.pem"
nginx['ssl_certificate_key'] = "/etc/letsencrypt/live/{{ gitlab_domain }}/privkey.pem"
registry_nginx['ssl_certificate'] = "/etc/letsencrypt/live/{{ gitlab_registry_domain }}/fullchain.pem"
registry_nginx['ssl_certificate_key'] = "/etc/letsencrypt/live/{{ gitlab_registry_domain }}/privkey.pem"


gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "{{ gitlab_smtp_address }}"
gitlab_rails['smtp_port'] = "{{ gitlab_smtp_port | default('465')}}"
gitlab_rails['smtp_user_name'] = "{{ gitlab_smtp_user_name }}"
gitlab_rails['smtp_password'] = "{{ gitlab_smtp_password }}"
gitlab_rails['smtp_domain'] = "{{ gitlab_smtp_domain }}"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_openssl_verify_mode'] = 'peer'

# If your SMTP server does not like the default 'From: gitlab@localhost' you
# can change the 'From' with this setting.
gitlab_rails['gitlab_email_from'] = "{{ gitlab_smtp_email_from }}"
gitlab_rails['gitlab_email_reply_to'] = "{{ gitlab_smtp_email_reply_to }}"