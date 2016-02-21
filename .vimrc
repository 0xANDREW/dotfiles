execute pathogen#infect()

syntax on
filetype indent plugin on
colorscheme desert

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType js set omnifunc=htmlcomplete#CompleteTags

set statusline=%F%m 
set omnifunc=syntaxcomplete#Complete
set hlsearch
set incsearch
set ignorecase
set number
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set background=dark

if exists('+cc')
  set cc=80
endif

" Change dir to current file
if exists('+autochdir')
  set autochdir
else
  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

" Break into pdb
command! Pdb :normal iimport pudb; pudb.set_trace()

" ctrl-j inserts a line break in normal mode
:nnoremap <NL> i<CR><ESC>

