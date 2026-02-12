# user_zsh Role

Bootstraps a full ZSH setup with dotfiles and Oh My Zsh plugins.

## What it does

- Installs `zsh`.
- Installs `atuin` via snap.
- Sets user shell to `/bin/zsh`.
- Clones `https://github.com/debauer/dotfiles` into `~/.dotfiles`.
- Installs Oh My Zsh and common plugins.
- Installs `powerlevel10k` theme.
- Removes default shell files and runs `stow shell`.

## Variables

This role currently has no defaults file. Variables are expected from inventory.

- `zsh_user` (list of strings): Usernames to configure (supports `root`).
- `zsh_update` (bool, optional): If `true`, forces plugin repo updates.

## Example host vars

```yaml
# inventory/host_vars/git.rackmonkey.de.yml
zsh_user:
  - debauer
  - root
zsh_update: false
```

## Notes

- The role requires `snap` support on the target because `atuin` is installed via snap.
- Existing non-symlink files like `.zshrc` are removed before `stow` links are created.
