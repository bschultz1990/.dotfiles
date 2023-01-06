autocmd BufRead,BufNewFile,VimEnter * syn match parens /[(){}]/ | hi parens ctermfg=red
" :hi MatchParen ctermbg=Yellow guibg=Yellow
command! -nargs=1 -complete=help H :tab help <args>
