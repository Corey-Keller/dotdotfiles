" ============================================================
" Name: 800_colorscheme.vim
" About: This file is for setting the colorscheme
" Author: Corey Keller
" Web: https://github.com/corey-keller/dotdotfiles
" Modification Date: 2020-01-30
" License: Mozilla Public License, Version 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at http://mozilla.org/MPL/2.0/.
" ============================================================

if !exists('$VIM_THEME')
	let $VIM_THEME = get(g:UserConfig, 'Colorscheme', $GLOBAL_THEME)
endif

function s:DynamicSetBg() abort "{{{
	if $VIM_THEME =~? 'dark'
		set background=dark
	elseif $VIM_THEME =~? 'light'
		set background=light
	else
		set background=light
	endif
endfunction "}}}

set termguicolors
call s:DynamicSetBg()

if $VIM_THEME =~? 'onehalf'
	if &background ==? 'dark'
		colorscheme onehalfdark
	elseif &background ==? 'light'
		colorscheme onehalflight
	endif
elseif $VIM_THEME =~? 'one'
	colorscheme one
	call s:DynamicSetBg()
elseif $VIM_THEME =~? 'stylus'
	colorscheme stylus
elseif $VIM_THEME =~? 'pencil'
	colorscheme pencil
elseif $VIM_THEME =~? 'nord'
	colorscheme nord
elseif $VIM_THEME =~? 'papercolor'
	colorscheme PaperColor
elseif $VIM_THEME =~? 'ayu'
	colorscheme ayu | let ayucolor=&background
elseif $VIM_THEME =~? 'gruvbox'
	colorscheme gruvbox
endif

if !exists('g:colors_name')
	try
		colorscheme $VIM_THEME
		catch
		try
			colorscheme default
			catch
		endtry
	endtry
endif

if g:colors_name =~ "base16-"
	let g:base16_shell_path=$BASE16_SHELL
 if filereadable(expand("~/.vimrc_background"))
		let base16colorspace=256
		source ~/.vimrc_background
	endif
endif

" vim:set filetype=vim:
