" Post-plugin config for 'papercolor-material'
" This file is for anything that must be set AFTER the plugin is sourced.

let g:PaperColor_Theme = 'material'

augroup LoadPaperColor
  " Remove all auto-commands from the group, so that it isn't added a second
  " time if we re-source the file
  autocmd!
  autocmd VimEnter * colorscheme PaperColor
augroup END

" vim:set filetype=vim:
