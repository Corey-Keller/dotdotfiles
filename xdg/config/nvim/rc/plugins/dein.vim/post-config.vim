" Post-plugin config for 'dein.vim'
" This file is for anything that must be set AFTER the plugin is sourced.

command! -bar DeinRecache call dein#clear_state()|
\ call dein#recache_runtimepath()|call dein#remote_plugins()

" vim:set filetype=vim:
