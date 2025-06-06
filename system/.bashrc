#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[3;33m\]\w \[\e[0;32m\]>\[\e[0m\] '

alias hx=helix
alias shx='sudo -E helix'
alias ls='eza --git-ignore --group-directories-first --color --icons'
alias la='ls -A'
alias pu='pastebinit -b "https://paste.ubuntu.com" | qr'
alias pd='curl https://pastebin.com/raw/U1k0ant3'

alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gl='git log -1 HEAD --stat'
alias gp='git push'
alias gP='git pull'
alias gr='git restore'
alias gR='git reset HEAD~1'
alias gs='git status'

function cd() {
    builtin cd "$@" && la
}

function man() {
    command man "$@" || "$@" --help | less
}

function mc() {
    mkdir -p "${1}" && cd "${1}"
}

function c() {
    cd "$(fd --type d --exact-depth 2 | fzf)"
}

function new() {
    [[ ! -e "${HOME}/projects/dotfiles/system/samples/${1}" ]] && echo "No sample for '${1}'" && return
    cp   -r "${HOME}/projects/dotfiles/system/samples/${1}" . &&  mv "${1}" "${2}" && cd "${2}"
    git init && gh repo create "${2}" --source=. --remote=origin --public
    git add . && git commit -m "Init" && git push --set-upstream origin main
    $EDITOR .
}
