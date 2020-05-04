" ============================================================
" Name: 045_indentation.vim
" About: This file is for settings that effect indentation.
" Author: Corey Keller
" Web: https://github.com/corey-keller/dotdotfiles
" Modification Date: 2020-01-30
" License: Mozilla Public License, Version 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at http://mozilla.org/MPL/2.0/.
" ============================================================

" Fold by indentation
" set foldmethod=syntax
set foldmethod=indent

" Start unfolded by default
augroup StartUnfolded "{{{1
	" Remove all auto-commands from the group, so that it isn't added a
	" second time if we re-source the file
	autocmd!
	" autocmd VimEnter * zR
	" autocmd BufNewFile,BufRead * normal! zR
	autocmd BufNewFile,BufRead,BufReadPost * silent! %foldopen!
augroup END "}}}1

" Use tabs instead of spaces. Revert with ":set expandtab"
" Reasoning: https://redd.it/c8drjo TL;DR: The fact that tab length is
" user controllable is essential to many visually impaired people.
set noexpandtab

" <Tab> inserts blanks according to 'shiftwidth'
set smarttab

" Force softtabstop to be tied to shiftwidth value by being negative
set softtabstop=-1

" Set tabs to display as this many spaces
" set shiftwidth=2

" vim:set filetype=vim:
