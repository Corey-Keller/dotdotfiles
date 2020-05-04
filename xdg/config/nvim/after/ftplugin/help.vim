" =========================================================================
" File: help.vim
" Author: Corey Keller
" Description: This file is for settings that I want to explicitly set for
" 'help' files.
" Repository: https://github.com/Corey-Keller/dotdotfiles
" Last Modified: 2020-04-27
" License: Mozilla Public License 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this file,
" You can obtain one at http://mozilla.org/MPL/2.0/.
" =========================================================================

" Jump to links with enter
nmap <silent> <buffer> <CR> <C-]>

" Jump back with backspace
nmap <silent> <buffer> <BS> <C-T>

" q to quit
nmap <silent> <buffer> q :quit<CR>

" Open help in the right window
" augroup HelpInRightWin "{{{1
" 	" Remove all auto-commands from the group, so that it isn't added
" 	" a second time if we re-source the file
" 	autocmd!
" 	autocmd! BufWinEnter * if &filetype ==# 'help' | wincmd L | endif
" augroup END "}}}1

" Use ReStructuredText style tables because they look better
let b:table_mode_corner_corner = '+'
let b:table_mode_header_fillchar = '='

" vim:set filetype=vim:
