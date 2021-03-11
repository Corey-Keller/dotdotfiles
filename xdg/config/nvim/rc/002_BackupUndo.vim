" ============================================================
" Name: 002_BackupUndo.vim
" About: This file is for settings that effect the ability to undo actions
" in vim, as well as those that effect making backups
" Author: Corey Keller
" Web: https://github.com/corey-keller/dotdotfiles
" Modification Date: 2020-07-31
" License: Mozilla Public License, Version 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at http://mozilla.org/MPL/2.0/.
" ============================================================

" ============================================================
" Variables
" ============================================================
let s:backup_directory = $XDG_CACHE_HOME . '/vim/backup'
let s:undo_directory = $XDG_CACHE_HOME . '/vim/undo'

" ============================================================
" Backup {{{
" ============================================================
" Enable backup copies of files
set backup

set backupcopy=auto

" Directory to store backup files in
let &backupdir = s:backup_directory

augroup SetBackupExt "{{{
	" Remove all auto-commands from the group, so that it isn't added
	" a second time if we re-source the file
	autocmd!
	if exists("*strftime")
		autocmd BufWritePre * let &backupext = '.backup_' .
		\ strftime("%Y-%m-%dT%H.%M.%S") . '.bak'
	else
		set backupext=~
	endif
augroup END "}}}
" }}}

" ============================================================
" Undo {{{
" ============================================================
" Maintain undo history between sessions
set undofile

" Directory to store undo files in
let &undodir = s:undo_directory

" Make it possible to undo accidental Ctrl-U or Ctrl-W in insert mode
" Revert with ":iunmap <C-U>" or ":iunmap <C-W>" respectively.
if empty(mapcheck('<C-U>', 'i'))
	inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
	inoremap <C-W> <C-G>u<C-W>
endif
" }}}

" ============================================================
" Make missing directories {{{
" ============================================================
for s:directory_to_check in [s:backup_directory, s:undo_directory] "{{{
	if !isdirectory(s:directory_to_check)
		call mkdir(s:directory_to_check, "p")
	endif
endfor "}}}
" }}}

" vim:set filetype=vim:
