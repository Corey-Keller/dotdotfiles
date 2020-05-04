function! g:Clean_plugin_name(name) abort "{{{
  " The plugin name needs to be converted to a name that can be used in a
  " function. Functions are limited to letters, numbers, and underscores. Thus
  " we replace any other characters with _'s
  return substitute(a:name, '[^A-Za-z0-9]', "_", "g")
endfunction "}}}

function! g:Check_plug_config_stub(name,...) abort "{{{
  " a:0 is the number of unnamed arguments passed, and a:1 is the first
  " unnamed argument.
  " let l:autoload_subdir = a:0 > 0 ? a:1 : 'config_plug'
  let l:cleanname = g:Clean_plugin_name(a:name)
  let g:autoload_subdir = get(a:000, 0, 'conf')
  let l:file = l:cleanname . '.vim'
  let l:fullpath = $VIMHOME . '/autoload/' . g:autoload_subdir . '/' . l:file
  if !filereadable(l:fullpath)
    echom 'writing stub: ' . l:fullpath
    execute 'silent !printf "\" Plugin config for ''' . a:name .
    \ '''\n\n\" Config to be set before the plugin loads\nfunction ' .
    \ g:autoload_subdir . '\#' .
    \ l:cleanname .
    \ '\#Pre() abort \"{{{\n  \nendfunction \"}}}\n\n\" Config to be set ' .
    \ 'after the plugin loads\nfunction ' . g:autoload_subdir . '\#' .
    \ l:cleanname . '\#Post() abort \"{{{\n  \nendfunction \"}}}\n\n\" ' .
    \ 'vim:set filetype=vim:" > "' . l:fullpath . '"'
  endif
" endfor
endfunction "}}}

function! g:MkAllStubz1() abort "{{{
  for s:plugname in map(glob('$VIMHOME/bundle2/*', '*',1,1), 'fnamemodify(v:val, ":t")')
    execute 'call g:Check_plug_config_stub(''' . s:plugname . ''', ''settings'')'
  endfor
endfunction "}}}

function! g:MkAllStubz2() abort "{{{
  for s:plugname in map(glob('$VIMHOME/bundle/*', '*',1,1), 'fnamemodify(v:val, ":t")')
    execute 'call g:Check_plug_config_stub(''' . s:plugname . ''', ''settings'')'
  endfor
endfunction "}}}

" vim:set filetype=vim:
