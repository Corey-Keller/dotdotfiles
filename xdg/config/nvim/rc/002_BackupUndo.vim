" ============================================================
" Name: 002_BackupUndo.vim
" About: This file is for settings that effect the ability to undo actions in
" vim, as well as those that effect making backups
" Author: Corey Keller
" Web: https://github.com/corey-keller/dotdotfiles
" Modification Date: 2020-01-30
" License: Mozilla Public License, Version 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at http://mozilla.org/MPL/2.0/.
" ============================================================

" ============================================================
" Backup {{{
" ============================================================
" Enable backup copies of files
set backup

set backupcopy=auto

set backupdir=$XDG_CACHE_HOME/vim/backup

if exists("*strftime")
	autocmd BufWritePre * let &backupext = '.backup_' .
	\ strftime("%Y-%m-%dT%H.%M.%S") . '.bak'
else
	set backupext=~
endif
" }}}

" ============================================================
" Undo {{{
" ============================================================
" Maintain undo history between sessions
set undofile

" Directory to store undo files in
set undodir=$XDG_CACHE_HOME/vim/undo/

" Make it possible to undo accidental Ctrl-U or Ctrl-W in insert mode
" Revert with ":iunmap <C-U>" or ":iunmap <C-W>" respectively.
if empty(mapcheck('<C-U>', 'i'))
	inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
	inoremap <C-W> <C-G>u<C-W>
endif
" }}}

" vim:set filetype=vim:
