" Pre-plugin config for 'vim-easymotion'
" This file is for anything that must be set BEFORE the plugin is sourced.

" ============================================================
" Motion Options {{{
" ============================================================
" Jump straight to the first match by pressing space or enter.
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_enter_jump_first = 1

" Make the label keys easier to hit with just the left hand
let g:EasyMotion_keys = 'asdfgqwertzxcvZXCVASDFhjkluiopQWERm54321'

" Allow you to jump to a folded line
let g:EasyMotion_skipfoldedline = 0
" }}}

" ============================================================
" Highlight Colors {{{
" ============================================================
" Set the highlight colors to be more visible
highlight link EasyMotionTarget SpellBad
highlight link EasyMotionTarget2First SpellRare
highlight link EasyMotionTarget2Second SpellLocal
highlight link EasyMotionShade Comment
highlight link EasyMotionMoveHL Search
highlight link EasyMotionIncSearch Search
" }}}

" vim:set filetype=vim:
