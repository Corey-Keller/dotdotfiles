" Post-plugin config for 'vimwiki'
" This file is for anything that must be set AFTER the plugin is sourced.

augroup VimWikiSetFiletype "{{{1
  " Remove all auto-commands from the group, so that it isn't added a second
  " time if we re-source the file
  autocmd!
  autocmd FileType vimwiki set filetype=markdown
augroup END "{{{1

" vim:set filetype=vim:
