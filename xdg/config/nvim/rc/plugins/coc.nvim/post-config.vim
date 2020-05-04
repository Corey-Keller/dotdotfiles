" Post-plugin config for 'coc.nvim'
" This file is for anything that must be set AFTER the plugin is sourced.

call coc#add_extension(
	\ 'coc-json',
	\ 'coc-powershell',
	\ 'coc-tag',
	\ 'coc-dictionary',
	\ 'coc-snippets',
	\ 'coc-lists',
	\ 'coc-highlight',
	\ 'coc-vimlsp',
	\ 'coc-pairs',
	\ 'coc-diagnostic',
	\ 'coc-git',
	\ 'coc-spell-checker',
	\)

" nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

let g:coc_snippet_next = get(g:, 'UltiSnipsJumpForwardTrigger', '<C-d>')
let g:coc_snippet_prev = get(g:, 'UltiSnipsJumpBackwardTrigger', '<C-f>')

" imap <C-e> <Plug>(coc-snippets-expand)
xmap <Tab> <Plug>(coc-snippets-select)

" vim:set filetype=vim:
