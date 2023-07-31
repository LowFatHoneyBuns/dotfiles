# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# source common definitions
if [ -f $HOME/.config/shell_env ]; then
    source $HOME/.config/shell_env
fi
if [ -f $HOME/.config/shell_common ]; then
    source $HOME/.config/shell_common
fi
if [ -f $HOME/.config/shell_aliases ]; then
    source $HOME/.config/shell_aliases
fi
if [ -f $HOME/.bash_local ]; then
    source $HOME/.bash_local
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  elif [ -f $BREW_PREFIX/etc/bash_completion ]; then
    source $BREW_PREFIX/etc/bash_completion
  fi
fi

# Starship 
if command -v starship >/dev/null; then
    eval "$(starship init bash)"
fi

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"; then
    eval "$(pyenv init -)"
fi

