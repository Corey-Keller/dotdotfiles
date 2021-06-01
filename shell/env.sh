#!/bin/sh
# =========================================================================
# File: env.sh
# Author: Corey Keller
# Description: This file is for shell agnostic environment variables
# Repository: https://github.com/Corey-Keller/dotdotfiles
# Last Modified: 2021-06-01
# License: Mozilla Public License 2.0
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# =========================================================================

# ============================================================
# Directories
# ============================================================
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Source File Directories
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export SHAREDSOURCEDIR="/src"
[ -d "$SHAREDSOURCEDIR" ] && [ -w "$SHAREDSOURCEDIR" ] &&
[ -x "$SHAREDSOURCEDIR" ] &&
GHDIR="$SHAREDSOURCEDIR/github.com" || GHDIR="$HOME/src/github.com"
export GHDIR="${GHDIR}"
export SHAREDBINDIR="$SHAREDSOURCEDIR/bin"
export GOBIN="$SHAREDBINDIR"
export GOROOT_FINAL="$SHAREDSOURCEDIR/go"

export DOTFILESDIR="$GHDIR/Corey-Keller/dotdotfiles"
if [ -d "$DOTFILESDIR" ] && [ ! -d "$HOME/.dotfiles" ]; then
	ln -s "$DOTFILESDIR" "$HOME/.dotfiles"
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# XDG Base Directories
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Directory under which user specific data files should be stored.
#export XDG_DATA_HOME="$DOTFILESDIR/xdg/data"
export XDG_DATA_HOME="$HOME/.local/share"
# Directories to search for data files in addition to $XDG_DATA_HOME
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
# Directory under which user specific configuration files should be stored.
#export XDG_CONFIG_HOME="$DOTFILESDIR/xdg/config"
export XDG_CONFIG_HOME="$HOME/.config"
# Directories to search for configuration files in addition to
# $XDG_CONFIG_HOME
export XDG_CONFIG_DIRS="/etc/xdg"
# Directory under which user specific non-essential data files should be
# stored.
export XDG_CACHE_HOME="$HOME/.cache"
# Directory under which user specific non-essential runtime files and other
# file objects (such as sockets, named pipes, ...) should be stored.
#export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/dev/shm/user/$(id -u)}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dotfiles Sub-Directories
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export DFDIR_SHELL="$DOTFILESDIR/shell"
export DFDIR_ZSH="$DFDIR_SHELL/zsh"
export DFDIR_NANO="$DOTFILESDIR/nano"
export DFDIR_BASH="$DFDIR_SHELL/bash"
export DFDIR_XDG="$DOTFILESDIR/xdg"

# set this specialized $DISPLAY value only in WSL sessions
if [ $(uname -r | grep microsoft-standard) ]; then
	export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0.0
	export LIBGL_ALWAYS_INDIRECT=1
fi

# export EDITOR=vim

# editorPreferenceOrder=('nvim' 'vim' 'nano' 'vi' 'ed')
editorPreferenceOrder='nvim vim nano emacs vi ed'
# for editorChoice in "${editorPreferenceOrder[@]}"; do
echo "$editorPreferenceOrder" | tr ' ' '\n' | while read -r editorChoice; do
	if command -v "$editorChoice" >/dev/null 2>&1; then
		export EDITOR=$editorChoice
		break
	fi
done

export SUDO_EDITOR=${EDITOR}
export VISUAL=${EDITOR}
export PAGER=less
export HISTSIZE='1000000'

# ============================================================
# Interactive Shell Stuff
# ============================================================
case "$-" in
	*i*)
		export GLOBAL_THEME="artesanal"
		. "$DFDIR_SHELL/LS_COLORS/base16.LS_COLORS.sh"
esac

#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
GPG_TTY=$(tty)
export GPG_TTY
#gpg-connect-agent updatestartuptty /bye >/dev/null
#gpgconf --launch gpg-agent
. "$DFDIR_SHELL/path.sh"

# ============================================================
# Miscellaneous Environment Variables
# ============================================================

# ============================================================
# Command Specific Environment Variables
# ============================================================
## gtags exports NEED TO FIX!
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# gtags
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export GTAGSCONF="$XDG_CONFIG_HOME/gtags/gtags.conf"
export GTAGSLABEL="pygments"
export GTAGS_OPTIONS="--accept-dotfiles --compact"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# [n]vim
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export VIMCONFIGDIR="$XDG_CONFIG_HOME/nvim"
export VIMDATADIR="$XDG_DATA_HOME/nvim"
export MYVIMRC="$VIMCONFIGDIR/init.vim"
export VIMINIT="source $MYVIMRC"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# git
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export GIT_EDITOR=${EDITOR:=vim}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# less
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# turn off .lesshst file
export LESSHISTFILE="-"
# color highlighting in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS="Ri"

# make less more friendly for non-text input files, see lesspipe(1)
if [ ! "$(type -p lesspipe >/dev/null 2>&1 && eval "$(lesspipe)")" ]; then
	## lesspipe if installed ##
	LESSPIPEX="$(type -p lesspipe.sh)"
	[ -x "${LESSPIPEX}" ] && export LESSOPEN="|${LESSPIPEX} %s"
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# fd
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
command -v fd >/dev/null 2>&1 &&
{
	has_fd_command=1
	export FD_OPTS='--hidden --follow --exclude .git'
	alias fd='fd $FD_OPTS'
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# rg
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
command -v rg >/dev/null 2>&1 &&
{
	has_rg_command=1
	export RG_OPTS='--hidden --follow --smart-case --no-messages'
	alias rg='rg $RG_OPTS'
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# fzf
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
export FZF_DEFAULT_OPTS="--history=$XDG_CACHE_HOME/.fzf_history --history-size=50000"

if [ "$has_fd_command" -eq 1 ]; then
	export FZF_DEFAULT_COMMAND="fd --type file --color=never $FD_OPTS"
elif [ "$has_rg_command" -eq 1 ]; then
	export FZF_DEFAULT_COMMAND="rg --files $RG_OPTS"
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# rbenv
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	RBENV_ROOT="${RBENV_ROOT:-${HOME}/.rbenv}"
if [ -d "${RBENV_ROOT}" ]; then
	export PATH="${RBENV_ROOT}/shims:${RBENV_ROOT}/bin:${PATH}"
fi
command -v pyenv >/dev/null 2>&1 &&
{
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
	export RBENV_ROOT
	export RBENV_SHELL="${RBENV_SHELL:-$SHELL}"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# pyenv
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	PYENV_ROOT="${PYENV_ROOT:-${HOME}/.pyenv}"
if [ -d "${PYENV_ROOT}" ]; then
	export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
fi
command -v pyenv >/dev/null 2>&1 &&
{
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
	export PYENV_ROOT
	export PYENV_SHELL="${PYENV_SHELL:-$SHELL}"
}

