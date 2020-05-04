" Pre-plugin config for 'ale'
" This file is for anything that must be set BEFORE the plugin is sourced.

" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
" let g:ale_completion_enabled = 1

set omnifunc=ale#completion#OmniFunc

let g:ale_linters = {
  \ 'sh': ['language_server', 'shell', 'shellcheck'],
  \ 'vim': ['vint'],
\}
let g:ale_fixers = {
  \ 'javascript': ['eslint'],
  \ 'sh': ['shfmt'],
\}

" vim:set filetype=vim:
