#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\e[3;34m\h \e[0;33m\w \e[0;32m>\e[0m '
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias sp='sudo pacman'
alias ..='cd ..'
alias ...='cd ../..'
alias vim='nvim'
alias v='nvim'
alias lg='lazygit'

dir=~/projects/dotfiles
samples=$dir/bash/samples/
function new() {
    [[ ! -e "${samples}${1}" ]] && echo "No sample for '${1}'" && return
    cp -r "${samples}${1}" . ; mv $1 $2 ; cd $2 ; $EDITOR .
}

alias dot='cd ${dir} ; $EDITOR .'
alias p='$EDITOR ${dir}/bash/.projects'
. $dir/bash/.projects
