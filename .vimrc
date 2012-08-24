set number
set ls=2
set tabstop=2
set shiftwidth=2
set hls
set ruler
set title
set ttyfast
set expandtab
set smarttab
set autoindent
set smartindent



call pathogen#infect()

autocmd VimEnter * NERDTree   " autostart nerdtree
"iautocmd VimEnter * wincmd p  " move the cursor from the nerdtree window


noremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction


set t_kb=
fixdel

"switch between windows
map <C-left> <C-w><Left>
map <C-right> <C-w><Right>
map <C-Tab> :bnext<CR>
map <C-S-Tab> :bprevious<CR>

"highlight whitespace
map <F2> /\s\+$<CR>

"no highlight
map <F3> :nohl<CR>

"autoindent
filetype indent on
map <F4> gg=G``

"restart vim, reload current file
map <F5> :so %<CR>

"map :W to :w or :Q to :q
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

" move lines, blocks up/down in different modes
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-down> :m .+1<CR>==

nnoremap <C-k> :m .-2<CR>==
nnoremap <C-up> :m .-2<CR>==

inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-down> <Esc>:m+<CR>==gi

inoremap <C-k> <Esc>:m-2<CR>==gi
inoremap <C-up> <Esc>:m-2<CR>==gi

vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-down> :m'>+<CR>gv=gv

vnoremap <C-k> :m-2<CR>gv=gv
vnoremap <C-up> :m-2<CR>gv=gv
