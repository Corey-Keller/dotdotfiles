" Post-plugin config for 'vim-easymotion'
" This file is for anything that must be set AFTER the plugin is sourced.

if !empty(maparg('<Plug>(is-nohl)')) && maparg('<Plug>(is-nohl)') !=# '<Nop>'
	let s:has_is_nohl = 1
else
	let s:has_is_nohl = 0
endif

" {{{ Map EasyMotion commands
if s:has_is_nohl
	nmap s <Plug>(is-nohl)<Plug>(easymotion-s2)
	xmap s <Plug>(is-nohl)<Plug>(easymotion-s2)
	omap z <Plug>(is-nohl)<Plug>(easymotion-s2)
	map  / <Plug>(is-nohl)<Plug>(easymotion-sn)
	omap / <Plug>(is-nohl)<Plug>(easymotion-tn)
else
	nmap s <Plug>(easymotion-s2)
	xmap s <Plug>(easymotion-s2)
	omap z <Plug>(easymotion-s2)
	map  / <Plug>(easymotion-sn)
	omap / <Plug>(easymotion-tn)
endif "}}} Map EasyMotion commands

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion. Without these mappings, `n` & `N` works fine. (These mappings
" just provide different highlight method and have some other features)
" if s:has_is_nohl
" 	map  n <Plug>(is-nohl)<Plug>(easymotion-next)
" 	map  N <Plug>(is-nohl)<Plug>(easymotion-prev)
" else
" 	map  n <Plug>(easymotion-next)
" 	map  N <Plug>(easymotion-prev)
" endif

" vim:set filetype=vim:
