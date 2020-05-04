##########################
#### zsh aliases
##########################

##This file is for zsh specific aliases

# add all the function aliases
local dotfilesFunctionDir="$DOTFILESDIR/shell/functions"
#[[ ${fpath[(ie)$dotfilesFunctionDir]} -le ${#fpath} ]] || export FPATH="$dotfilesFunctionDir:${FPATH}"
#[[ ${fpath[(ie)$dotfilesFunctionDir]} -gt ${#fpath} ]] && export FPATH="$dotfilesFunctionDir:${FPATH}"
[[ ${fpath[(ie)$dotfilesFunctionDir ]} -gt ${#fpath} ]] && fpath=($dotfilesFunctionDir ${fpath[@]})
autoload -Uk $dotfilesFunctionDir/*(:t)

# add the shell agnostic aliases
source $DOTFILESDIR/shell/aliases

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
