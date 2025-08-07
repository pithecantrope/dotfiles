#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export HISTSIZE=3072
export HISTFILESIZE=3072
export HISTCONTROL=erasedups
export EDITOR=helix
export BROWSER=chromium
export COLORTERM=truecolor
export LS_COLORS="$(vivid generate dracula)"
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
export BAT_THEME="gruvbox-dark"

startx
