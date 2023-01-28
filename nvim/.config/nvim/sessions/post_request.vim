let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Documents/webdevelopmentbootcamp/Projects
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +9 230120_Post_Request_Routes/comments.txt
badd +51 230120_Post_Request_Routes/index.js
badd +14 230120_Post_Request_Routes/views/comments/edit.ejs
badd +15 230120_Post_Request_Routes/views/comments/index.ejs
badd +20 230120_Post_Request_Routes/views/comments/new.ejs
badd +12 230120_Post_Request_Routes/views/comments/show.ejs
argglobal
%argdel
$argadd ~/Documents/webdevelopmentbootcamp/Projects
edit 230120_Post_Request_Routes/index.js
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 128 + 128) / 256)
exe 'vert 2resize ' . ((&columns * 127 + 128) / 256)
argglobal
balt 230120_Post_Request_Routes/views/comments/index.ejs
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 54 - ((45 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 54
normal! 02|
lcd ~/Documents/webdevelopmentbootcamp/Projects
wincmd w
argglobal
if bufexists(fnamemodify("~/Documents/webdevelopmentbootcamp/Projects/230120_Post_Request_Routes/views/comments/edit.ejs", ":p")) | buffer ~/Documents/webdevelopmentbootcamp/Projects/230120_Post_Request_Routes/views/comments/edit.ejs | else | edit ~/Documents/webdevelopmentbootcamp/Projects/230120_Post_Request_Routes/views/comments/edit.ejs | endif
if &buftype ==# 'terminal'
  silent file ~/Documents/webdevelopmentbootcamp/Projects/230120_Post_Request_Routes/views/comments/edit.ejs
endif
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 14 - ((13 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 14
normal! 07|
lcd ~/Documents/webdevelopmentbootcamp/Projects
wincmd w
exe 'vert 1resize ' . ((&columns * 128 + 128) / 256)
exe 'vert 2resize ' . ((&columns * 127 + 128) / 256)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
