#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[3;33m\]\w \[\e[1;32m\]>\[\e[0m\] '
alias e=helix

alias ls='eza --group-directories-first --icons --git-ignore'
alias lt='eza --group-directories-first --icons --git-ignore --tree --level=3'
alias la='eza --group-directories-first --icons --all'
alias ll='eza --group-directories-first --icons --git-ignore --long --header --color-scale --binary --total-size --git'
# --{modified, changed, accessed, created}

cd() {
    builtin cd "$@" && la
}

man() {
    command man "$@" 2>/dev/null || "$@" --help 2>&1 | bat --plain --language=help
}

alias c='xclip -selection clipboard'
alias pb='curl -F "file=@-" 0x0.st'

alias fp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
eval "$(fzf --bash)" # Ctrl-T, Ctrl-R, Alt-C and helix **<TAB>
