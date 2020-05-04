" =========================================================================
" File: man.vim
" Author: Corey Keller
" Description: This file is for settings that I want to explicitly set for
" 'man' files
" Repository: https://github.com/Corey-Keller/dotdotfiles
" Last Modified: 2020-04-14
" License: Mozilla Public License 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this file,
" You can obtain one at http://mozilla.org/MPL/2.0/.
" =========================================================================

if !exists('g:no_plugin_maps') && !exists('g:no_man_maps')
	" Make :Man use a vertical split
	nnoremap <silent> <buffer> <C-]>      :vertical Man<CR>
	nnoremap <silent> <buffer> K          :vertical Man<CR>

	" Jump to links with enter
	nnoremap <silent> <buffer> <CR> :Man<CR>

	" Jump back with backspace
	nnoremap <silent> <buffer> <BS> :call man#pop_tag()<CR>

endif

" vim:set filetype=vim:
