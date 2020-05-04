" Pre-plugin config for 'thirsty.vim'
" This file is for anything that must be set BEFORE the plugin is sourced.

" 10 minutes instead of 20 between prompting the user to drink some water
let g:thirsty#frequency = 600
" let g:thirsty#frequency = 30

" After 30 minutes, require a drink and don't accept the user saying that
" they're not thirsty
let g:thirsty#max_time = 1800
" let g:thirsty#max_time = 90

" Shorter prompt
let g:thirsty#prompt = 'Drink water!'

" vim:set filetype=vim:
