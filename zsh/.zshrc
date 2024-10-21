#!/bin/sh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


#plugins 

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# zinit snipets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::brew

autoload -Uz compinit && compinit
zinit cdreplay -q


alias ls='ls --color'
alias ..='cd ..'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no 
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'



source /opt/homebrew/share/zsh-abbr/zsh-abbr.zsh
source "$HOME/.config/zsh/zsh-aliases"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

HISTFILE=~/.zsh_history 
setopt appendhistory

# Key-bindings
bindkey -v
bindkey -s '^s' 'ncdu^M'
bindkey -s '^n' 'nvim $(fzf)^M'
bindkey '^[[P' delete-char
bindkey -r "^u"
bindkey -r "^d"

bindkey '^a' autosuggest-accept

# bun completions
[ -s "/Users/$USER/.bun/_bun" ] && source "/Users/$USER/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/$USER/.bun"

export PATH="$BUN_INSTALL/bin:$PATH"


#Cargo
export CARGO_INSTALL="$HOME/.cargo"
export PATH="$CARGO_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export EDITOR="nvim"

eval "$(starship init zsh)"

export GOPATH=$HOME/go
export PATH=$PATH:$(go env GOPATH)/bin

eval "$(zoxide init --cmd cd zsh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

export FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
eval "$(/opt/homebrew/bin/mise activate zsh)"


# pnpm
export PNPM_HOME="/Users/lfilipowicz/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Eza
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
