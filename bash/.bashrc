#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='\e[0;33m\w \e[0;32m>\e[0m '
alias vim='nvim'
alias lg='lazygit'

dir=~/projects/dotfiles
function new() {
    [[ ! -e "${$dir/bash/samples/}${1}" ]] && echo "No sample for '${1}'" && return
    cp   -r "${$dir/bash/samples/}${1}" . ; mv $1 $2 ; cd $2 ; $EDITOR .
}

alias dot='cd ${dir} ; $EDITOR .'
. $dir/bash/.projects
