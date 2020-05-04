" Pre-plugin config for 'suda.vim'
" This file is for anything that must be set BEFORE the plugin is sourced.

let g:suda#prefix = ['suda://', 'sudo://',]

" Allow saving of files as sudo when forgot to start vim using sudo
cmap w!! w suda://%
cmap wq!! w suda://%\|q

" vim:set filetype=vim:
