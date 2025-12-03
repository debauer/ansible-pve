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

