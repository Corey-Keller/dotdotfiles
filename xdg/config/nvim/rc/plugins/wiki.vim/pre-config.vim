" Pre-plugin config for 'wiki.vim'
" This file is for anything that must be set BEFORE the plugin is sourced.

let g:wiki_root = '/src/github.cerner.com/ck050750/Notes'
let g:wiki_filetypes = ['md', 'markdown']
let g:wiki_link_target_type = 'md'
let g:wiki_link_target_map = 'WikiLinkRestructure'
let g:wiki_mappings_global = {
    \ '<Plug>(wiki-link-next)' : '<leader>wN',
    \ '<Plug>(wiki-link-prev)' : '<leader>wP',
	\}
function! WikiLinkRestructure(text) abort "{{{
  " 'Some Text' becomes 'some-text/index'
  return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction "}}}

function! WikiBase64Link() abort "{{{
	let l:linktext = '<img src="data:image/png;base64,' .
	\ system('base64 -w 0 ~/clipboard.png') . '" />'
	" echom l:linktext
	put =l:linktext
endfunction "}}}

nnoremap <leader>wi :call WikiBase64Link()<CR>



" vim:set filetype=vim:
