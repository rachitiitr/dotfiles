#!/bin/bash

# Personal dotfiles setup script
# Run this on a fresh machine to get up and running quickly.

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ── Tools ─────────────────────────────────────────────────────────────────────

# Install tig (terminal git browser)
if ! command -v tig &> /dev/null; then
  echo "Installing tig..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install tig
  else
    sudo apt update && sudo apt install -y tig
  fi
fi

# Install smug (tmux session manager)
if ! command -v smug &> /dev/null; then
  if ! command -v go &> /dev/null; then
    echo "⚠️  Go is not installed — skipping smug. Install Go and run: go install github.com/ivaaaan/smug@latest"
  else
    echo "Installing smug..."
    go install github.com/ivaaaan/smug@latest
  fi
fi

# Install zoxide (smart cd replacement)
if ! command -v zoxide &> /dev/null; then
  echo "Installing zoxide..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install zoxide
  else
    sudo apt update && sudo apt install -y zoxide
  fi
fi

# ── Zsh + Oh My Zsh ───────────────────────────────────────────────────────────

if ! command -v zsh &> /dev/null; then
  echo "Installing zsh..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install zsh
  else
    sudo apt update && sudo apt install -y zsh
  fi
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# ── fzf ───────────────────────────────────────────────────────────────────────

if ! command -v fzf &> /dev/null; then
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi

# ── Symlink dotfiles ──────────────────────────────────────────────────────────

echo "Symlinking dotfiles..."

ln -sf "$DOTFILES_DIR/dotfiles/.zshrc"     ~/.zshrc
ln -sf "$DOTFILES_DIR/dotfiles/.commonrc"  ~/.commonrc
ln -sf "$DOTFILES_DIR/dotfiles/.tmux.conf" ~/.tmux.conf

mkdir -p ~/.config/nvim
ln -sf "$DOTFILES_DIR/dotfiles/.config/nvim/init.lua" ~/.config/nvim/init.lua

mkdir -p ~/.config/yazi/flavors ~/.config/yazi/plugins
ln -sf "$DOTFILES_DIR/dotfiles/.config/yazi/yazi.toml"   ~/.config/yazi/yazi.toml
ln -sf "$DOTFILES_DIR/dotfiles/.config/yazi/keymap.toml" ~/.config/yazi/keymap.toml
ln -sf "$DOTFILES_DIR/dotfiles/.config/yazi/theme.toml"  ~/.config/yazi/theme.toml

ln -sf "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig

# ── Shell ─────────────────────────────────────────────────────────────────────

if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Changing default shell to zsh..."
  chsh -s "$(which zsh)"
fi

echo ""
echo "✅ Dotfiles setup complete! Restart your shell or run: source ~/.zshrc"
