#!/usr/bin/env sh

set -ex

YADM=${HOME}/.local/bin/yadm

# BOLD="$(tput bold 2>/dev/null || printf '')"
# GREY="$(tput setaf 0 2>/dev/null || printf '')"
# UNDERLINE="$(tput smul 2>/dev/null || printf '')"
# RED="$(tput setaf 1 2>/dev/null || printf '')"
# GREEN="$(tput setaf 2 2>/dev/null || printf '')"
# YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
# BLUE="$(tput setaf 4 2>/dev/null || printf '')"
# MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
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

if ! has git; then
    error "git is not installed"
    exit 1
fi

if ! has yadm; then # install yadm
    mkdir -p "$(dirname "${YADM}")"
    curl -fLo "${YADM}" https://github.com/TheLocehiliosan/yadm/raw/master/yadm
    chmod a+x "${YADM}"
fi

info "repo: ${REPO}"
if [ -z "${REPO}" ]; then
    REPO=https://github.com/LowFatHoneyBuns/dotfiles.git
    if ssh -q git@github.com; [ $? -eq 1 ]; then
        REPO=git@github.com:LowFatHoneyBuns/dotfiles.git
    fi
fi

# have yadm grab the dotfiles and bootstrap
${YADM} clone -f --bootstrap ${REPO}
${YADM} status
