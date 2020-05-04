" Post-plugin config for 'leaderf'
" This file is for anything that must be set AFTER the plugin is sourced.

" ============================================================
" Mappings {{{
" ============================================================

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Buffers {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Search for a buffer, including the unlisted buffers
nnoremap <Leader>fb :LeaderfBufferAll<CR>

" Search buffer history (recently opened files)
nnoremap <Leader>h :LeaderfMru<CR>
nnoremap <Leader>fr :LeaderfMru<CR>
" }}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Tags {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Search for tags in current buffer
nnoremap <Leader>t :LeaderfBufTag<CR>
nnoremap <Leader>ft :LeaderfBufTag<CR>

" Search for tags in all open buffers
nnoremap <Leader>fT :LeaderfBufTagAll<CR>
" }}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Specific Directories {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Search for files in the user's home directory
nnoremap <Leader>f~ :LeaderfFile ~<CR>

" Search for files in the user's vim configuration directory
nnoremap <Leader>fv :LeaderfFile $VIMCONFIGDIR<CR>
" Command that can be called directly
command! VimConfigFiles LeaderfFile $VIMCONFIGDIR

" Search for files in the user's vim data directory
nnoremap <Leader>fD :LeaderfFile $VIMDATADIR<CR>
" Command that can be called directly
command! VimDataFiles LeaderfFile $VIMDATADIR

" Search for files in the user's dotfiles directory
nnoremap <Leader>fd :LeaderfFile $DOTFILESDIR<CR>
" Command that can be called directly
command! DFiles LeaderfFile $DOTFILESDIR
" }}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Lines {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Search for a line in the current buffer
nnoremap <Leader>fl :LeaderfLine<CR>

" Search for a line in all open buffers
nnoremap <Leader>fL :LeaderfLineAll<CR>
" }}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Misc {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Search for help documentation
nnoremap <Leader>H :LeaderfHelp<CR>
nnoremap <Leader>fh :LeaderfHelp<CR>

" Search :command history
nnoremap <Leader>: :LeaderfHistoryCmd<CR>
nnoremap <Leader>fc :LeaderfHistoryCmd<CR>
" }}}
" }}}

" vim:set filetype=vim:
