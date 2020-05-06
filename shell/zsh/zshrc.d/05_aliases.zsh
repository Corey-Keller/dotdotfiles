# =========================================================================
# File: 05_aliases.zsh
# Author: Corey Keller
# Description: This file is for zsh specific aliases
# Repository: https://github.com/Corey-Keller/dotdotfiles
# Last Modified: 2020-05-06
# License: Mozilla Public License 2.0
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# =========================================================================

# add all the function aliases
local dotfilesFunctionDir="$DOTFILESDIR/shell/functions"
#[[ ${fpath[(ie)$dotfilesFunctionDir]} -le ${#fpath} ]] || export FPATH="$dotfilesFunctionDir:${FPATH}"
#[[ ${fpath[(ie)$dotfilesFunctionDir]} -gt ${#fpath} ]] && export FPATH="$dotfilesFunctionDir:${FPATH}"
[[ ${fpath[(ie)$dotfilesFunctionDir ]} -gt ${#fpath} ]] && fpath=($dotfilesFunctionDir ${fpath[@]})
autoload -Uk $dotfilesFunctionDir/*(:t)

# add the shell agnostic aliases
source $DOTFILESDIR/shell/aliases.sh

#CD ALIASES
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g .......='../../../../../..'
alias -g ........='../../../../../../..'
alias -g .........='../../../../../../../..'
alias -g ..........='../../../../../../../../..'

#GENERAL ALIASES
# only make the alias if there isn't already a mmv command
command -v mmv >/dev/null 2>&1 || { autoload -U zmv && alias mmv='noglob zmv -W'; }
#alias history=' fc -fl 1'
