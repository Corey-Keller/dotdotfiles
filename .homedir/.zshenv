export VERBOSE_ZSH_STARTUP=0 # OFF == 0 and ON == >=1
export VERBOSE_SHELL_STARTUP=$VERBOSE_ZSH_STARTUP # OFF == 0 and ON == >=1
export ZDOTDIR=$HOME/.dotfiles/shell/zsh
(($VERBOSE_ZSH_STARTUP)) && echo 'loading $HOME/.zshenv'
source $ZDOTDIR/zshenv
(($VERBOSE_ZSH_STARTUP)) && echo 'finished loading $HOME/.zshenv'
