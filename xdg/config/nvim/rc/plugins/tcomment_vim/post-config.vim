" Post-plugin config for 'tcomment_vim'
" This file is for anything that must be set AFTER the plugin is sourced.

command! DoCommentLine execute "normal \<Plug>TComment_Commentc"
command! DoUncommentLine execute "normal \<Plug>TComment_Uncommentc"

if empty(mapcheck('gC','n'))
	nmap gC <Plug>TComment_gC
endif

if empty(mapcheck('gC','o'))
	omap gC <Plug>TComment_gC
endif

" vim:set filetype=vim:
