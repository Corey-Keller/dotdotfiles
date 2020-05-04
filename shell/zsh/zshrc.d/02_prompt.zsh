if [[ "$ZSH_CHOSEN_THEME" = "powerlevel10k" ]]
then 
  ##########################
  #### powerlevel10k
  ##########################

  # To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
  source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme
  [[ -f $ZDOTDIR/themes/corey-keller.p10k.zsh ]] &&
  source $ZDOTDIR/themes/corey-keller.p10k.zsh

elif [[ "$ZSH_CHOSEN_THEME" = "git-prompt" ]]
then
  ##########################
  #### git-prompt.zsh
  ##########################

  source $ZDOTDIR/plugins/git-prompt.zsh/git-prompt.zsh
  [[ -f $ZDOTDIR/themes/corey-keller.git-prompt.zsh ]] &&
  source $ZDOTDIR/themes/corey-keller.git-prompt.zsh
fi

[[ -x $DFDIR_SHELL/thirsty.sh ]] &&
source $DFDIR_SHELL/thirsty.sh &&
PROMPT+='%{$reset_color%}$(drink_water) '
export PROMPT
