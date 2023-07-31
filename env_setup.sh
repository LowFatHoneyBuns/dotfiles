NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"


info() {
    BOLD="$(tput bold 2>/dev/null || printf '')"
    GREY="$(tput setaf 0 2>/dev/null || printf '')"
    printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}

warn() {
    YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
    printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
    RED="$(tput setaf 1 2>/dev/null || printf '')"
    printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

completed() {
    GREEN="$(tput setaf 2 2>/dev/null || printf '')"
    printf '%s\n' "${GREEN}✓${NO_COLOR} $*"
}

has() {
  command -v "$1" 1>/dev/null 2>&1
}


case "$OSTYPE" in
    darwin*)  
        echo "OSX"
        #Install HomeBrew
        if ! has brew; then
            warn "HomeBrew not installed"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        #Install Pipx
        if ! has pipx; then
            warn "pipx not installed"
            brew install pipx
        fi
        #Install Nerd Fonts
            brew tap homebrew/cask-fonts &&
            brew install --cask font-hack-nerd-font
        #Install Starship
        if ! has starship; then
            warn "starship not installed"
            brew install starship
        fi
   
        #Install Pyenv
        if ! has pyenv; then
            warn "pyenv not installed"
            git clone https://github.com/pyenv/pyenv.git ~/.pyenv
            brew install openssl readline sqlite3 xz zlib tcl-tk
        fi
        echo "all good"
    ;; 
    linux*)   
        echo "LINUX" 
        if ! has python3; then
            error "python3 is not installed"
            exit 1
        fi
        if ! has pipx; then
            warn "pipx is not installed"
            python3 -m pip install --user pipx
            python3 -m pipx ensurepath
        fi  
        if ! has pyenv; then
            warn "pyenv not installed"
            git clone https://github.com/pyenv/pyenv.git ~/.pyenv
            sudo apt update && sudo apt install build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
        fi
        mkdir -p ~/.local/share/fonts
        cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack//Regular/HackNerdFont-Regular.ttf

        echo "all good"
    ;;
    msys*)
        echo "WINDOWS" 
    ;;
    cygwin*)
        echo "ALSO WINDOWS"
    ;;
    *)
        echo "unknown: $OSTYPE"
    ;;
esac
