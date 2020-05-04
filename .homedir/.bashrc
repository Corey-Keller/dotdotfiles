#!/usr/bin/env bash
# =========================================================================
# File: .bashrc
# Author: Corey Keller
# Description: Bash config
# Repository: https://github.com/Corey-Keller/dotdotfiles
# Last Modified: 2020-04-13
# License: Mozilla Public License 2.0
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# =========================================================================
export HISTSIZE=1000000
export HISTFILESIZE=1000000000

# Enable incremental history search with up/down arrows (also Readline
# goodness)
# Learn more about this here:
# http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'
