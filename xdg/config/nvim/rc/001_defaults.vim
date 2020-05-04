" =========================================================================
" File: 001_defaults.vim
" Author: Corey Keller
" Description: Some defaults that I prefer.
" Repository: https://github.com/Corey-Keller/dotdotfiles
" Last Modified: 2020-04-29
" License: Mozilla Public License 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this file,
" You can obtain one at http://mozilla.org/MPL/2.0/.
" =========================================================================

" ============================================================
" Mappings {{{
" ============================================================
" Set <leader> to the spacebar button
let mapleader="\<Space>"

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Disable arrow keys (to force me to use hjkl) {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
noremap <up>    :echoerr 'Use "k" to go up'<CR>
noremap <down>  :echoerr 'Use "j" to go down'<CR>
noremap <left>  :echoerr 'Use "h" to go left'<CR>
noremap <right> :echoerr 'Use "l" to go right'<CR>
" }}}
" }}}

" ============================================================
" Window Management {{{
" ============================================================
" Make switching windows easier
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W

" Horizontal splits open the new window on bottom
set splitbelow

" Vertical splits open the new window to the right
set splitright

" Make documentation files (help, man) open in a vertical window on the
" right.
augroup DocsInRightWin "{{{
	" Remove all auto-commands from the group, so that it isn't added
	" a second time if we re-source the file
	autocmd!
	autocmd BufWinEnter * if &filetype ==? 'help' | wincmd L | endif
	" autocmd BufWinEnter * if &filetype ==? 'man' | wincmd L | endif
	autocmd FileType man :wincmd L
augroup END "}}}

" }}}

" ============================================================
" Misc {{{
" ============================================================
" Silence the |ins-completion-menu| messages in the command line such as
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match', 'Pattern
" not found', 'Back at original', etc.
if has('patch-7.4.314')
	set shortmess+=c
endif

" Better display for messages, also reduces instances of 'Press ENTER or
" type command to continue' prompts
set cmdheight=2

" Prefer unix format for files.
set fileformats=unix,dos

" Show matching brackets
set showmatch

" This method of sudoing is broken in nvim (see
" https://github.com/neovim/neovim/issues/1716). As a workaround, install
" https://github.com/lambdalisue/suda.vim
if !has('nvim') "{{{
	" Allow saving of files as sudo when forgot to start vim using sudo
	cmap w!! w !sudo tee > /dev/null %
	cmap wq!! w !sudo tee > /dev/null %\|q
endif "}}}

" Enable file type detection. Also load indent files, to automatically do
" language-dependent indenting. Revert with ":filetype off".
filetype plugin indent on

" Terminal beeps are annoying, so disable them always
set belloff=all

" Show what commands you're typing
set showcmd

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" More intuitive text formatting
set formatoptions=tcqj

" Directory to store swap files in
set directory=$XDG_CACHE_HOME/vim/swap//

" time out on mapping after three seconds, time out on key codes
" after a tenth of a second
set timeout timeoutlen=3000 ttimeoutlen=100

let g:extended_font = 1

" don't scan included files for completion
set complete-=i

" Pad (and left align) the 'showbreak' character so that it is as wide
" as the line number area
let &showbreak = repeat(' ', &numberwidth - 1)

" Set the 'showbreak character based on if we have unicode fonts available
scriptencoding utf-8
	let &showbreak.=g:extended_font?'↪':'>'
scriptencoding
" Move the 'showbreak' characters to the line number area
set cpoptions+=n

" Keep at least 10000 lines of command line history
if &history < 10000 "{{{
	set history=10000
endif "}}}

" Don't complain about unsaved files when switching buffers.
set hidden

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find
" it confusing.
set nrformats-=octal

" Lowering this improves performance in files with long lines.
if &synmaxcol > 500
	set synmaxcol=500
endif

" Show a few lines of context around the cursor. Note that this makes
" the text scroll if you mouse-click near the start or end of the window.
set scrolloff=2

" Set a reasonable line length
set textwidth=75

" Set a visible warning for long columns
set colorcolumn=+1
" }}}

" vim:set filetype=vim:
