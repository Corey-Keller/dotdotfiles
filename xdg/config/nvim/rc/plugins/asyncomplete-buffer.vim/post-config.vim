" Post-plugin config for 'asyncomplete-buffer.vim'
" This file is for anything that must be set AFTER the plugin is sourced.

" Registration for asyncomplete-buffer.vim plugin
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

" vim:set filetype=vim:
