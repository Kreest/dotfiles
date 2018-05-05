# Installation: Please install zplug then simply copy this to ~/.zshrc
# Author: Mateen Ulhaq <mulhaq2005@gmail.com>

# INITIAL
# If not running interactively, don't do anything
[[ -o interactive ]] || return


# ZPLUG {{{1

source /usr/share/zsh/scripts/zplug/init.zsh

# PLUGINS {{{2
zplug "changyuheng/fz", defer:1                             # Fuzzy tab completion for z
zplug "lib/history", from:oh-my-zsh                         #
zplug "lib/key-bindings", from:oh-my-zsh                    # Useful keybindings
zplug "mafredri/zsh-async", defer:0                         #
zplug "mollifier/anyframe"                                  # Bindings for fuzzy commands
zplug "rupa/z", use:"*.sh"                                  # Navigate to most used directories
zplug "zsh-users/zsh-autosuggestions"                       #



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
