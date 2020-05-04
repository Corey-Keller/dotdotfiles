" Post-plugin config for 'deoplete.nvim'
" This file is for anything that must be set AFTER the plugin is sourced.

if ((g:UserConfig.PluginManager ==? 'vim-plug' && has_key(g:plugs, 'ale'))
  \ || (g:UserConfig.PluginManager ==? 'dein' && dein#tap('ale'))) "{{{1
  " Use ALE and also some plugin 'foobar' as completion sources for all code.
  " call deoplete#custom#option('sources', {
  " \ '_': ['ale', 'foobar'],
  " \})
endif "}}}1
function! s:check_back_space() abort "{{{1
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~? '\s'
endfunction "}}}1
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" vim:set filetype=vim:
