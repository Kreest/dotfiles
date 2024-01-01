# INITIAL
# If not running interactively, don't do anything
[[ -o interactive ]] || return

# Vi bindings
export KEYTIMEOUT=1 

# Path
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# tmux chooser
if [[ ! -v TMUX && $TERM_PROGRAM != "vscode" ]]; then
	tmux_chooser && exit
fi

# ZPLUG {{{1

source ~/.zplug/init.zsh

# PLUGINS {{{2
zplug "lib/history", from:oh-my-zsh                         #
zplug "lib/key-bindings", from:oh-my-zsh                    # Useful keybindings
zplug "mafredri/zsh-async", defer:0                         #
zplug "mollifier/anyframe"                                  # Bindings for fuzzy commands
zplug "zsh-users/zsh-autosuggestions"                       #
zplug "lib/vi-mode", from:oh-my-zsh			    # Vi-like keybindings


# THEMES
# zplug "themes/bira", from:oh-my-zsh
# zplug "oskarkrawczyk/honukai-iterm-zsh", as:theme
zplug "themes/fox", from:oh-my-zsh


# LOAD
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
	zplug install
fi

# Consider updating
# zplug update

# Source plugins and add commands to $PATH
zplug load

# SOURCING

# Aliases
[ -f ~/.aliases ] && source ~/.aliases

# ls colors
[ -e ~/.dircolors ] && eval $(dircolors -b ~/.dircolors) || eval $(dircolors -b)

# cdr (for searching/jumping to frequent directories using anyframe-widget-cdr)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# Rename files using zmv 'test(*).png' '$1.png'
autoload zmv

# MISCELLANEOUS CONFIGURATIONS

# History sizes
HISTSIZE=20000
SAVEHIST=10000

# Do not save to history commands prefixed wtih space
setopt hist_ignore_space

# Remove duplicate commands from history on exit
setopt hist_ignore_all_dups
setopt hist_save_no_dups

# Better globbing
setopt extended_glob

# Directory stack
setopt autopushd pushdminus pushdsilent pushdtohome

# Style
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # Use LS COLORS to autocomplete

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

export EDITOR=nvim

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

LS_COLORS=$LS_COLORS:'di=1;33:' ; export LS_COLORS
source /etc/profile.d/vte.sh

autoload -Uz compinit
compinit

zstyle ":anyframe:selector:" use fzf-tmux
zstyle ":anyframe:selector:fzf-tmux:" command 'fzf-tmux -h'

eval $(thefuck --alias)
bindkey -v

bindkey '^xb' anyframe-widget-cdr
bindkey '^x^b' anyframe-widget-checkout-git-branch

bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^r' anyframe-widget-execute-history

bindkey '^xi' anyframe-widget-put-history
bindkey '^x^i' anyframe-widget-put-history

bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository

bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill

bindkey '^xe' anyframe-widget-insert-git-branch
bindkey '^x^e' anyframe-widget-insert-git-branch

# opam configuration
[[ ! -r /home/kreest/.opam/opam-init/init.zsh ]] || source /home/kreest/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
