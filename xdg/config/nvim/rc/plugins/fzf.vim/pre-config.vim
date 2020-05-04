" Pre-plugin config for 'fzf.vim'
" This file is for anything that must be set BEFORE the plugin is sourced.

" Create empty non-existent variables {{{
if empty($FZF_DEFAULT_COMMAND)
	let $FZF_DEFAULT_COMMAND = ''
endif
if empty($FZF_DEFAULT_OPTS)
	let $FZF_DEFAULT_OPTS = ''
endif
if empty($FZF_CTRL_T_COMMAND)
	let $FZF_CTRL_T_COMMAND = ''
endif
if empty($FZF_CTRL_T_OPTS)
	let $FZF_CTRL_T_OPTS = ''
endif
if empty($FZF_ALT_C_COMMAND)
	let $FZF_ALT_C_COMMAND = ''
endif
if empty($FZF_ALT_C_OPTS)
	let $FZF_ALT_C_OPTS = ''
endif
" }}} Create empty non-existent variables

" if has('nvim') || has('gui_running')
" 	let $FZF_DEFAULT_OPTS .= ' --inline-info'
" endif

let g:fzf_colors ={
	\ 'fg':      ['fg', 'Normal'],
	\ 'bg':      ['bg', 'Normal'],
	\ 'hl':      ['fg', 'Comment'],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'Pmenu', 'CursorLine', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Statement'],
	\ 'info':    ['fg', 'PreProc'],
	\ 'border':  ['fg', 'Ignore'],
	\ 'prompt':  ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker':  ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment']
\}

" Terminal buffer options for fzf
augroup FzfTermBuffOpts "{{{1
	" Remove all auto-commands from the group, so that it isn't added
	" a second time if we re-source the file
	autocmd!
	autocmd! FileType fzf set noshowmode noruler nonumber
augroup END "}}}1

 " vim:set filetype=vim:
