" ============================================================
" Name: 025_dein.vim
" About: This file is for loading plugins using dein
" Author: Corey Keller
" Web: https://github.com/corey-keller/dotdotfiles
" Modification Date: 2020-01-30
" License: Mozilla Public License, Version 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at http://mozilla.org/MPL/2.0/.
" ============================================================

" Only run if we're using dein
if g:UserConfig.PluginManager !=? 'dein' "{{{
  finish
endif "}}}

" ============================================================
" Variables {{{
" ============================================================
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Script Variables {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let s:dein_root_dir = g:UserConfig.VimData . '/dein'
let s:dein_repo_dir = s:dein_root_dir . '/repos/github.com/Shougo/dein.vim'
let s:vim_prog_name = fnamemodify(v:progname, ':r')
" }}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Global Variables {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:dein#cache_directory = fnameescape(expand('$XDG_CACHE_HOME/vim/dein')) .
	\ '/' . s:vim_prog_name
let g:dein#install_log_filename =  g:dein#cache_directory . '/' .
	\ s:vim_prog_name . '_dein_install.log'
let g:dein#auto_recache = 1
" }}}

" }}}

" If dein isn't installed, install it
if !isdirectory(s:dein_repo_dir) "{{{
	execute '!git clone https://github.com/Shougo/dein.vim ' .
	\ s:dein_repo_dir
endif "}}}

" Add the dein installation directory into runtimepath
execute 'set runtimepath^=' . s:dein_repo_dir

augroup DeinPostHooks "{{{
	" Remove all auto-commands from the group, so that it isn't added
	" a second time if we re-source the file
	autocmd!
	autocmd VimEnter * call dein#call_hook('post_source')
augroup END "}}}

function s:PostDeinSetup() abort "{{{
	" call hooks
	call dein#call_hook('source')
endfunction " }}}

if !dein#load_state(s:dein_root_dir) "{{{
	call s:PostDeinSetup()
	finish
endif "}}}

let s:vim_rc_dir = g:UserConfig.VimConfig . '/rc'
let s:vim_rc_files = split(glob(s:vim_rc_dir .
	\ '/**/*.\(vim\|toml\|json\)'))
let s:dein_toml = g:UserConfig.PluginConfigDir .
	\ '/dein/plugins.toml'
let s:dein_lazy_toml = g:UserConfig.PluginConfigDir .
	\ '/dein/plugins_lazy.toml'

call dein#begin(s:dein_root_dir, s:vim_rc_files)
call dein#load_toml(s:dein_lazy_toml, {'lazy' : 1})
call dein#load_toml(s:dein_toml, {'lazy' : 0})

if g:UserConfig.Completion ==? 'asyncomplete' "{{{
	let s:dein_asyncomplete_toml = g:UserConfig.PluginConfigDir .
		\ '/dein/plugins_asyncomplete.toml'
	call dein#load_toml(s:dein_asyncomplete_toml)
endif "}}}

for s:plugin_name in keys(g:dein#_plugins) "{{{
	" Make any missing plugin config files
	execute 'call fns#CheckPlugConfigFiles(''' . s:plugin_name . ''')'

	" Install any missing plugins
	execute 'if dein#check_install(''' . s:plugin_name . ''')
	\| call dein#install(''' . s:plugin_name . ''')|endif'

	" Set all plugins to source '/plugin-name/pre-config.vim' before
	" loading the 'plugin-name' plugin, and source
	" '/plugin-name/post-config.vim' after it is sourced
	execute 'call dein#config(''' . s:plugin_name .
	\ ''', {''hook_source'':''source ' . g:UserConfig.PluginConfigDir .
	\ '/' . s:plugin_name .
	\ '/pre-config.vim'',''hook_post_source'': ''source ' .
	\ g:UserConfig.PluginConfigDir . '/' . s:plugin_name .
	\ '/post-config.vim'',})'
endfor "}}}

call dein#end()
call dein#save_state()

call s:PostDeinSetup()

" vim:set filetype=vim:
