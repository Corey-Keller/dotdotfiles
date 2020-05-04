" Pre-plugin config for 'vim-gutentags'
" This file is for anything that must be set BEFORE the plugin is sourced.

" Enable debug output from gutentags
" let g:gutentags_trace = 1

" Enable (1) or disable (0) gutentags from running
let g:gutentags_enabled=0

let g:gutentags_project_root = ['.tags_root_dir', '.root']

let g:gutentags_resolve_symlinks = 1

let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif

if executable('cscope')
	let g:gutentags_modules += ['cscope']
endif

if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" if executable('gtags-cscope') && executable('gtags')
" 	let g:gutentags_modules = ['gtags_cscope']
" elseif executable('cscope')
" 	let g:gutentags_modules = ['cscope']
" elseif executable('ctags')
" 	let g:gutentags_modules = ['ctags']
" endif

" vim:set filetype=vim:
