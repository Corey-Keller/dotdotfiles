" Post-plugin config for 'vim-toml'
" This file is for anything that must be set AFTER the plugin is sourced.

" work around for the settings not loading for the first toml document opened
if &filetype ==? 'toml'
	set filetype=
	set filetype=toml
endif

" vim:set filetype=vim:
