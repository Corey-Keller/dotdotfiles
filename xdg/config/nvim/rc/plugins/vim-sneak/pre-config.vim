" Pre-plugin config for 'vim-sneak'
" This file is for anything that must be set BEFORE the plugin is sourced.

" 'EasyMotion' style movement, where each available movement target is
" shown as a highlighted character for easy movement
let g:sneak#label = 1

" Immediately after invoking Sneak you can move to the next match by
" hitting s (or S for the previous match) again.
let g:sneak#s_next = 1

" Use 'PmenuSel' highlight group for Sneak matches
highlight link Sneak PmenuSel
highlight link SneakLabel PmenuSel
highlight link SneakLabelMask PmenuSel

" Use 'Pmenu' highlight group for the columns searched while using
" sneak-vertical-scope
highlight link SneakScope Pmenu

" vim:set filetype=vim:
