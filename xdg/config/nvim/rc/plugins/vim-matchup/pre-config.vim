" Pre-plugin config for 'vim-matchup'
" This file is for anything that must be set BEFORE the plugin is sourced.

" remap from 'z%' to avoid conflicts with 'vim-sneak'
nmap x% <plug>(matchup-z%)
xmap x% <plug>(matchup-z%)
omap x% <Plug>(matchup-o_)<plug>(matchup-z%)

" vim:set filetype=vim:
