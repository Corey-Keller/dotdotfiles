" Post-plugin config for 'asyncomplete-file.vim'
" This file is for anything that must be set AFTER the plugin is sourced.

" Registration for asyncomplete-file.vim plugin
autocmd User asyncomplete_setup call
\ asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

" vim:set filetype=vim:
