# =========================================================================
# File: .zshrc
# Author: Corey Keller
# Description: Zsh config file
# Repository: https://github.com/Corey-Keller/dotdotfiles
# Last Modified: 2021-03-11
# License: Mozilla Public License 2.0
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# =========================================================================
(($VERBOSE_ZSH_STARTUP)) && echo 'loading $ZDOTDIR/.zshrc'
local testLoadTime=0 # OFF == 1 and ON == >=1
(($testLoadTime)) && zmodload zsh/zprof && zprof -c

export ZDOTDIR=${ZDOTDIR:-$HOME}

# if not an interactive shell, return
[[ ! -o interactive ]] && return

# add ~/bin if it exists, and isn't already in the path
# note: using the magic $path arrayish variable here
[[ ${path[(ie)$HOME/bin ]} -le ${#path} ]] ||
    export PATH="${PATH}:${HOME}/bin"

# detect os
# if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
#     OS="Darwin"
# else
#     OS=$(uname -s)
# fi
# export OS


# detect ssh
IS_SSH="${IS_SSH:-0}"
if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
  IS_SSH=1
fi
export IS_SSH


# load local init config if it exists
[ -s $HOME/.zshrc_pre ] && . $HOME/.zshrc_pre

# disable START/STOP output control
# if [ -x /bin/stty ]; then
#     /bin/stty -ixon
#     /bin/stty -ixoff
# fi
(($VERBOSE_ZSH_STARTUP)) && echo 'loading $ZDOTDIR/zshrc.d files'
for file in ${ZDOTDIR}/zshrc.d/[0-9][0-9]_*.zsh; do
  (($VERBOSE_ZSH_STARTUP)) && echo "loading $file"
    source $file
  (($VERBOSE_ZSH_STARTUP)) && echo "finished loading $file"
done
(($VERBOSE_ZSH_STARTUP)) && echo 'finished loading $ZDOTDIR/zshrc.d files'

# Load 'fzf'
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] &&
source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# load local post config if it exists
[ -s $HOME/.zshrc_post ] && . $HOME/.zshrc_post

(($testLoadTime)) && zprof
(($VERBOSE_ZSH_STARTUP)) && echo 'finished loading $ZDOTDIR/.zshrc'

