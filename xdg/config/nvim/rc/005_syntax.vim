" ============================================================
" Name: 005_syntax.vim
" About: This file is for settings that effect syntax
" Author: Corey Keller
" Web: https://github.com/corey-keller/dotdotfiles
" Modification Date: 2020-01-30
" License: Mozilla Public License, Version 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at http://mozilla.org/MPL/2.0/.
" ============================================================

augroup syntaxdetect
	" Remove all auto-commands from the group, so that it isn't added a
	" second time if we re-source the file
	autocmd!
	autocmd BufNewFile,BufRead *.dircolors set syntax=dircolors
augroup END

augroup enableshfolding
	" Remove all auto-commands from the group, so that it isn't added a
	" second time if we re-source the file
	autocmd!
	autocmd FileType sh let g:sh_fold_enabled=7
	autocmd FileType sh let g:is_bash=1
	autocmd FileType sh set foldmethod=syntax
augroup END
