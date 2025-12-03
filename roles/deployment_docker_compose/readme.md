# Ansible Role: Deployment Docker Compose

## Requirements

`geerlingguy.docker`

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

```yaml
deployment_docker_compose_base_path: "deployments"
deployment_docker_compose_docker_networks:
    - proxy
deployment_docker_compose:
  - name: uv
    target_folder: /opt/docker/uv
    target_folder_mode: 770
    copy_files:
      - src: docker-compose.yml
      - src: application.toml
        dst: config.toml
        file_mode: 770
    start_container: true
    restart_container: true
    user: root
```
