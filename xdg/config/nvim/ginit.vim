" =========================================================================
" File: ginit.vim
" Author: Corey Keller
" Description: My GUI (n)vimrc
" Repository: https://github.com/Corey-Keller/dotdotfiles
" Last Modified: 2020-02-13
" License: Mozilla Public License 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this file,
" You can obtain one at http://mozilla.org/MPL/2.0/.
" =========================================================================

if exists('g:fvim_loaded')
	" good old 'set guifont' compatibility
	set guifont=FiraCodeNF:h14
	" Ctrl-ScrollWheel for zooming in/out
	nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
	nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
	nnoremap <A-CR> :FVimToggleFullScreen<CR>
	FVimCursorSmoothMove v:true
	FVimCursorSmoothBlink v:true
endif

" vim:set filetype=vim:
