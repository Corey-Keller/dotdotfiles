function! HeadPadVimL(...) abort "{{{
  " If a parameter wasn't provided, set to 1)
  let l:headingLevel = get(a:000, 0, 1)
  if l:headingLevel == 1
    let l:lineLength = 60
    let l:padChar = '='
  elseif l:headingLevel = 2
    let l:lineLength = 45
    let l:padChar = '-'
  elseif l:headingLevel = 3
    let l:lineLength = 30
    let l:padChar = '.'
  else
    echom '"' . l:headingLevel . '" is not a valid heading level. Valid: 1, 2, 3'
    return
  endif

  normal! ^d$
  " Put a space before and after the string for readability.
  let l:curString = ' ' . @" . ' '
  let l:curStringLen = strlen(l:curString)
  let l:padPerSide = (l:lineLength - l:curStringLen) / 2.0
  let l:endString = '" ' . repeat(l:padChar, float2nr(floor(l:padPerSide))) .
                  \ l:curString .
                  \ repeat(l:padChar, float2nr(ceil(l:padPerSide)))
  " return l:endString
  let @"=l:endString
  normal! p
endfunction "}}}
