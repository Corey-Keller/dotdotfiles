" =========================================================================
" File: plugins.vim
" Author: Corey Keller
" Description: Non-lazily loaded plugins
" Repository: https://github.com/Corey-Keller/dotdotfiles
" Last Modified: 2020-04-27
" License: Mozilla Public License 2.0
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this file,
" You can obtain one at http://mozilla.org/MPL/2.0/.
" =========================================================================

" ============================================================
" Colorschemes #{{{
" ============================================================
call dein#add('wimstefan/vim-artesanal')

call dein#add('laggardkernel/vim-one')

call dein#add('arcticicestudio/nord-vim')

call dein#add('ayu-theme/ayu-vim')

call dein#add('jeffkreeftmeijer/vim-dim')

call dein#add('nickburlett/vim-colors-stylus')

call dein#add('lifepillar/vim-solarized8')

call dein#add('reedes/vim-colors-pencil')

call dein#add('NLKNguyen/papercolor-theme')

call dein#add('romainl/apprentice')

call dein#add('sonph/onehalf', {
\ 'rtp' : 'vim/'
\ })
"}}}

" ============================================================
" Language Specific #{{{
" ============================================================
call dein#add('cespare/vim-toml', {
\ 'on_ft' : 'toml'
\ })

call dein#add('kevinoid/vim-jsonc', {
\ 'on_ft' : 'jsonc'
\ })
"}}}

" ============================================================
" Completion #{{{
" ============================================================
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" coc specific plugins
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
call dein#add('neoclide/coc-neco', {
\ 'if' : "dein#tap('coc.nvim')",
\ 'on_source' : ['neco-vim'],
\ 'depends' : ['coc.nvim', 'neco-vim']
\ })
"}}}

" ============================================================
" Fuzzy Finder #{{{
" ============================================================
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" fzf
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
call dein#add('junegunn/fzf', {
\ 'if' : "g:UserConfig.Finder ==? 'fzf'",
\ 'path' : "$GHDIR/junegunn/fzf",
\ 'hook_post_update' : './install --all'
\ })

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" LeaderF
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Navigate marks
call dein#add('yggdroot/leaderf-marks', {
\ 'depends' : ['leaderf'],
\ 'if' : "dein#tap('leaderf')"
\ })
"}}}

" ============================================================
" Programming #{{{
" ============================================================
" Use EditorConfig (https://editorconfig.org/) to determine
" project standards
call dein#add('editorconfig/editorconfig-vim')

" Show invisible characters (tab, space, nbsp etc) in vim
call dein#add('Corey-Keller/invisiblechars.vim')

" Linting engine
" [[plugins]]
" repo = 'dense-analysis/ale'
"}}}

" ============================================================
" Vim Improvements #{{{
" ============================================================
" Make '.' repeat full mappings
call dein#add('tpope/vim-repeat')

" Set 'path', 'suffixesadd', 'include', 'includeexpr', and 'define'
"for several file types
call dein#add('tpope/vim-apathy')

" Allow saving with sudo
call dein#add('lambdalisue/suda.vim', {
\ 'if' : "has('nvim') && executable('sudo')"
\ })

" A better Directory viewer than netrw
call dein#add('justinmk/vim-dirvish')
" on_map = { #{{{
" 	n = ['<Plug>(dirvish_up)', '<Plug>(dirvish_split_up)',
" 	'<Plug>(dirvish_split_up)']
" } #}}}
" on_cmd = ['Dirvish','Shdo']

" Add git status icons in dirvish
call dein#add('kristijanhusak/vim-dirvish-git')

" Show diff when recovering swap file
call dein#add('chrisbra/recover.vim')
"}}}

" ============================================================
" Vim Specific #{{{
" ============================================================
call dein#add('roxma/nvim-yarp', {
\ 'if' : "!has('nvim')"
\ })

call dein#add('roxma/vim-hug-neovim-rpc', {
\ 'if' : "!has('nvim')"
\ })

" Improved incremental searching
call dein#add('haya14busa/is.vim')
"}}}

" ============================================================
" Misc #{{{
" ============================================================
" Let dein manage dein
call dein#add('shougo/dein.vim')

" Create templates, by file type, for new files
call dein#add('aperezdc/vim-template')

call dein#add('reconquest/vim-pythonx', {
\ 'if' : "has('pythonx')"
\ })

call dein#add('Corey-Keller/thirsty.vim')

"}}}

" vim:set filetype=vim:
