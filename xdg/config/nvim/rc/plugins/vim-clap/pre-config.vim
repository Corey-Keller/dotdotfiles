" Pre-plugin config for 'vim-clap'
" This file is for anything that must be set BEFORE the plugin is sourced.

let g:clap_cache_directory = $XDG_CACHE_HOME . '/vim/clap'

if get(g:, 'extended_font') || get(g:, 'invisiblechars#extended_font') ||
\ exists('g:loaded_webdevicons') || get(g:, 'spacevim_nerd_fonts')
	let g:clap_enable_icon = 1
endif

let g:clap_layout = { 'relative': 'editor' }
let g:clap_popup_input_delay = 5
let g:clap_maple_delay = 5
let g:clap_on_move_delay = 5

" vim:set filetype=vim:
