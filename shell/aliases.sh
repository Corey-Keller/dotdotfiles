#!/bin/sh
# =========================================================================
# File: aliases.sh
# Author: Corey Keller
# Description: This file is for shell agnostic aliases
# Repository: https://github.com/Corey-Keller/dotdotfiles
# Last Modified: 2020-03-05
# License: Mozilla Public License 2.0
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# =========================================================================

# ============================================================
# SPACE ALIASES: Don't store these commands in the history
# file
# ============================================================
alias kill=' kill'
alias delhist=' delhist'
alias alias=' alias'

# ============================================================
# SUDO ALIASES: Run these commands as root without having to
# type sudo
# ============================================================
alias su='sudo su'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown'
alias fdisk='sudo fdisk'
alias visudo='sudo visudo'

# ============================================================
# OVERWRITE ALIASES:Overwrite a builtin command with something
# else
# ============================================================

alias ls='ls -hAlF --group-directories-first --color=always'
alias mkdir='mkdir -p'
alias chown='chown -Rv'
alias chmod='chmod -Rv'
alias cp='cp -pr'
alias rm='rm -dI'

#OTHER ALIASES
alias ax='chmod a+x'
alias cp1='rsync -avz --progress'
alias please='sudo $(fc -l -n -1)'
alias ghist='history|grep'
alias sudo='sudo ' #Allow aliases to be sudo'd

# ============================================================
# Command Specific Aliases
# SYNTAX:
# command -v foo >/dev/null 2>&1 &&
# {
# ...
# }
#
# PIECE BY PIECE EXPLANATION:
# NOTE: lines for actual commands start with '## ' instead of '# '
# checks if a command named foo exists and if so outputs it's path
## command -v foo
#
# ============================================================

# APT
command -v apt >/dev/null 2>&1 &&
{
	# use 'apt' instead of 'apt-get'
	alias apt-get='apt'
	for action in install reinstall remove purge autoremove update upgrade \
	full-upgrade edit-sources
	do
		subalias apt_${action}='sudo apt '"${action}"' "$@"'
	done

	alias ins='apt install'
	alias aptup='apt update && apt full-upgrade'
}

# GIT
command -v git >/dev/null 2>&1 &&
{
	alias g='git'
	alias ga='git add'
	alias gaa='git add --all'
	alias gs='git status'
	alias gc='git commit -v'
	alias gp='git push'
	alias gpo='git push origin'
	alias gpm='git push origin master'
	alias gl='git pull'
	alias glo='git pull origin'
	alias glm='git pull origin master'
	alias gca='git commit -am'
}

# SYSTEMCTL
command -v systemctl >/dev/null 2>&1 &&
{
	# Base
	alias sc=systemctl
	alias scu='systemctl --user'

	# Root only sub-commands
	alias scst='sudo systemctl start'
	alias scsp='sudo systemctl stop'
	alias scrl='sudo systemctl reload'
	alias scrt='sudo systemctl restart'
	alias sce='sudo systemctl enable'
	alias scd='sudo systemctl disable'

	# Other sub-commands
	alias scs='systemctl status'
	alias scsw='systemctl show'
	alias sclu='systemctl list-units'
	alias scluf='systemctl list-unit-files'
	alias sclt='systemctl list-timers'
	alias scc='systemctl cat'
	alias scie='systemctl is-enabled'
}

# TRASH-CLI
command -v trash-put >/dev/null 2>&1 &&
command -v trash-empty >/dev/null 2>&1 &&
command -v trash-list >/dev/null 2>&1 &&
command -v trash-restore >/dev/null 2>&1 &&
command -v trash-rm >/dev/null 2>&1 &&
{
	# This ludicrous mess resolves to the following, as a single line:
	# Use 'trash-put' instead of rm'' please. If you really need to use rm,
	# use '\rm' and it will work as expected
	alias rm='echo "Use '\''trash-put'\'' instead of '\''rm'\'' please. If you really need to use rm, use '\''\\\rm'\'' and it will work as expected"; false'
}
