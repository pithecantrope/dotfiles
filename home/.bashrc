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

# fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"
 
# # in your .bashrc/.zshrc/*rc
# alias bathelp='bat --plain --language=help'
# help() {
#     "$@" --help 2>&1 | bathelp
# }

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

# Output style You can use the --style option to control the appearance of bat's
# output. You can use --style=numbers,changes, for example, to show only Git
# changes and line numbers but no grid and no file header. Set the BAT_STYLE
# environment variable to make these changes permanent or use bat's configuration
# file. Tip If you specify a default style in bat's config file, you can change
# which components are displayed during a single run of bat using the --style
# command-line argument. By prefixing a component with + or -, it can be added
# or removed from the current style. For example, if your config contains
# --style=full,-snip, you can run bat with --style=-grid,+snip to remove the
# grid and add back the snip component. Or, if you want to override the styles
# completely, you use --style=numbers to only show the line numbers.
#
# Use bat --list-themes to get a list of all available themes for syntax
# highlighting. By default, bat uses Monokai Extended or Monokai Extended Light
# for dark and light themes respectively. To select the TwoDark theme, call bat
# with the --theme=TwoDark option or set the BAT_THEME environment variable to
# TwoDark. Use export BAT_THEME="TwoDark" in your shell's startup file to make
# the change permanent. Alternatively, use bat's configuration file. If you want
# to preview the different themes on a custom file, you can use the following
# command (you need fzf for this): bat --list-themes | fzf --preview="bat
# --theme={} --color=always /path/to/file" bat automatically picks a fitting theme
# depending on your terminal's background color. You can use the --theme-dark
# / --theme-light options or the BAT_THEME_DARK / BAT_THEME_LIGHT environment
# variables to customize the themes used. This is especially useful if you
# frequently switch between dark and light mode.
# 
