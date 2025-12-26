# ansible-homelab

## get dependencies
```` bash
ansible-galaxy install -r requirements.yml -p roles --ignore-errors
````

## Resize root partition

```bash
growpart  /dev/sda 1
resize2fs /dev/sda1
```

## TODOS

* root ssh login funzt aufm host noch nicht. Proxmox ist seltsam.


##

```bash
docker exec -it ollama-cpu /bin/bash
ollama pull gpt-oss:120b
# OR
docker exec -it ollama-gpu /bin/bash
ollama pull qwen3-coder:30b
ollama pull qwen3:30b
ollama pull qwen3:32b
ollama pull embeddinggemma:300m

```