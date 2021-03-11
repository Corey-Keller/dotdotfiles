# Setup fzf
# ---------
if [[ ! "$PATH" == */src/github.com/junegunn/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/src/github.com/junegunn/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/src/github.com/junegunn/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/src/github.com/junegunn/fzf/shell/key-bindings.zsh"
