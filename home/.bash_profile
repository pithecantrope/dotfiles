#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR=helix
export BROWSER=firefox
export HISTSIZE=4096
export HISTFILESIZE=4096
export HISTCONTROL=erasedups
export COLORTERM=truecolor
export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=Adwaita-Dark
export LS_COLORS="$(vivid generate gruvbox-dark)"
export BAT_THEME="gruvbox-dark"
export MANPAGER="bat -plman"
