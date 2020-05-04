" Only run if we're using vim-plug
if g:UserConfig.PluginManager !=? 'vim-plug' "{{{1
	finish
endif "}}}1

function s:main() abort "{{{1
	" Automatically install vim-plug
	let l:PlugAutoloadFile = g:UserConfig.VimConfig . '/autoload/plug.vim'
	let s:VimPlugDir = g:UserConfig.VimData . '/bundle'
	if empty(glob(l:PlugAutoloadFile)) "{{{2
		execute 'silent !curl -fLo "' . g:UserConfig.VimConfig .
		\ '" --create-dirs' .
		\ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		augroup InstallVimPlug "{{{3
			" Remove all auto-commands from the group, so that it isn't
			" added a second time if we re-source the file
			autocmd!
			autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
		augroup END "{{{3
	endif "{{{2

	call plug#begin(s:VimPlugDir)
	" Let vim-plug manage itself
	Plug 'junegunn/vim-plug'

	" ============================================================
	" Wiki
	" ============================================================
	Plug 'lervag/wiki.vim'
	Plug 'dhruvasagar/vim-table-mode'

	Plug 'editorconfig/editorconfig-vim'

	Plug 'easymotion/vim-easymotion'

	" ============================================================
	" Colorschemes
	" ============================================================
	Plug 'laggardkernel/vim-one'
	Plug 'nickburlett/vim-colors-stylus'
	Plug 'reedes/vim-colors-pencil'
	Plug 'sonph/onehalf', {'rtp': 'vim/'}
	Plug 'arcticicestudio/nord-vim'
	Plug 'ayu-theme/ayu-vim'
	Plug 'romainl/Apprentice'
	Plug 'wimstefan/vim-artesanal'

	" ============================================================
	" Autocompletion
	" ============================================================
	 " Syntax source for neocomplete/deoplete/ncm/asyncomplete
	 Plug 'Shougo/neco-syntax'
	" The vim source for neocomplete/deoplete/ncm/asyncomplete/coc
	Plug 'Shougo/neco-vim'

	Plug 'Shougo/deoplete.nvim', Cond('g:UserConfig.Completion ==?
				\ ''deoplete'''), {
				\ 'do': 'if has(''nvim'')|:UpdateRemotePlugins|endif'
				\}
	Plug 'roxma/nvim-yarp', Cond(!has('nvim'))
	Plug 'roxma/vim-hug-neovim-rpc', Cond(!has('nvim'))
	Plug 'prabirshrestha/asyncomplete.vim',
	\ Cond('g:UserConfig.Completion ==? ''asyncomplete''')

	if has_key(g:plugs, 'asyncomplete.vim')
		Plug 'prabirshrestha/asyncomplete-buffer.vim'
		Plug 'prabirshrestha/asyncomplete-file.vim'
		Plug 'yami-beta/asyncomplete-omni.vim'
		Plug 'prabirshrestha/asyncomplete-lsp.vim'
		if has_key(g:plugs, 'asyncomplete-lsp')
			Plug 'prabirshrestha/async.vim'
			Plug 'prabirshrestha/vim-lsp'
		endif
		if has_key(g:plugs, 'neco-vim')
			Plug 'prabirshrestha/asyncomplete-necovim.vim'
		endif
		if has_key(g:plugs, 'neco-syntax')
			Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
		endif
		if executable('ctags')
			Plug 'prabirshrestha/asyncomplete-tags.vim'
		endif
	endif

	Plug 'junegunn/fzf', {
	\ 'dir': '$GHDIR/junegunn/fzf',
	\ 'do': './install --all'
	\ }
	if executable('fzf')
		Plug 'junegunn/fzf.vim'
	endif
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-apathy'
	Plug 'tpope/vim-characterize'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-fugitive'
	Plug 'Yggdroot/indentLine'
	" Plug 'dense-analysis/ale'
	Plug 'chrisbra/matchit'
	" Plug 'itchyny/lightline.vim'
	" Plug 'benknoble/vim-auto-origami'

	if executable('ctags')
		Plug 'ludovicchabant/vim-gutentags'
		Plug 'skywind3000/gutentags_plus'
	endif

	" Automatically install missing plugins on startup
	augroup AddMissingPlugs "{{{2
		" Remove all auto-commands from the group, so that it isn't
		" added a second time if we re-source the file
		autocmd!
		autocmd VimEnter *
		\  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
		\| PlugInstall --sync | q
		\| endif
	augroup END "{{{2

	" Run any configuration that needs to happen before plugins are loaded
	call LoadPluginConfig('pre')

	" Load plugins
	call plug#end()

	" Run any configuration that needs to happen after plugins are loaded
	call LoadPluginConfig('post')
endfunction "}}}1

" Check if plugin has been loaded by vim-plug
function! PlugLoaded(name) abort "{{{1
	return (
	\ has_key(g:plugs, a:name) &&
	\ isdirectory(g:plugs[a:name].dir) &&
	\ stridx(&runtimepath, g:plugs[a:name].dir) >= 0)
endfunction "}}}1

function Cond(cond, ...) abort "{{{1
	let opts = get(a:000, 0, {})
	return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction "}}}1

function LoadPluginConfig(state,...) abort "{{{1
	for l:plugin_name in g:plugs_order
		let l:file = g:UserConfig.PluginConfig . '/' . a:state . '/' .
		\ l:plugin_name . '.vim'
		" echom 'looking for ' . l:file
		if filereadable(fnameescape(l:file))
			" echom 'Running ' . a:state . ' config for ' . l:plugin_name
			execute 'source ' . fnameescape(l:file)
		endif
	endfor
endfunction "}}}1

call s:main()

" vim:set filetype=vim:
