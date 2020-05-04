" =========================================================================
" File: 000_init.vim
" Author: Corey Keller
" Repo: https://github.com/Corey-Keller/dotdotfiles
" Last Modified: 2020-02-04
" License: MPL2
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this file,
" You can obtain one at http://mozilla.org/MPL/2.0/.
" =========================================================================

" ============================================================
" Disable unnecessary stuff {{{
" ============================================================
"Disable 'compatible' {{{
if has('vim_starting') && &compatible
	" vint: -ProhibitSetNoCompatible
	set nocompatible
endif "}}}

"Don't load matchit {{{
" We'll load our own version later
let g:loaded_matchit = 1 "}}}
" }}}

" ============================================================
" User Configuration {{{
" ============================================================
let g:UserConfig = get(g:, 'UserConfig',{})
let g:SysConfig = get(g:, 'SysConfig',{})

let g:UserConfig.VimConfig = fnameescape(resolve(expand(
	\ get(g:UserConfig, 'VimConfig', '$VIMCONFIGDIR'))))

let g:UserConfig.VimData = fnameescape(resolve(expand(
	\ get(g:UserConfig, 'VimData', '$VIMDATADIR'))))

let g:UserConfig.PluginConfigDir = fnameescape(resolve(expand(
	\ get(g:UserConfig, 'PluginConfigDir',
	\ g:UserConfig.VimConfig .'/rc/plugins'))))

" Is the setup we're using even remotely modern, i.e. using at least:
" Vim 8 (released 2016-09-12) or neovim 0.2.1 (released 2017-11-07)
" Python 3 (released 2008-12-03)
if v:version >= 800 && has('python3') "{{{
	let g:SysConfig.Modern = 1
else
	let g:SysConfig.Modern = 0
endif "}}}

if !has_key(g:UserConfig,'PluginManager') "{{{
	let g:UserConfig.PluginManager = g:SysConfig.Modern ? 'dein' :
	\ 'vim-plug'
endif "}}}

if !has_key(g:UserConfig,'Completion') "{{{
	let g:UserConfig.Completion = g:SysConfig.Modern ? 'coc' :
	\ 'asyncomplete'
endif "}}}

if !has_key(g:UserConfig,'Finder') "{{{
	if executable('fzf') "{{{
		let g:UserConfig.Finder = 'fzf'
	else
		let g:UserConfig.Finder = 'leaderf'
	endif "}}}
endif "}}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Snippet Variables {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:snips_author = get(g:, 'snips_author', 'Corey Keller')
let g:snips_email = get(g:, 'snips_email', 'contact@coreykeller.net')
let g:snips_github = get(g:, 'snips_github',
\ 'https://github.com/Corey-Keller') " }}}
" }}}

" ============================================================
" Custom Commands {{{
" ============================================================
command! Mkhead1 call fns#MkHeader(1)
command! Mkhead2 call fns#MkHeader(2)
command! Mkhead3 call fns#MkHeader(3)
command! Unmkhead call fns#MkHeader(0)
" }}}

" ============================================================
" Better grep "{{{
" ============================================================
if executable("rg")
	set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
	set grepformat=%f:%l:%c:%m
endif
" }}}

" vim:set filetype=vim:
