" Post-plugin config for 'asyncomplete-necosyntax.vim'
" This file is for anything that must be set AFTER the plugin is sourced.

" Registration for asyncomplete-necosyntax.vim plugin
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
    \ 'name': 'necosyntax',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
    \ }))

" vim:set filetype=vim:
