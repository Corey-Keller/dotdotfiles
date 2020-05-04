# =========================================================================
# File: 99_post.zsh
# Author: Corey Keller
# Description: ZSH settings to do as late as possible
# Repository: https://github.com/Corey-Keller/dotdotfiles
# Last Modified: 2020-03-10
# License: Mozilla Public License 2.0
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# =========================================================================

# load shell agnostic post actions
[ -s "$DFDIR_SHELL/init_post.sh" ] && source "$DFDIR_SHELL/init_post.sh"

# ============================================================
# Local Overrides
# ============================================================
# load any local overrides at the end
[ -s "$HOME/.zshrc_post" ] && source "$HOME/.zshrc_post"

# ============================================================
# Cleanups
# ============================================================

