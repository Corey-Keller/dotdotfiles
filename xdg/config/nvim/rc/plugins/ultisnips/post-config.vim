" Post-plugin config for 'ultisnips'
" This file is for anything that must be set AFTER the plugin is sourced.

augroup ReloadUltiSnips
	" Remove all auto-commands from the group, so that it isn't
	" added a second time if we re-source the file
	autocmd!
	" this one is which you're most likely to use?
	autocmd BufWritePost *.snippets call UltiSnips#RefreshSnippets()
augroup end

" vim:set filetype=vim:
