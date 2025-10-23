#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[3;33m\]\w \[\e[0;32m\]>\[\e[0m\] '

alias edit=helix
alias ls='eza --git-ignore --group-directories-first --color --icons'
alias lt='ls --tree --level=3'
alias la='ls --almost-all'
alias ll='la --long --header --color-scale --binary --total-size --git' # --{modified, changed, accessed, created}
alias pb='pastebinit -b "https://paste.ubuntu.com" | qr'

cd() {
    builtin cd "$@" && la
}

man() {
    command man "$@" 2>/dev/null || "$@" --help 2>&1 | bat --plain --language=help
}

function new() {
    [[ ! -e "${HOME}/projects/dotfiles/samples/${1}" ]] && echo "No sample for '${1}'" && return
    cp   -r "${HOME}/projects/dotfiles/samples/${1}" .  &&  mv "${1}" "${2}" && cd "${2}"
    ${EDITOR} .
}

. "$HOME/.local/bin/env"
