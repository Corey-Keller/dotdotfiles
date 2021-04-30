" =========================================================================
" File: init.vim
" Author: Corey Keller
" Description: My (n)vimrc
" Repository: https://github.com/Corey-Keller/dotdotfiles
" Last Modified: 2021-04-30
" License: Mozilla Public License 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this file,
" You can obtain one at http://mozilla.org/MPL/2.0/.
" =========================================================================

if (has('win64')||has('win32'))
	let g:python3_host_prog='C:\Tools\python3\python.exe'
	let g:python_host_prog='C:\Tools\python2\python.exe'
endif

let s:local_vimrc = fnameescape(resolve(expand('~/.local_vimrc')))
if filereadable(s:local_vimrc) "{{{
	execute 'source ' . s:local_vimrc
endif "}}}

" If $XDG_DATA_HOME, $XDG_CONFIG_HOME, or $XDG_CACHE_HOME are empty,
" set them to the default
if empty($XDG_DATA_HOME) "{{{
	let $XDG_DATA_HOME = fnameescape(resolve(expand('~/.local/share')))
endif "}}}
if empty($XDG_CONFIG_HOME) "{{{
	let $XDG_CONFIG_HOME = fnameescape(resolve(expand('~/.config')))
endif "}}}
if empty($XDG_CACHE_HOME) "{{{
	let $XDG_CACHE_HOME = fnameescape(resolve(expand('~/.cache')))
endif "}}}

" Set vim data directory (plugins, backups, swap/undo files and other
" files that aren't edited by the user)
if empty($VIMDATADIR) "{{{
	let $VIMDATADIR = $XDG_DATA_HOME . '/nvim'
endif "}}}

" Set the vim config directory (user configuration files)
if empty($VIMCONFIGDIR) "{{{
	let $VIMCONFIGDIR = $XDG_CONFIG_HOME .'/nvim'
endif "}}}

" load the lua config instead if we have nvim >= 0.5
if has('nvim-0.5') "{{{
	if has('vim_starting') "{{{
		set runtimepath^=$VIMDATADIR
		set runtimepath^=$VIMCONFIGDIR
		lua require('init')
		finish
	endif "}}}
endif "}}}

if has('vim_starting') "{{{
	set runtimepath^=$VIMDATADIR
	set runtimepath+=$VIMDATADIR/after
	set runtimepath^=$VIMCONFIGDIR
	set runtimepath+=$VIMCONFIGDIR/after

	" check if vim is at least version 8
	if v:version >= 800 "{{{
		set packpath^=$VIMDATADIR
	endif "}}}

	runtime! rc/[0-9][0-9][0-9]_*.vim
endif "}}}

" vim:set filetype=vim:
