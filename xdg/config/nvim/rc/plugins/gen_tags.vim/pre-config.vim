" Pre-plugin config for 'gen_tags.vim'
" This file is for anything that must be set BEFORE the plugin is sourced.

	let g:gen_tags#use_cache_dir = 0
	let g:gen_tags#gtags_opts = ['--compact', '--accept-dotfiles',
	\ '--gtagsconf /src/github.com/Corey-Keller/dotdotfiles/xdg/config/gtags/gtags.conf',
	\ '--gtagslabel pygments']

" vim:set filetype=vim:
