" =========================================================================
" File: 050_statusline.vim
" Author: Corey Keller
" Description: This file is for setting the statusline.
" Repository: https://github.com/Corey-Keller/dotdotfiles
" Last Modified: 2020-02-24
" License: Mozilla Public License 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this file,
" You can obtain one at http://mozilla.org/MPL/2.0/.
" =========================================================================

function! SetActiveStatusLine() abort "{{{
	let l:statusline = []
	" call add(l:statusline, ' %{strftime(''%H:%M:%S'')}')
	" call add(l:statusline, ' %{mode()}')

	if get(g:, 'loaded_thirsty')
		call add(l:statusline, '%#ErrorMsg#%{thirsty#run()}')
		" call add(l:statusline, '%{thirsty#statusline(''Search'')}')
	endif
	call add(l:statusline, '%#SlModeColor# %-8{ModeCurrent()}')
	call add(l:statusline, ' %n ')                         " buffer number
	if get(g:, 'did_coc_loaded')
		call add(l:statusline, '%#ErrorMsg#%{Status_Coc_Error()}')
		call add(l:statusline, '%#WarningMsg#%{Status_Coc_Warning()}')
	endif
	call add(l:statusline, '%#Visual#')                   " colour
	call add(l:statusline, '%{&paste?'' PASTE '':''''}')
	call add(l:statusline, '%{&spell?'' SPELL '':''''}')
	call add(l:statusline, '%#StatusLine#')               " colour
	call add(l:statusline, '%R')                          " readonly flag
	call add(l:statusline, '%M')                          " modified [+] flag
	if get(g:, 'loaded_fugitive')
		call add(l:statusline, '%#Cursor#%{FugitiveStatusline()}')
		call add(l:statusline, '%#StatusLine#')
	endif
	call add(l:statusline, ' %t ')                        " short file name
	call add(l:statusline, '%=')                          " right align
	if get(g:, 'loaded_gutentags')
		call add(l:statusline, '%{gutentags#statusline()}')
	endif
	call add(l:statusline, ' %3l:%-2c ')                  " line:column
	call add(l:statusline, '%#StatusLineNC#')             " colour
	" Set file encoding
	call add(l:statusline, '%{toupper(strlen(&fileencoding)?(&fileencoding . '' | ''):'''')}')
	call add(l:statusline, '%{ShowNewline()}')            " line ending
	call add(l:statusline, '%#StatusLine#')               " colour
	call add(l:statusline, ' %Y ')                        " file type
	execute 'setlocal statusline='.escape(join(l:statusline, ''), ' |')
	" return join(l:statusline, '')
endfunction "}}}

function! SetInactiveStatusLine() abort "{{{
	let l:statusline = ['%#StatusLineNC#']                " colour
	call add(l:statusline, ' %F ')                        " full file name
	" return join(l:statusline, '')
	execute 'setlocal statusline='.escape(join(l:statusline, ''), ' |')
	" execute 'setlocal statusline=%!'.join(l:statusline, '')
endfunction "}}}

function s:add_if_func_exists(name, ...) abort "{{{
	let l:end_string_list = []
	if a:0
		call extend(l:end_string_list, ['%#', a:1, '#'])
	endif
	if exists('*' . a:name)
		call extend(l:end_string_list, ['%{', a:name, '()}'])
	endif
	if a:0 > 1
		call extend(l:end_string_list, ['%#', a:2, '#'])
	endif
	return join(l:end_string_list, '')
endfunction "}}}

function s:main() abort "{{{
	" Don't show what mode you're currently in because that's in the
	" statusline
	set noshowmode
	set laststatus=2
	augroup SetStatusLine
		autocmd!
		autocmd WinEnter,BufEnter * call SetActiveStatusLine()
		autocmd WinLeave,BufLeave * call SetInactiveStatusLine()
		" autocmd WinEnter,BufEnter * setlocal statusline=%!SetActiveStatusLine()
		" autocmd WinLeave,BufLeave * setlocal statusline=%!SetInactiveStatusLine()
	augroup END
endfunction "}}}

" List of all modes {{{
let g:Sl_Mode_Labels = get(g:, 'Sl_Mode_Labels',{})
let g:Sl_Mode_Labels['n'] = get(g:Sl_Mode_Labels, 'n', 'NORMAL')
let g:Sl_Mode_Labels['no'] = get(g:Sl_Mode_Labels, 'no', 'OP PEND')
let g:Sl_Mode_Labels['v'] = get(g:Sl_Mode_Labels, 'v', 'VISUAL ')
let g:Sl_Mode_Labels['V'] = get(g:Sl_Mode_Labels, 'V', 'V·LINE')
let g:Sl_Mode_Labels["\<C-v>"] = get(g:Sl_Mode_Labels, "\<C-v>", 'V·BLOCK')
let g:Sl_Mode_Labels['s'] = get(g:Sl_Mode_Labels, 's', 'SELECT')
let g:Sl_Mode_Labels['S'] = get(g:Sl_Mode_Labels, 'S', 'S·LINE')
let g:Sl_Mode_Labels["\<C-s>"] = get(g:Sl_Mode_Labels, "\<C-s>", 'S·BLOCK')
let g:Sl_Mode_Labels['i'] = get(g:Sl_Mode_Labels, 'i', 'INSERT')
let g:Sl_Mode_Labels['R'] = get(g:Sl_Mode_Labels, 'R', 'REPLACE')
let g:Sl_Mode_Labels['Rv'] = get(g:Sl_Mode_Labels, 'Rv', 'V·REPL')
let g:Sl_Mode_Labels['c'] = get(g:Sl_Mode_Labels, 'c', 'COMMAND')
let g:Sl_Mode_Labels['cv'] = get(g:Sl_Mode_Labels, 'cv', 'Vim Ex')
let g:Sl_Mode_Labels['ce'] = get(g:Sl_Mode_Labels, 'ce', 'Ex')
let g:Sl_Mode_Labels['r'] = get(g:Sl_Mode_Labels, 'r', 'Prompt')
let g:Sl_Mode_Labels['rm'] = get(g:Sl_Mode_Labels, 'rm', 'More')
let g:Sl_Mode_Labels['r?'] = get(g:Sl_Mode_Labels, 'r?', 'Confirm')
let g:Sl_Mode_Labels['!'] = get(g:Sl_Mode_Labels, '!', 'Shell')
let g:Sl_Mode_Labels['t'] = get(g:Sl_Mode_Labels, 't', 'Terminal')

let g:Sl_Visual_Mode_List = ['VISUAL', ' V·LINE', 'V·BLOCK']
let g:Sl_Select_Mode_List = ['SELECT', ' S·LINE', 'S·BLOCK']
" }}} List of all modes

" Function: return current mode
function! ModeCurrent() abort "{{{
	let l:currentMode = mode()
	" use get() -> fails safely, since ^V doesn't seem to register
	" 3rd arg is used when return of mode() == 0, which is case with ^V
	" thus, ^V fails -> returns 0 -> replaced with the visual block value
	let l:currentModeLabel = get(g:Sl_Mode_Labels, l:currentMode, get(g:Sl_Mode_Labels, "\<C-v>"))

	call ModeCurrentColor(l:currentMode)

	return l:currentModeLabel
endfunction "}}}

" Function: return current mode color
function! ModeCurrentColor(mode) abort "{{{
	" Default highlight rules if they aren't defined already.
	highlight link NormalMode DiffAdd
	highlight link InsertMode Search
	highlight link ReplaceMode DiffDelete
	highlight link SelectMode WildMenu
	highlight link CommandMode Todo
	highlight link VisualMode Cursor

	if a:mode ==# 'n'
		highlight! link SlModeColor NormalMode
	elseif a:mode ==# 'c'
		highlight! link SlModeColor CommandMode
	elseif a:mode == 'i'
		highlight! link SlModeColor InsertMode
	elseif a:mode ==# 'R'
		highlight! link SlModeColor ReplaceMode
	elseif (index(['v', 'V', "\<C-v>"], a:mode) >=0)
		highlight! link SlModeColor VisualMode
	elseif (index(g:Sl_Select_Mode_List, a:mode) >=0)
	elseif (index(['s', 'S', "\<C-s>"], a:mode) >=0)
		highlight! link SlModeColor SelectMode
	else
		highlight! link SlModeColor Visual
	endif
endfunction "}}}

function! ShowNewline() abort "{{{
	" Labels for types of line breaks {{{
	let g:Sl_Newline_Labels = get(g:, 'Sl_Newline_Labels',{
	\ 'unix': 'LF',
	\ 'mac': 'CR',
	\ 'dos': 'CRLF'
	\}) " }}} Labels for types of line breaks

	" show newline
	return get(g:Sl_Newline_Labels, &fileformat, &fileformat)
endfunction "}}}

function! Status_Coc_Error() abort "{{{
	let info = get(b:, 'coc_diagnostic_info', {})
	if empty(info) | return '' | endif
	if get(info, 'error', 0)
		return 'E' . info['error']
	else
		return ''
	endif
endfunction "}}}

function! Status_Coc_Warning() abort "{{{
	let info = get(b:, 'coc_diagnostic_info', {})
	if empty(info) | return '' | endif
	if get(info, 'warning', 0)
		return 'W' . info['warning']
	else
		return ''
	endif
endfunction "}}}

call s:main()

" vim:set filetype=vim:
