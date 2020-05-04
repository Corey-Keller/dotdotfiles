" Pre-plugin config for 'leaderf'
" This file is for anything that must be set BEFORE the plugin is sourced.

" ============================================================
" Option Variables {{{
" ============================================================

" Change the shortcut to search all files
" Default: '<leader>f'
let g:Lf_ShortcutF = '<leader>ff'

let g:Lf_WildIgnore = {
\ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine'],
\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
\}

let g:Lf_CacheDirectory = $XDG_CACHE_HOME . '/vim/leaderf'
let g:Lf_NumberOfCache = 25
let g:Lf_IndexTimeLimit = 3600
let g:Lf_MruMaxFiles = 5000

" Change the shortcut to search open buffers
" Default: '<leader>b'
" let g:Lf_ShortcutB = "<leader>b"

" Remap the 'open in vertical split' command from 'CTRL+]' to 'CTRL+V'
" Swap the Up/Down arrows with the 'Ctrl+k' and 'Ctrl+j' buttons
" respectively (so we can use the arrows to move through the list)
let g:Lf_CommandMap = {
	\'<C-]>': ['<C-V>'],
	\'<Up>': ['<C-K>'],
	\'<C-K>': ['<Up>'],
	\'<Down>': ['<C-J>'],
	\'<C-J>': ['<Down>'],
	\}
" }}}

" ============================================================
" Highlight Colors {{{
" ============================================================
highlight! link Lf_hl_popup_window Pmenu
highlight! link Lf_hl_popup_inputMode InsertMode
highlight! link Lf_hl_popup_normalMode NormalMode
highlight! link Lf_hl_popup_inputText StatusLineNC
highlight! link Lf_hl_popup_prompt StatusLine
highlight! link Lf_hl_popup_spin StatusLine
highlight! link Lf_hl_popup_mode StatusLine
highlight! link Lf_hl_popup_category StatusLine
highlight! link Lf_hl_popup_cwd StatusLine
highlight! link Lf_hl_popup_separator0 StatusLine
highlight! link Lf_hl_popup_separator1 StatusLine
highlight! link Lf_hl_popup_separator2 StatusLine
highlight! link Lf_hl_popup_separator3 StatusLine
highlight! link Lf_hl_popup_separator4 StatusLine
highlight! link Lf_hl_popup_separator5 StatusLine
highlight! link Lf_hl_popup_lineInfo StatusLine
highlight! link Lf_hl_popup_nameOnlyMode StatusLine
highlight! link Lf_hl_popup_regexMode StatusLine
highlight! link Lf_hl_popup_fullPathMode StatusLine
highlight! link Lf_hl_popup_fuzzyMode StatusLine
highlight! link Lf_hl_popup_total StatusLine
highlight! link Lf_hl_popup_blank StatusLine
" }}}

" ============================================================
" Floating LeaderF {{{
" ============================================================
" floating LeaderF popup window
if has('nvim') && exists('*nvim_open_win') "{{{
  let g:Lf_WindowPosition='popup'

  " Show the preview of the result in a popup window
  let g:Lf_PreviewInPopup = 1

  " let g:Lf_PreviewHorizontalPosition = 'right'
  " let g:Lf_PreviewPopupWidth = 87
endif "}}}
" }}}

" vim:set filetype=vim:
