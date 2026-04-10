# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load common aliases and env vars
source ~/.commonrc

echo "zshrc loaded"
