#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[3;33m\]\w \[\e[0;32m\]>\[\e[0m\] '

alias ..='cd ..'
alias ...='cd ../..'
alias ls='eza --git-ignore --group-directories-first --icons'
alias g='gitui'

mc() {
    mkdir -p "${1}" && cd "${1}"
}

c() {
    cd "$(fd --type d | fzf)"
}

new() {
    [[ ! -e "${~/projects/dotfiles/bash/samples/}${1}" ]] && echo "No sample for '${1}'" && return
    cp   -r "${~/projects/dotfiles/bash/samples/}${1}" . ; mv $1 $2 ; cd $2 ; $EDITOR .
}
