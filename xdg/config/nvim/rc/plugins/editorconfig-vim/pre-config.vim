" Pre-plugin config for 'editorconfig-vim'
" This file is for anything that must be set BEFORE the plugin is sourced.

  " Workaround to ensure compatibility with Tim Pope's fugitive
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" vim:set filetype=vim:
