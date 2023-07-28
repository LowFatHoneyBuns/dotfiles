#Setup antidote 
export ADOTDIR=$HOME/.local/share/antidote
autoload -Uz compinit && compinit

source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh

ZSH=$(antidote path ohmyzsh/ohmyzsh)
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
[[ -d $ZSH_CACHE_DIR ]] || mkdir -p $ZSH_CACHE_DIR

antidote load 

setopt HIST_IGNORE_SPACE

# Setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# remove all the crappy oh-my-zsh aliases
unalias -a

# source common definitions
if [ -f ~/.config/shell_env ]; then
    source ~/.config/shell_env
fi
if [ -f ~/.config/shell_common ]; then
    source ~/.config/shell_common
fi
if [ -f ~/.config/shell_aliases ]; then
    source ~/.config/shell_aliases
fi
if [ -f ~/.zsh_local ]; then
    source ~/.zsh_local
fi

if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
fi

