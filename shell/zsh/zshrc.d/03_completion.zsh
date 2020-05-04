##########################
#### completion control
##########################
## completion stuff
zstyle ':compinstall' filename '${ZDOTDIR:-$HOME}/.zshrc'
fpath=(${ZDOTDIR:-$HOME}/plugins/zsh-completions/src $fpath)
fpath=(${ZDOTDIR:-$HOME}/completion $fpath)
zCacheDir="${ZDOTDIR:-$HOME}/.zcache"
[[ -d "$zCacheDir" ]] || mkdir -p "$zCacheDir"

local cacheSuffix="-${HOST:-'UnknownHost'}-${ZSH_VERSION:-'UnknownZshVersion'}-${OSTYPE:-'UnknownOsType'}"
_zcache_compare() {
  local cached_zwc="$zCacheDir/${1:t}$cacheSuffix.zwc"
  local auger="$zCacheDir/${1:t}$cacheSuffix.auger"
  if [[ -s ${1} && ( ! -s $cached_zwc || ${1} -nt $cached_zwc ) ]]; then
    zcompile -UM $cached_zwc ${1}
  fi
}

#loadShellFunctions() {
#  setopt local_options
#  setopt extendedglob
#  setopt globdots
#  local currentDirectory=$(pwd)
#  local shellFunctionsDir="$DOTFILESDIR/shell/functions"
#  local shell_functions_zwc="$zCacheDir/shell_functions.zwc"
  #local shellFunctionsRelDir="$(realpath --relative-to=$zCacheDir $shellFunctionsDir)"
  #[[ ${fpath[(ie)$shellFunctionsDir ]} -gt ${#fpath} ]] && fpath=($shellFunctionsDir ${fpath[@]}) && export fpath
  #autoload -Uk $shellFunctionsDir/*(:t)
  #[[ ${fpath[(ie)$shell_functions_zwc ]} -gt ${#fpath} ]] && fpath=($shell_functions_zwc $fpath)
  #if [[ -d $shellFunctionsDir && ( ! -s $shell_functions_zwc || $shellFunctionsDir -nt $shell_functions_zwc ) ]]; then
  #  cd $zCacheDir
  #  zcompile -aMk $shell_functions_zwc $shellFunctionsDir/*(:t)
  #  cd $currentDirectory
  #fi
  #autoload -w $shell_functions_zwc
#}

#loadShellFunctions
#unfunction loadShellFunctions

_update_zcomp() {
    setopt local_options
    setopt extendedglob
    autoload -Uz compinit
    autoload -Uz bashcompinit && bashcompinit
    local zcompf="$zCacheDir/zcompdump$cacheSuffix"
    # use a separate file to determine when to regenerate, as compinit doesn't
    # always need to modify the compdump
    local zcompf_a="${zcompf}.augur"

    if [[ -e "$zcompf_a" && -f "$zcompf_a"(#qN.md-1) ]]; then
        compinit -C -d "$zcompf"
    else
        compinit -d "$zcompf"
        touch "$zcompf_a"
    fi

    # complete dot files
    #_comp_options+=(globdots)

    # if zcompdump exists (and is non-zero), and is older than the .zwc file,
    # then regenerate
    if [[ -s "$zcompf" && (! -s "${zcompf}.zwc" || "$zcompf" -nt "${zcompf}.zwc") ]]; then
        # since file is mapped, it might be mapped right now (current shells), so
        # rename it then make a new one
        [[ -e "$zcompf.zwc" ]] && mv -f "$zcompf.zwc" "$zcompf.zwc.old"
        # compile it mapped, so multiple shells can share it (total mem reduction)
        # run in background
        zcompile -M "$zcompf" &!
    fi
}

_update_zcomp "$zCacheDir"
unfunction _update_zcomp

zcompcdir="$zCacheDir/zcompcache"
[[ -d "$zcompcdir" ]] || mkdir -p "$zcompcdir"

zstyle ':completion:*' cache-path "$zcompcdir"
zstyle ':completion:*' use-cache on
unset zcompcdir
unset zCacheDir

# Use menu completion
#zstyle ':completion:*' menu select
zstyle ':completion:*' menu 'select=4'

# simple matcher first, then case insensitive match
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# enable zsh-history-substring-search plugin
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# enable zsh-syntax-hilighting plugin
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#: <<'BLOCK_COMMENT'
#source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true

# This way you tell zsh comp to take the first part of the path to be
# exact, and to avoid partial globs. Now path completions became nearly
# immediate.
zstyle ':completion:*' accept-exact '*(N)'

# Always use menu selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# Verbose completion results
zstyle ':completion:*' verbose true

# Don't complete hosts from /etc/hosts
zstyle ':completion:*' hosts
# or users
#zstyle ':completion:*' users

# group results by category
#zstyle ':completion:*' group-name ''

# Use ls-colors for path completions
function _set-list-colors() {
     local LS_COLORS='no=00:fi=00:ca=00:di=36:ln=35:pi=33:so=36:bd=40;33;01:cd=40;33;01:or=35:mi=41;30;01:ex=31:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:'
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	unfunction _set-list-colors
}
_set-list-colors

# list dirs first
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' single-ignored show

# output format
#zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:descriptions' format '.: %d :.'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%Bno matches for: %F{214}%d%b'

# Dont complete uninteresting stuff unless we really want to.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
zstyle ':completion:*:*:*:users' ignored-patterns '_*'

## Better SSH/Rsync/SCP Autocomplete
# disable users in ssh tab completion
zstyle ':completion:*:*:ssh:*:my-accounts' off
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
#BLOCK_COMMENT
