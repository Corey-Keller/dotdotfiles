" Post-plugin config for 'asyncomplete-necovim.vim'
" This file is for anything that must be set AFTER the plugin is sourced.

" Registration for asyncomplete-necovim.vim plugin
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
    \ 'name': 'necovim',
    \ 'whitelist': ['vim'],
    \ 'completor': function('asyncomplete#sources#necovim#completor'),
    \ }))

" vim:set filetype=vim:
