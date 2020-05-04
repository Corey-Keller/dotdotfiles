##########################
#### general options
##########################

# SET ZSH OPTIONS

# Change directory without having to write 'cd' first
setopt AUTO_CD

# enable interactive commnets
setopt INTERACTIVE_COMMENTS

# extended/fancier zsh globbing
setopt EXTENDED_GLOB

# Emulate ksh function autoloading. This means that when a function is autoloaded, the corresponding file is merely executed, and must define the function itself. 
#setopt KSH_AUTOLOAD

setopt automenu
setopt correct
setopt badpattern
setopt globdots
setopt markdirs
unsetopt correctall 
unsetopt caseglob

# If a pattern for filename generation has no matches, print an error, instead
# of leaving it unchanged in the argument list.
#setopt nomatch

## some bindkey fixes
bindkey -e
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

## autoloads
autoload -Uz edit-command-line

# enable Emacs style command editing
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# default is '*?_-.[]~=/&;!#$%^(){}<>'
# omit / so word splits on path component too
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


##########################
#### History
##########################
# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST 

# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS

# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS

# Ignore duplicates when searching
setopt HIST_FIND_NO_DUPS

# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE

# Remove superfluous blanks from each command line being added to the history list. 
setopt HIST_REDUCE_BLANKS

# Write the history file in the ":start:elapsed;command" format.
setopt EXTENDED_HISTORY

# Append to history instead of overwriting
setopt APPEND_HISTORY

# Write to the history file immediately, not when the shell exits. (redundant with SHARE_HISTORY)
setopt INC_APPEND_HISTORY

# Remove the history (fc -l) command from the history list when invoked. 
setopt HIST_NO_STORE

# Don't execute immediately upon history expansion.
setopt HIST_VERIFY

HISTORY_IGNORE="(l[lsa]|[bf]g|cd *|pushd *|popd *|kill *| alias *|exit|clear|reset)"

##########################
#### runtime help
##########################
# In some situations run-help is aliased to man, but if it isn't hide the error
unalias run-help  &>/dev/null
autoload -Uz run-help
# autoload -Uz run-help-git
# autoload -Uz run-help-ip
# autoload -Uz run-help-sudo
# autoload -Uz run-help-openssl
# autoload -Uz run-help-p4
# autoload -Uz run-help-svk
# autoload -Uz run-help-svn
alias help='run-help '
