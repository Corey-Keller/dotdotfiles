" =========================================================================
" File: 999_post.vim
" Author: Corey Keller
" Description: This file is for setup that needs to happen as late as
" possible during startup
" Repository: https://github.com/Corey-Keller/dotdotfiles
" Last Modified: 2020-02-12
" License: Mozilla Public License 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this file,
" You can obtain one at http://mozilla.org/MPL/2.0/.
" =========================================================================

" Only allow syntax to be set once, as multiple times can cause
" highlighting to be overwritten.
if !exists('g:syntax_on') && has('vim_starting') "{{{
	syntax enable
endif "}}}

" if has('vim_starting') "{{{
" 	if 'dein' ==? get(g:UserConfig, 'PluginManager','none') "{{{
" 		call dein#call_hook('post_source')
" 		augroup DeinPostHooks "{{{
" 			" Remove all auto-commands from the group, so that it isn't
" 			" added a second time if we re-source the file
" 			autocmd!
" 			autocmd VimEnter * call dein#call_hook('post_source')
" 		augroup END "}}}
" 	endif "}}}
" endif "}}}

set list

" Enable indentation rules (to automatically do language-dependent
" indenting) and plugins according to the detected filetype
" Revert with ":filetype off".
filetype plugin indent on

" " Load matchit.vim, but only if the user hasn't installed a newer
" " version.
" if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim',
" 	\ &runtimepath) ==# ''
" 	runtime! macros/matchit.vim
" endif

" vim:set filetype=vim:
