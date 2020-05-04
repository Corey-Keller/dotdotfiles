# Taken from the robbyrussel oh-my-zsh theme: https://github.com/robbyrussell/oh-my-zsh/blob/32338fd40cae45c775dadc34ae05476811a3834b/themes/robbyrussell.zsh-theme
# The only change(s) were:
#  * removing the arrow indicating return status
#  * Adding the time to the prompt in the form of [00:00:00]
PROMPT='%{$fg[yellow]%}[%D{%H:%M:%S}] %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
