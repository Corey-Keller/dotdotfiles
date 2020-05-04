function! fns#SynGroup() abort "{{{1
	let l:s = synID(line('.'), col('.'), 1)
	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction "}}}1

" Make the current line into a padded header line.
" Depends on having the commands 'DoCommentLine' and 'DoUncommentLine' defined
" to comment and uncomment the current line respectively
" NOTE: Will wipe out register h ("h)
function! fns#MkHeader(...) abort "{{{1
	if !exists('g:fns#MkHeader#LineLengths') "{{{2
		let g:fns#MkHeader#LineLengths = [60, 45, 30]
	endif "}}}2
	if !exists('g:fns#MkHeader#PadChars') "{{{2
		let g:fns#MkHeader#PadChars = ['=', '~', '>']
	endif "}}}2
	if !exists('g:fns#MkHeader#Style') "{{{2
		let g:fns#MkHeader#Style = 'block'
	endif "}}}2

	if len(g:fns#MkHeader#LineLengths) != len(g:fns#MkHeader#PadChars) "{{{2
		echomsg '''g:fns#MkHeader#LineLengths'' and ''g:fns#MkHeader#PadChars'' do
						\ not have the same number of items. Fix before continuing.'
		return
	endif "}}}2

	let l:arraySize = len(g:fns#MkHeader#LineLengths)

	" If a parameter wasn't provided, set to 1)
	let l:parameter = get(a:000, 0, 1)

	if !(l:parameter =~? '\d\+' && l:parameter >= 0 &&
			\ l:parameter <= l:arraySize) "{{{2
		echomsg '"' . l:parameter . '" is not a valid heading level. Must be a
					\ number between 0 (zero, which will undo the existing header) and ' .
					\ l:arraySize
		return
	endif "}}}2

	let l:headingIndex = l:parameter - 1
	let l:lineLength = g:fns#MkHeader#LineLengths[l:headingIndex]
	let l:padChar = g:fns#MkHeader#PadChars[l:headingIndex]

	" Uncomment the line, but only if it was already commented
	if synIDattr(synIDtrans(synID(line('.'), col('$')-1, 1)), 'name')=~?'comment'
		DoUncommentLine
	endif

	if g:fns#MkHeader#Style ==? 'block' "{{{2
		" If the parameter is zero, then undo the heading padding. Will cause
		" unwanted deletion if the line is already unpadded
		if l:parameter ==? 0 "{{{3
			" For the current line, do the following:
			" 1. Move up 1 line (k) and delete the line (dd) into the 'black hole'
			" register ("_) (so that the deleted text isn't saved at all), this
			" moves us down 1 line (to the line we started on)
			" 2. Move down 1 line (j) and delete the line (dd) into the 'black hole'
			" register ("_), this moves us down 1 line (to the line below the
			" one we started on)
			" 3. Move up 1 line (k) back to the initial line
			normal! k"_ddj"_ddk
			return
		endif "}}}3

		" For the current line, do the following:
		" 1. Move to the first non-whitespace character (^) of the line
		" 2. Yank (y) everything from here to the beginning of the line (0)
		" into register h ("h). This ensures that we preserve the indentation
		" level
		normal! ^"hy0

		" Append l:lineLength count of l:padChar to register h
		let @H = repeat(l:padChar, l:lineLength) . "\n"

		" For the current line, do the following:
		" 3. Take the contents of register h ("h) and paste it above (P) the
		" current line, meaning we end on the line above where we started

		" Take the contents of register h ("h) and paste it below (p) the
		" current line (and moving us down to the new line), and then comment it
		normal! "hp
		DoCommentLine

		" Move up 1 line (k) back to the line we started on
		normal! k

		" Take the contents of register h ("h) and paste it above (P) the
		" current line (and moving us to the new line), and then comment it
		normal! "hP
		DoCommentLine

		" Move down 1 line (j) back to the line we started on
		normal! j

	endif "}}}2

	if g:fns#MkHeader#Style ==? 'center' "{{{2
		" If the parameter is zero, then undo the heading padding. Will cause
		" unwanted deletion if the line is already unpadded
		if l:parameter ==? 0 "{{{3
			" For the current line, do the following:
			" 1. Move to the end of the line ($)
			" 2. Go backwards to the first match (F) of the space character ( )
			" 3. Delete (d) into the 'black hole' register h ("_) (so that the
			" deleted text isn't saved at all) up to to the end of the line ($)
			" 4. Move to the first non-whitespace character (^) of the line
			" 5. Delete (d) into register h ("h)  up to the start of the next
			" word (w)
			normal! $F "_d$^"_dw
			return
		endif "}}}3

		" For the current line, delete (d) everything from the first
		" non-whitespace character (^) to the end of the line ($) into
		" register h ("h)
		normal! ^"hd$

		" '@h' means the contents of the 'h' register
		" Put a space before and after the string for readability.
		let l:curString = ' ' . @h . ' '
		let l:curStringLen = strlen(l:curString)
		let l:padPerSide = (l:lineLength - l:curStringLen) / 2.0
		let l:endString = repeat(l:padChar, float2nr(floor(l:padPerSide))) .
										\ l:curString .
										\ repeat(l:padChar, float2nr(ceil(l:padPerSide)))
		let @h=l:endString
		normal! "hp
	endif "}}}2

	" Will comment the current line
	DoCommentLine

	" Empty register h
	call setreg('h', [])
endfunction "}}}1

function! fns#CheckPlugConfigFiles(name,...) abort "{{{1
	let g:UserConfig = get(g:, 'UserConfig',{})
	if empty(get(g:UserConfig, 'VimConfig', ''))
		let g:UserConfig.VimConfig = fnameescape(resolve(expand(
		\ '$VIMCONFIGDIR')))
	endif

	if empty(get(g:UserConfig, 'PluginConfigDir', ''))
		let g:UserConfig.PluginConfigDir = fnameescape(resolve(expand(
		\ g:UserConfig.VimConfig .'/rc/plugins')))
	endif

	" if !exists('g:fns#PlgCfgF#States') "{{{2
	"   let g:fns#PlgCfgF#States = ['pre', 'post']
	" endif "}}}2

	let l:FilePathPre = g:UserConfig.PluginConfigDir . '/' . a:name .
											\ '/pre-config.vim'
	let l:FilePathPost = g:UserConfig.PluginConfigDir . '/' . a:name .
											\ '/post-config.vim'

	if !filereadable(l:FilePathPre) "{{{2
		" Make the directory with write access only to the user. More detail:
			" 1. ':h' in fnamemodify gets the 'head' of the file path (in this case
			" everything but the filename itself. For more info run
			" ':help fnamemodify()' and ':help filename-modifiers'
			" 2. 'p' in mkdir creates all missing directories in the path, and 0755
			" sets the permissions. For more info run ':help mkdir' or (for more info
			" on file permissions) run 'man chmod' in the shell (outside of vim)
		call mkdir(fnamemodify(l:FilePathPre,':h'),'p',0755)
		echomsg 'writing file: ' . l:FilePathPre
		execute 'silent !printf "\" Pre-plugin config for ''' . a:name .
		\ '''\n\" This file is for anything that must be set BEFORE the plugin' .
		\ ' is sourced.\n\n\n\" vim:set filetype=vim:" > "' . l:FilePathPre . '"'
	endif "}}}2

	if !filereadable(l:FilePathPost) "{{{2
		" Make the directory with write access only to the user. More detail:
			" 1. ':h' in fnamemodify gets the 'head' of the file path (in this case
			" everything but the filename itself. For more info run
			" ':help fnamemodify()' and ':help filename-modifiers'
			" 2. 'p' in mkdir creates all missing directories in the path, and 0755
			" sets the permissions. For more info run ':help mkdir' or (for more info
			" on file permissions) run 'man chmod' in the shell (outside of vim)
		call mkdir(fnamemodify(l:FilePathPost,':h'),'p',0755)
		echomsg 'writing file: ' . l:FilePathPost
		execute 'silent !printf "\" Post-plugin config for ''' . a:name .
		\ '''\n\" This file is for anything that must be set AFTER the plugin' .
		\ ' is sourced.\n\n\n\" vim:set filetype=vim:" > "' . l:FilePathPost . '"'
	endif "}}}2
endfunction "}}}1

function! fns#Clean_plugin_name(name) abort "{{{1
	" The plugin name needs to be converted to a name that can be used in a
	" function. Functions are limited to letters, numbers, and underscores. Thus
	" we replace any other characters with _'s. We also lowercase it, but that
	" part is just personal preference
	return tolower(substitute(a:name, '[^A-Za-z0-9]', '_', 'g'))
endfunction "}}}1

function! fns#Check_plug_config_stub(name,...) abort "{{{1
	" a:0 is the number of unnamed arguments passed, and a:1 is the first
	" unnamed argument.
	" let l:autoload_subdir = a:0 > 0 ? a:1 : 'config_plug'
	let l:cleanname = fns#Clean_plugin_name(a:name)
	let g:fns#PlgCfg#autoload_subdir = get(a:000, 0, 'conf')
	let l:file = l:cleanname . '.vim'
	let l:fullpath = $VIMCONFIGDIR . '/autoload/' .
				\ g:fns#PlgCfg#autoload_subdir . '/' . l:file
	if !filereadable(l:fullpath) "{{{2
		echomsg 'writing stub: ' . l:fullpath
		execute 'silent !printf "\" Plugin config for ''' . a:name .
		\ '''\n\n\" Config to be set before the plugin loads\nfunction ' .
		\ g:fns#PlgCfg#autoload_subdir . '\#' .
		\ l:cleanname .
		\ '\#Pre() abort \"{{{\n  \nendfunction \"}}}\n\n\" Config to be set ' .
		\ 'after the plugin loads\nfunction ' . g:fns#PlgCfg#autoload_subdir .
		\ '\#' . l:cleanname .
		\ '\#Post() abort \"{{{\n  \nendfunction \"}}}\n\n\" ' .
		\ 'vim:set filetype=vim:" > "' . l:fullpath . '"'
	endif "}}}2
endfunction "}}}1

" vim:set filetype=vim:
