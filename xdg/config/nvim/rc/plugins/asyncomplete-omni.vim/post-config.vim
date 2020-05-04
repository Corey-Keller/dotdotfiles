" Post-plugin config for 'asyncomplete-omni.vim'
" This file is for anything that must be set AFTER the plugin is sourced.

" Registration for asyncomplete-omni.vim plugin
call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
\ 'name': 'omni',
\ 'whitelist': ['*'],
\ 'blacklist': ['c', 'cpp', 'html'],
\ 'completor': function('asyncomplete#sources#omni#completor')
\  }))

" vim:set filetype=vim:
