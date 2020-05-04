" Post-plugin config for 'vim-auto-origami'
" This file is for anything that must be set AFTER the plugin is sourced.

augroup autofoldcolumn "{{{1
  " Remove all auto-commands from the group, so that it isn't added a second
  " time if we re-source the file
  autocmd!
  autocmd CursorHold,BufWinEnter,WinEnter * AutoOrigamiFoldColumn
augroup END "}}}1

" vim:set filetype=vim:
