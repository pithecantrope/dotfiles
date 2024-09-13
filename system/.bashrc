#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[3;33m\]\w \[\e[0;32m\]>\[\e[0m\] '

alias hx=helix
alias shx='sudo helix'
alias ls='eza --git-ignore --group-directories-first --color --icons'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gl='git log -1 HEAD --stat'
alias gp='git push'
alias gP='git pull'
alias gs='git status'
alias gS='git stash'
alias gr='git remote'
alias gt='git tag'

function mc() {
    mkdir -p "${1}" && cd "${1}"
}

function c() {
    cd "$(fd --type d --exact-depth 2 | fzf)"
}

function new() {
    [[ ! -e "${HOME}/projects/dotfiles/bash/samples/${1}" ]] && echo "No sample for '${1}'" && return
    cp   -r "${HOME}/projects/dotfiles/bash/samples/${1}" . ;  mv "${1}" "${2}" ; cd "${2}" ; $EDITOR .
}
