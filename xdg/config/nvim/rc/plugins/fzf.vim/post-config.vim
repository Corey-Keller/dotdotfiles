" Post-plugin config for 'fzf.vim'
" This file is for anything that must be set AFTER the plugin is sourced.

" Shamelessly taken from:
" https://jesseleite.com/posts/2/its-dangerous-to-vim-alone-take-fzf

" ============================================================
" Mappings {{{
" ============================================================

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Buffers {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Search open buffers
nmap <Leader>b :Buffers<CR>
nmap <Leader>fb :Buffers<CR>

" Search buffer history (recently opened files)
nmap <Leader>h :History<CR>
nmap <Leader>fr :History<CR>
" }}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Tags {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Search for tags in current buffer
" Search for tags in current buffer
nmap <Leader>t :BTags<CR>
nmap <Leader>ft :BTags<CR>

" Search for tags across the whole project
nmap <Leader>fT :Tags<CR>
" }}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Specific Directories {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Search for files in the user's home directory
nnoremap <Leader>f~ :call fzf#vim#files(expand('~'))<CR>

" Search for files in the user's vim configuration directory
nnoremap <Leader>fv :call fzf#vim#files('$VIMCONFIGDIR')<CR>
" Command that can be called directly
command! VimConfigFiles call fzf#vim#files('$VIMCONFIGDIR', <bang>0)

" Search for files in the user's vim data directory
nnoremap <Leader>fD :call fzf#vim#files('$VIMDATADIR')<CR>
" Command that can be called directly
command! VimDataFiles call fzf#vim#files('$VIMDATADIR', <bang>0)

" Search for files in the user's dotfiles directory
nnoremap <Leader>fd :call fzf#vim#files('$DOTFILESDIR')<CR>
" Command that can be called directly
command! DFiles call fzf#vim#files('$DOTFILESDIR', <bang>0)
" }}}
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Misc {{{
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Search all files
nmap <Leader>ff :Files<CR>

" Search only git tracked files
nmap <Leader>F :GFiles<CR>

" Search for help documentation
nmap <Leader>H :Helptags!<CR>
nmap <Leader>fh :Helptags!<CR>

" Search defined commands
nmap <Leader>C :Commands<CR>
nmap <Leader>C :Commands<CR>

" Search :command history
nmap <Leader>: :History:<CR>
nmap <Leader>fc :History:<CR>

" All files
command! -nargs=? -complete=dir AF
	\ call fzf#run(fzf#wrap(fzf#vim#with_preview({
	\'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '
	\ . expand(<q-args>)
	\ })))
" }}}
" }}}

" ============================================================
" floating fzf {{{
" ============================================================
if has('nvim')
	let $FZF_DEFAULT_OPTS .= ' --layout=reverse'

	function! FloatingFZF(width, height, border_highlight)
		function! s:create_float(hl, opts)
			let buf = nvim_create_buf(v:false, v:true)
			let opts = extend({'relative': 'editor', 'style': 'minimal'},
			\ a:opts)
			let win = nvim_open_win(buf, v:true, opts)
			call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
			call setwinvar(win, '&colorcolumn', '')
			return buf
		endfunction

		" Size and position
		let width = float2nr(&columns * a:width)
		let height = float2nr(&lines * a:height)
		let row = float2nr((&lines - height) / 2)
		let col = float2nr((&columns - width) / 2)

		" Border
		let top = '╭' . repeat('─', width - 2) . '╮'
		let mid = '│' . repeat(' ', width - 2) . '│'
		let bot = '╰' . repeat('─', width - 2) . '╯'
		let border = [top] + repeat([mid], height - 2) + [bot]

		" Draw frame
		let s:frame = s:create_float(a:border_highlight, {
			\ 'row': row,
			\ 'col': col,
			\ 'width': width,
			\ 'height': height
		\ })
		call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)

		" Draw viewport
		call s:create_float('Normal', {
			\ 'row': row + 1,
			\ 'col': col + 2,
			\ 'width': width - 4,
			\ 'height': height - 2
		\ })
		autocmd BufWipeout <buffer> execute 'bwipeout' s:frame
	endfunction

	let g:fzf_layout = { 'window': 'call FloatingFZF(0.9, 0.6, "Comment")' }
endif
" }}}

" vim:set filetype=vim:
