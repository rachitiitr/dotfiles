# rachit-dotfiles

My personal dotfiles for a productive terminal environment.

## What's inside

| File | Purpose |
|------|---------|
| `dotfiles/.zshrc` | Zsh config — Oh My Zsh, plugins, fzf |
| `dotfiles/.commonrc` | Shared aliases and env vars |
| `dotfiles/.tmux.conf` | Tmux config with vim-aware pane navigation |
| `dotfiles/.config/nvim/init.lua` | Neovim config (lazy.nvim, catppuccin, fzf-lua, nvim-tree) |
| `dotfiles/.config/yazi/` | Yazi file manager config + catppuccin theme |
| `git/gitconfig` | Git aliases |

## Install

```bash
git clone git@github.com:rachitjain2095/dotfiles.git ~/rachit-dotfiles
cd ~/rachit-dotfiles
./setup.sh
```

## What `setup.sh` does

- Installs: `zsh`, `oh-my-zsh`, `zsh-autosuggestions`, `fzf`, `tig`, `smug`
- Symlinks all dotfiles to their correct locations
- Sets zsh as the default shell
